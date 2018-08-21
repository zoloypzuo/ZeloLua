# zlua栈式虚拟机设计
这章节介绍zlua的核心部分设计；
我尽量把指令规格/API与文字描述相结合，零碎的简单指令再一起收录到指令集这个章节；
更加细节或者通用的内容我在zlua设计这章节里描述

## 类型模型
不用实现，如果需要实现一个单独的类即可

### 相等性
似乎不用管，相应元方法也可以不管，用不到

## table
1. 直接多继承list和dict不存在的
2. 有几个类型上的地方，使用py默认的即可，因为比lua的沉默（偷偷做转换）要好
1，不简单，in和get/set会有repeat的地方，但是可能单独用，因此重复是必要的
2. TODO，文档没写好，api都没有
3. 

### 表创建指令
```antlrv4
tableconstructor: '{' fieldlist? '}';
fieldlist: field (fieldsep field)* fieldsep?;
field: '[' exp ']' '=' exp | NAME '=' exp | exp ; //表ctor的字段初始化;
```

首先一定有一句newtable，然后处理field
这些new指令会把表压栈（尤其是set new table）

#### 新指令】set_new_list n
return 1，2，3和local a=1，2，3时使用，因为隐式table，可以一次解决
一个newtable和n个exp已经正序（从左到右）压栈，取出exps加入表，把表压栈

#### newtable
local a={}。所以{}是一个表达式，所以要有指令，所有ctor以newtable打头

#### 新指令】append_new_list
table ctor变数太多，遇到exp我们就append

#### 新指令】set_new_table

#### get/set table
流程：
push table，使用get LUG
push key，同上
get table 指令本身：pop前两个值然后把val压栈，之后用其他指令赋值给其他
set table 指令本身：要再push val，pop三个值后赋值即可

### get/set table带元方法的处理
带元方法后暴露了设计的问题和src看不懂。原来的代码可能变成错的了
set table，考虑new index和覆盖两种情况，显然找到了就要覆盖，否则调用new index，如果没有new index则当前表插入新键。new index要考虑no mt和no mm两种

## 调用与返回协议
1. 调用流程：push closure，push args（被解析lua代码中的实参列表从左到右压栈），call
    * 宿主函数以closure(args)的形式直接调用它
2. 返回流程：
    1. 单返回值：
        1. 多返回值会被包装到一个table（apart）里，返回这个table
        2. “没有返回值”的函数和被解析文本中的"return "被翻译为ret 0指令，表示返回None
        3. 函数末尾自动添加ret 0指令
    2. 过程调用：这是由语句级别确定的，所以我选择加指令，procedure pop（专用pop）
3. 与宿主语言互操作：宿主调用lua一般是dofile，不谈；主要是lua调用宿主，提供了一个*args的接口，任意函数可以直接注册，实参正确性不会被检查，lua代码中所有实参列表传给宿主函数直接调用
4. 关于PythonClosure
    1. python closure被注册到G，lua里调用后参数照样传入
    2. call指令会取出参数直接调用py func，返回值压栈
    3. 不需要栈帧
5. no vararg，这个特性根本用不到（python都很少用）

### 函数定义和调用指令

#### closure proto index
从inner funcs里索引一个proto，包装成closure后push；注意匿名函数是表达式/右值

#### self name
表对象已经在栈顶，弹出后压入t\[name\]，再压入表
所以方法应该这样翻译和执行
obj:f()
一个push指令（LUG）压入obj
有一个self f指令，压入f，压入obj
然后call

#### call nargs
函数自己和参数已经压栈，取出后调用，nargs标记了实参列表长度（虽然exp栈理论上长度可以推出来，但是不好）

#### return 1/0
1表示有一个返回值

## 虚拟机执行流程
thread只知道要执行Lua closure，第一次需要手动push chunk（无参有返回值），然后调用execute执行

## 运行时环境
### Stack\<LuaClosure\>
基本的调用数据结构，不讲

### env：block与scope
1. 设计
    1. 一个proto内的locals要根据运行时当前环境来确定，是proto的locals加上block栈上的所有locals，即
        bstack上所有元素的locals，我们把proto也压进去，利用多态简化判断
    2. 利用多态栈替代了父指针，清晰简单地实现了scope的两个作用：确定scope（LUG）和get/set局部变量
2. 坚持了C#的内部block不能与外部有同名局部变量
   因此block的作用是我可以在同一层的三个子block里都声明一个i，这很重要
   刚刚想到了一个特殊情况，说明了这样的重要性。本来最早的认知是：debug显示很不好。事实上允许同名会出现这样的情况：local a{{local b=a}local a}，你看，运行时回去找到后面一个a，这是错误的。
   重名会在编译期检查好。所以运行时虽然所有声明都已加入locals（而不是声明了再加）但是是对的
   
#### 新指令】enterb block index和exitb
不讲

#### 新指令】get/set LUG name
LUG其实是scope管理的三种情况

代码】确定scope（LUG）：需要先查proto的可见作用域，再递归向上层查upval，否则是G
```python 
def _local_upval_global(self, name):
    '''分析右值name是从哪来的，local一定是local声明时已经加入符号表的，但是upval一定是右值，所以第一次要检查一下并注册到upval符号表
    global不需要符号表_G，默认就是有的
    '''
    assert isinstance(name, str)
    if name in self._currp:  # local一定是通过声明已经注册的
        return 'local'
    if name in self._currp.upvals:  # 已经注册的upval
        return 'upval'
    # 否则我们得第一次检查这个名字的作用域
    for p in reversed(self.pstack[:-1]):  # 栈顶是local p，前面检查过local了
        for scope in reversed(p.scope_stack):
            if name in scope.locals:
                self._currp.upvals[name] = partial(lambda scope: scope.locals[name], scope=scope)
                return 'upval'
    return 'global'
```

代码】get/set局部变量，注意细节上的区别；new_locals是声明新的局部变量，因此要在当前块中
get/set_local是在当前可见作用域中get/set局部变量
```python
def _new_locals(self, *operands):
    names = operands
    exps = self.popn(len(names))
    self.curr_cl.p.curr_locals.update(dict(zip(names, exps)))

def _get_local(self, *operands):
    name = operands[0]
    self.push(self.curr_cl.p[name])

def _set_local(self, *operands):
    name = operands[0]
    self.curr_cl.p[name] = self.pop()
```

# zlua实现与API设计

## 表达式与指令生成
语言最重要的是语句和表达式，而且两者之间只有一些微妙的差别

#### 新指令】push_l literal
l=literal

## 常量折叠
结论】不太好弄。local a=True, not(not(a))，外面那个not a，在C#里我们返回一个temp，但是栈式没有temp
你也不能会上去判断之前的exp不是literal exp（num，str等），这样很丑
所以visit*没有返回值，直接emit
常量折叠的另一一个问题是，编译期和runtime的指令实现会repeat yourself，估计很难提取函数，很丑（因为其实函数本身很简单）

## 多重赋值
结论】多重赋值其实不是个好的特性，用得也很少。
不好是指语义很难确定，你可以有多种设计，但是很难有比较好的。另一头的用户也不知道多重赋值带来什么好处，
语义是怎么样的；另外很难实现，自己做了才知道根本没有办法（我想不出来）。我描述一下思路：varlist=explist，应该先左侧求值再右侧求值再赋值，但是
栈式虚拟机要求先压exp再赋值。总之你把explist压入，栈式虚拟机没法处理。对的，你可以打破这个方法，去访问栈顶n个元素。不好，容易错。
结论：我保留了local a,b,c=1,2,3，事实上这个还经常用，是这个特性的主要用法。支持unpack，如果右侧是一个table exp，左侧var数＞1个会解包。这里实现容易是因为是声明局部变量
因此范围很小，我加了一条new local指令一次性初始化一个list的局部变量

这里很难做好，lua manual对多重复制的语义有明确的规定。而且和python不太一样。
这是一个语言细节。不应该太依赖，这样会写出容易错的代码（以manual的那个例子）
先计算所有左侧的表字段，因为这里面涉及exp，这一步对于varlist要从左到右，因为可以调用函数，理论上有副作用
然后计算右侧所有表达式，这是一般的设计。因为这样才能a,b=b,a来swap。

答案是不要这个特性了。

来看local声明的assign
我们用unpack解开。总之栈顶是一个exps，去出来后用new local直接赋值

#### 新指令】new locals names
因为是声明，我们直接在block内新建key val pair（虽然key已经有了）

#### 新指令】unpack n_names
弹出栈顶的array（table），检查是否解包成n names个元素，不行则error
解包的值正序（从左到右）压栈（因为popn也是正序取出的）

## 元方法
元方法绝对不是一开始就要考虑的，它是可选项
1. 只有表有元表
2. 不初始化key，而是访问是检查in
3. 使用有限的元方法，多了也没用，其实分为两个部分，一个是核心的index和new index，这个当然很重要，call其次（参见《脚本语言中消失的设计模式》），其他都只是为了重载符号而已
4. 为了元方法对vm loop重构，提取arith统一用binary处理，正因为抽象而简单，这样可以debug时跳过，美滋滋

1. 有一点对语言的理解，注意metatable是对象的一个表，元表固定有那么多key；而不是表直接有元方法，这很重要。

## upval实现
之前忽略了一个问题，既然proto是编译器产物，lua closure也只是proto的wrap，执行到函数定义完就构建好了，那么函数是对象是怎么做到的呢，函数怎么保证每次闭包生成新的状态（upval）
答案是我用python闭包实现闭包，但是要注意，要存储这些闭包（未调用的lambda），每次close时更新状态，这样就实现了
之前是错的，我直接用upvals\[name\]存储，这样只能更新一次，是错的。
这样的设计有一个好处，我们并不像lua src那样那么关心内存生命周期，我总是引用那个scope的那个数值，这意味着那个proto的locals有引用，事实上本来就不会回收，这样挺好的
而且我们只要在call指令处初始化upvals即可，非常简单清晰

## 错误处理
结论】所有错误应该在compiler和vm捕获并抛出，就这么简单
错误处理的目的是给用户返回可读的错误信息
谷歌关键字换了好几次：error handle python visitor都没用，都是教你抛出语言异常（有毛病。。）
我要的是控制错误信息。我试了一下IDLE，其实默认的错误信息很好。（但是红字太多了一开始没看清楚）；
结论：重载visitErrorNode抛出一个SyntaxError即可。为什么呢？因为前面说的antlr error好像是沉默的（就是个print），它继续执行到运行时抛出了看不懂的错误

## 数字类型使用float的问题
1. 解析num literal我一定返回float；程序处理的也只有float
2. 但是我要求key必须是int或str，因此1.0转成1（int）存入，get时也是这样


## 模块加载机制和库的导入
1. 我放弃了require。因为没有必要。你要的是热加载，因此所有都用dofile。这样语义清晰
2. 库导入十分简单直接，name => func的dict就是一个lib，加载到G

## and or eq ne和元方法，vm loop取指分派的设计
1. 分派的设计是，先判断算术运算，which操作数只能是float，这些方法都有对应元方法，直接处理
2. concat，relation op可能有元方法：1. and or是一定没有元方法的，不讲 2. relation op只有eq需要元方法，其他不需要

## debugger
必须实现，否则你无法debug。简单的方法，关联行号。如果不能，其实你可以自己解析行内容（很傻，应该不必）

## 如何debug line number
python接口有点不一样，SO没有，你自己ctrl n搜一下CommonToken，有line，text和coloumn

## 控制流
0. 所有谓词表达式返回bool，使用test指令检查是否为真（lua真），test指令紧跟一句jmp，jmp到假的处理，因此指令顺序是test；jmp 假处理块；真处理块
1. jmp使用绝对地址-1（因为pc++），因为本质上是绝对跳转
2. cond exp的实现：我们让exp自然地返回bool，对于cond的情况使用test指令生成jmp
3. test：弹出一个exp判断真假
4. and or 短路求值：1.返回bool，因为讲过了 2.更接近if else 3. test_and test_or用于跳转，并且会把lhs压栈（不同于test）
5. for ijk：for prep初始化三个变量，for loop用于exp判断和跳转回去;
    1. 这里必须存储ijk对象，我选择特殊记号。因为local中的id不能特殊符号起头，我用@i来表示循环变量对象
    2. prep name has_k，name是循环变量id，has_k时为3，否则为2
6. for in: 弹出一个table（之前已经压入）;for in loop。这里证明了for ijk这种做法的失策。其实道理

## for ijk loop
1. 不支持负数step，现在不必
2. ij还是最好左闭右开，src是左右闭，不好
3. 既然有prep指令，其实不必退一步再跳到loop指令，可以直接在prep判断是否第一次就不匹配

## dofile与库初始化
有点复杂，思考过的，chunk签名形如void chunk(){}，因此不需要传参数和返回值
但是提出来这件事的重要原因是调用chunk的逻辑必须是单独的，不可能和其他lua closure共用call函数
do string有两种情况，一是什么都没有，二是已经加载了lua代码，内部元编程加载新代码，后者要保存指针，就像一般的调用一样
而且要用if判断，否则null reference
要理解execute的功能：就是状态机的转换动作，而且是靠指令来行动的，你要给他准备正确的pc和栈帧，仅此而且，它只负责loop里执行指令
这里也看起来简单，实际上不太好写
