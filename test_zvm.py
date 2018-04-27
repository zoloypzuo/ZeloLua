from zvm import *
from zasm import *
def test_process():
    # ---- prepare p1
    p1 = Process('1-assign_exe.json')
    run_p1=p1.run()
    next(run_p1)
    # ---- run by step
    # setglobal a 10
    next(run_p1)
    assert p1.global_data['a']==10
    # setglobal b 30
    next(run_p1)
    assert p1.global_data['b']==30.0
    # setglobal c "foo"
    next(run_p1)
    assert p1.global_data['c'] == "foo"
    next(run_p1)
    # Ret
    next(run_p1)


if __name__ == '__main__':
    test_process()