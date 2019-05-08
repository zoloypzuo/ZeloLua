'''
Protected宏的参数是代码块
使用常规c#的方法就是函数指针，但是这没有意义
所以生成代码
一共有17处引用
'''


def p(s: str):
    s = '''
                savedpc = pc;
                {0}
                @base = this.@base;
    '''.format(s)
    return s


