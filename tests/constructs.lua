print "testing syntax"

-- testing priorities
do
    assert(2 ^ 3 ^ 2 == 2 ^ (3 ^ 2));
    assert(2 ^ 3 * 4 == (2 ^ 3) * 4);
    --assert(2 ^ -2 == 1 / 4 and -2 ^ --2 == --4); 这行在format后不符合语法,不要测试
    assert(not nil and 2 and not (2 > 3 or 3 < 2));
    assert(-3 - 1 - 5 == 0 + 0 - 9);
    assert(-2 ^ 2 == -4 and (-2) ^ 2 == 4 and 2 * 2 - 3 - 1 == 0);
    assert(2 * 1 + 3 / 3 == 3 and tostring(1 + 2) .. tostring(3 * 1) == "3.03.0");--TODO 再想想
    assert(not (2 + 1 > 3 * 1) and "a" .. "b" == "ab");
    assert(not ((true or false) and nil))
    assert(true or false and nil)

    local a, b = 1, nil;
    assert(-(1 or 2) == -1 and (1 and 2) + (-1.25 or -4) == 0.75);
    x = ((b or a) + 1 == 2 and (10 or a) + 1 == 11);
    assert(x);
    x = (((2 < 3) or 1) == true and (2 < 3 and 4) == 4);
    assert(x);

    local x, y = 1, 2;
    assert((x > y) and x or y == 2);
    x = 2
    y = 1;
    assert((x > y) and x or y == 2);

    assert(1234567890 == tonumber('1234567890') and 1234567890 + 1 == 1234567891)
end

-- silly loops
do
    while false do
    end ;
    while nil do
    end ;
end

do
    -- test old bug (first name could not be an `upvalue')
    local a;
    local function f(x)
        x = { a = 1 };
        x = { x = 1 };
        x = { G = 1 }
    end
end

do
    local f = function(i)
        if i < 10 then
            return 'a';
        elseif i < 20 then
            return 'b';
        elseif i < 30 then
            return 'c';
        end ;
    end

    assert(f(3) == 'a' and f(12) == 'b' and f(26) == 'c' and f(100) == nil)
end

--for i=1,1000 do break; end; TODO 没有break
n = 100;
i = 3;
t = {};
a = nil
while not a do
    a = 0;
    for i = 1, n do
        for i = 0, i, 1 do
            a = a + 1;
            t[i] = 1;
        end ;
    end ;
end
print('a:', a)
print('i:', i)
assert(a == n * (n - 1) / 2 and i == 3);

do
    local f = function(i)
        if i < 10 then
            return 'a'
        elseif i < 20 then
            return 'b'
        elseif i < 30 then
            return 'c'
        else
            return 8
        end
    end

    assert(f(3) == 'a' and f(12) == 'b' and f(26) == 'c' and f(100) == 8)
    local a, b = nil, 23
    x = { tonumber(f(100)) * 2 + 3 or a, a or b + 2 }
    print(x)
    assert(x[0] == 19 and x[1] == 25)
    x = { f = 2 + 3 or a, a = b + 2 }
    assert(x.f == 5 and x.a == 25)
end

a = { y = 1 }
x = { a.y }

function f(i)
    while 1 do
        if i > 0 then
            i = i - 1;
        else
            return ;
        end ;
    end ;
end;

function g(i)
    while 1 do
        if i > 0 then
            i = i - 1
        else
            return
        end
    end
end

f(10);
g(10);

do
    function f ()
        return 1, 2, 3;
    end
    local a, b, c = f();
    assert(a == 1 and b == 2 and c == 3)
end

--do 这个测试不要了,zlua必须实参与形参匹配
--    local function g (a, b, c, d, e)
--        if not (a >= b or c or d and e or nil) then
--            return 0;
--        else
--            return 1;
--        end ;
--    end
--
--    local function h (a, b, c, d, e)
--        while (a >= b or c or (d and e) or nil) do
--            return 1;
--        end ;
--        return 0;
--    end;
--
--    assert(g(2, 1) == 1 and h(2, 1) == 1)
--    assert(g(1, 2, 'a') == 1 and h(1, 2, 'a') == 1)
--    assert(f(1, 2, 'a') == 'a' and g(1, 2, 'a') == 1 and h(1, 2, 'a') == 1)
--    assert(g(1, 2, nil, 1, 'x') == 1 and
--            h(1, 2, nil, 1, 'x') == 1)
--    assert(g(1, 2, nil, nil, 'x') == 0 and
--            h(1, 2, nil, nil, 'x') == 0)
--    assert(g(1, 2, nil, 1, nil) == 0 and
--            h(1, 2, nil, 1, nil) == 0)
--end
do
    assert(1 and 2 < 3 == true and 2 < 3 --[[and 'a'<'b' == true--]]) --不做,zlua暂时不考虑字典序
    x = 2 < 3 and not 3;
    assert(x == false)
    x = 2 < 1 or (2 > 1 and 'a');
    assert(x == 'a')
end

do
    local a;
    if nil then
        a = 1;
    else
        print('a',a)
        a = 2;
    end ;    -- this nil comes as PUSHNIL 2
    print('a:', a)
    assert(a == 2)
end
print 'OK'