using System;
using System.Collections.Generic;
using System.IO;

namespace zlua.Compiler
{
    internal class Parser
    {
        #region 私有属性



        #endregion 私有属性



        #region 公有方法

        //public static Block Parse(Stream chunk, string chunkName)
        //{
        //    IEnumerable<Token> tokens = Lexer.TokenStream(chunk, chunkName);
        //    //block = parseBlock(lexer);

        //    //lexer.NextTokenOfKind(TOKEN_EOF);

        //    //return block;
        //}

        #endregion 公有方法

        #region 私有方法

        private Block ParseBlock()
        {
            return new Block
            {
                Stats = ParseStats(),
                RetExps = ParseExps(),
                LastLine = 1,// TODO lexer.line
            };
        }

        //private Exp[] ParseExps()
        //{
        //}

        //private Stat[] ParseStats()
        //{
        //}

        #endregion 私有方法
    }

    // chunk ::= block
    // type Chunk *Block
    //
    // block ::= {stat} [retstat]
    // 不写readonly了，还要写无聊的ctor。。
    internal class Block
    {
        public int LastLine;
        public Stat[] Stats;
        public Exp[] RetExps;
    }

    internal class Stat
    {
    }

    internal class Exp
    {
    }
}