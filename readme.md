# zlua

## 简介

zlua是一个C#实现的lua，以lua5.1.4（下面简称为clua）为参考而开发。

zlua是：

* 以学习Lua语言和Lua实现为目的的项目
  * Lua语言
  * Lua实现
  * 比较C#，Lua和Python
  * 单元测试，自动化测试生成
  * 性能剖析和优化
  * 静态代码分析
* C#风格的Lua实现
  * 面向对象，clua中常见的L参数在zlua中是this
  * 重新划分模块和尽可能封装zlua的类的字段和方法，而clua全局地暴露了很多内部实现细节
  * 按照C#的编程实践进行编写
  * 简化了clua中函数多余的参数和返回值，让每个方法的输入输出直接明了

zlua不是：

* 完美兼容符合标准的Lua实现
* zlua很可能没有机会被大量应用于项目实践，而且现在网上已经有很多成熟的方案了

我已经在知乎开通了专栏，开始编写一些教程介绍zlua开发过程的心得体会。欢迎大家关注和讨论。

[从零开始的Lua教程](https://zhuanlan.zhihu.com/c_1108411426598825984)

## 项目目录结构

* Compiler
  * CodeGenerator：代码生成
* Core
  * API：lua API
  * CallSystem：调用系统
  * Configuration：lua配置
  * InstructionSet：指令集
  * Lua：lua解释器
  * MetaMethod：元方法
  * TypeModel：类型模型
  * State：lua_State类和global_State类
  * Undumper：加载预编译chunk
  * VirtualMachine：虚拟机
* Library
  * AuxLib：辅助库
  * StdLib：标准库


## 开发进度

事件 | 时间戳
--- | -----
第一阶段开始 | 2018年4月
第一阶段结束 | 2018年8月
第二阶段开始 | 2019年3月29日
完成Undumper | 2019年3月30日
完成InstructionSet | 2019年3月31日
完成手写Lexer | 2019年4月5日
完成手写Parser | 2019年4月7日
完成虚拟机大部分指令 | 2019年4月12日
使得zlua能运行hello world | 2019年4月12日
第二阶段结束 | 2019年4月14日
第三阶段开始 | 2019年4月24日
完成Table | 2019年4月25日
用5.1标准重写部分虚拟机 | 2019年4月25日
用5.1标准重写Undumper | 2019年4月25日
删除手写的编译器，开始打桩测试和修改虚拟机 | 2019年4月27日
通过helloworld和functioncall的chunk测试 | 2019年4月29日
构建了一个简单的自动生成测试系统 | 2019年4月30日
完成大部分《Lua设计与实现》的测试 | 2019年5月5日
使用CodeMaid和Reshaper清理代码 | 2019年5月7日
完整地审查整个项目 | 2019年5月7日
开始重读《PiL 第二版》，重新规划zlua设计 | 2019年5月8日
生成lapi代码和文档，调整代码让doxygen能正确显示 | 2019年5月9日
实现大部分lapi和lauxlib | 2019年5月10日
调整，发布第三版 | 2019年5月12日
第三阶段结束 | 2019年5月12日