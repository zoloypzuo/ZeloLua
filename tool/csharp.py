from tool.util import tab


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


def method_call(o, func, arglist):
    # 静态方法也可
    return o + '.' + func + '(' + ','.join(arglist) + ');\n'


def attribute(attribute, code):
    return [attribute + '\n'] + \
           code


def string(s):
    return '"' + \
           s. \
               replace('\\', '\\\\'). \
               replace('\n', '\\n'). \
               replace('"', '\\"') + \
           '"'


def r_comment(comment, s):
    # 空comment被忽略
    return s.rstrip() + '  // ' + comment + '\n' if comment else s


def newline(code: list): code.append('\n')


def namespace(namespace, code):
    return ['namespace ' + namespace,
            '{\n'] + \
           tab(code) + \
           ['}\n']


def _class(access, _class, code):
    code = [access + ' class ' + _class + '\n',
            '{\n'] + \
           tab(code) + \
           ['}\n']
    return code


def using(namespaces: list): return ['using ' + namespace + ';\n' for namespace in namespaces]


def csharp(code):
    return code
