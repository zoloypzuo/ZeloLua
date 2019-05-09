import os


def join(l): return ''.join(l)


def tab(code: list): return ['\t' + line for line in code]


def read_all(path):
    with open(path, 'r', encoding='utf-8') as f:
        return f.read()


def write_all(path, s: str):
    make_dirs(path)
    with open(path, 'w', encoding='utf-8') as f:
        return f.write(s)


def make_dirs(path):
    '''
    输入完整路径（包含文件名），为该路径上所有目录创建目录保证能写入改文件
    :param path:
    :return:
    '''
    if not os.path.exists(os.path.dirname(path)):
        os.makedirs(os.path.dirname(path))
