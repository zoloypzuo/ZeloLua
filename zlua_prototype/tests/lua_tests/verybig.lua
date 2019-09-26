print "testing large programs (>64k)"
dostring("print 'A'")
for i=0,10 do
    dofile('constructs.file')
end
print 'OK'