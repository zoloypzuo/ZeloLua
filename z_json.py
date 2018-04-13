"""
z_json_serialization provides encoding and decoding for class object to extend standard library 'json'.
requirement:
1. class should be built by yourself, to avoid tricky things like Datetime
2. class should conform to json standard:
    1. use list (avoid tuple)
    2. use dict, and only use str as key (avoid tuple, int, float)
    3. use primitive type: int, float, str, bool, None

interface:
1. {func} beautified_json and {func} plain_json is simple to use, and it is as same as use {std} json with {func} encodable

TODO 虽然支持cast，但是最好检测出tuple，之后复原;同样上面的2.2也是
TODO 支持namedtuple，namedtuple在json.dumps后返回tuple的dumps，只有值，考虑从_asdict。。。

"""

from json import dumps, load as _load, loads as _loads


# ---- serialize
class A:
    pass


def encodable(obj, decodable=True) -> object:
    '''
    make class obj serializable to json, please conform to json standard
    if set undecodable to true, class will be encoded the same as dict, the output json may be thus easier to read or ...
    commonly, class is encoded with a special dict that contains class mod name, class name and class dict so that it can be decoded then
    :param obj:
    :param undecodable:
    :return:json_obj, commonly a dict
    '''
    # TODO 可能需要扩充，else来报错是不存在的
    # TODO 日后类型等限制可能解除，所以有些地方要再思考一下，比如class obj处
    COMMON_NOT_ALLOWED_TYPES = (set,)
    assert not isinstance(obj, COMMON_NOT_ALLOWED_TYPES)
    if isinstance(obj, (int, float, str, bool)):
        return obj
    elif isinstance(obj, (list,tuple)):
        return [encodable(i, decodable=decodable) for i in obj]
    elif isinstance(obj, dict):
        for key, val in obj.items():
            assert isinstance(key, str)
        return {encodable(key, decodable=decodable): encodable(val, decodable=decodable) for key, val in obj.items()}
    elif obj is None:
        return None
    else:  # class type; note that isinstanceof(object) is useless since even dict returns true
        if not decodable: #if decoable is set to false, class info wont be recorded
            return {encodable(key, decodable=decodable): encodable(val, decodable=decodable) for key, val in
                    obj.__dict__.items()}
        else:
            _ret = {'__class_module__': obj.__class__.__module__, '__class_name__': obj.__class__.__name__,
                    '__class_dict__': {}}
            for key, value in obj.__dict__.items():
                _ret['__class_dict__'][encodable(key, decodable=decodable)] = encodable(value, decodable=decodable)
            return _ret


def beautified_json(obj, decodable=True) -> str:
    '''return beautified json str of obj;
       also used to overwrite obj.__str__ for pretty output eg. def __str__(self):return beau...(self)'''
    return dumps(encodable(obj, decodable=decodable), indent=4, sort_keys=True)



def plain_json(obj, decodable=True):
    '''return plain/compact json str of obj
       add "@compact" for test'''
    a = encodable(obj)
    return dumps(encodable(obj,  decodable=decodable))


# ---- deserialize
import sys


def _load_class(module, name):
    """Loads the module and returns the class.

    >>> _loadclass('test.classes','A')
    <class 'test.classes.A'>
    """
    __import__(module)
    mod = sys.modules[module]
    cls = getattr(mod, name)
    return cls


def _is_class_dict(obj):
    """Helper class that tests to see if the obj is a flattened object

    >>> _isclass_dict({'__class_module__':'__builtin__', '__class_name__':'int'})
    True
    >>> _isclass_dict({'key':'value'})
    False
    >>> _isclass_dict(25)
    False
    """
    if type(obj) is dict and \
            obj.__contains__('__class_module__') and obj.__contains__('__class_name__'):
        return True
    return False


def decode(json_obj: object) -> object:
    '''

    :param json_obj: json_obj return by json.load(s)
    :return:
    '''
    if _is_class_dict(json_obj):  # class must be checked before dict, or it will be...
        # if it is a encoded class, we load class (class is object in python) and new it, then recursively build its dict
        cls = _load_class(json_obj['__class_module__'], json_obj['__class_name__'])
        instance = object.__new__(cls)
        instance.__dict__ = {decode(key): decode(val) for key, val in json_obj['__class_dict__'].items()}
        return instance
    elif isinstance(json_obj, (int, float, str, bool)):
        return json_obj
    elif isinstance(json_obj, list):
        return [decode(i) for i in json_obj]
    elif json_obj is None:
        return None
    elif isinstance(json_obj, dict):
        return {decode(key): decode(val) for key, val in json_obj.items()}


def load(path) -> object:
    with open(path, 'r') as f:
        return decode(_load(f))


def loads(json_text: str) -> object:
    _loads(json_text)
    return decode(_loads(json_text))
