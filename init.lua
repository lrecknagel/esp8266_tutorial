DEBUGPRINT = true

function debugPrint(...)
	if DEBUGPRINT then
		print(...)
	end
end

local wifiConfig = {}

wifiConfig.mode = wifi.STATIONAP
wifiConfig.accessPointConfig = {}
wifiConfig.accessPointConfig.ssid = "ESP-" .. node.chipid()
wifiConfig.accessPointConfig.pwd = "ESP-" .. node.chipid()

wifiConfig.stationPointConfig = {}
wifiConfig.stationPointConfig.ssid = "YOUR_SSID"
wifiConfig.stationPointConfig.pwd = "YOUR_PW"

wifi.setmode(wifiConfig.mode)
debugPrint('set (mode=' .. wifi.getmode() .. ')')
debugPrint('MAC: ', wifi.sta.getmac())
debugPrint('chip: ', node.chipid())
debugPrint('heap: ', node.heap())

wifi.ap.config(wifiConfig.accessPointConfig)
wifi.sta.config(wifiConfig.stationPointConfig.ssid, wifiConfig.stationPointConfig.pwd)
wifiConfig = nil
collectgarbage()

local joinCounter = 0
local joinMaxAttempts = 10

tmr.alarm(0, 3000, 1, function()
	local ip = wifi.sta.getip()
	if not ip and joinCounter < joinMaxAttempts then
		debugPrint('Connecting to WiFi Access Point ...')
		joinCounter = joinCounter + 1
	else
		if joinCounter == joinMaxAttempts then
			debugPrint('Failed to connect to WiFi Access Point.')
			node.restart()
		else
			debugPrint('IP: ',ip)
			dofile("main.lua")
		end
		tmr.stop(0)
		joinCounter = nil
		joinMaxAttempts = nil
		collectgarbage()
	end
end)
