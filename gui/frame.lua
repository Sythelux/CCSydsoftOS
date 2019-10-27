local x,y,width,height
local monitor
local logger = {}
local loggerSize = 0
local peripherals = {}

function cls()
  for dx = x, x+width-1, 1 do
    for dy =y, y+height-1, 1 do
      monitor.setCursorPos(dx,dy)
      monitor.write(" ")
    end
  end
end

function printLogger()
  cls()
  --print("for i = "..loggerSize..", 0, -1 do")
  local j = 2
  for i = loggerSize-1, 0, -1 do
    if y+height-j < y then
      return
    end
    monitor.setCursorPos(x,y+height-j)
    monitor.write(logger[i])
    j=j+1
  end
  --print("end of printLogger()")
end

function addPeripheral(name, linkNr, state)
  printLogger()
  peripherals[name]={linkNr,state}
  monitor.setCursorPos(x,y+height-1)
  local printVal = ""
  if state == true then
    printVal = " on"
  else
    printVal = " off"
  end
  local printString = format(name,printVal)
  for i = 1, #printString do
    local c = printString:sub(i,i)
    monitor.write(c)
    sleep(0.1)
  end
  logger[loggerSize] = printString
  loggerSize = loggerSize+1
end

function format(name,printVal)
  local str = name
  for i = 1, 12-#name, 1 do
    str = str.." "
  end
  str = str .. printVal
  return str
end

function setDimensions(mX,mY,mWidth,mHeight)
  x = mX
  y = mY
  width = mWidth
  height = mHeight
end

function setParent(parent)
  monitor = parent
end