﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
/// <summary>
/// 目标：实现90%的lua
/// 目的：
/// 1.了解lua作为最简单的解释器的实现
/// 2.自己实现一个可以用于辅助unity的脚本语言
/// 要求： 
/// 1.以可读性为最优先
/// 2.修改lua特性，让它足够简单，unity够用即可
/// 代码规范：
/// 1.python风格
/// 2.命名规范：重新自己命名
/// 3.保留：
///     1.文件命名
///     2.lua_, luaX_ 前缀命名
/// </summary>
namespace zlua {
    /// <summary>
    /// (lua.c in lua src)
    /// </summary>
    partial class Lua {
        public enum LuaType {
            LUA_TNONE = -1,

            LUA_TNIL = 0,
            LUA_TBOOLEAN = 1,
            LUA_TLIGHTUSERDATA = 2,
            LUA_TNUMBER = 3,
            LUA_TSTRING = 4,
            LUA_TTABLE = 5,
            LUA_TFUNCTION = 6,
            LUA_TUSERDATA = 7,
            LUA_TTHREAD = 8,
        }

    }
}
