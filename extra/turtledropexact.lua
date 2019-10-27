local amount = 9
local dropLocation = "down"
local timeout = 1

function min(one, two)
  if one < two then return one
  else return two end
end

function max(one, two)
  if one > two then return one
  else return two end
end

while true do
for i=1,16 do
  turtle.select(i)
  if turtle.getItemCount(i) >= amount then
    if     dropLocation == "down" then turtle.dropDown(amount)
    elseif dropLocation == "up" then turtle.dropUp(amount)
    elseif dropLocation == "front"then turtle.drop(amount)
    end
    timeout = timeout-17
  end
end
timeout = min( timeout+1, 10)
timeout = max( timeout, 0)
print("sleeping for:"..timeout)
sleep(timeout)
end