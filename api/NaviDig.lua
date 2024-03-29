os.loadAPI("api/Navigator.lua")

retries = 64
navigationLevel = 85

function turnLeft()
    return Navigator.TurnLeft()
end

function turnRight()
    return Navigator.TurnRight()
end

function turnAround()
    return Navigator.TurnLeft() and Navigator.TurnLeft()
end

function forward()
    for i = 1, retries do
            if Navigator.Forward() then
            return true
        end
        turtle.dig()
    end
    return false
end

function up()
    for i = 1, retries do
        if Navigator.Up() then
            return true
        end
        turtle.digUp()
    end
    return false
end

function down()
    for i = 1, retries do
        if Navigator.Down() then
            return true
        end
        turtle.digDown()
    end
    return false
end

function back()
    turnAround()
    forward()
    turnAround()
end

function threeWayForward()
    forward()
    turtle.digDown()
    turtle.digUp()
end

function savelyRead(variable)
    coord = nil
    repeat
        term.clear()
        term.setCursorPos(1, 1)
        print("Please enter your " .. variable .. " coordinate")
        write("  " .. variable .. " = ")
        coord = tonumber(read())
        if coord == nil then
            print("Incorrect input. Use numbers only!")
            print()
        end
    until (coord ~= nil)
    return coord
end

function fixLevel(source, target, orientation) -- south north are even. east,west are odd
    -- math.fmod(x,y)
    if (source > target) then
        Navigator.TurnRight(2)
    elseif (source < target) then
        Navigator.TurnRight(0)
    end
    -- Navigator.Forward(math.abs(navigationLevel-z))
end

function goTo(tX, tY, tZ, l)
    -- Reset Position
    -- Initialize Navigator
    if (Navigator.InitializeNavigator()) then
        -- print("Navigator file found, resetting position.")

        x, y, z, direction = Navigator.GetPosition()
        -- First Y:
        if (y < navigationLevel) then
            -- print("Moving up.")
            Navigator.Up(navigationLevel - y)
        else
            -- print("Vertical is fine.")
        end

        -- Now Z:
        if (z > tZ) then
            -- print("Moving north.")
            -- Turn to positive z and move.
            Navigator.TurnRight(2) -- facing -z
        elseif (z < tZ) then
            -- print("Moving south.")
            -- Turn to negative z and move.
            Navigator.TurnRight(0) -- facing +z
            Navigator.Forward(math.abs(tZ - z))

            -- Now Z:
            if (x > tX) then
                -- print("Moving north.")
                -- Turn to positive z and move.
                Navigator.TurnRight(3) -- facing -z
            elseif (x < tX) then
                -- print("Moving south.")
                -- Turn to negative z and move.
                Navigator.TurnRight(1) -- facing +z
                Navigator.Forward(math.abs(tX - x))

                if (y > tY) then
                    -- print("Moving down.")
                    Navigator.Down(tY - y)
                elseif (y < tY) then
                    -- print("Moving up.")
                    Navigator.Up(tY - y)
                else
                    -- print("Vertical is fine.")
                end
            else
                print("initialize first")

                x, y, z, direction = Navigator.GetPosition()

                print("IMPORTANT! Stand directly behind turtle")
                print("Press F3 to read coordinates")
                print()
                continue = true
                while continue do
                    x = savelyRead("X")
                    y = savelyRead("Y")
                    z = savelyRead("Z")
                    direction = savelyRead("direction")
                end
            end
        end
    end
end
