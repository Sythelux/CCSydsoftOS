local reactorStr = "BigReactors-Reactor_1"
local monitorStr = "monitor_1"
local reactor = peripheral.wrap(reactorStr)
local monitor = peripheral.wrap(monitorStr)
local maxEnergy = 10000000

function nl()
  local _, oldy = monitor.getCursorPos()
  monitor.setCursorPos(1,oldy+1)
end

if peripheral.isPresent(monitorStr) then
  print(monitorStr.." is present.")
  monitor.setCursorPos(1,1)
  monitor.setTextScale(.5)
  monitor.clear()
else
  print(monitorStr.." not found.")
  return
end

if peripheral.isPresent(reactorStr) then
  monitor.write(reactorStr.." is present.")
  nl()
  while 1 do
    local energyAmount = reactor.getEnergyStored()/maxEnergy
    monitor.write("reactor currently at: "..(energyAmount*100).."%         ")
    nl()
    if energyAmount > 0.9 then
      reactor.setActive(false)
    elseif energyAmount < 0.1 then
      reactor.setActive(true)
    end
    monitor.write("reactor is: "..toString(reactor.getActive()).."          ")
    local _, oldy = monitor.getCursorPos()
    monitor.setCursorPos(1,oldy-1)
    os.sleep(10)
  end
else
  monitor.write(reactorStr.." not found.")
  return
end

nl()

for key, value in pairs(peripheral.getMethods(reactorStr)) do
  monitor.write(key..": "..value.."")
  nl()
end