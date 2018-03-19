# ---- Constants -----------------------------------------------------------------------------
# ---- Filename --------------------------------------------------------------------------

MAX_FILENAME_SIZE = 2048  # Maximum filename length

SOURCE_FILE_EXT = ".XASM"  # Extension of a source code file
EXEC_FILE_EXT = ".XSE"  # Extension of an executable code file

# ---- Source Code -----------------------------------------------------------------------

MAX_SOURCE_CODE_SIZE = 65536  # Maximum number of lines in source
# code
MAX_SOURCE_LINE_SIZE = 4096  # Maximum source line length

# ---- ,XSE Header -----------------------------------------------------------------------

XSE_ID_STRING = "XSE0"  # Written to the file to state it's
# validity

VERSION_MAJOR = 0  # Major version number
VERSION_MINOR = 4  # Minor version number
from enum import Enum

# ---- Lexer -----------------------------------------------------------------------------

MAX_LEXEME_SIZE = 256  # Maximum lexeme size


class LexState(Enum):
    NOT_STRING = 0  # Lexemes are scanned as normal
    IN_STRING = 1  # Lexemes are scanned as strings
    END_STRING = 2  # Lexemes are scanned as normal, and the
    # next state is LEXEME_STATE_NOSTRING


class TokenType(Enum):
    INT = 0  # An integer literal
    FLOAT = 1  # An floating-point literal
    STRING = 2  # An string literal
    QUOTE = 3  # A double-quote
    IDENT = 4  # An identifier
    COLON = 5  # A colon
    OPEN_BRACKET = 6  # An openening bracket
    CLOSE_BRACKET = 7  # An closing bracket
    COMMA = 8  # A comma
    OPEN_BRACE = 9  # An openening curly brace
    CLOSE_BRACE = 10  # An closing curly brace
    NEWLINE = 11  # A newline

    INSTR = 12  # An instruction

    SETSTACKSIZE = 13  # The SetStackSize directive
    VAR = 14  # The Var/Var [] directives
    FUNC = 15  # The Func directives
    PARAM = 16  # The Param directives
    REG_RETVAL = 17  # The _RetVal directives

    INVALID = 18  # Error code for invalid tokens
    END_OF_TOKEN_STREAM = 19  # The end of the stream has been reached


MAX_IDENT_SIZE = 256  # Maximum identifier size
# ---- Instruction Lookup Table ----------------------------------------------------------

MAX_INSTR_LOOKUP_COUNT = 256  # The maximum number of instructions the lookup table will hold
MAX_INSTR_MNEMONIC_SIZE = 16  # Maximum size of an instruction mnemonic's string


# mnemonic's string


# ---- Instruction Opcodes -----------------------------------------------------------


class OpCode(Enum):
    MOV = 0

    ADD = 1
    SUB = 2
    MUL = 3
    DIV = 4
    MOD = 5
    EXP = 6
    NEG = 7
    INC = 8
    DEC = 9

    AND = 10
    OR = 11
    XOR = 12
    NOT = 13
    SHL = 14
    SHR = 15

    CONCAT = 16
    GETCHAR = 17
    SETCHAR = 18

    JMP = 19
    JE = 20
    JNE = 21
    JG = 22
    JL = 23
    JGE = 24
    JLE = 25

    PUSH = 26
    POP = 27

    CALL = 28
    RET = 29
    CALLHOST = 30

    PAUSE = 31
    EXIT = 32


# ---- Operand Type Bitfield Flags ---------------------------------------------------

# The following constants are used as flags into an operand type bit field, hence
# their values being increasing powers of 2.
class OperandFlag(Enum):
    INT = 1  # Integer literal value
    FLOAT = 2  # Floating-point literal value
    STRING = 4  # Integer literal value
    MEM_REF = 8  # Memory reference (variable or array
    # index, both absolute and relative)
    LINE_LABEL = 16  # Line label (used for jumps)
    FUNC_NAME = 32  # Function table index (used for Call)
    HOST_API_CALL = 64  # Host API Call table index (used for
    # CallHost)
    REG = 128  # Register


# ---- Assembled Instruction Stream ------------------------------------------------------


class AssembledOperand(Enum):
    INT = 0  # Integer literal value
    FLOAT = 1  # Floating-point literal value
    STRING_INDEX = 2  # String literal value
    ABS_STACK_INDEX = 3  # Absolute array index
    REL_STACK_INDEX = 4  # Relative array index
    INSTR_INDEX = 5  # Instruction index
    FUNC_INDEX = 6  # Function index
    HOST_API_CALL_INDEX = 7  # Host API call index
    REG = 8  # Register


# ---- Functions -------------------------------------------------------------------------

MAIN_FUNC_NAME = "_MAIN"  # _Main ()'s name
# ---- Error Strings ---------------------------------------------------------------------

# The following macros are used to represent assembly-time error strings
ERROR_MSSG_INVALID_INPUT = "Invalid input"

ERROR_MSSG_LOCAL_SETSTACKSIZE = "SetStackSize can only appear in the global scope"

ERROR_MSSG_INVALID_STACK_SIZE = "Invalid stack size"

ERROR_MSSG_MULTIPLE_SETSTACKSIZES = "Multiple instances of SetStackSize illegal"

ERROR_MSSG_IDENT_EXPECTED = "Identifier expected"

ERROR_MSSG_INVALID_ARRAY_SIZE = "Invalid array size"

ERROR_MSSG_IDENT_REDEFINITION = "Identifier redefinition"

ERROR_MSSG_UNDEFINED_IDENT = "Undefined identifier"

ERROR_MSSG_NESTED_FUNC = "Nested functions illegal"

ERROR_MSSG_FUNC_REDEFINITION = "Function redefinition"

ERROR_MSSG_UNDEFINED_FUNC = "Undefined function"

ERROR_MSSG_GLOBAL_PARAM = "Parameters can only appear inside functions"

ERROR_MSSG_MAIN_PARAM = "_Main () function cannot accept parameters"

ERROR_MSSG_GLOBAL_LINE_LABEL = "Line labels can only appear inside functions"

ERROR_MSSG_LINE_LABEL_REDEFINITION = "Line label redefinition"

ERROR_MSSG_UNDEFINED_LINE_LABEL = "Undefined line label"

ERROR_MSSG_GLOBAL_INSTR = "Instructions can only appear inside functions"

ERROR_MSSG_INVALID_INSTR = "Invalid instruction"

ERROR_MSSG_INVALID_OP = "Invalid operand"

ERROR_MSSG_INVALID_STRING = "Invalid string"

ERROR_MSSG_INVALID_ARRAY_NOT_INDEXED = "Arrays must be indexed"

ERROR_MSSG_INVALID_ARRAY = "Invalid array"

ERROR_MSSG_INVALID_ARRAY_INDEX = "Invalid array index"


class ScriptHeader():
    def __int__(self):
        self.StackSize = 0  # Requested stack size
        self.GlobalDataSize = 0  # The size of the script's global data
        self.MainFuncPresent = False  # Is _Main () present?
        self.MainFuncIndex = 0  # _Main ()'s function index


class InstrLookup():

    def __init__(self):
        self.Mnemonic = ""  # Mnemonic string
        self.Opcode = 0  # Opcode
        self.oprand_count = 0  # Number of operands
        self.oprand_types = []  # Pointer to operand list


class AssembledOperand():

    def __init__(self):
        self.Type = 0  # Type
        self.value = None  # The value
        # possible value type:
        # int iIntLiteral;                        # Integer literal
        # float fFloatLiteral;                    # Float literal
        # int iStringTableIndex;                  # String table index
        # int iStackIndex;                        # Stack index
        # int iInstrIndex;                        # Instruction index
        # int iFuncIndex;                         # Function index
        # int iHostAPICallIndex;                  # Host API Call index
        # int iReg;                               # Register code
        self.OffsetIndex = 0  # Index of the offset


class Instr():
    def __init__(self):
        self.Opcode = 0  # Opcode
        self.operand_count = 0  # Number of operands
        self.oprand_list = []  # Pointer to operand list


class FuncNode():

    def __init__(self):
        self.Index = 0
        self.Name = ""
        self.ParamCount = 0
        self.LocalDataSize = 0


class LabelNode():
    def __init__(self):
        self.Index
        self.name = ""
        self.TargetIndex = 0
        self.FuncIndex = 0


class SymbolNode():
    def __init(self):
        self.Index = 0
        self.name = ""
        self.LocalDatasize = 0
        self.StackIndex = 0
        self.FuncIndex = 0


class Lexer():
    def __init__(self):
        # 基本
        self.curr_src_line_index = 0
        self.Index0 = 0
        self.Index1 = 0
        self.CurrToken = 0
        self.CurrLexeme = ""
        self.CurrLexState = LexState.NOT_STRING

        self.SourceCodes = []
        self.SourceCodeSize = 0

        self.SourceFilename = ""
        self.ExecFilename = ""
        # ---- Initialize the script header
        self.ScriptHeader = ScriptHeader()
        self.ScriptHeader.StackSize = 0
        self.ScriptHeader.MainFuncPresent = False
        self.ScriptHeader.GlobalDataSize = 0

        self.InstrStream = ""
        self.InstrStreamSize = 0
        self.SetStackSizeFound = False
        self.CurrInstrIndex = 0

        self.InstrTable = {}
        self.FuncTable = {}
        self.LabelTable = {}
        self.SymbolTable = {}
        self.StringTable = {}
        self.HostAPICallTable = {}

        # iIsFuncActive = False
        # pCurrFunc = FuncNode()
        # CurrFuncIndex
        # CurrFuncName

        # iCurrFuncParamCount = 0
        # iCurrFuncLocalDataSize = 0

        # Create an instruction definition structure to hold instruction information when
        # dealing with instructions.

        # CurrInstr = InstrLookup()

    def ResetLexer(self):
        self.curr_src_line_index = 0
        self.Index0 = 0
        self.Index1 = 0
        self.CurrToken = TokenType.INVALID
        self.CurrLexState = LexState.NOT_STRING

    #     #--核心组件---------------------------

    def GetCurrLexeme(self):  # 从来不用
        """获取当前lexeme
           补充】非常简单，因为GetToken分析出并设置了当前词素，单纯的getter"""
        # rtype string
        return self.CurrLexeme

    #     def GetLookAheadChar():
    #         """偷看下一个char
    #            补充】下一个词素的第一个char，并返回"""
    #         pass
    def is_EOF(self):
        return self.curr_src_line_index >= len(self.SourceCodes)  # ?

    def SkipToNextLine(self):
        """忽略该行剩下的字符直接跳到下一行，EOF时返回False"""
        self.curr_src_line_index += 1
        self.Index0 = 0
        self.Index1 = 0
        self.CurrLexState = LexState.NOT_STRING

    def LoadSourceFile(self, path):  # 测试后加载完数组为空
        with open(path) as f:
            for i in f:
                self.SourceCodeSize += 1
                x = StripComments(i)
                x = TrimWhitespace(x)
                self.SourceCodes.append(x)

    def AssembleSourceFile(self):

        # Set the current function's flags and variables  ？？？

        # ---- Perform first pass over the source

        # Reset the lexer

        self.ResetLexer()

        def on_set_stack_size():
            pass

        def on_var():
            pass

        def on_func():
            pass

        def on_close_brace():
            pass

        def on_param():
            pass

        def on_instr():
            pass

        def on_indent():
            pass

        first_pass_token_type2action = {
            TokenType.SETSTACKSIZE: on_set_stack_size,
            TokenType.VAR: on_var,
            TokenType.FUNC: on_func,
            TokenType.CLOSE_BRACE: on_close_brace,
            TokenType.PARAM: on_param,
            TokenType.INSTR: on_instr,
            TokenType.IDENT: on_indent
        }
        # Loop through each line of code
        while True:
            # Get the next token and make sure we aren't at the end of the stream
            if self.GetNextToken() == TokenType.END_OF_TOKEN_STREAM: break
            try:
                first_pass_token_type2action[self.CurrToken]()
            except KeyError:
                # Anything else should cause an error, minus line breaks
                if self.CurrToken != TokenType.NEWLINE:
                    ExitOnCodeError(ERROR_MSSG_INVALID_INPUT)
            # Skip to the next line, since the initial tokens are all we're really worrid
            # about in this phase
            self.SkipToNextLine()
            if not self.is_EOF(): break

        # We counted the instructions, so allocate the assembled instruction stream array
        # so the next phase can begin

        self.InstrStream = []

        # Initialize every operand list pointer to NULL
        pass

        # Set the current instruction index to zero

        self.CurrInstrIndex = 0

        # ---- Perform the second pass over the source

        # Reset the lexer so we begin at the top of the source again

        self.ResetLexer()

        def on_second_func():
            pass

        def on_second_close_brace():
            pass

        def on_second_param():
            pass

        def on_second_instr():
            pass

        second_pass_token_type2action = {
            TokenType.FUNC: on_second_func,
            TokenType.CLOSE_BRACE: on_second_close_brace,
            TokenType.PARAM: on_second_param,
            TokenType.INSTR: on_second_instr
        }

        # Loop through each line of code
        while True:
            # Get the next token and make sure we aren't at the end of the stream
            if self.GetNextToken() == TokenType.END_OF_TOKEN_STREAM: break
            try:
                second_pass_token_type2action[self.CurrToken]()
            except KeyError:
                ExitOnCodeError(ERROR_MSSG_INVALID_OP)

            # Skip to the next line
            self.SkipToNextLine()
            if not self.is_EOF(): break

    def BuildXSE(self):
        pass


import re


def StripComments(SourceLine):
    # 删除注释，要考虑到字符串
    InString = False
    str_index = 0
    for i in SourceLine:
        if i == "\"":
            if (InString):
                InString = False
            else:
                InString = True
        if i == ";" and not InString:
            return SourceLine[str_index]
        str_index += 1


def TrimWhitespace(String):  # x命名不好
    return String.strip("\s")


# // ---- String Processing -----------------------------------------------------------------


def IsCharWhitespace(Char):
    return re.match("[ \t]", Char) is not None


def IsCharNumeric(Char):
    return re.match("[0-9]", Char) is not None


def IsCharIdent(Char):
    return re.match("\w", Char) is not None


def IsCharDelimiter(Char):
    return re.match('[\:\,"\[\]\{\}\s]', Char) is not None  # 这个re并不好写，要多试


def IsStringWhitespace(String):
    if String == None: return False
    if String == "": return True
    for i in String:
        if not IsCharWhitespace(i):
            return False
    return True


def IsStringIdent(String):
    if String == None: return False
    if String == "": return False
    if IsCharNumeric(String[0]): return False
    for i in String:
        if not IsCharIdent(i):
            return False
    return True


def IsStringInteger(String):
    if String == None: return False
    if String == "": return False
    if not (IsCharNumeric(String[0]) or String[0] == "-"):
        return False
    for i in String[1:]:
        if not IsCharNumeric(i):
            return False
    return True


def IsStringFloat(String):
    if String == None: return False
    if String == "": return False
    RadixPointFound = False
    if not (IsCharNumeric(String[0]) or String[0] == "-" or String[0] == "."):
        return False
    for i in String[1:]:
        if (not (IsCharNumeric(i) or i == ".")):
            return False
        if i == ".":
            if RadixPointFound:
                return False
            else:
                RadixPointFound = True
    if RadixPointFound:
        return True
    else:
        return False


def ExitOnCodeError(error_msg): exit(error_msg)
