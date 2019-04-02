using System.Diagnostics;
using System.IO;

using Newtonsoft.Json;

namespace zluaTests
{
    internal class TestTool
    {
        #region 私有常量

        private const string pathBase = "../../../../data/json/";

        private static readonly JsonSerializerSettings settings =
            new JsonSerializerSettings
            {
                TypeNameHandling = TypeNameHandling.Auto
            };

        #endregion 私有常量

        #region 公有方法

        // 使用json将对象序列化到文件
        public static void ExportObject(object o)
        {
            using (StreamWriter writer =
                new StreamWriter(new FileStream(pathBase + $"{o}.json", FileMode.OpenOrCreate))) {
                string output = JsonConvert.SerializeObject(o, settings);
                writer.Write(output);
            }
        }

        // 断言比较两个对象所有字段对应相等
        //
        // 文件统一放在data/json下，默认文件名是类的作用域路径，/fileName/使用这个文件名即可
        //
        // 使用json.net将对象序列化到json字符串，这个字符串能标识一个对象的状态，或者说所有字段的值
        // 这个方法本身就是把/actual/同样序列化一遍，比较两个对象的字符串值相等
        // json.net的序列化非常可靠，包括环，多态的处理，但是不得不在类中插入很多特性
        //
        // TODO，因为作为项目，这些特性应该被移除，如果降低性能的话
        public static void AssertPropertyEqual(string fileName, object actual)
        {
            string actualS = JsonConvert.SerializeObject(actual, settings);
            Debug.Assert(actualS == File.ReadAllText(pathBase + fileName));
        }

        #endregion 公有方法

        #region 公有常量
        public const string PathBase = "../../../../data/";
        #endregion
    }
}