from functools import reduce
from re import match
class DFA:
    '''DETERMINISTIC FINITE AUTOMATON (A BIT OF THEORY)
    ===============================================

    Formal definition:
    ------------------

        M : (Q, Σ, δ, q0, F)
        Q                   finite set of internal states
        Σ                   finite set of symbols -- input alphabet
        δ : Q x Σ -> Q      total function -- transition function
        q0 ∈ Q              initial state
        F ⊆ Q               set of terminal states

    How a DFA operates:
    -------------------
    For each symbol in an input string, the automaton applies the δ function.
    If the string is processed as a whole and reaches a terminal state, then the
    string is considered accepted. Otherwise, it is rejected.

    A better way to understand/visualize automaton operations is to draw a graph
    from its definition...'''
    def __init__(self,alphabet,states,initial,terminals,transition_table):
        self.alphabet=alphabet #list of valid symbols
        self.states=states  #list of internal states
        self.initial=initial # {*states}initial state
        self.terminals=terminals # {list<*states>}final states
        self.transition_table=transition_table #{(curr_state, {*alphabet}input):next_state,...}

    def accept(self,string):
        '''
        return True if DFA accept the string
        :param string: {list<*alphabet>}
        :return:
        '''
        return reduce(
            lambda curr_state,input:self.transition_table[(curr_state,input)],
            string,self.initial) in self.terminals



