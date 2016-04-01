-- Check every  600000 10 minutes  - 15000 - 15sec

tempout = 0 -- Initialize value that holds temp

tmr.alarm(1, 30000, 1, function() -- Do every 1 minute
	dofile("ds.lua")
	tmr.wdclr()
end)

srv = net.createServer(net.TCP)
srv:listen(80, function(conn)
	conn:on("receive", function(conn, payload)
		--print(payload)
		conn:send('HTTP/1.1 200 OK\r\nConnection: keep-alive\r\nCache-Control: private, no-store\r\n\r\n')
		conn:send(tempout)
		conn:close()
		collectgarbage()
	end)
	conn:on("sent", function(conn) conn:close() end)
end)
