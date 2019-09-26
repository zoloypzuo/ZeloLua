from unittest import TestCase


class TestDebugger(TestCase):
    def test_execute(self):
        # self.fail()
        pass
    def test_parse_instr(self):
        from zlua_prototype.debugger import _parse_instr
        assert _parse_instr('f ')==('f','')