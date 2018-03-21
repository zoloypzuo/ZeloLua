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


class Opcode(Enum):
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


class Table(dict):
    """添加表项禁止key重复（也不允许设置已有的项），添加时返回分配给的index"""

    def __setitem__(self, key, value):
        if self.__contains__(key):
            ExitOnCodeError(ERROR_MSSG_IDENT_REDEFINITION)  # 这里信息是不对的，但是可以忽略
        return dict.__setitem__(self, key, value)

    def add(self, key, value):
        self.__setitem__(key, value)
        return len(self) - 1


class SimpleTable(list):
    """添加时返回分配给的index"""
    def add(self,key):
        self.append(key)
        return len(self)-1

class AssembledInstr():

    def __init__(self):
        self.Opcode = 0  # Opcode
        self.operand_count = 0  # Number of operands
        self.oprand_list = []  # Pointer to operand list


class AssembledOperand():

    def __init__(self):
        self.Type = 0  # Type

        # The value
        # possible value type:
        # int iIntLiteral;                        # Integer literal
        # float fFloatLiteral;                    # Float literal
        # int iStringTableIndex;                  # String table index
        # int iStackIndex;                        # Stack index
        # int iInstrIndex;                        # Instruction index
        # int iFuncIndex;                         # Function index
        # int iHostAPICallIndex;                  # Host API Call index
        # int iReg;                               # Register code
        self.value = None
        self.OffsetIndex = 0  # Index of the offset


class InstrNode():
    """ISA中一条指令的相关信息"""

    def __init__(self,Mnemonic,Opcode,operand_count):
        self.Mnemonic = Mnemonic  # Mnemonic string
        self.Opcode = OpCode  # Opcode
        self.operand_count = operand_count  # Number of operands
        # Pointer to operand list;
        # index is index of operand in the instr,and value is its type, which is defined in OperandFlag
        self.operand_types = []


class FuncNode():

    def __init__(self, Name):
        self.Index = 0  # Index
        self.Name = Name  # Name
        self.EntryPoint = 0  # Entry point
        self.ParamCount = 0  # Param count
        self.LocalDataSize = 0  # Local data size


class LabelNode():
    def __init__(self, name, FuncIndex):
        self.Index = 0  # Index
        self.name = name  # Identifier
        self.TargetIndex = 0  # Index of the target instruction
        self.FuncIndex = FuncIndex  # Function in which the label resides


class SymbolNode():
    def __init__(self, name, FuncIndex):
        self.Index = 0  # Index
        self.name = name  # Identifier
        self.Size = 0  # Size (1 for variables, N for arrays)
        self.StackIndex = 0  # The stack index to which the symbol
        self.FuncIndex = FuncIndex  # Function in which the symbol resides


class Lexer():
    def __init__(self):
        # 基本
        self.curr_src_line_index = 0
        self.Index0 = 0
        self.Index1 = 0
        self.CurrToken = 0
        self.CurrLexeme = ""
        self.CurrLexState = LexState.NOT_STRING
        # ---- Source Code
        self.SourceCodes = []
        self.SourceCodeSize = 0

        self.SourceFilename = ""
        self.ExecFilename = ""
        # ---- Script
        # ---- Initialize the script header
        self.ScriptHeader = ScriptHeader()
        self.ScriptHeader.StackSize = 0
        self.ScriptHeader.MainFuncPresent = False
        self.ScriptHeader.GlobalDataSize = 0
        self.SetStackSizeFound = False
        # ---- Assembled Instruction Stream
        # ---- Set some initial variables
        self.InstrStream = ""  # Pointer to a dynamically allocated instruction stream
        self.InstrStreamSize = 0  # The number of instructions
        self.CurrInstrIndex = 0  # The current instruction's index
        # ---- Instruction Lookup Table
        self.InstrTable = SimpleTable()
        self.FuncTable = Table()
        self.LabelTable = Table()
        self.SymbolTable = Table()
        self.StringTable = SimpleTable()
        self.HostAPICallTable = Table()

    def ResetLexer(self):
        self.curr_src_line_index = 0
        self.Index0 = 0
        self.Index1 = 0
        self.CurrToken = TokenType.INVALID
        self.CurrLexState = LexState.NOT_STRING

    def GetCurrLexeme(self):  # 从来不用
        """获取当前lexeme
           补充】非常简单，因为GetToken分析出并设置了当前词素，单纯的getter"""
        # rtype string
        return self.CurrLexeme

    def GetLookAheadChar(self):
        """偷看下一个char
           补充】下一个词素的第一个char，并返回"""
        # We don't actually want to move the lexer's indices, so we'll make a copy of them

        curr_src_line_index = self.curr_src_line_index
        iIndex = self.iIndex1

        # If the next lexeme is not a string, scan past any potential leading whitespace

        if self.iCurrLexState != LexState.IN_STRING:
            # Scan through the whitespace and check for the end of the line

            while True:
                # If we've passed the end of the line, skip to the next line and reset the
                # index to zero

                if iIndex >= len(self.SourceCodes[curr_src_line_index]):
                    # Increment the source code index

                    curr_src_line_index += 1

                    # If we've passed the end of the source file, just return a null character

                    if curr_src_line_index >= self.iSourceCodeSize:
                        # ! variable declaration...

                        # Otherwise, reset the index to the first character on the new line

                        iIndex = 0

                # If the current character is not whitespace, return it, since it's the first
                # character of the next lexeme and is thus the look-ahead

                if not IsCharWhitespace(self.SourceCodes[curr_src_line_index][iIndex]):
                    break

                # It is whitespace, however, so move to the next character and continue scanning

                iIndex += 1

        # Return whatever character the loop left iIndex at

        return self.SourceCodes[curr_src_line_index][iIndex]

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
        # Set the current function's flags and variables
        iIsFuncActive = False
        CurrFunc = FuncNode()
        CurrFuncIndex = 0
        CurrFuncName = ""
        CurrFuncParamCount = 0
        CurrFuncLocalDataSize = 0
        # Create an instruction definition structure to hold instruction information when
        # dealing with instructions.

        CurrInstr = InstrNode()

        # ---- Perform first pass over the source

        # Reset the lexer

        self.ResetLexer()

        def on_set_stack_size():  # SetStackSize
            # SetStackSize can only be found in the global scope, so make sure we
            # aren't in a function.
            if IsFuncActive: ExitOnCodeError(ERROR_MSSG_LOCAL_SETSTACKSIZE)
            # It can only be found once, so make sure we haven't already found it

            if self.IsSetStackSizeFound:
                ExitOnCodeError(ERROR_MSSG_MULTIPLE_SETSTACKSIZES)

            # Read the next lexeme, which should contain the stack size

            if self.GetNextToken() != TokenType.INT:
                ExitOnCodeError(ERROR_MSSG_INVALID_STACK_SIZE)

            # Convert the lexeme to an integer value from its string
            # representation and store it in the script header

            self.ScriptHeader.StackSize = int(self.GetCurrLexeme())

            # Mark the presence of SetStackSize for future encounters

            self.IsSetStackSizeFound = True

        def on_var():  # Var/Var []
            # Get the variable's identifier

            if self.GetNextToken() != TokenType.IDENT:
                ExitOnCodeError(ERROR_MSSG_IDENT_EXPECTED)

            Ident = self.GetCurrLexeme()[:]
            # Now determine its size by finding out if it's an array or not, otherwise
            # default to 1.

            Size = 1

            # Find out if an opening bracket lies ahead

            if self.GetLookAheadChar() == '[':
                # Validate and consume the opening bracket

                if self.GetNextToken() != TokenType.OPEN_BRACKET:
                    ExitOnCharExpectedError('[')

                # We're parsing an array, so the next lexeme should be an integer
                # describing the array's size

                if self.GetNextToken() != TokenType.INT:
                    ExitOnCodeError(ERROR_MSSG_INVALID_ARRAY_SIZE)

                # Convert the size lexeme to an integer value

                Size = int(self.GetCurrLexeme())

                # Make sure the size is valid, in that it's greater than zero

                if Size <= 0:
                    ExitOnCodeError(ERROR_MSSG_INVALID_ARRAY_SIZE)

                # Make sure the closing bracket is present as well

                if self.GetNextToken() != TokenType.CLOSE_BRACKET:
                    ExitOnCharExpectedError(']')
            # Determine the variable's index into the stack

            # If the variable is local, then its stack index is always the local data
            # size + 2 subtracted from zero

            if iIsFuncActive:
                iStackIndex = -(CurrFuncLocalDataSize + 2)

            # Otherwise it's global, so it's equal to the current global data size

            else:
                iStackIndex = self.ScriptHeader.GlobalDataSize

            # Attempt to add the symbol to the table
            # self.AddSymbol(Ident, Size, iStackIndex, CurrFuncIndex)

            # Depending on the scope, increment either the local or global data size
            # by the size of the variable

            if iIsFuncActive:
                CurrFuncLocalDataSize += Size
            else:
                self.ScriptHeader.iGlobalDataSize += Size

        def on_func():
            # First make sure we aren't in a function already, since nested functions
            # are illegal

            if iIsFuncActive:
                ExitOnCodeError(ERROR_MSSG_NESTED_FUNC)

            # Read the next lexeme, which is the function name

            if self.GetNextToken() != TokenType.IDENT:
                ExitOnCodeError(ERROR_MSSG_IDENT_EXPECTED)

            pstrFuncName = self.GetCurrLexeme()

            # Calculate the function's entry point, which is the instruction immediately
            # following the current one, which is in turn equal to the instruction stream
            # size

            iEntryPoint = self.iInstrStreamSize

            # Try adding it to the function table, and pran error if it's already
            # been declared

            # iFuncIndex = AddFunc(pstrFuncName, iEntryPoint)
            # if iFuncIndex == -1:
            #     ExitOnCodeError(ERROR_MSSG_FUNC_REDEFINITION)

            # Is this the _Main () function?

            if pstrFuncName == MAIN_FUNC_NAME:
                self.ScriptHeader.iIsMainFuncPresent = True
                self.ScriptHeader.iMainFuncIndex = iFuncIndex

            # Set the function flag to true for any future encounters and re-initialize
            # function tracking variables

            iIsFuncActive = True
            pstrCurrFuncName = pstrFuncName
            iCurrFuncIndex = iFuncIndex
            iCurrFuncParamCount = 0
            iCurrFuncLocalDataSize = 0

            # Read any number of line breaks until the opening brace is found

            while self.GetNextToken() == TokenType.NEWLINE: pass

            # Make sure the lexeme was an opening brace

            if self.CurrToken != TokenType.OPEN_BRACE:
                ExitOnCharExpectedError('{')

            # All functions are automatically appended with Ret, so increment the
            # required size of the instruction stream

            self.iInstrStreamSize += 1

        def on_close_brace():
            # This should be closing a function, so make sure we're in one

            if not iIsFuncActive:
                ExitOnCharExpectedError('}')

            # Set the fields we've collected

            # SetFuncInfo(pstrCurrFuncName, iCurrFuncParamCount, iCurrFuncLocalDataSize)

            # Close the function

            iIsFuncActive = False

        def on_param():
            # If we aren't currently in a function, pran error

            if not iIsFuncActive:
                ExitOnCodeError(ERROR_MSSG_GLOBAL_PARAM)

            # _Main () can't accept parameters, so make sure we aren't in it

            if pstrCurrFuncName == MAIN_FUNC_NAME:
                ExitOnCodeError(ERROR_MSSG_MAIN_PARAM)

            # The parameter's identifier should follow

            if self.GetNextToken() != TokenType.IDENT:
                ExitOnCodeError(ERROR_MSSG_IDENT_EXPECTED)

            # Increment the current function's local data size

            iCurrFuncParamCount += 1

        def on_instr():
            # Make sure we aren't in the global scope, since instructions
            # can only appear in functions

            if not iIsFuncActive:
                ExitOnCodeError(ERROR_MSSG_GLOBAL_INSTR)

            # Increment the instruction stream size

            self.iInstrStreamSize += 1

        def on_indent():
            # Make sure it's a line label

            if self.GetLookAheadChar() != ':':
                ExitOnCodeError(ERROR_MSSG_INVALID_INSTR)

            # Make sure we're in a function, since labels can only appear there

            if not iIsFuncActive:
                ExitOnCodeError(ERROR_MSSG_GLOBAL_LINE_LABEL)

            # The current lexeme is the label's identifier

            pstrIdent = self.GetCurrLexeme()

            # The target instruction is always the value of the current
            # instruction count, which is the current size - 1

            iTargetIndex = self.iInstrStreamSize - 1

            # Save the label's function index as well

            iFuncIndex = iCurrFuncIndex

            # Try adding the label to the label table, and pran error if it
            # already exists

            if AddLabel(pstrIdent, iTargetIndex, iFuncIndex) == -1:
                ExitOnCodeError(ERROR_MSSG_LINE_LABEL_REDEFINITION)

        def default():
            # Anything else should cause an error, minus line breaks

            if self.CurrToken != TokenType.NEWLINE:
                ExitOnCodeError(ERROR_MSSG_INVALID_INPUT)

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
            # We've encountered a Func directive, but since we validated the syntax
            # of all functions in the previous phase, we don't need to perform any
            # error handling here and can assume the syntax is perfect.

            # Read the identifier

            self.GetNextToken()

            # Use the identifier (the current lexeme) to get it's corresponding function
            # from the table

            pCurrFunc = GetFuncByName(GetCurrLexeme())

            # Set the active function flag

            iIsFuncActive = True

            # Set the parameter count to zero, since we'll need to count parameters as
            # we parse Param directives

            iCurrFuncParamCount = 0

            # Save the function's index

            iCurrFuncIndex = pCurrFunc.iIndex

            # Read any number of line breaks until the opening brace is found

            while self.GetNextToken() == TokenType.NEWLINE: pass

        def on_second_close_brace():
            # Clear the active function flag

            iIsFuncActive = False

            # If the ending function is _Main (), append an Exit instruction

            if pCurrFunc.pstrName == MAIN_FUNC_NAME:
                # First set the opcode

                self.pInstrStream[self.iCurrInstrIndex].iOpcode = INSTR_EXIT

                # Now set the operand count

                self.pInstrStream[self.iCurrInstrIndex].iOpCount = 1

                # Now set the return code by allocating space for a single operand and
                # setting it to zero

                self.pInstrStream[self.iCurrInstrIndex].pOpList[0].iType = OP_TYPE_INT
                self.pInstrStream[self.iCurrInstrIndex].pOpList[0].iIntLiteral = 0

            # Otherwise append a Ret instruction and make sure to NULLify the operand
            # list pointer

            else:
                self.pInstrStream[self.iCurrInstrIndex].iOpcode = INSTR_RET
                self.pInstrStream[self.iCurrInstrIndex].iOpCount = 0
                self.pInstrStream[self.iCurrInstrIndex].pOpList = None

            self.iCurrInstrIndex += 1

        def on_second_param():
            # Read the next token to get the identifier

            if self.GetNextToken() != TokenType.IDENT:
                ExitOnCodeError(ERROR_MSSG_IDENT_EXPECTED)

            # Read the identifier, which is the current lexeme

            pstrIdent = self.GetCurrLexeme()

            # Calculate the parameter's stack index

            iStackIndex = -(pCurrFunc->iLocalDataSize + 2 + ( iCurrFuncParamCount + 1) )

            # Add the parameter to the symbol table

            if AddSymbol(pstrIdent, 1, iStackIndex, iCurrFuncIndex) == -1:
                ExitOnCodeError(ERROR_MSSG_IDENT_REDEFINITION)

            # Increment the current parameter count
            iCurrFuncParamCount += 1

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

    # // ---- Instructions - ---------------------------------------------------------------------

    def InitInstrTable(self):
        # Create a temporary index to use with each instruction

        # ! variable declaration...

        # The following code makes repeated calls to self.AddInstrLookup () to add a hardcoded
        # instruction set to the assembler's vocabulary. Each self.AddInstrLookup () call is
        # followed by zero or more calls to self.SetOpType (), whcih set the supported types of
        # a specific operand. The instructions are grouped by family.

        # ---- Main

        # Mov          Destination, Source

        iInstrIndex = self.AddInstrLookup("Mov", Opcode.MOV, 2)
        self.SetOpType(iInstrIndex, 0, OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 1, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)

        # ---- Arithmetic

        # Add         Destination, Source

        iInstrIndex = self.AddInstrLookup("Add", Opcode.ADD, 2)
        self.SetOpType(iInstrIndex, 0, OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 1, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)

        # Sub          Destination, Source

        iInstrIndex = self.AddInstrLookup("Sub", Opcode.SUB, 2)
        self.SetOpType(iInstrIndex, 0, OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 1, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)

        # Mul          Destination, Source

        iInstrIndex = self.AddInstrLookup("Mul", Opcode.MUL, 2)
        self.SetOpType(iInstrIndex, 0, OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 1, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)

        # Div          Destination, Source

        iInstrIndex = self.AddInstrLookup("Div", Opcode.DIV, 2)
        self.SetOpType(iInstrIndex, 0, OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 1, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)

        # Mod          Destination, Source

        iInstrIndex = self.AddInstrLookup("Mod", Opcode.MOD, 2)
        self.SetOpType(iInstrIndex, 0, OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 1, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)

        # Exp          Destination, Source

        iInstrIndex = self.AddInstrLookup("Exp", Opcode.EXP, 2)
        self.SetOpType(iInstrIndex, 0, OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 1, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)

        # Neg          Destination

        iInstrIndex = self.AddInstrLookup("Neg", Opcode.NEG, 1)
        self.SetOpType(iInstrIndex, 0, OperandFlag.MEM_REF |
                       OperandFlag.REG)

        # Inc          Destination

        iInstrIndex = self.AddInstrLookup("Inc", Opcode.INC, 1)
        self.SetOpType(iInstrIndex, 0, OperandFlag.MEM_REF |
                       OperandFlag.REG)

        # Dec          Destination

        iInstrIndex = self.AddInstrLookup("Dec", Opcode.DEC, 1)
        self.SetOpType(iInstrIndex, 0, OperandFlag.MEM_REF |
                       OperandFlag.REG)

        # ---- Bitwise

        # And          Destination, Source

        iInstrIndex = self.AddInstrLookup("And", Opcode.AND, 2)
        self.SetOpType(iInstrIndex, 0, OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 1, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)

        # Or           Destination, Source

        iInstrIndex = self.AddInstrLookup("Or", Opcode.OR, 2)
        self.SetOpType(iInstrIndex, 0, OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 1, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)

        # XOr          Destination, Source

        iInstrIndex = self.AddInstrLookup("XOr", Opcode.XOR, 2)
        self.SetOpType(iInstrIndex, 0, OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 1, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)

        # Not          Destination

        iInstrIndex = self.AddInstrLookup("Not", Opcode.NOT, 1)
        self.SetOpType(iInstrIndex, 0, OperandFlag.MEM_REF |
                       OperandFlag.REG)

        # ShL          Destination, Source

        iInstrIndex = self.AddInstrLookup("ShL", Opcode.SHL, 2)
        self.SetOpType(iInstrIndex, 0, OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 1, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)

        # ShR          Destination, Source

        iInstrIndex = self.AddInstrLookup("ShR", Opcode.SHR, 2)
        self.SetOpType(iInstrIndex, 0, OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 1, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)

        # ---- String Manipulation

        # Concat       String0, String1

        iInstrIndex = self.AddInstrLookup("Concat", Opcode.CONCAT, 2)
        self.SetOpType(iInstrIndex, 0, OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 1, OperandFlag.MEM_REF |
                       OperandFlag.REG |
                       OperandFlag.STRING)

        # GetChar      Destination, Source, Index

        iInstrIndex = self.AddInstrLookup("GetChar", Opcode.GETCHAR, 3)
        self.SetOpType(iInstrIndex, 0, OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 1, OperandFlag.MEM_REF |
                       OperandFlag.REG |
                       OperandFlag.STRING)
        self.SetOpType(iInstrIndex, 2, OperandFlag.MEM_REF |
                       OperandFlag.REG |
                       OperandFlag.INT)

        # SetChar      Destination, Index, Source

        iInstrIndex = self.AddInstrLookup("SetChar", Opcode.SETCHAR, 3)
        self.SetOpType(iInstrIndex, 0, OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 1, OperandFlag.MEM_REF |
                       OperandFlag.REG |
                       OperandFlag.INT)
        self.SetOpType(iInstrIndex, 2, OperandFlag.MEM_REF |
                       OperandFlag.REG |
                       OperandFlag.STRING)

        # ---- Conditional Branching

        # Jmp          Label

        iInstrIndex = self.AddInstrLookup("Jmp", Opcode.JMP, 1)
        self.SetOpType(iInstrIndex, 0, OperandFlag.LINE_LABEL)

        # JE           Op0, Op1, Label

        iInstrIndex = self.AddInstrLookup("JE", Opcode.JE, 3)
        self.SetOpType(iInstrIndex, 0, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 1, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 2, OperandFlag.LINE_LABEL)

        # JNE          Op0, Op1, Label

        iInstrIndex = self.AddInstrLookup("JNE", Opcode.JNE, 3)
        self.SetOpType(iInstrIndex, 0, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 1, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 2, OperandFlag.LINE_LABEL)

        # JG           Op0, Op1, Label

        iInstrIndex = self.AddInstrLookup("JG", Opcode.JG, 3)
        self.SetOpType(iInstrIndex, 0, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 1, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 2, OperandFlag.LINE_LABEL)

        # JL           Op0, Op1, Label

        iInstrIndex = self.AddInstrLookup("JL", Opcode.JL, 3)
        self.SetOpType(iInstrIndex, 0, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 1, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 2, OperandFlag.LINE_LABEL)

        # JGE          Op0, Op1, Label

        iInstrIndex = self.AddInstrLookup("JGE", Opcode.JGE, 3)
        self.SetOpType(iInstrIndex, 0, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 1, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 2, OperandFlag.LINE_LABEL)

        # JLE           Op0, Op1, Label

        iInstrIndex = self.AddInstrLookup("JLE", Opcode.JLE, 3)
        self.SetOpType(iInstrIndex, 0, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 1, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)
        self.SetOpType(iInstrIndex, 2, OperandFlag.LINE_LABEL)

        # ---- The Stack Interface

        # Push          Source

        iInstrIndex = self.AddInstrLookup("Push", Opcode.PUSH, 1)
        self.SetOpType(iInstrIndex, 0, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)

        # Pop           Destination

        iInstrIndex = self.AddInstrLookup("Pop", Opcode.POP, 1)
        self.SetOpType(iInstrIndex, 0, OperandFlag.MEM_REF |
                       OperandFlag.REG)

        # ---- The Function Interface

        # Call          FunctionName

        iInstrIndex = self.AddInstrLookup("Call", Opcode.CALL, 1)
        self.SetOpType(iInstrIndex, 0, OperandFlag.FUNC_NAME)

        # Ret

        iInstrIndex = self.AddInstrLookup("Ret", Opcode.RET, 0)

        # CallHost      FunctionName

        iInstrIndex = self.AddInstrLookup("CallHost", Opcode.CALLHOST, 1)
        self.SetOpType(iInstrIndex, 0, OperandFlag.HOST_API_CALL)

        # ---- Miscellaneous

        # Pause        Duration

        iInstrIndex = self.AddInstrLookup("Pause", Opcode.PAUSE, 1)
        self.SetOpType(iInstrIndex, 0, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)

        # Exit         Code

        iInstrIndex = self.AddInstrLookup("Exit", Opcode.EXIT, 1)
        self.SetOpType(iInstrIndex, 0, OperandFlag.INT |
                       OperandFlag.FLOAT |
                       OperandFlag.STRING |
                       OperandFlag.MEM_REF |
                       OperandFlag.REG)
    def AddInstrLookup(self, pstrMnemonic, iOpcode,iOpCount ):
        return self.InstrTable.add(InstrNode(pstrMnemonic.upper(),iOpcode,iOpCount))

    def SetOpType(self,iInstrIndex, iOpIndex,iOpType ):
        self.InstrTable[iInstrIndex].operand_types[iOpIndex]=iOpType
    # // ---- Tables - ---------------------------------------------------------------------------

    def AddString(self, String):
        return self.StringTable.add(String)

    def AddFunc(self,Name, iEntryPoint):
        new_func=FuncNode(Name)
        new_func.EntryPoint=iEntryPoint
        new_func.Index=self.FuncTable.add(Name,new_func)

    def GetFuncByName(self, Name):
        return self.FuncTable[Name]

    def SetFuncInfo(self,Name, iParamCount,iLocalDataSize ):
        self.FuncTable[Name].ParamCount=iParamCount
        self.FuncTable[Name].LocalDataSize = iLocalDataSize

    def AddLabel(self,Ident, iTargetIndex, iFuncIndex ):
        new_label=LabelNode(Ident,iFuncIndex)
        new_label.TargetIndex=iTargetIndex
        new_label.Index=self.LabelTable.add((Ident,iFuncIndex),new_label)

    def GetLabelByIdent(self,Ident, iFuncIndex ):
        return self.LabelTable[(Ident,iFuncIndex)]


    def AddSymbol(self, Name, Size, StackIndex, FuncIndex):
        new_symbol = SymbolNode(Name,FuncIndex)
        new_symbol.Size=Size
        new_symbol.StackIndex=StackIndex
        new_symbol.Index = self.SymbolTable.Add((Name, FuncIndex), new_symbol)

    def GetSymbolByIdent(self, Ident, iFuncIndex):
        return self.SymbolTable[(Ident, iFuncIndex)]

    def GetStackIndexByIdent(self, Ident, iFuncIndex):
        return self.SymbolTable[(Ident, iFuncIndex)].StackIndex

    def GetSizeByIdent(self, Ident, iFuncIndex):
        return self.SymbolTable[(Ident, iFuncIndex)].Size


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


# x没有实现好
def ExitOnCodeError(error_msg): exit(error_msg)


def ExitOnError(error_msg): exit(error_msg)


def ExitOnCharExpectedError(Char): exit(char)
