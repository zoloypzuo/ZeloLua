from zvm import *
from zasm import *
def test_process():
    # ---- prepare p1
    p1 = Process('test_3_exe.json')
    run_p1=p1.run()
    next(run_p1)
    # ---- run by step
    # 	Var		Counter
    next(run_p1)
    # 	Mov		Counter, 16	;Counter=16
    next(run_p1)
    assert p1.stack_top().local_data['Counter']==16
    # LoopStart0:
    # Var		Dur
    next(run_p1)
    # Mov		Dur, 2000 ;Dur=2000
    next(run_p1)
    # Ret
    next(run_p1)


if __name__ == '__main__':
    test_process()