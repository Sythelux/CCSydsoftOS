--[[
	Item sort Algorithm for Computercraft Turtles
	needs this pattern:
	ccxcc	x=space
	xxxxx	c=chest
	ccxcc	t=turtle (with chest underneath)
	xxxxx	i=inputchest
	ccxcc	compass:
	xxxxx	  z
	ccxcc	x y x
	xxtxx	  z
	xxixx	
	needs the turtle goto algorithmfound here:
	http://pastebin.com/UVX7zPKm
]]
local chestCountPerLevel = 16
local levelCount = 1
local chests = {}
local currentItemRawName = ""
local found = {}
local UUIDChestPosition = "ChestPosition"
local UUIDSizeLeft = "ChestPosition"
local UUIDItemList = "ItemList"

function main()
  shell.run("rm log")

  load()
  
  while true do
    doIt()
    save()
  end
  
  save()
end

function load()
  local location = ""
  for z = 0,7,1 do
    if z%2 == 0 then
      for y = 1,levelCount,1 do
        for x = -2,2,1 do
          location = x.." "..y.." "..z
          local f = fs.open(location, "r")
          if f ~= nil then
            chests[location]= textutils.unserialize(f.readAll())
            f.close()
          else
            initChests()
            save()
            return
          end
        end
      end
    end
  end
  

end

function save()
  for key,val in pairs(chests) do
    local f = fs.open(key, "w")
    f.write(textutils.serialize(val))
    f.close()
  end
end

function deSerializeChests(chestString, fileName)
  local retTable ={}
   for k, v in string.gmatch(chestString, " ") do
    retTable[fileName]=texutils.unserialize(v)
   end
   return retTable
end

function serializeChests(chestTable)
  local retString = ""
  for i,v in pairs(chestTable) do
    retString = retString..textutils.serialize(v).." "
  end
  return retString
end

function initChests()
  --table.setn(chests, chestCountPerLevel*levelCount)
  local location = {0,0,0}
  local size = 0
  local itemlist = {}
  local entry = {}
  for z = 0,7,1 do
    if z%2 == 0 then
      print("z:"..z.."------------------------------")
      for y = 1,levelCount,1 do
        print("  y:"..y.."------------------------------")
        for x = -2,2,1 do
          print("    x:"..x.."------------------------------")
          print("    goto "..x.." "..y.." "..z)
          shell.run("goto "..x.." "..y.." "..z)
          location = x.." "..y.." "..z
          size = 0
          if peripheral.isPresent("front") then
            size = peripheral.call("front", "getSizeInventory")
          end
          --table.setn(itemlist, size)
          entry[UUIDSizeLeft] = size
          entry[UUIDItemList] = itemlist
          print("  "..textutils.serialize(entry))
          --table.insert(chests, entry)
          chests[location] = entry
          print("    ---------------------------------")
        end
        print("  ---------------------------------")
      end
      print("---------------------------------")
    end
  end
  shell.run("goto home")
end

function getItems()
  shell.run("goto home")
  turtle.turnLeft()
  turtle.turnLeft()
  if not turtle.suck() then
    print("no item found sleeping for a bit.")
    os.sleep(10)
    os.reboot()
  end
  turtle.turnRight()
  turtle.turnRight()
  turtle.dropDown()
  currentItemRawName= peripheral.wrap("bottom").getStackInSlot(0)["rawName"]
  print("got item: "..currentItemRawName)
  turtle.suckDown()
  turtle.select(1)
  return turtle.getItemCount(1) == 64
end

function placeInNewChest()
  local dest = getNextEmptyChest()
  print("goto "..dest)
  shell.run("goto "..dest)
  table.insert(chests[dest][UUIDItemList], currentItemRawName)
  chests[dest][UUIDSizeLeft] = chests[dest][UUIDSizeLeft]-1
  --print(textutils.serialize(chests[dest][UUIDItemList]))
  turtle.drop()
  --shell.run("goto home")
end

function getNextEmptyChest()
  for key,value in pairs(chests) do
    if value[UUIDSizeLeft] > 0 then
      return key
    end
  end
end

function place(location)
  if location == nil then
    return false
  end
  print("want to place "..currentItemRawName.."@"..found[location].. " into chest "..location)
  shell.run("goto "..location)
  local p = peripheral.wrap("front")
  local itemsMovedCount = p.pullIntoSlot("north", 1, turtle.getItemCount(1), found[location]) --older versions
--  local itemsMovedCount = p.pullItemIntoSlot("north", 1, turtle.getItemCount(1), found[location]) --newer versions
  if turtle.getItemCount(1) > 0 then
    print("I have some "..currentItemRawName.." left.")
    return place(whereWasIt())
  else
    return true
  end
end

function whereWasIt()
  for keyLocation, valChest in pairs(chests) do
    for keyPlace,valRawName in pairs(valChest[UUIDItemList]) do
      if keyPlace > found[keyLocation] then
        if valRawName == currentItemRawName then
          found[keyLocation] = keyPlace
          return keyLocation
        end
      end
    end
  end
  return nil
end

function doIt()
  resetFound()
  if getItems() then
    print("getItems() was true so I placeInNewChest()")
    placeInNewChest()
  else
    print("getItems() was false so I place(whereWasIt())")
    if not place(whereWasIt()) then
      print("place(whereWasIt()) was false so I placeInNewChest()")
      placeInNewChest()
    end
  end
end

function resetFound()
  for keyLocation, valChest in pairs(chests) do
    found[keyLocation] = 0
  end
end

function logIt(logString)
  local f = fs.open("log", fs.exists("log") and "a" or "w")
  f.write(logString)
  f.write("\n")
  f.close()
end
















main()