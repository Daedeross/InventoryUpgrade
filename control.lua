require ("defines")
require("config")
require("scripts/onInventoryIncrease")
require("scripts/createNewCharacter")

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

game.onevent(defines.events.onplayercreated, function(event)
    local player_index = event.playerindex
    local player = game.players[playerindex]
    if player ~= nil then
        local u_level = 0
        local tech_prefix = "inventory-upgrade-"
        
        
        for i=1, MaxInventoryUpgrades do
            local tech_name = tech_prefix .. i
            if player.force.technologies[tech_name].researched then
                index  = i
            end
        end
        
        if i > 0 then
            local proto_name = string.format("%s%i", "player-", u_level)
            local new_proto = game.entityprototypes[proto_name]
            
            createNewCharacter.main(player, new_proto)
        end 
    end 
end)