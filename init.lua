-- init wifi
wifi.setmode(wifi.STATION)
wifi.sta.config("SSID","PASSWD")
wifi.sta.setip({ip="192.168.100.23",netmask="255.255.255.0"})

-- execute timerjob
print("*** you've got 0.5 sec to stop timer 0 ***")
tmr.alarm(0, 500, 0, function()
  dofile("bh1750_ex.lua")
end)