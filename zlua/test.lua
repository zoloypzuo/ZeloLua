-- test `function def
function A.B.C.D.f()end
function g()end
function H.I.J.K:h()end
-- test `local function def 
local function f()
	-- test `local assign
	local a,b,c=nil,nil,nil --simple normal
	--local a,b,c=1,2,3  --normal
	local d,e,f=4,5  --right side less than left side
	local g,h,i=6,7,8,9,10 -- ...
	local j,k --only declaration
end