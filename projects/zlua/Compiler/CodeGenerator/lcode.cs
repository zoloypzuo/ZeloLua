using System;
using System.Collections.Generic;
using ZoloLua.Core.InstructionSet;

namespace ZoloLua.Compiler.CodeGenerator
{
    internal class lcode
    {
    }

    // 这里的*info类是指*语言成分的编译时信息

    // 说实在的
    // 自己重写name style是很没有意义的事情
    // 直接复制过来，重写类型是最重要的
    // 名字与原书或者clua源代码一致还有便于查看的优点
    // 我现在就是跟着《go lua》写，也不要管clua，因为作者是很可靠的
    internal class upvalInfo
    {
        public int index;
        public int locVarSlot;
        public int upvalIndex;
    }

    internal class locVarInfo
    {
        // 是否被闭包捕获
        public bool captured;
        public string name;
        public locVarInfo prev;

        // 作用域层次
        public int scopeLv;

        // 与这个名字绑定的寄存器索引
        public int slot;
    }

    internal class funcInfo
    {
        // break表 p323 17.1.4
        public List<List<int>> breaks;

        // nil bool number string
        // 常量值到常量表索引的映射
        public Dictionary<object, int> constants;

        public List<Bytecode> insts;
        public bool isVararg;
        public int lastLine;
        public int line;
        public List<int> lineNums;

        // 当前生效的局部变量 是不是指已经声明的？？？
        public Dictionary<string, locVarInfo> locNames;

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
        public int numParams;
        public funcInfo parent;

        // 当前作用域层次，初始值为0，每进入新作用域就递增
        public int scopeLv;
        public List<funcInfo> subFuncs;

        // upvalue表 p324 17.1.5
        public Dictionary<string, upvalInfo> upvalues;

        internal void closeOpenUpvals()
        {
            //int a = getJmpArgA();
            //if (a > 0) {
            //    emitJmp(a, 0);
            //}
        }

        // 由于构造的复杂性，初始化在ctor完成
        //public funcInfo(funcInfo parent, functiondefExpContext fd)
        //{
        //    this.parent = parent;
        //    subFuncs = new List<funcInfo>();
        //    constants = new Dictionary<object, int>();
        //    upvalues = new Dictionary<string, upvalInfo>();
        //    locNames = new Dictionary<string, locVarInfo>();
        //    locVars = new List<locVarInfo>();
        //    breaks = new List<List<int>>();
        //    insts = new List<Bytecode>();
        //    if (fd.funcbody.parlistOptional == null) {
        //        numParams = 0;
        //    } else {
        //        // ???
        //        // 这里的情况有点多，vararg算？
        //        // 作者简单地使用了len(parlist)
        //        //numParams =fd.funcbody.parlistOptional
        //    }
        //}

        /* constants */
        // 这里的方法基本是照抄翻译，没什么。。
        // 所以我就用他的命名了，没有帕斯卡

        // 返回/constants/查找结果，如果没有就从常量表尾部新分配一个索引，并添加到/constants/中
        public int indexOfConstant(object constant)
        {
            int outI;
            if (constants.TryGetValue(constant, out outI)) return outI;
            int i = constants.Count;
            constants[constant] = i;
            return i;
        }

        /* registers */

        // 分配一个寄存器，必要时更新最大寄存器数量
        //
        // 一个函数最大寄存器数量255
        // 寄存器索引从0开始（lua语言索引从1开始。。）
        public int allocReg()
        {
            usedRegs++;
            if (usedRegs >= 255) throw new Exception("function or expression needs too many registers");
            if (usedRegs > maxRegs) maxRegs = usedRegs;
            return usedRegs - 1;
        }

        public void freeReg()
        {
            if (usedRegs <= 0)
                throw new Exception("usedRegs <= 0 !");
            usedRegs--;
        }

        public int allocRegs(int n)
        {
            if (n <= 0) throw new Exception("n <= 0 !");
            for (int i = 0; i < n; i++) allocReg();
            return usedRegs - n;
        }

        public void freeRegs(int n)
        {
            if (n < 0)
                throw new Exception("n<0");
            for (int i = 0; i < n; i++) freeReg();
        }

        /* lexical scope */

        // 注意，这里的进出指的是编译时进出作用域
        public void enterScope(bool breakable)
        {
            scopeLv++;
            if (breakable)
                breaks.Add(new List<int>());
            else
                breaks.Add(null);
        }

        public void exitScope()
        {
            List<int> pendingBreakJmps = breaks[breaks.Count - 1];
            //breaks.pop()

            //var a = getJmpArgA();
            //for _, pc := range pendingBreakJmps {
            //    sBx:= pc() - pc;
            //    i:= (sBx + MAXARG_sBx) << 14 | a << 6 | OP_JMP;
            //    insts[pc] = uint32(i);
            //}

            scopeLv--;

            foreach (KeyValuePair<string, locVarInfo> item in locNames) {
                locVarInfo locVar = item.Value;
                if (locVar.scopeLv > scopeLv) removeLocVar(locVar);
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
            locVarInfo newVar = new locVarInfo
            {
                name = name,
                prev = locNames[name],
                scopeLv = scopeLv,
                slot = allocReg()
            };

            locVars.Add(newVar);
            locNames[name] = newVar;

            return newVar.slot;
        }

        // 检查局部变量名是否与某个寄存器绑定，是则返回寄存器索引，否则返回-1
        public int slotOfLocVar(string name)
        {
            locVarInfo outLocVarInfo;
            if (locNames.TryGetValue(name, out outLocVarInfo))
                return outLocVarInfo.slot;
            return -1;
        }

        public void addBreakJmp(int pc)
        {
            for (int i = scopeLv; i >= 0; i--)
                if (breaks[i] != null) { // breakable
                    breaks[i].Add(pc);
                    return;
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
    }
}