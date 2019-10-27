local x,y,width,height
local monitor
local logger = {}

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
  local j = 2
  for i = #logger, 1, -1 do
    if y+height-j < y then
      return
    end
    monitor.setCursorPos(x,y+height-j)
    setTextColor(logger[i][1])
    monitor.write(logger[i][2])
    setTextColor()
    j=j+1
  end
end

function setTextColor(level)
  if level == "info" then
    monitor.setTextColor(colors.green)
  elseif level == "warning" then
    monitor.setTextColor(colors.yellow)
  elseif level == "error" then
    monitor.setTextColor(colors.red)
  else
    monitor.setTextColor(colors.orange)
  end
end

function addLog( level, message, timeStamp)
  if timeStamp == nil then
    timeStamp = textutils.formatTime(os.time(), true)
  end
  local printVal = ""
  local printStrings = format(timeStamp,message)
  for j = 1, #printStrings do
    printLogger()
    setTextColor(level)
    local printString = printStrings[j]
    monitor.setCursorPos(x,y+height-1)
    for i = 1, #printString do
      local c = printString:sub(i,i)
      monitor.write(c)
      sleep(0.1)
    end
    local temp = {}
    table.insert(temp,level)
    table.insert(temp,printString)
    table.insert(logger,temp)
    setTextColor()
  end
end

function format(timeStamp,message)
  local strs = {}
  local str = ""
  for i = 1, #message do
    if i % (width-6) == 0 then
      table.insert(strs, str)
      str = ""
    end
    str = str..message:sub(i,i)
  end
  table.insert(strs, str)
  for i = 1, #strs do
    if i == 1 then
      strs[i] = timeStamp.." "..strs[i]
    else
      strs[i] = "      "..strs[i]
    end
  end
  return strs
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