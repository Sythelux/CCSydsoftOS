local redstoneDir = "back"
local mfsu = "mfsu_0"

function check()
  local mfsuStor = peripheral.wrap(mfsu)
  local storedEU = mfsuStor.getEUStored()
  local capacity = mfsuStor.getEUCapacity()
  local diff = storedEU/capacity
  print("EU value "..diff)
  if diff > 0.9 then
    print("  redstone signal off")
    redstone.setOutput(redstoneDir, false)
  elseif diff < 0.5 then
    print("  redstone signal on")
    redstone.setOutput(redstoneDir, true)
  end
end
  
while true do
  check()
  print("sleeping for 5 seconds")
  sleep(5)
end