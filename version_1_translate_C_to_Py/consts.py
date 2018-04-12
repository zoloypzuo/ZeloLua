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
