// 测试工具

using System;
using System.Diagnostics;
using System.IO;
using Newtonsoft.Json;
using ZoloLua.Core.VirtualMachine;

namespace ZoloLua
{
    internal class TestTool
    {
        public const string DataPathBase = "../../../../data/";
        public const string JsonDataPathBase = "../../../../data/json/";
        public const string LuaDataPathBase = "../../../../data/lua/";

        private static JsonSerializerSettings Settings { get; } =
            new JsonSerializerSettings
            {
                TypeNameHandling = TypeNameHandling.Auto
            };

        // 使用json将对象序列化到文件
        // 文件名有时间戳和类型名构成，是唯一标识的
        // 文件被放在json目录下，生成后你可以移动整理到自己要的位置
        public static void ExportObject(object o)
        {
            using (StreamWriter writer =
                new StreamWriter(new FileStream($"{JsonDataPathBase}{DateTime.Now}_{o}.json", FileMode.OpenOrCreate))) {
                string output = JsonConvert.SerializeObject(o, Settings);
                writer.Write(output);
            }
        }

        // 断言比较两个对象所有字段对应相等
        //
        // /subPath/是基于json目录的相对路径
        //
        // 使用json.net将对象序列化到json字符串，这个字符串能标识一个对象的状态，或者说所有字段的值
        // 这个方法本身就是把/actual/同样序列化一遍，比较两个对象的字符串值相等
        // json.net的序列化非常可靠，包括环，多态的处理，但是不得不在类中插入很多特性
        public static void AssertPropertyEqual(string subPath, object actual)
        {
            string actualS = JsonConvert.SerializeObject(actual, Settings);
            string fullPath = $"{JsonDataPathBase}{subPath}";
            Debug.Assert(actualS == File.ReadAllText(fullPath));
        }

        /// <summary>
        ///     执行chunk文件
        /// </summary>
        /// <param name="filename"></param>
        /// <example>
        ///     <code>t00("empty/empty");</code>
        /// </example>
        public static void t00(string filename)
        {
            const string basePath = "../../../../data/chunk/";
            lua_State.lua_newstate().luaL_dofile($"{basePath}{filename}.out");
        }

        /// <summary>
        ///     dostring
        /// </summary>
        /// <param name="filename"></param>
        public static void t01(string s)
        {
            //lua_State.lua_newstate().luaL_dostring(s);
        }
    }
}