from json import dumps

# ---- serialize


def compact(f):
    """remove spaces from str output of f"""
    def _compact(s):
        return f(s).replace(' ', '')
    return _compact


def serializablize(obj):
    '''make class obj serializable to json, but notice that the key of dict in the obj must be str
    :return: json_obj, commonly a dict
    '''
    def _serialize(obj):
        if isinstance(obj, (int, float, str, bool)):
            return obj
        elif isinstance(obj, (list, tuple)):
            return [_serialize(i) for i in obj]
        elif isinstance(obj, dict):
            return {_serialize(key): _serialize(val) for key, val in obj.items()}
        elif obj is None:
            return None
        else:  # class type
            return {_serialize(key): _serialize(val) for key, val in obj.__dict__.items()}
    return _serialize(obj)


def beautified_json(obj):
    '''return beautified json str of obj
        also used to overwrite obj.__str__ for pretty output eg. def __str__(self):return beau...(self)'''
    return dumps(serializablize(obj), indent=4, sort_keys=True)

# @compact


def plain_json(obj):
    '''return plain/compact json str of obj
       add "@compact" for test'''
    return dumps(serializablize(obj))


# ---- deserialize
from re import match, sub


def generate_deserialize_code(path):
    '''
        generate code that deserialize json_obj and return obj
        paste the code to somewhere like "load_A_from_json()" in a A.py file

    :param path: .py file that contains definition of class, currently only 1 file
    :return: code that ...
    '''
    class_names = class_names_in_file(path)
    small_codes = '\n\t\t'.join([code_for_a_class(i) for i in class_names])
    old_code = '\n'.join(
        ['def deserialize(json_obj):',
         '\tif isinstance(json_obj,(int,float,str,bool)):',
         '\t\treturn json_obj',
         '\telif isinstance(json_obj,list):',
         '\t\treturn [deserialize(i) for i in json_obj]',
         '\telif json_obj is None:',
         '\t\treturn  None',
         '\telif isinstance(json_obj,dict):',
         '\t\tif False:pass  #just for foo',
         '\t\t!!!!',
         '\t\telse:',
         '\t\t\treturn {deserialize(key):deserialize(val) for key,val in json_obj.items() }'])
    return sub('!!!!', small_codes, old_code)


def class_names_in_file(path):
    with open(path, 'r', encoding='utf-8') as f:
        for line in f:
            i = match(r'class (\w+):', line)  # 暂时不完美，比如class后可以有括号，还有嵌套类是识别不出的
            if i is not None:
                yield i.group(1)


def code_for_a_class(class_name):
    example_old_str = '\n\t\t'.join(['elif json_obj.keys() == Tree().__dict__.keys():',
                                     '\tnew_tree=Tree()',
                                     '\tnew_tree.__dict__ = {deserialize(key): deserialize(val) for key, val in json_obj.items()}',
                                     '\treturn new_tree'])
    return sub(r'Tree|tree', class_name, example_old_str)


class A:

    def __init__(self):
        self.a = 0

    def __eq__(self, other):
        return self.__dict__ == other.__dict__


class B:

    def __init__(self):
        self.b = A()

    def __eq__(self, other):
        return self.__dict__ == other.__dict__


def deserialize(json_obj):
    if isinstance(json_obj, (int, float, str, bool)):
        return json_obj
    elif isinstance(json_obj, list):
        return [deserialize(i) for i in json_obj]
    elif json_obj is None:
        return None
    elif isinstance(json_obj, dict):
        if False:
            pass  # just for foo
        elif json_obj.keys() == A().__dict__.keys():
            new_A = A()
            new_A.__dict__ = {deserialize(key): deserialize(val) for key, val in json_obj.items()}
            return new_A
        elif json_obj.keys() == B().__dict__.keys():
            new_B = B()
            new_B.__dict__ = {deserialize(key): deserialize(val) for key, val in json_obj.items()}
            return new_B
        else:
            return {deserialize(key): deserialize(val) for key, val in json_obj.items()}


def test():
    # ----serialize
    assert plain_json(1) == '1'
    assert plain_json(1.1) == '1.1'
    assert plain_json('abc') == '"abc"'  # note 'abc' is wrong, "'abc'" is also wrong
    assert plain_json(True) == 'true'
    assert plain_json(None) == 'null'
    # assert plain_json([1, 2, 3]) == '[1,2,3]'
    # assert plain_json({1: 2}) == '{"1":2}'
    # assert plain_json(A()) == '{"a":0}'
    # assert plain_json(B()) == '{"b":{"a":0}}'

    # ----deserialize
    print(deserialize({'b': {'a': 0}}))
    assert deserialize({'b': {'a': 0}}) == B()
    print(code_for_a_class('A'))
    print(generate_deserialize_code('zasm.py'))
if __name__ == '__main__':
    test()
