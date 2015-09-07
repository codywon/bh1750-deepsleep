sleep_time = 120 * 1000 * 1000
-- define pins
SDA_PIN = 3
SCL_PIN = 4
-- define libs and init
bh1750 = require("bh1750")
bh1750.init(SDA_PIN, SCL_PIN)
-- read twice so we don't get a 0
bh1750.read(OSS)
bh1750.read(OSS)
l = bh1750.getlux()
--print("lux: ".. math.floor(l/100) .. " lx")
conn=net.createConnection(net.TCP, 0) 
conn:on("receive", function(conn, payload) print(payload) end)
-- domoticz server
conn:connect(8080,"192.168.100.1") 
conn:send("GET /json.htm?type=command&param=udevice&idx=127&svalue=".. math.floor(l/100) .." HTTP/1.1\r\n") 
conn:send("Host: thor.wirehead.be\r\n") 
conn:send("Accept: */*\r\n") 
conn:send("User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n")
conn:send("\r\n")
conn:on("sent",function(conn)
    conn:close()
end)
conn:on("disconnection", function(conn)
    print("go to sleep")
    node.dsleep(sleep_time)
end)