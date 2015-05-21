require ("defines")
require("config")
require("scripts/onInventoryIncrease")
--require ("util")
--[[
game.oninit(function ()
    glob.inv_upgrades = {}
    for i = 1, MaxInventoryUpgrades do
        glob
    end
)
]]--

game.onevent(defines.events.onresearchfinished, function(event)
    local e_name = event.research
    i, j, level  = string.find(e_name, "inventory%-upgrade%-(%d+)")
    local u_level = 0
    if level ~= nil then
        u_level = tonumber(level)
    end
    if u_level > 0 then
        onInventoryIncrease.main(event, u_level)
    end 
end)