print("make sure that the following items are in the following slots:")
print("<item>        <cnt> <slot>")
print("coal           5     1")
print("redstone      10     2")
print("cleanstone     5     3")
print("redstonetorch  2     4")
print("stickypiston   4     5")
print("pressureplate  4     6")
print("the Turtle should sit on the right side in front of the future door")
read()

function main()
 turtle.select(1)
 turtle.refuel(5)
	forward()
	forward()
	down()
	down()
	placeUp(3)
	placeDust()
	turtle.turnLeft()
	forward()
	turtle.turnRight()
	placeDust()
	turtle.turnLeft()
	placeDust()
	turtle.turnLeft()
	placeDust()
	turtle.turnLeft()
	forward()
	turtle.turnLeft()
	turtle.turnLeft()
	placeDust()
	turtle.turnLeft()
	placeDust()
	turtle.turnLeft()
	forward()
	turtle.turnLeft()
	turtle.turnLeft()
	placeDust()
	turtle.turnLeft()
	turtle.turnLeft()
	up()
	placeDustDown()
	forward()
	up()
	placeTorch()
	placeDustDown()
	
	turtle.turnLeft()
	turtle.turnLeft()
	
	for i = 1, 5 do
		forward()
	end

	placeDustDown()
	turtle.back()
	turtle.digDown()
	forward()
	placeTorch()

	up()

	turtle.turnLeft()
	turtle.turnLeft()
	
	for i = 1, 4 do
		forward()
	end

	placePiston()
	turtle.down()
	placePiston()
	
	turtle.turnLeft()
	turtle.turnLeft()

	for i = 1, 3 do
		forward()
	end
	
	placePiston()
	turtle.up()
	placePiston()

	turtle.turnLeft()
	turtle.turnLeft()
	
	forward()
	
	turtle.turnLeft()
	forward()
	turtle.turnRight()
	placeDown(6)
	forward()
	placeDown(6)
	
	turtle.turnRight()
	
	forward()
	turtle.turnRight()
	placeDown(3)
	forward()
	placeDown(3)

	turtle.turnLeft()
	forward()
	turtle.turnLeft()
	turtle.turnLeft()
	placeFront(3)
	turtle.turnRight()
	placeDown(6)
	forward()
	turtle.turnLeft()
	placeFront(3)
	turtle.turnRight()
	placeDown(6)
	turtle.turnRight()
	forward()
	turtle.down()
end

function forward()
   while not turtle.forward() do
      turtle.dig()
	  turtle.attack()
   end
end

function down()
   while not turtle.down() do
      turtle.digDown()
	  turtle.attackDown()
   end
end

function up()
   while not turtle.up() do
      turtle.digUp()
	  turtle.attackUp()
   end
end

function placeFront( var)
	turtle.dig()
	turtle.select(var)
	turtle.place()
	turtle.select(1)
end

function placeDown( var)
	turtle.digDown()
	turtle.select(var)
	turtle.placeDown()
	turtle.select(1)
end

function placeUp( var)
	turtle.digUp()
	turtle.select(var)
	turtle.placeUp()
	turtle.select(1)
end

function placeTorch()
	placeFront(4)
end

function placeStPPlate()
	placeFront(6)
end

function placePiston()
	placeFront(5)
end

function placeDust()
	placeFront(2)
end

function placeDustDown()
	placeDown(2)
end
main()