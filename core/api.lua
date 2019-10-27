require 'class'

Console = class(function(cons)
end)

function Console:__tostring()
  return 'Console'
end

function Console:log(level, message)
  print(level..','..message)
end

function Console:logInfo(message)
  self.log("INFO",message)
end
function Console:logWarn(message)
  self.log("WARN",message)
end
function Console:logErr(message)
  self.log("ERRO",message)
end
function Console:addState(name, initialVal)
  print("ADDP"..name..","..initialVal)
end
function Console:updateState(name, val)
  print("UPDP"..name..","..val)
end
function Console:removeState(name)
  print("REMP"..name)
end

ClientAPI = class(Console, function(c,rednetName)
  Console.init(c)  -- must init base!
  rednet.open(rednetName)
  rednet.broadcast("WhoIsHost")
  local event, param1, param2, param3 = os.pullEvent()
  print("eventThrown:"..event)
  print("  with:"..tostring(param1)..","..tostring(param2)..","..tostring(param3))
  if event == "rednet_message" then
    c.hostID = param1
  end
end)

function ClientAPI:__tostring()
  return 'ClientAPI'
end

function ClientAPI:clientSend(command, message)
  rednet.send(self.hostID, command.." "..message)
end
function ClientAPI:log(level, message)
  self.clientSend("LOG "..level , message)
end
function ClientAPI:logInfo(message)
  self.log("INFO",message)
end
function ClientAPI:logWarn(message)
  self.log("WARN",message)
end
function ClientAPI:logErr(message)
  self.log("ERRO",message)
end
function ClientAPI:addState(name, initialVal)
  self.clientSend("ADDP ",name.."="..initialVal)
end
function ClientAPI:updateState(name, val)
  self.clientSend("UPDP ",name.."="..val)
end
function ClientAPI:removeState(name)
  self.clientSend("REMP ",name)
end


ServerAPI = class(Console, function(c,rednetName, monitor)
  Console.init(c)  -- must init base!
  rednet.open(rednetName)
  c.monitor = monitor
end)

function ServerAPI:__tostring()
  return 'ServerAPI'
end

function ServerAPI:listen()
  while true do
    local event, param1, param2, param3 = os.pullEvent()
    print("eventThrown:"..event)
    print("  with:"..tostring(param1)..","..tostring(param2)..","..tostring(param3))
    if event == "rednet_message" then
      local senderId = param1
      local message = param2
      local distance = param3
      local m = split(message, "%S+")
      if message:find("WhoIsHost") then
        rednet.send(senderId, os.getComputerLabel())
        print("send:"..senderId..":"..os.getComputerLabel())
        table.insert(self.clients, senderId)
      elseif message:find("LOG") then
        self.log(m[1], m[2])
      elseif message:find("ADDP") then
        self.addState(m[1], m[2])
      elseif message:find("UPDP") then
        self.updateState(m[1], m[2])
      elseif message:find("REMP") then
        self.removeState(m[1])
      end
    end
  end
end

function split(message, delim)
  local table ={]
    for i in string.gmatch(message, delim) do
      table.insert(table, i)
    end
  return table
end
function ServerAPI:log(level, message)
  self.monitor.log(level , message)
end
function ServerAPI:addState(name, initialVal)
  self.monitor.addState(name, initialVal)
end
function ServerAPI:updateState(name, val)
  self.monitor.updateState(name, val)
end
function ServerAPI:removeState(name)
  self.monitor.removeState(name)
end

Monitor = class(Console)