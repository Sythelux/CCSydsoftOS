os.loadAPI("api/NaviDig.lua")
local tArgs = {...}

local rowLength =  tArgs[1] or 0

function digRow(num)
    for i = 1, num do
        NaviDig.threeWayForward()
    end
end

if rowLength == 0 then
    print("place turtle in the middle bottom position of the planned row and a chest on the right")
    return
end

function main()
    --check Fuel

    NaviDig.up()
    digRow(rowLength)
    NaviDig.turnLeft()
    NaviDig.threeWayForward()
    NaviDig.turnLeft()
    digRow(rowLength)
    NaviDig.turnLeft()
    NaviDig.threeWayForward()
    NaviDig.threeWayForward()
    NaviDig.turnLeft()
    digRow(rowLength)
    NaviDig.turnLeft()
    NaviDig.threeWayForward()
    NaviDig.turnRight()
    NaviDig.down()
end

main()
