-- Check every  600000 10 minutes  - 15000 - 15sec

tempout = 0 -- Initialize value that holds temp

tmr.alarm(1, 2000, 1, function() -- Do every 10 minutes
	dofile("ds.lua")
	tmr.wdclr()
end)

srv = net.createServer(net.TCP)
srv:listen(80, function(conn)
	conn:on("receive", function(conn, payload)
		print(payload)
		conn:send('HTTP/1.1 200 OK\r\nConnection: keep-alive\r\nCache-Control: private, no-store\r\n\r\n')
		conn:send('<!DOCTYPE HTML>')
		conn:send('<html lang="en">')
		conn:send('<head>')
		conn:send('<meta http-equiv="Content-Type" content="text/html; charset=utf-8">')
		conn:send('<meta http-equiv="refresh" content="60">')
		conn:send('<meta name="viewport" content="width=device-width, initial-scale=1">')
		conn:send('<title>(ESP8266 & DS18B20)</title>')
		conn:send('</head>')
		conn:send('<body>')
		conn:send('<h1>(ESP8266 & DS18B20)</h1>')
		conn:send('<h2>')
		conn:send('<input style="text-align: center" type="text" size=4 name="p" value="' .. tempout .. '"> C <br><br>')
		conn:send('</h2>')
		conn:send('</body></html>')
		conn:close()
		collectgarbage()
	end)
	conn:on("sent", function(conn) conn:close() end)
end)
