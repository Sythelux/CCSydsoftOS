local currslot = 1
local princess = 0
local bestDrone = 0
local data=""
local countBees = 0
local beeTable = {}
local currScore = 0

s = peripheral.wrap("right") 
 
function regTable()
   beeTable["bees.species.vis"] = 31
   beeTable["bees.species.ethereal"] = 30
   beeTable["bees.species.arcane"] = 20
   beeTable["bees.species.supernatural"] = 21
   beeTable["bees.species.enchanted"] = 20
   beeTable["bees.species.mysterious"] = 12
   beeTable["bees.species.charmed"] = 11
   beeTable["bees.species.eldritch"] = 10
   beeTable["bees.species.esoteric"] = 9
   beeTable["bees.species.cultivated"] = 6
   beeTable["bees.species.common"] = 5
   beeTable["bees.species.forest"] = 1
   beeTable["bees.species.meadows"] = 1
end  
 
function getBees()
   turtle.select(1)
   for i = 1,6 do
     if turtle.suck() then countBees = countBees + 1 end
   end
end
 
function returnBees()
   turtle.turnRight()
   turtle.turnRight()
   turtle.select(princess)
   s.dropSneaky(1,1)
   turtle.select(bestDrone)
   s.dropSneaky(0,1)
end
 
function ditchCombs()  
   turtle.turnLeft()
   m = peripheral.wrap("front")
   for i = 1,8 do
     turtle.suck()
     while (not m.isBee()) and (turtle.getItemCount(i) > 0) do
     turtle.select(i)
     turtle.drop()
     if not m.isBee() then
        print("Gotta ditch the combs!")
        turtle.suck()
        turtle.dropDown()
        turtle.select(countBees)
        turtle.transferTo(i, 1)
        countBees = countBees - 1
     end
   end
   end
end
 
function scanBees()
   turtle.turnLeft()
   for i = 1, countBees do
     turtle.select(i)
     turtle.drop()
   end
   print("Sleeping for a minute while the bee scans")
end
 
function determineBest(slot)
   print("Drone = "..slot)
   print("  "..data["speciesPrimary"]..":"..data["speciesSecondary"])
   score = beeTable[data["speciesPrimary"]] + beeTable[data["speciesSecondary"]]
   print("  Current: "..currScore)
   print("  NewScore: "..score)
   if(bestDrone == 0) then
     bestDrone = slot
     currScore = score
   else
     if (score > currScore) then
       bestDrone = slot
       currScore = score
     end
   end  
end
 
function analyzeBees()
  for i = 1, countBees do
    sleep(26)
    turtle.select(i)
    turtle.suck()
    turtle.turnRight()
    turtle.drop()
    m = peripheral.wrap("front")
    data = m.analyze()
    if (data["type"] == "princess") then
      princess = i
      print("Princess = "..i)
    else
      determineBest(i)
    end
    print("BestDrone = "..bestDrone)
    turtle.suck()
    turtle.turnLeft()
   end
end
 
 
function dropExcess()
  for i = 1, 6 do
    turtle.select(i)
    turtle.dropDown()
   end  
end
------=============================

currslot = 1
princess = 0
bestDrone = 0
data=""
countBees = 0
beeTable = {}
currScore = 0

regTable()
getBees()
if (turtle.getItemCount(2) > 0) then 
   ditchCombs()
   scanBees()
   analyzeBees()
   returnBees()
   dropExcess()
end