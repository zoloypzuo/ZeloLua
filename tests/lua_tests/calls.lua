print("testing functions and calls")


-- testing local-function recursion
--do
    local res = 1
    local function fact (n)
        if n == 0 then
            return res
        else
            return n * fact(n - 1)
        end
    end
    print('before assert')
    print(fact(5))
    assert(fact(5) == 120)
--end

---- testing declarations
--do
--    a = { i = 10 }
--    self = 20
--    function a:x (x)
--        return x + self.i
--    end
--    function a.y (x)
--        return x + self
--    end
--
--    assert(a:x(1) + 10 == a.y(1))
--
--    a.t = { i = -100 }
--    a["t"].x = function(self, a, b)
--        return self.i + a + b
--    end
--
--    assert(a.t:x(2, 3) == -95)
--end
--do
--    local a = { x = 0 }
--    function a:add (x)
--        self.x = self.x + x
--        a.y = 20;
--        return self
--    end
--    assert(a:add(10):add(20):add(30).x == 60 and a.y == 20)
--end
--
--do
--    local a = { b = { c = {} } }
--
--    function a.b.c.f1 (x)
--        return x + 1
--    end
--    function a.b.c:f2 (x, y)
--        self[x] = y
--    end
--    assert(a.b.c.f1(4) == 5)
--    a.b.c:f2('k', 12);
--    assert(a.b.c.k == 12)
--
--    print('+')
--
--    t = nil   -- 'declare' t
--    function f(a, b, c)
--        local d = 'a';
--        t = { a, b, c, d }
--    end
--end
--f(-- this line change must be valid
--        1, 2)
--assert(t[1] == 1 and t[2] == 2 and t[3] == nil and t[4] == 'a')
--f(1, 2, -- this one too
--        3, 4)
--assert(t[1] == 1 and t[2] == 2 and t[3] == 3 and t[4] == 'a')
--
--function fat(x)
--    if x <= 1 then
--        return 1
--    else
--        return x * loadstring("return fat(" .. x - 1 .. ")")()
--    end
--end
--
--local x, y, z, a
--a = {};
--lim = 2000
--for i = 1, lim do
--    a[i] = i
--end
--
---- testing closures
--
---- fixed-point operator
--Y = function(le)
--    local function a (f)
--        return le(function(x)
--            return f(f)(x)
--        end)
--    end
--    return a(a)
--end
--
--
---- non-recursive factorial
--
--F = function(f)
--    return function(n)
--        if n == 0 then
--            return 1
--        else
--            return n * f(n - 1)
--        end
--    end
--end
--
--fat = Y(F)
--
--assert(fat(0) == 1 and fat(4) == 24 and Y(F)(5) == 5 * Y(F)(4))
--
--local function g (z)
--    local function f (a, b, c, d)
--        return function(x, y)
--            return a + b + c + d + a + x + y + z
--        end
--    end
--    return f(z, z + 1, z + 2, z + 3)
--end
--
--f = g(10)
--assert(f(9, 16) == 10 + 11 + 12 + 13 + 10 + 9 + 16 + 10)
--
---- testing multiple returns
--
--function f()
--    return 1, 2, 30, 4
--end
--function ret2 (a, b)
--    return a, b
--end

