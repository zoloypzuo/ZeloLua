-- lua值都可以作为条件测试，只有false和nil是条件为假

-- 短路运算
-- and短路规则：如果lhs条件为假，返回lhs，否则返回rhs
-- 短路是指，仅当有必要时再求rhs的值
4 and 5 --> 5
nil and 13 --> nil
false and 13 --> 13
0 or 5 --> 0
false or "hi" --> "hi"

-- not运算符返回条件bool
not nil --> true
not false --> true
not 0 --> false
not not 1 --> true
not not nil --> false