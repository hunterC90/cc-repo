robot = require("robot")
sides = require("sides")
os = require("os")
component = require("component")
inv = component.inventory_controller

function main()
  local leftFlag = false -- Initialize leftFlag as false

  robot.up()
  robot.forward()
  for ix1 = 1,10 do

    robot.useDown()

    for ix2 = 1,18 do
      robot.useDown()
      robot.forward()
    end

    robot.useDown()
    if ix1 ~= 10 then
      if leftFlag then
        robot.turnLeft()
        robot.forward()
        robot.forward()
        robot.turnLeft()
        leftFlag = false
      else
        robot.turnRight()
        robot.forward()
        robot.forward()
        robot.turnRight()
        leftFlag = true
      end
    end
  end

  if leftFlag then
    robot.turnRight()
    for j=1,18 do
      robot.forward()
    end
    robot.turnLeft()
    robot.forward()

    robot.down()
  else
    robot.turnLeft()
    for j=1,18 do
      robot.forward()
    end
    robot.turnLeft()
    for j=1,18 do
      robot.forward()
    end
    robot.forward()
    robot.down()
  end


  for i=1,16 do
    robot.select(i)
    inv.dropIntoSlot(sides.front, 27, 64)
  end

  robot.turnLeft()
  robot.turnLeft()
  os.sleep(5)
end

while true do
  main()
end