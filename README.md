# zlua
设计
## 栈式虚拟机和指令集
### 调用与返回协议
1. 宿主和Lua函数协议相同
2. no vararg，这个特性根本用不到（python都很少用）
3. 调用流程：push closure，push args（被解析lua代码中的实参列表从左到右压栈），`_call会逆序args（因为压栈）然后以closure(args)调用它
4. 返回流程：pop ret：单返回值，以多返回值形式写的会被包装到tuple里（目前是table）

### 解包/多重赋值协议
1. a,b,c这样的会被包装成tuple
2. 赋值右侧的tuple自动解包
3. 不允许类似于 a, b, c = 1, (2, 3)，个数要严格匹配

### 虚拟机执行流程
1. 因为python严格不允许goto（事实上真的不好，你得逼自己想一个好的，抽象的solution）
2. thread只知道要执行Lua closure，第一次需要手动push chunk，然后调用execute执行

### 运行时环境
1. Stack<Closure>，
2.