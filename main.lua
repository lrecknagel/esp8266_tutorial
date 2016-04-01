-- Check every  600000 10 minutes  - 15000 - 15sec

tempout = 0 -- Initialize value that holds temp

tmr.alarm(1, 2000, 1, function() -- Do every 1 minute
	dofile("ds.lua")
	tmr.wdclr()
end)

srv = net.createServer(net.TCP)

srv:listen(80, function(conn)
	conn:on("receive", function(conn, req)

		local buf = "";
    local _, _, method, path, vars = string.find(req, "([A-Z]+) (.+)?(.+) HTTP");
    if(method == nil)then
        _, _, method, path = string.find(req, "([A-Z]+) (.+) HTTP");
    end
    local _GET = {}
    if (vars ~= nil)then
        for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
            _GET[k] = v
        end
    end

		if (path == "/temp") then
			conn:send('HTTP/1.1 200 OK\r\nConnection: keep-alive\r\nCache-Control: private, no-store\r\n\r\n')
			conn:send(tempout)
		end

		if (path == "/") then
			conn:send('HTTP/1.1 200 OK\r\nConnection: keep-alive\r\nCache-Control: private, no-store\r\n\r\n')
			conn:send("<html><head></head><body><h3>Welcome to esp8266 temperature server</h3></body></html>")
		end

		conn:close()
		collectgarbage()
	end)
	conn:on("sent", function(conn) conn:close() end)
end)
