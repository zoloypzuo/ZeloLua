# zlua

## 简介

zlua是一个C#实现的lua，以lua5.1.4（下面简称为clua）为参考而开发。

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
  * ObjectModel：类型模型
  * Undumper：加载预编译chunk
  * VirtualMachine：虚拟机
  * State：lua_State类定义

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