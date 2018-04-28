from zvm import *
from zasm import *
def test_process():
    # ---- prepare p1
    p1 = Thread('1-assign_exe.json')
    p1.run()
    assert p1.global_data['a']==10
    assert p1.global_data['b']==30.0
    assert p1.global_data['c'] == "foo"


if __name__ == '__main__':
    test_process()