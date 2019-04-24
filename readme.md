# zlua

## 简介

zlua是一个C#实现的lua，以lua5.1.4（下面简称为clua）为参考而开发。

## 项目目录结构

* Compiler
  * Lexer：词法分析
  * Parser：语法分析
  * CodeGenerator：代码生成
* Core
  * API：lua API
  * CallSystem：调用系统
  * Configuration：lua配置
  * Instruction：指令集
  * Lua：lua解释器
  * MetaMethod：元方法
  * ObjectModel：类型模型
  * Undumper：加载预编译chunk
  * VirtualMachine：虚拟机

## 开发进度

2019年3月29日 开始重写，进度如下：

完成的模块或通过的测试 | 完成时间
------------------ | -------
Undumper | 2019年3月30日
Instruction | 2019年3月31日
Lexer | 2019年4月5日
Parser | 2019年4月7日
虚拟机大部分指令 | 2019年4月12日
运行hello world | 2019年4月12日
Table | 2019年4月25日