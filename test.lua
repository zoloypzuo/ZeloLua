do
    print('nothing')
    local msgs = {}
    local function Message (m)
        print('Msg: ', m)
        msgs[#msgs + 1] = m
    end
    (Message or print)('\a\n >>> testC not active: skipping API tests <<<\n\a')
end

do
    print('nothing')
    local function formatmem (m)
        if m < 1024 then
            do
                return m
            end
        else
            m = m / 1024 - m / 1024 % 1
            if m < 1024 then
                do
                    return "K"
                end
            else
                m = m / 1024 - m / 1024 % 1
                do
                    return "M"
                end
            end
        end
    end
    formatmem(1)
end

do
    print('test ijk loop')
    local a = {}
    for i = 0, 1000 do
        a[i] = true
    end
    a[999] = 10
    print(a)
end

do
    print('test metamethod')
    local b = {
        __lt = function(a, b)
            return a[0] < b[0]
        end
    }
    local a1, a3, a4 = { 1 }, { 3 }, { 4 }
    setmetatable(a1, b)
    setmetatable(a3, b)
    setmetatable(a4, b)
    assert(a1 < a3)
    assert(a1 < a4)
    assert(not (a4 < a3))
end

do
    print "testing require，不需要，require被原始的dofile替代"

    --assert(require "string" == string)
    --assert(require "math" == math)
    --assert(require "table" == table)
    --assert(require "io" == io)
    --assert(require "os" == os)
    --assert(require "debug" == debug)
    --assert(require "coroutine" == coroutine)
    --
    --assert(type(package.path) == "string")
    --assert(type(package.cpath) == "string")
    --assert(type(package.loaded) == "table")
    --assert(type(package.preload) == "table")

end

do
    print 'test exp'
    assert((10 and 2) == 2)
    assert((10 or 2) == 10)
    assert((10 or assert(nil)) == 10)
    assert(not (nil and assert(nil)))
    assert((nil or "alo") == "alo")
    assert((nil and 10) == nil)
    assert((false and 10) == false)
    assert((true or 10) == true)
    assert((false or 10) == 10)
    assert(false ~= nil)
    assert(nil ~= false)
    assert(not nil == true)
    assert(not not nil == false)
    assert(not not 1 == true)
    assert(not not (6 or nil) == true)
    assert(not not (nil and 56) == false)
    assert(not not (nil and true) == false)
    print('+')
end

do
    print 'test table'
    function f(a)
        return a
    end

    local a = {}
    for i = -3000, 3000, 1 do
        a[i] = i;
    end
    a[10e30] = "alo";
    --print(a)
    for i = -3000, 3000, 1 do
        --print('i',i,'a[i]',a[i])
        assert(a[i] == i);
    end

    a = a
    a.x = a[-3]
    a.y = nil

    a[2 ^ 31] = 10;
    a[2 ^ 31 + 1] = 11;
    a[-2 ^ 31] = 12;
    a[2 ^ 32] = 13;
    a[-2 ^ 32] = 14;
    a[2 ^ 32 + 1] = 15;
    a[10 ^ 33] = 16;

    assert(a[2 ^ 31] == 10 and a[2 ^ 31 + 1] == 11 and a[-2 ^ 31] == 12 and
            a[2 ^ 32] == 13 and a[-2 ^ 32] == 14 and a[2 ^ 32 + 1] == 15 and
            a[10 ^ 33] == 16)

    a = nil
end