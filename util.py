import sys
def compact(f):
    """remove spaces from str output of f, used for test for convenience"""

    def _wrapper(*args, **kwargs):
        return f(*args, **kwargs).replace(' ', '')

    return _wrapper


def load_class(module, name):
    """Loads the module and returns the class.

    >>> _loadclass('test.classes','A')
    <class 'test.classes.A'>
    """
    __import__(module)
    mod = sys.modules[module]
    cls = getattr(mod, name)
    return cls


def is_class_dict(obj):
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


def is_named_tuple_dict(obj):
    return isinstance(obj, dict) and \
           obj.__contains__('__namedtuple_cls_name') and obj.__contains__('__namedtuple_dict')


def is_namedtuple_instance(x):
    t = type(x)
    b = t.__bases__
    if len(b) != 1 or b[0] != tuple: return False
    f = getattr(t, '_fields', None)
    if not isinstance(f, tuple): return False
    return all(type(n) == str for n in f)
