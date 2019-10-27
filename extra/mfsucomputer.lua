local mfsu = peripheral.wrap("left")
local id = 0


function main()
  openConnection()
  local state =0--0=default,1=full was printed,2=empty was printed
  local percentage = (mfsu.getEUStored()/mfsu.getEUCapacity())*100
  sleep(2)
  print(id..": INFOmfsu is at "..toint(percentage).."%")
  rednet.send(id, "INFOmfsu is at "..toint(percentage).."%")
  while true do
    sleep(4)
    percentage = toint((mfsu.getEUStored()/mfsu.getEUCapacity())*100)
    if percentage > 99 and not (state == 1) then
      print(id..": INFOmfsu is full")
      rednet.send(id, "INFOmfsu is full")
      state = 1
    elseif percentage < 1 and not (state == 2) then
      print(id..": WARNmfsu is empty")
      rednet.send(id, "WARNmfsu is empty")
      state = 2
    end
    sleep(4)
  end
end

function openConnection()
  print("open Connection")
  rednet.open("right")
  local msg = ""
  local dist = 0
  while (id == nil) or (id == 0) do
    rednet.broadcast("ME"..os.getComputerLabel().."WhoIsHost")
    print("broadcast:ME"..os.getComputerLabel().."WhoIsHost")
    id, msg, dist = rednet.receive(2)
  end
  print("received:"..id..":"..msg..","..dist)
end

function toint(n)
  local s = tostring(n)
  local i,j = s:find('%.')
  if i then
    return tonumber(s:sub(1,i-1))
  else
    return n
  end
end

main()