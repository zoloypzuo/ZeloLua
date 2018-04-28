from zvm import *
from zasm import *
def test_process():
    # ---- prepare p1
    p1 = Thread('1-assign_exe.json')
    rtp1=p1.run()
    for i in range(4):
        next(rtp1)
    assert p1.global_data['a']==10
    assert p1.global_data['b']==30.0
    assert p1.global_data['c'] == "foo"

    p2=Thread('2-call func_exe.json')
    rtp2=p2.run()
    for i in range(8):
        next(rtp2)
    assert p2.global_data['.ret_val']==2
    pass


if __name__ == '__main__':
    test_process()