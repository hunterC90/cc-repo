local component = require("component")
local nav = component.navigation
local inv = component.inventory_controller
local robot = require("robotLib")
local sides = require("sides")
local os = require("os")
local geo = component.geolyzer


function pickup64()
  robot.turnToSide(sides.north)
  local itemsLeft = 64 - (inv.getStackInInternalSlot(1) or {size=0}).size - (inv.getStackInInternalSlot(2) or {size=0}).size - (inv.getStackInInternalSlot(3) or {size=0}).size
  local item = {}
  
  for ix = 1,54 do
    if itemsLeft == 0 then
      return true
    end
  
    item = inv.getStackInSlot(sides.front,ix)
    if item then
      if item.name == "minecraft:stone" then
        robot.select(1)
        itemsLeft = 64 - (inv.getStackInInternalSlot(1) or {size=0}).size
        inv.suckFromSlot(sides.front,ix,itemsLeft)        
      elseif item.name == "minecraft:log" then
        robot.select(2)
        itemsLeft = 64 - (inv.getStackInInternalSlot(2) or {size=0}).size
        inv.suckFromSlot(sides.front,ix,itemsLeft)
      elseif item.name == "minecraft:gold_block" then
        robot.select(3)
        itemsLeft = 64 - (inv.getStackInInternalSlot(3) or {size=0}).size
        inv.suckFromSlot(sides.front,ix,itemsLeft)
      end   
    end
  end
end

function placeBlock()
  robot.select(1)
  if not robot.placeDown() then
    robot.select(2)
    robot.placeDown()
    if not robot.placeDown() then
      robot.select(3)
      robot.placeDown()
    end
  end  
end

function doThing()
  robot.select(1)
  local block = geo.analyze(sides.down)
  if block.name == "botania:livingwood" or block.name == "botania:livingrock" or block.name == "contenttweaker:living_gold" then
    robot.select(4)
    robot.swingDown()
  end
  placeBlock()
end

function deposit()
  robot.turnToSide(sides.west)
  robot.select(4)
  inv.dropIntoSlot(sides.front,1,64)
  robot.select(5)
  inv.dropIntoSlot(sides.front,2,64)
  robot.select(6)
  inv.dropIntoSlot(sides.front,3,64)
end

function main()
  local leftFlag = true

  robot.goHome()
  deposit()
  pickup64()
  os.sleep(2)
  robot.goToUnsafe({0,1,3})
  
  for ix1 = 1,9 do
    doThing()
    for ix2 = 1,11 do
      doThing()
      robot.safeForward()
    end
    
    doThing()
    if leftFlag then      
      robot.turnLeft()      
      robot.safeForward()
      robot.turnLeft()
      leftFlag = false
    else
      robot.turnRight()
      robot.safeForward()
      robot.turnRight()
      leftFlag = true
    end
    
  end
  
end

robot.goHome()
while true do main() os.sleep(0.05) end