print('testing local variables plus some extra stuff')

do
    do
        local i = 100;
        assert(i == 100)
    end
    do
        local i = 1000;
        assert(i == 1000)
    end
    local i = 10
    assert(i == 10)
end

function f (a)
    local _1, _2, _3, _4, _5
    local _6, _7, _8, _9, _10
    local x = 3
    local b = a
    local c, d = a, b
    if (d == b) then
        x = 'q'
        x = b
        assert(x == 2)
    else
        assert(nil)
    end
    assert(x == 3)
    local f = 10
end
