class Table:
    def __init__(self):
        self.apart = []
        self.hpart = {}
        self.metatable = {}

    def append(self, obj):
        self.apart.append(obj)

    def put(self, key, val):
        self.hpart[key] = val

    def __getitem__(self, key):
        if isinstance(key, int):
            try:
                return self.apart[key]
            except IndexError:
                return self.hpart[key]
        elif isinstance(key, str):
            return self.hpart[key]
        else:
            raise TypeError('不要使用int和str以外的类型作为key')

    def __setitem__(self, key, value):
        if isinstance(key, int):
            try:
                self.apart[key] = value
            except IndexError:
                self.hpart[key] = value
        elif isinstance(key, str):
            self.hpart[key] = value
        else:
            raise TypeError('不要使用int和str以外的类型作为key')

    def __iter__(self):
        for i in self.apart: yield i
        for k, v in self.hpart.items(): yield k, v

    def __len__(self):
        return len(self.apart) + len(self.hpart)


def lua_cond_true_false(o):
    '''lua真假定义'''
    if o == None: return False
    if o == False: return False
    return True


def lua_not(o):
    return not lua_cond_true_false(o)


def get_metamethod(obj, mt_name: str):
    '''
    对错误沉默，返回None
    不设计成方法'''
    assert mt_name
    if not isinstance(obj, Table):
        return None
    if mt_name not in obj.metatable:
        return None
    return obj.metatable[mt_name]


if __name__ == '__main__':
    t = Table()
    t.append('ele1')
    t[2] = 'ele2'
    for i in t: print(i)
