# zlua设计
## 栈式虚拟机和指令集


### 类型模型
不用实现，如果需要实现一个单独的类即可
#### table
1. 直接多继承list和dict不存在的
2. 有几个类型上的地方，使用py默认的即可，因为比lua的沉默（偷偷做转换）要好
#### 相等性
似乎不用管，元方法也可以不管，用不到
### 变量与scope实现
#### upval
#### 检查
TODO 错误处理：你不希望报exp stack empty这种错误。错误处理很困难

### 调用与返回协议
1. 宿主函数和Lua函数协议相同
2. no vararg，这个特性根本用不到（python都很少用）
3. 调用流程：push closure，push args（被解析lua代码中的实参列表从左到右压栈）
    1. 宿主函数以closure(args)的形式调用它
4. 返回流程：
    1. 单返回值：
        1. 多返回值会被包装到table里，返回一个table
        2. 没有返回值的返回None，包括"return "和函数末尾自动添加ret 0指令
    2. 过程调用，这是由语句级别确定的，所以我选择加指令，procedure pop（专用pop）

### 虚拟机执行流程
1. thread只知道要执行Lua closure，第一次需要手动push chunk（无参无返回值），然后调用execute执行
2. 因为python严格不允许goto（事实上真的不好，你得像这样逼自己想一个好的，抽象的solution）

### 运行时环境
#### Stack\<LuaClosure\>
关于PythonClosure
1. python closure被注册到G，lua里调用后参数照样传入
2. call指令会取出参数直接调用py func，返回值压栈
3. 不需要栈帧

#### block与scope
旧版：startpc和endpc，非常不好。要用事件驱动换
新版：新增enterb和exitb指令
因为block的原因，这里有点乱
我们使用了两个栈，而不是一个proto和block的多态栈，因为还是要判断local
我们用栈来替代了parent
一个proto内的locals要根据curr来确定，是proto的locals加上block栈上的所有locals
坚持了C#的内部block不能与外部有同名局部变量，因此block的作用是我可以在同一层的三个子block里都声明一个i，这很重要
刚刚想到了一个特殊情况，说明了这样的重要性。本来最早的认知是：debug显示很不好。事实上允许同名会出现这样的情况
local a{{local b=a}local a}，你看，运行时回去找到后面一个a，这是错误的。
重名会在编译期检查好。所以运行时虽然所有声明都已加入locals（而不是声明了再加）但是是对的

### 指令集设计
### 基本指令
#### move
不需要，因为没有寄存器
#### loadk
不需要，常量直接编码到指令，不需要这样间接映射
####新指令 push_l o
l=literal
因为push重复了。
#### get/set LUG name
LUG其实是scope管理的三种情况
#### closure
从inner里用index取出一个proto，变成closure后push
设计上，还是区分开proto和closure，这样的话需要一个wrap proto的过程，本身是exp可以压栈
#### get/set_table
push table，使用get LUG
push key，同上
get table 指令本身：pop前两个值然后把val压栈，之后用其他指令赋值给其他
set table 指令本身：要再push val，pop三个值后赋值即可

TODO #### arith
双单，还要元方法
TODO #### 控制流类，一个都没做

### 语句级别指令
#### 新指令：new locals names
因为是声明，我们直接在block内新建key val pair（虽然key已经有了）
#### 新指令：unpack n_names
弹出栈顶的array（table），检查是否解包成n names个元素，不行则error
解包的值正序（从左到右）压栈（因为popn也是正序取出的）

### 函数定义和调用指令
#### self name
表对象已经在栈顶，弹出后压入t\[name\]，再压入表
所以方法应该这样翻译和执行
obj:f()
一个push指令（LUG）压入obj
有一个self f指令，压入f，压入obj
然后call
####call nargs
函数自己和参数已经压栈，取出后调用，nargs标记了实参列表长度（虽然exp栈理论上长度可以推出来，但是不好）
####return 1/0
旧版：(无参。自动检测有没有返回值，因为exp栈在计算后保持是空的，如果有就是有返回值返回他)
新版：1表示有一个返回值。不这样设计的后果是要区分call procedure，然后compiler这里的逻辑很复杂（对，可以写，我想出来了，
但是这个问题在于你吃掉了return的一个参数，which让事情变得复杂）
其实道理很简单。函数有没有返回值当然是return管。
因为有没return的函数体，所以自动附加ret

###表创建指令
```antlrv4
tableconstructor: '{' fieldlist? '}';
fieldlist: field (fieldsep field)* fieldsep?;
field: '[' exp ']' '=' exp | NAME '=' exp | exp ; //表ctor的字段初始化;
```
首先一定有一句newtable，然后处理field
这些new指令会把表压栈（尤其是set new table）
####set_new_list n
return 1，2，3和local a=1，2，3时使用，因为隐式table，可以一次解决
一个newtable和n个exp已经正序（从左到右）压栈，取出exps加入表，把表压栈
####newtable
local a={}。所以{}是一个表达式，所以要有指令，所有ctor以newtable打头
####append_new_list
新指令，table ctor变数太多，遇到exp我们就append
####set_new_table

### 表达式与指令生成
#### 常量折叠
之前想折叠常量，不太好弄。local a=True, not(not(a))，外面那个not a，在C#里我们返回一个temp，但是栈式没有temp
你也不能会上去判断之前的exp不是literal exp（num，str等），这样很丑
所以visit*没有返回值，直接emit
常量折叠的另一一个问题是，编译期和runtime的指令实现会repeat yourself，估计很难提取函数，很丑（因为其实函数本身很简单）

### 多重赋值
多重赋值其实不是个好的特性，用得也很少。
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

###函数实现
说一句，func def里的查表是不能用prefixexp代替的，因为设计上它就像是必须编译器确定
TODO所以你可以看到这里使用切片是多么蛋疼。你应该加一个parser rule区别开table的部分
