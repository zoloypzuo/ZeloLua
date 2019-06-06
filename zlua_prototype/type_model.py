class Table:
    def __init__(self, apart=None, hpart=None):
        self.apart = apart if apart != None else []
        self.hpart = hpart if hpart != None else {}
        self.metatable = None

    def set_metatable(self, mt):
        self.metatable = mt

    def append(self, obj):
        self.apart.append(obj)

    def __getitem__(self, key):
        if isinstance(key, float):
            i = int(key)
            if i == key:
                if i >= 0 and i < len(self.apart):
                    return self.apart[i]
                else:
                    return self.hpart[i]
            else:
                raise TypeError('不要使用float作为key')
        elif isinstance(key, str):
            return self.hpart[key]
        else:
            raise TypeError('不要使用int和str以外的类型作为key')

    def V_get_table(self, key):
        table = self
        while key not in table:
            mm = get_metamethod(table, '__getter')
            if mm:
                table = mm
            else:
                raise KeyError('Lua KeyError :table: ' + self.__str__() + ' key: ' + key.__str__())
        else:
            return table[key]

    def __setitem__(self, key, value):
        if isinstance(key, float):
            i = int(key)
            if i == key:
                if i == len(self.apart):
                    self.apart.append(value)
                if i >= 0 and i < len(self.apart):
                    self.apart[i] = value
                else:
                    self.hpart[i] = value
            else:
                raise TypeError('不要用float作为key')
        elif isinstance(key, str):
            self.hpart[key] = value
        else:
            raise TypeError('不要使用int和str以外的类型作为key ' + key.__str__() + value.__str__())

    def V_set_table(self, key, value):
        table = self  # initially self
        while key not in table:  # 找不到key
            mm = get_metamethod(table, '__setter')
            if mm:  # 尝试mm
                table = mm  # 更新table
            else:
                table[key] = value  # 否则在当前table插入新pair
        else:
            table[key] = value  # 找到了直接更新pair

    def __iter__(self):
        for i in self.apart: yield i
        for k, v in self.hpart.items(): yield k, v

    def __len__(self):
        return len(self.apart) + len(self.hpart)

    def __str__(self):
        return self.apart.__str__() + self.hpart.__str__()

    __repr__ = __str__

    def __contains__(self, key):
        '''注意table同时是list和dict，但是in是dict的in，因此。。。；相比于get item，不跑出异常，而是返回False'''
        if isinstance(key, float):
            i = int(key)
            if i == key:
                if i >= 0 and i < len(self.apart): return True
                return i in self.hpart
        elif isinstance(key, str):
            return key in self.hpart
        else:
            return False


def lua_cond_true_false(o):
    '''lua真假定义'''
    if o == None: return False
    if o == False: return False
    return True


def lua_not(o):
    return not lua_cond_true_false(o)


def get_metamethod(obj, mt_name: str):
    '''
    对错误沉默，返回None；任何类型都可调用，但是没有元表或者元表没找到mm都会返回None
    不设计成方法'''
    assert mt_name
    if not (isinstance(obj, Table) and obj.metatable):
        return None
    if mt_name not in obj.metatable:
        return None
    return obj.metatable[mt_name]


if __name__ == '__main__':
    t = Table()
    t.append('ele1')
    t[2] = 'ele2'
    for i in t: print(i)
