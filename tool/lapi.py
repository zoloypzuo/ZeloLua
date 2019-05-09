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
'''


def join(l): return ''.join(l)


def tab(code: list): return ['\t' + line for line in code]


# region c#
def method_def(access, ret_type, method, parlist, code: list):
    return ['{access} {ret_type} {method}({parlist})\n'.format(
        access=access,
        ret_type=ret_type,
        method=method,
        parlist=','.join(parlist))
           ] + \
           ['{\n'] + \
           tab(code) + \
           ['}\n']


# endregion

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

# region gen app
def my_method_def(method):
    return method_def('public', 'void', method, [], [])


def my_see(method):
    return see('https://www.lua.org/manual/5.1/manual.html#' + method, method)


def my_summary(method):
    return summary(my_see(method))


def cutoff(s: str, sep='。；，'):
    '''截断太长的行'''


from bs4 import BeautifulSoup


# 测试用源文本还是有缺陷的
# 3.7 C API的函数和类型
def read_all(path):
    with open(path, 'r', encoding='utf-8') as f:
        return f.read()


def write_all(path, s: str):
    with open(path, 'w', encoding='utf-8') as f:
        return f.write(s)


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
    method=code[0].strip()
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


# 测试用源文本
'''
lua_pushlstring
void lua_pushlstring (lua_State *L, const char *s, size_t len);
把指针 s 指向的长度为 len 的字符串压栈。 Lua 对这个字符串做一次内存拷贝（或是复用一个拷贝）， 因此 s 处的内存在函数返回后，可以释放掉或是重用于其它用途。 字符串内可以保存有零字符。

lua_pushnil
void lua_pushnil (lua_State *L);
把一个 nil 压栈。

'''
# 生成效果
'''
/// <summary>
/// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_pushlstring">lua_pushlstring</see>
/// </summary>
/// <remarks>
/// 	<para>
/// 		lua_pushlstring
/// 		void lua_pushlstring (lua_State *L, const char *s, size_t len);
/// 		把指针 s 指向的长度为 len 的字符串压栈。 Lua 对这个字符串做一次内存拷贝（或是复用一个拷贝）， 因此 s 处的内存在函数返回后，可以释放掉或是重用于其它用途。 字符串内可以保存有零字符。
/// 	</para>
/// </remarks>
public void lua_pushlstring()
{
}

/// <summary>
/// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_pushnil">lua_pushnil</see>
/// </summary>
/// <remarks>
/// 	<para>
/// 		lua_pushnil
/// 		void lua_pushnil (lua_State *L);
/// 		把一个 nil 压栈。
/// 	</para>
/// </remarks>
public void lua_pushnil()
{
}

'''
