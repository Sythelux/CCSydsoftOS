function main()
   turtle.select(1)
   turtle.refuel(5)
   level()
   forward()
   turtle.turnRight()
   strip()
   forward()
   turtle.turnRight()
   forward()
   strip()
   forward()
   turtle.turnRight()
   forward()
   strip()
   turtle.turnRight()
   forward()
   stairs()
end

function stairs()
   for i = 1, 6 do
      forward()
      turtle.digUp()
      turtle.digDown()
      turtle.down()
      if i% 2 == 0 then
         turtle.turnLeft()
      end
   end
   turtle.turnRight()
end

function level()
  for j = 1, 3 do
   for i = 1, 2 do
     dig3High()
   end
   if j == 1 then
     turtle.turnLeft()
     dig3High()
     turtle.turnLeft()
   end
   if j == 2 then
     turtle.turnRight()
     dig3High()
     turtle.turnRight()
   end 
   if j == 3 then
     turtle.turnRight()
     forward()
     forward()
     turtle.turnRight()
     forward()
     forward()
     turn()
   end
  end
end

function strip()
   for i = 1, 15 do
      dig2High()
      if i%4 == 0 then
         turtle.turnRight()   
         miniStrip()
         turtle.turnLeft()
      end
   end
   turn()
   for i = 1, 15 do
      forward()
   end
end

function miniStrip()
   for j = 1, 7 do
      dig2High()
   end
   turn()
   for j = 1, 7 do
      forward()
   end
   for j = 1, 7 do
      dig2High()
   end
   turn()
   for j = 1, 7 do
        forward()
   end
end

function dig2High()
   forward()
   turtle.digUp()
end

function dig3High()
  turtle.digUp()
  turtle.up()
  forward()
  turtle.digUp()
  turtle.digDown()
  turtle.down()
end

local torchCount = 0
function forward()
   while not turtle.forward() do
      turtle.dig()
	  turtle.attack()
   end
   torchCount = torchCount + 1
   if torchCount == 4 then
      turtle.select(16)
	  turtle.placeUp()
	  torchCount = 0
   end
end

function turn()
   turtle.turnLeft()
   turtle.select(16)
   turtle.placeUp()
   turtle.turnLeft()
end

main()