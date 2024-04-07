local component = require("component")
local nav = component.navigation
local tank = component.tank_controller
local robot = require("robotLib")
local sides = require("sides")
local os = require("os")

-- north is negz, east is posx
local locations = 
{
{3, 2, 0},
{4, 1, 0},
{6, 2, 0},
{7, 1, 0},
{9, 2, 0},
{10, 1, 0},
{12, 2, 0},
{13, 1, 0}
}

function fillTank()
  robot.turnToSide(sides.west)
  while robot.drain() do 
    os.sleep(0.05)
  end
  robot.turnToSide(sides.east)
end

function depositLava()
  local dropFlag = false
  robot.turnToSide(sides.south)
  dropFlag = robot.fill()
  os.sleep(0.2)
  robot.drain()
  robot.turnToSide(sides.east)
  return dropFlag
end

function main()
  robot.goHome()
  fillTank()
  
  for ix = 1,#locations do
    robot.goToUnsafe(locations[ix])
    if not depositLava() then
      break
    end
  end
  os.sleep(30)
end

while true do
  main()
end