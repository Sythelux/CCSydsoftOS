os.loadAPI("../api/NaviDig")
local tArgs = {...}

local rowLength = 0 or tArgs[1]

function digRow(num) for i = 0, num do NaviDig.threeWayForward() end end

if rowLength == 0 then
    print(
        "place turtle in the middle bottom position of the planned row and a chest on the right")
    return
end

function main()
    NaviDig.up()
    NaviDig.digRow(rowLength)
    NaviDig.turnLeft()
    NaviDig.threeWayForward()
    NaviDig.turnLeft()
    NaviDig.digRow(rowLength)
    NaviDig.turnLeft()
    NaviDig.threeWayForward()
    NaviDig.threeWayForward()
    NaviDig.turnLeft()
    NaviDig.digRow(rowLength)
    NaviDig.turnLeft()
    NaviDig.threeWayForward()
    NaviDig.turnRight()
    NaviDig.down()
end

main()
