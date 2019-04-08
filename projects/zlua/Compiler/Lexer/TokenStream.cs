using System;
using System.Collections.Generic;

namespace zlua.Compiler.Lexer
{
    // 包装Lexer为一个带前瞻的流对象
    //
    // 词法分析认为是复杂计算，因此前瞻时缓存结果
    // 内部维护一个List<Token>包含所有已经计算的Token值，不删除旧的值，所有Token都会一直在内存
    // NextToken对应于流的指针，而LookAhead(n)的n是相对于流指针的偏移
    // LookAhead有单个元素和数组两个版本，因为我暂时不知道parser是否要用哪种，干脆都写
    // NextToken和LookAhead在未计算所需Token时计算并缓存Token，从缓存中取出Token
    internal class TokenStream
    {
        #region 公有属性

        public bool IsNotEndOfStream { get; private set; }

        //
        public int Line {
            get { return CachedTokens[StreamPosition].Line; }
        }

        #endregion 公有属性

        #region 私有属性

        private IEnumerator<Token> TokenEnumerator { get; }
        private List<Token> CachedTokens { get; } = new List<Token>();

        private int CachedPosition {
            get { return CachedTokens.Count; }
        }

        private int StreamPosition { get; set; } = -1;

        #endregion 私有属性

        #region 构造函数

        // 传入Lexer对象
        public TokenStream(IEnumerable<Token> tokens)
        {
            TokenEnumerator = tokens.GetEnumerator();
        }

        #endregion 构造函数

        #region 公有方法

        // 前瞻token，不前进流指针
        public Token LookAhead(int n = 1)
        {
            CacheIfNeeded(n);
            return CachedTokens[StreamPosition + n];
        }

        public Token[] LookAheadArray(int n)
        {
            CacheIfNeeded(n);
            return CachedTokens.GetRange(StreamPosition, n).ToArray();
        }

        // 返回下一个token并前进一格流指针
        public Token NextToken()
        {
            CacheIfNeeded(1);
            StreamPosition++;
            return CachedTokens[StreamPosition];
        }

        #endregion 公有方法

        #region 私有方法

        private void CacheIfNeeded(int n)
        {
            // 初始值 0<=-1+1
            if (CachedPosition <= StreamPosition + n) {
                // 初始值 -1+1-0+1
                int numToCache = StreamPosition + n - CachedPosition + 1;
                int i = 0;
                while (i < numToCache) {
                    IsNotEndOfStream = TokenEnumerator.MoveNext();
                    if (IsNotEndOfStream) {
                        CachedTokens.Add(TokenEnumerator.Current);
                    } else {
                        // TODO
                        // 这里会在parser报错
                        // 比如"print(1"缺少一个右括号，parser调用lexer时就会走到这里
                        // 我现在还不知道
                        // 到时候再说
                        // 别忘了可以捕获异常，但是要考虑性能
                        throw new Exception("no more tokens");
                    }
                    i++;
                }
            }
        }

        #endregion 私有方法
    }
}