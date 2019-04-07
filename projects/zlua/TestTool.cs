// 测试工具
//
// [ ] 因为作为项目，这些特性应该被移除，如果降低性能的话
// * 暂时放在这里，便于在zlua进行调试
//

using System;
using System.Diagnostics;
using System.IO;
using Newtonsoft.Json;

namespace zluaTests
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
            using (var writer =
                new StreamWriter(new FileStream($"{JsonDataPathBase}{DateTime.Now}_{o}.json", FileMode.OpenOrCreate))) {
                var output = JsonConvert.SerializeObject(o, Settings);
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
            var actualS = JsonConvert.SerializeObject(actual, Settings);
            var fullPath = $"{JsonDataPathBase}{subPath}";
            Debug.Assert(actualS == File.ReadAllText(fullPath));
        }
    }
}