local base = 3

local function forward()
	repeat 
		turtle.dig()
	until turtle.forward()
end

local function dig()
	shell.run("quarry -dim "..base.." "..base.." 1 -invert true -rednet false")
end

while(1) do
	dig()
	for j=1,10 do
		for i=1,10 do
			for f=1,base do forward() end
			dig()
		end
		if j%2==0 then turtle.turnRight() else turtle.turnLeft() end
		for f=1,base do turtle.forward() end
		if j%2==0 then turtle.turnRight() else turtle.turnLeft() end
	end
end