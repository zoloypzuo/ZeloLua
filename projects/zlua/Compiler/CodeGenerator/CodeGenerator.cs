// 代码生成
//
// 目标：
// [x] 复习，理解和参考antlr的visitor的api设计
// [x] 复习，理解和参考自己的regex engine的visitor的api设计
// [ ] 复盘parser，修正一些错误和设计让类型更加健壮
// [ ] 思考为什么自己旧的scope实现是错误的，作者是怎么弄得
// [] 参考旧的visitor
//
// [ ] 实现上我们分为以下两个阶段：
//     [ ] 访问AST生成编译时信息（包括代码生成），返回funcinfo实例
//     [ ] 将编译时信息转换成运行时需要的数据格式（这也是一次遍历），返回proto实例
//     这个方法虽然遍历次数增加了若干次，但是程序结构清晰，把数据转换这种简单琐碎的工作分离出来，容易调试，开发，修改，我以后写编译器都会这样做
//
// TODO：
// [ ] 为每个*Context类继承基类Context，包含一个必须实现的visitchildren(visitor)方法，这个方法遍历访问自己的生成式序列
// [ ] 为Bytecode类添加工厂类，实现一些指令工厂
// [ ] 整理zlua语法，请按照作者的标准来写，不要使用antlr的语法，不过他的单引号我打不出来这个算了
// [ ] 试一试写一个parser generator，按照BNF语法的标准，用python写，生成c#代码
//
//
//
// 变量和作用域的原理请先看p321的例子代码和右侧的示意图，然后就能看懂代码了
// 相关代码在funcInfo的scope区域
using System;
using System.Collections.Generic;

using zlua.Compiler.Parser;
using zlua.Core.Instruction;

namespace zlua.Compiler.CodeGenerator
{
    internal class LuaBaseVisitor
    {
        public void VisitChildren(blockContext ontext)
        {
        }

        public void VisitChildren(statContext context)
        {
        }
    }

    // 我决定暂时，至少名字不用antlr visitor，而是使用作者的命名
    internal class LuaVisitor : LuaBaseVisitor
    {
        // 当前函数
        private funcInfo fi;

        // block ::= {stat} [retstat]
        public void Visit_block(blockContext ctx)
        {
            //foreach (var item in ctx.StatStar) {
            //    Visit_stat(fi, item);
            //}
            //if (ctx.RetStatOptional != null) {
            //    Visit_retstat(ctx.RetStatOptional);
            //}
        }

        // 我觉得这里就可以看出我和作者在语法解析时的区别了，我的方式更加类型安全
        // 更加严谨地定义语法成分
        private void Visit_retstat(retstatContext ctx)
        {
            // "return"
            // 生成return nil语句
            if (ctx.explistOptional == null) {
                fi.emitReturn(0, 0);
                return;
            } else {
                //TODO确认explist最后一个元素是vararg或函数
                //
                //不太好写，要判断一次，我先放一放
                //bool multRet = isVarargOrFuncCall(c)
                bool multRet = false;
                //TODO
                // 这里很依赖最后一个元素
                // 如果最后一个exp是vararg或函数
                // 要visit exp(fi,exp,r,-1)
                // 对于前面的元素，要visit exp(fi,exp,r,1)
                //fi.freeRegs(nExps);
                int a = fi.usedRegs;
                if (multRet) {
                    fi.emitReturn(a, -1);
                } else {
                    //fi.emitReturn(a.nExps);
                }
            }
            // p328 最下面
            // 作者不实现尾递归
        }

        private bool isVarargOrFuncCall(expContext exp)
        {
            return (exp is VarargExpContext) ||
                (exp is functioncallPrefixexpLabelContext);
        }

        // label左部要这么写，antlr里我会交给BaseVisitor去VisitChildren
        private void Visit_stat(statContext ctx)
        {
            // 这里要多态派发
            // 当然是不好的
            // 因此访问要写在context里
            // 怎么弄
            // context实现visitor显然乱了
            // TODO 去看看antlr
            ctx.Accept(this);
        }

        // local function Name funcbody
        private void Visit_localFuncDefStat(localFuncDefStatLabelContext ctx)
        {
            // 这里就只需要名字字符串
            //var r = fieldContext.addLocVar(ctx.Name);
            //TODO fi, node, r, 0 ???
            //Visit_funcbody(ctx.funcbody);
        }

        private void Visit_breakStat()
        {
            //int pc = fi.emitJmp(0, 0);
            //fi.addBreakJmp(pc);
        }

        private void Visit_doStat(doStatLabelContext ctx)
        {
            fi.enterScope(false);
            Visit_block(ctx.block);
            //fi.closeOpenUpvals();
            fi.exitScope();
        }
    }

#pragma warning disable IDE1006 // Naming Styles
    // 这里的*info类是指*语言成分的编译时信息

    // 说实在的
    // 自己重写name style是很没有意义的事情
    // 直接复制过来，重写类型是最重要的
    // 名字与原书或者clua源代码一致还有便于查看的优点
    // 我现在就是跟着《go lua》写，也不要管clua，因为作者是很可靠的
    internal class upvalInfo
    {
        public int locVarSlot;
        public int upvalIndex;
        public int index;
    }

    internal class locVarInfo
    {
        public locVarInfo prev;
        public string name;

        // 作用域层次
        public int scopeLv;

        // 与这个名字绑定的寄存器索引
        public int slot;

        // 是否被闭包捕获
        public bool captured;
    }

    internal class funcInfo
    {
        public funcInfo parent;
        public List<funcInfo> subFuncs;

        #region 寄存器分配

        // 每一个局部变量和vm计算的临时变量都会分配一个寄存器
        // 局部变量退出作用域
        // 和临时变量计算完毕时回收寄存器
        //
        // 已经分配的寄存器数量
        public int usedRegs;

        // 函数需要的最大的寄存器数量，必要时扩容
        public int maxRegs;

        #endregion 寄存器分配

        // 当前作用域层次，初始值为0，每进入新作用域就递增
        public int scopeLv;

        // 变量作用域是纯粹的栈
        // 每个栈代表一个同名的局部变量
        // 但是是不同的lua对象实例，在lua栈上占用不同的寄存器
        // 因此进出作用域时我们将栈也压栈和退栈，这样就切换了变量名字绑定的寄存器
        // 我知道为什么错了
        // * 你没有搞懂lua怎么实现scope就觉得他实现的不好，要自己凭空想一个，这是99%会失败的
        //   作用域是基础模块，没必要自己想
        // * 刚刚我想用List来替代手写单链表，这是错误的
        //   这是一个树，不是List或者Stack
        //   这种栈树，用父亲指针是最好的
        //   这种写法是侵入式的，可以写一个泛型的外部的类来
        //   class StackTree<T>{
        //     StackTreeNode<T> root;
        //     public push(node);  // 构建树，在当前节点压入新节点
        //     public pop();  // 弹栈到上一层次
        //     。。。 TODO
        //   }
        //   class StackTreeNode<T>{
        //     StackTreeNode<T> prev/parent/father;
        //     T item;
        //   }
        // local a
        public List<locVarInfo> locVars;

        // 当前生效的局部变量 是不是指已经声明的？？？
        public Dictionary<string, locVarInfo> locNames;

        // upvalue表 p324 17.1.5
        public Dictionary<string, upvalInfo> upvalues;

        // nil bool number string
        // 常量值到常量表索引的映射
        public Dictionary<object, int> constants;

        // break表 p323 17.1.4
        public List<List<int>> breaks;

        public List<Bytecode> insts;
        public List<int> lineNums;
        public int line;
        public int lastLine;
        public int numParams;
        public bool isVararg;

        // 由于构造的复杂性，初始化在ctor完成
        public funcInfo(funcInfo parent, functiondefExpContext fd)
        {
            this.parent = parent;
            subFuncs = new List<funcInfo>();
            constants = new Dictionary<object, int>();
            upvalues = new Dictionary<string, upvalInfo>();
            locNames = new Dictionary<string, locVarInfo>();
            locVars = new List<locVarInfo>();
            breaks = new List<List<int>>();
            insts = new List<Bytecode>();
            if (fd.funcbody.parlistOptional == null) {
                numParams = 0;
            } else {
                // ???
                // 这里的情况有点多，vararg算？
                // 作者简单地使用了len(parlist)
                //numParams =fd.funcbody.parlistOptional
            }
        }

        /* constants */
        // 这里的方法基本是照抄翻译，没什么。。
        // 所以我就用他的命名了，没有帕斯卡

        // 返回/constants/查找结果，如果没有就从常量表尾部新分配一个索引，并添加到/constants/中
        public int indexOfConstant(object constant)
        {
            int outI;
            if (constants.TryGetValue(constant, out outI)) {
                return outI;
            } else {
                int i = constants.Count;
                constants[constant] = i;
                return i;
            }
        }

        /* registers */

        // 分配一个寄存器，必要时更新最大寄存器数量
        //
        // 一个函数最大寄存器数量255
        // 寄存器索引从0开始（lua语言索引从1开始。。）
        public int allocReg()
        {
            usedRegs++;
            if (usedRegs >= 255) {
                throw new Exception("function or expression needs too many registers");
            }
            if (usedRegs > maxRegs) {
                maxRegs = usedRegs;
            }
            return usedRegs - 1;
        }

        public void freeReg()
        {
            if (usedRegs <= 0) {
                throw new Exception("usedRegs <= 0 !");
            } else {
                usedRegs--;
            }
        }

        public int allocRegs(int n)
        {
            if (n <= 0) {
                throw new Exception("n <= 0 !");
            } else {
                for (int i = 0; i < n; i++) {
                    allocReg();
                }
                return usedRegs - n;
            }
        }

        public void freeRegs(int n)
        {
            if (n < 0) {
                throw new Exception("n<0");
            } else {
                for (int i = 0; i < n; i++) {
                    freeReg();
                }
            }
        }

        /* lexical scope */

        // 注意，这里的进出指的是编译时进出作用域
        public void enterScope(bool breakable)
        {
            scopeLv++;
            if (breakable) {
                breaks.Add(new List<int>());
            } else {
                breaks.Add(null);
            }
        }

        public void exitScope()
        {
            var pendingBreakJmps = breaks[breaks.Count - 1];
            //breaks.pop()

            //var a = getJmpArgA();
            //for _, pc := range pendingBreakJmps {
            //    sBx:= pc() - pc;
            //    i:= (sBx + MAXARG_sBx) << 14 | a << 6 | OP_JMP;
            //    insts[pc] = uint32(i);
            //}

            scopeLv--;

            foreach (var item in locNames) {
                var locVar = item.Value;
                if (locVar.scopeLv > scopeLv) { // out of scope
                    removeLocVar(locVar);
                }
            }
        }

        // 退出作用域时删除作用域内局部变量，包括解绑局部变量名，回收寄存器
        public void removeLocVar(locVarInfo locVar)
        {
            // 回收寄存器
            freeReg();
            // 查看同名变量情况
            //
            // 如果没有，直接解绑变量名
            if (locVar.prev == null) {
                // delete(locNames, locVar.name)
            }
            // 如果有，且在同一作用域内
            //
            // 递归调用remove处理
            else if (locVar.prev.scopeLv == locVar.scopeLv) {
                removeLocVar(locVar.prev);
            }
            // 否则在外层作用域，重新绑定变量名和局部变量
            else {
                locNames[locVar.name] = locVar.prev;
            }
        }

        // 在当前作用域添加一个局部变量，返回分配给它的寄存器索引
        public int addLocVar(string name)
        {
            var newVar = new locVarInfo
            {
                name = name,
                prev = locNames[name],
                scopeLv = scopeLv,
                slot = allocReg(),
            };

            locVars.Add(newVar);
            locNames[name] = newVar;

            return newVar.slot;
        }

        // 检查局部变量名是否与某个寄存器绑定，是则返回寄存器索引，否则返回-1
        public int slotOfLocVar(string name)
        {
            locVarInfo outLocVarInfo;
            if (locNames.TryGetValue(name, out outLocVarInfo)) {
                return outLocVarInfo.slot;
            } else {
                return -1;
            }
        }

        public void addBreakJmp(int pc)
        {
            for (int i = scopeLv; i >= 0; i--) {
                if (breaks[i] != null) { // breakable
                    breaks[i].Add(pc);
                    return;
                }
            }

            throw new Exception("<break> at line ? not inside a loop!");
        }

        // 已经生成的最后一条指令的索引
        public int pc()
        {
            return insts.Count - 1;
        }

        // TODO 注意fixSbx要修改移动码

        // return r[a], ... ,r[a+b-2]
        public void emitReturn(int a, int n)
        {
            //self.emitABC(OP_RETURN, a, n + 1, 0)
        }
    }

#pragma warning restore IDE1006 // Naming Styles
}