--[[
	this Turtle Programm gives a possibility to navigate coordinate based without a GPS System
]]

local arg = { ... }
local x = 1
local y = 2
local z = 3
local position = {0,1,0}

function main()
  local f = fs.open("gotoVars", "r")
  if f ~= nil then
    position = textutils.unserialize(f.readAll())
    f.close()
  end
  if table.getn(arg) == 3 then
    local dest = {tonumber(arg[x]),tonumber(arg[y]),tonumber(arg[z])}
    goto(dest)
  elseif table.getn(arg) == 1 then
    if arg[1] == "home" then
      goHome()
    end
  else
    --print("syntax:goto <x> <y> <z>")
  end
  local f = fs.open("gotoVars", "w")
  f.write(textutils.serialize(position))
  f.close()
end

function goLeft(n)
  --print("goLeft:"..n)
  turtle.turnLeft()
  for i=1, n, 1 do
    if turtle.forward() then
      position[x]=position[x]-1
    end
  end
  turtle.turnRight()
end

function goRight(n)
  --print("goRight:"..n)
  turtle.turnRight()
  for i=1, n, 1 do
    if turtle.forward() then
      position[x]=position[x]+1
    end
  end
  turtle.turnLeft()
end

function goForward(n)
  --print("goForward:"..n)
  for i=1, n, 1 do
    if turtle.forward() then
      position[z]=position[z]+1
    end
  end
end

function goBack(n)
  --print("goBack:"..n)
  for i=1, n, 1 do
    if turtle.back() then
      position[z]=position[z]-1
    end
  end
end

function goUp(n)
  --print("goUp:"..n)
  for i=1, n, 1 do
    if turtle.up() then
      position[y]=position[y]+1
    end
  end
end

function goDown(n)
  --print("goDown:"..n)
  for i=1, n, 1 do
    if turtle.down() then
      position[y]=position[y]-1
    end
  end
end

function goHome()
  local location = {0,1,0}
  goto(location)
end

function goto(destination)
  destination[z]=destination[z]-destination[z]%2
  --print("x:"..destination[x].."|"..position[x])
  --print("y:"..destination[y].."|"..position[y])
  --print("z:"..destination[z].."|"..position[z])
  if position[z] ~= destination[z] then
    if position[x] > 0 then
      goLeft(position[x])
    end
    if position[x] < 0 then
      goRight(-position[x])
    end
  end
  if destination[z] > position[z] then
    goForward(destination[z]-position[z])
  end
  if destination[z] < position[z] then
    goBack(position[z]-destination[z])
  end  
  if destination[x] < position[x] then
    goLeft(position[x]-destination[x])
  end
  if destination[x] > position[x] then
    goRight(destination[x]-position[x])
  end  
  if destination[y] < position[y] then
    goDown(position[y]-destination[y])
  end
  if destination[y] > position[y] then
    goUp(destination[y]-position[y])
  end  
  --print("x:"..destination[x].."|"..position[x])
  --print("y:"..destination[y].."|"..position[y])
  --print("z:"..destination[z].."|"..position[z])
end

main()