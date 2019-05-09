'''
在文档添加lua manual链接
<see href="http://stackoverflow.com">HERE</see>
我添加英文版的链接，复制中文版内容到remark.para，太长的句子会换行，根据逗号，句号

LUA_API → public
参数列表为空，返回值不变，去掉指针

一个一个弄

/// <summary>
///     lua_equal和lua_rawequal的区别在于前者调用元方法
/// </summary>
/// <param name="index1"></param>
/// <param name="index2"></param>
/// <returns></returns>
/// <remarks>
///     int lua_rawequal (lua_State *L, int index1, int index2);
///     如果两个索引 index1 和 index2 处的值简单地相等 （不调用元方法）则返回 1 。 否则返回 0 。 如果任何一个索引无效也返回 0 。
/// </remarks>
public bool lua_rawequal(int index1, int index2)
{
    TValue o1 = index2adr(index1);
    TValue o2 = index2adr(index2);
    return !ReferenceEquals(o1, lobject.luaO_nilobject) &&
           !ReferenceEquals(o2, lobject.luaO_nilobject) &&
           lobject.luaO_rawequalObj(o1, o2);
}


从这个例子可以看到，有时没办法经常生成，所以需求必须稳定，考虑清楚
比如我这里生成好了，我往里面写代码了，很多东西都改了，你不可能重新生成一遍的
所以你要去检查doxygen的生成效果，要接近manual的html，那就ok了

开发中的问题：

## 版本1

测试的源文本还是和大量生成有点差距，我复制了整个文本后发现很难分出单个方法，因此我想到html

## 版本2

那么要解析html，然而，python自带的HTMLParser真的很傻逼，我就是想提取正文，唉，而且还有莫名其妙的bug，我也懒得解决了
安装了第三方美丽肥皂库后好多了

问题在于html的tag在文档中效果很差
code tag会把单词也变成行

## 版本3

所以结合上面的信息，先parse html，为method做一个标记，我用^，然后用网上的html to txt工具转txt，再用py来split ^

实际上，我将<hr>换成^即可


2019年5月9日20:21:19 使用完成，这个生成项目不应该再次生成了，因为不可以
'''
from tool.csharp import method_def
from tool.test.util import tab, join, read_all, write_all


# region xml

def xml_tag(tag, code):
    '''
    def para(code):
    return ['<para>'] + \
           tab(code) + \
           ['</para>']
    :param tag:
    :param code:
    :return:
    '''
    return ['<{tag}>\n'.format(tag=tag)] + \
           tab(code) + \
           ['</{tag}>\n'.format(tag=tag)]


def para(code):
    return xml_tag('para', code)


def remarks(code):
    return xml_tag('remarks', code)


def summary(code):
    return xml_tag('summary', code)


def see(link, code: str):
    '''<see href="http://stackoverflow.com">HERE</see>
    code单行，返回一个一个元素的list
    '''
    return ['<see href="{link}">{code}</see>\n'.format(link=link, code=code)]


def xml_doc(code):
    '''xml doc顶层是tag列表，不过仍然是code
    为所有xml doc添加前缀的三斜杠
    '''
    return ['/// ' + line for line in code]


# endregion

# region app
def my_method_def(method):
    return method_def('public', 'void', method, [], [])


def my_see(method):
    return see('https://www.lua.org/manual/5.1/manual.html#' + method, method)


def my_summary(method):
    return summary(my_see(method))


def cutoff(s: str, sep='。；，'):
    '''截断太长的行'''
    pass


# endregion

# region main
src = read_all('lapi.txt').strip()
# method_docs = src.split('\n\n')  # split to paragraphs
method_docs = src.split('^')
all_code = []
for method_doc in method_docs:
    # 比较下面两种写法，split会去掉换行符，也就是说，你split了再join最后变成一行了
    # 所以不要这样用，使用splitlines并keep end
    # code = method_doc.split('\n')  # split lines
    code = method_doc.splitlines(keepends=True)
    # code[len(code) - 1] += '\n'  # 最后一行添加换行符，[..., 'sth\n']和[..., 'sth', '\n']是不一样的
    # soup = BeautifulSoup(code[0])
    # method = soup.code.string
    method = code[0].strip()
    code = \
        xml_doc(
            my_summary(method) + \
            remarks(
                para(code)
            )
        ) + \
        my_method_def(method) + \
        ['\n']
    all_code += code
write_all('lapi.cs', join(all_code))

# endregion
