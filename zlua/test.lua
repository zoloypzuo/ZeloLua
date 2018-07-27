
-- assign (global)
a = nil
a1 = false
a2 = true

b = 1
b1 = 1.2

c = "lalala"

d = function(a) return a end
e = d(1)

f = {1, 2}
f1 = {1, 2, {3}, 4}

g = #{1, 2}
h = 1 * 2
i = 1 + 2
j = "1" + "2"
k = 1 == 2
l = true and false

-- func def, call
function add(a, b)
    return a + b
end
p = add(1, 2)

-- while loop
while true do
    q = 1
end

while a == 1 do
    q = 1
    
end


-- # more test added on 2018.7.27
local a,b,c=1,2,3  --normal
local d,e,f=4,5  --right side less than left side
local g,h,i=6,7,8,9,10 -- ...
local j,k --only declaration