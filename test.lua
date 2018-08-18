--do
--    local msgs = {}
--    function Message (m)
--        print('Msg: ', m)
--        msgs[#msgs + 1] = m
--    end
--    (Message or print)('\a\n >>> testC not active: skipping API tests <<<\n\a')
--end
--do
--    local function formatmem (m)
--        if m < 1024 then
--            return m
--        else
--            m = m / 1024 - m / 1024 % 1
--            if m < 1024 then
--                return "K"
--            else
--                m = m / 1024 - m / 1024 % 1
--                return "M"
--            end
--        end
--    end
--end
do
    local a = {}
    for i = 0, 1000 do
        a[i] = true
    end
    a[999] = 10
end
--do
--    local b = { __lt = function(a, b)
--        return a[0] < b[0]
--    end }
--    local a1, a3, a4 = { 1 }, { 3 }, { 4 }
--    setmetatable(a1, b)
--    setmetatable(a3, b)
--    setmetatable(a4, b)
--    assert(a1 < a3)
--    assert(a1 < a4)
--    assert(not (a4 < a3))
--end