local args = {...}
if fs.exists("Frame") then
  shell.run("rm Frame")
end
shell.run("pastebin get w2RgdfS4 Frame")
os.unloadAPI("Frame")
os.loadAPI("Frame")

if fs.exists("SystemLog") then
  shell.run("rm SystemLog")
end
shell.run("pastebin get VtbNT0ji SystemLog")
os.unloadAPI("SystemLog")
os.loadAPI("SystemLog")

local monitorName = "top"
local rednetName = "right"

local monitor = peripheral.wrap(monitorName)
local hostID = -1

function main()
  for i,v in ipairs(args) do
    if v=="host" then
      beRednetHost()
      exit()
    end
  end
  beRednetClient()
end

function clientSend(command, message)
  rednet.send(hostID, command.." "..message)
end

function logInfo(message)
  clientSend("INFO", message)
end
function logWarn(message)
  clientSend("WARN", message)
end
function logErr(message)
  clientSend("ERRO", message)
end
function addState(name, initialVal)
  clientSend("ADDP", name..","..initialVal)
end
function updateState(name, val)
  clientSend("UPDP", name..","..val)
end
function removeState(name)
  clientSend("REMP", name)
end

function beRednetClient()
  rednet.open(rednetName)
  rednet.broadcast("WhoIsHost")
  while true do
    local event = ""
    local param1 = ""
    local param2 = ""
    local param3 = ""
    event, param1, param2, param3 = os.pullEvent()
    print("eventThrown:"..event)
    print("  with:"..tostring(param1)..","..tostring(param2)..","..tostring(param3))
    if event == "rednet_message" then
      local senderId = param1
      local message = param2
      local distance = param3
      if message:find("WhoIsHost") then
	    hostID = senderId
      end
    elseif event == "key" then
      if param1 == "46" then
        exit()
      end
    end
  end
end

function beRednetHost()
  rednet.open("right")
  SystemLog.addLog("info", "System started!")
  while true do
    local event = ""
    local param1 = ""
    local param2 = ""
    local param3 = ""
    event, param1, param2, param3 = os.pullEvent()
    print("eventThrown:"..event)
    print("  with:"..(param1 or "")..","..(param2 or "")..","..(param3 or ""))
    if event == "rednet_message" then
      local senderId = param1
      local message = param2
      local distance = param3
      if message:find("WhoIsHost") then
        rednet.send(senderId, os.getComputerLabel())
        print("send:"..senderId..":"..os.getComputerLabel())
        Frame.addPeripheral(message:sub(3,message:find("WhoIsHost")-1),senderId,true)
      elseif message:find("INFO") then
        SystemLog.addLog("info", message:sub(5))
      elseif message:find("WARN") then
        SystemLog.addLog("warning", message:sub(5))
      elseif message:find("ERRO") then
        SystemLog.addLog("error", message:sub(5))
      elseif message:find("ADDP") then
        Frame.addPeripheral(message:sub(3,message:find("ADDP")-1),senderId,true)
      elseif message:find("UPDP") then
        Frame.updatePeripheral(message:sub(3,message:find("UPDP")-1),senderId,true)
      elseif message:find("REMP") then
        Frame.removePeripheral(message:sub(3,message:find("REMP")-1),senderId,true)
      end
    elseif event == "key" then
      if param1 == "46" then
        exit()
      end
    end
  end
end

function cls()
  local _, y = monitor.getCursorPos()
  for cy=1,y,1 do
    monitor.setCursorPos(1,cy)
    monitor.clearLine()
  end
end

function newLine(x)
  local _, y = monitor.getCursorPos()
  if x == nil then
    x = 1
  end  
  monitor.setCursorPos(x,y+1)
end

function window(x,y,width,height)
--  print("func:"..x..","..y..","..width..","..height)
  for cx = x,x+width,1 do
    monitor.setCursorPos(cx,y)
    monitor.write("-")
    monitor.setCursorPos(cx,y+height)
    monitor.write("-")
  end
  for cy = y,y+height,1 do
    monitor.setCursorPos(x,cy)
    monitor.write("|")
    monitor.setCursorPos(x+width,cy)
    monitor.write("|")
  end
end

monitor.setTextScale(0.5)
monitor.setTextColor(colors.orange)
local w, h = monitor.getSize()
--print("monitorsize:"..w..","..h)
local x = 1
local y = 1
local wHalf = w/2
local hHalf = h/2

cls()
window(1,1,wHalf-1,h-1)
window(wHalf+1,1,wHalf-1,hHalf-1)

function printLogo()
	local logo = {}
	table.insert(logo, "             + =???????I~ ,             ")
	table.insert(logo, "         +~+++?????????IIIIII           ")
	table.insert(logo, "        +++++++    =?I ,IIIIIII,        ")
	table.insert(logo, "      =++++~       +?I     ~IIII?I      ")
	table.insert(logo, "     ===+=         =?I        III7I     ")
	table.insert(logo, "   =====          :=?I~        III7     ")
	table.insert(logo, "   ===:=++      ????III:        ~I77?   ")
	table.insert(logo, "  ==== =++?II,+++????IIIII    ??I=I77I  ")
	table.insert(logo, ",:===    +?I=++++?????III,7:=+??IIII7I  ")
	table.insert(logo, "~~~=:     ?==+++++,  ??IIII7,+?~   I77  ")
	table.insert(logo, "~~~~      ,===++       IIIIII=     II7  ")
	table.insert(logo, "~~~~      =====+        IIIII      III+ ")
	table.insert(logo, ":~~~      ~=====       ,?IIII      IIII ")
	table.insert(logo, " ~~~     ?~~=====      ??IIII      IIII ")
	table.insert(logo, " ~~~~  ++?I:==~==+++++????II++    ~IIII ")
	table.insert(logo, " ~~~~==++?II,  ==+++++?????=++?I  IIII+ ")
	table.insert(logo, " ,~~~~=+:     ~===+++~~??  ,++?IIIIII:  ")
	table.insert(logo, "  :~~~~          :,:,         ,~?III,   ")
	table.insert(logo, "    ~~~~         =+?I         =???II    ")
	table.insert(logo, "     ~~~~~       =+?,        ?????      ")
	table.insert(logo, "     ~~~~~==~    =+?      ???????       ")
	table.insert(logo, "        ~~~========:=+++++++???         ")
	table.insert(logo, "          ~~========++++++++~~          ")
	table.insert(logo, "              ======++++++              ")
	local num = wHalf+(wHalf/2-(#logo[1]/2))
	monitor.setCursorPos(num,hHalf+1)
	for i=1,#logo do
		monitor.write(logo[i])
		newLine(num)
	end
end
Frame.setDimensions(wHalf+2,2,wHalf-2,hHalf-2)
Frame.setParent(monitor)
SystemLog.setDimensions(2,2,wHalf-2,h-2)
SystemLog.setParent(monitor)
printLogo()
main()
--Frame.addPeripheral("testPer1",40,true)
--SystemLog.addLog(textutils.formatTime(os.time(), true), "error", "SystemError detected!")