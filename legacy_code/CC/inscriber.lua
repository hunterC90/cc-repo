os.loadAPI("APIs/storage.lua")

-- I have to do this nonsense so that VSCode knows about storage.lua
pcall(function()
    storage = require("storage.lua")
end)

local inscriberSide = "left"
local inputSide = "right"
local outputSide = "top"

local inscriber = peripheral.wrap(inscriberSide)
local inputChest = peripheral.wrap(inputSide)
local outputChest = peripheral.wrap(outputSide)

local inscriberSlots = {1, 3, 2}

items = {
    ["au"] = {"minecraft:gold_ingot", 0},
    ["di"] = {"minecraft:diamond", 0},
    ["rd"] = {"minecraft:redstone", 0},
    ["si"] = {"appliedenergistics2:material", 5},
    ["pq"] = {"appliedenergistics2:material", 10},
    ["cp"] = {"appliedenergistics2:material", 13},
    ["ep"] = {"appliedenergistics2:material", 14},
    ["lp"] = {"appliedenergistics2:material", 15},
    ["sp"] = {"appliedenergistics2:material", 19},
    ["cc"] = {"appliedenergistics2:material", 16},
    ["ec"] = {"appliedenergistics2:material", 17},
    ["lc"] = {"appliedenergistics2:material", 18},
    ["sc"] = {"appliedenergistics2:material", 20},
}

recipes = {
    {"cp", "pq"},
    {"ep", "di"},
    {"lp", "au"},
    {"sp", "si"},
    {"cc", "rd", "sc"},
    {"lc", "rd", "sc"},
    {"ec", "rd", "sc"}
}


function craft(v)
    local slots = {}
    local num = #v
    for i = 1, num do
        slots[i] = storage.searchInv(inputChest, items[v[i]][1], items[v[i]][2])
        if slots[i] == nil then
            return false
        end
    end


    for i = 1, num do
        inputChest.pushItems(inscriberSide, slots[i][1], 1, inscriberSlots[i])
    end

    while inscriber.list[4] == nil do sleep(0) end
    if num == 2 then
        inscriber.pushItems(inputSide, inscriberSlots[1])
    end
    outputChest.pullItems(inscriberSide, 4)
    return true

end



function cleanUp()
    inputChest.pullItems(inscriberSide, 4)
    inscriber.pushItems(inputSide, inscriberSlots[1])
    inputChest.pullItems(inscriberSide,inscriberSlots[2])
    inputChest.pullItems(inscriberSide,inscriberSlots[3])
end

cleanUp()
while true do
    for k,v in pairs(recipes) do
        while(craft(v)) do
            
        end
    end
    os.sleep(1)
end