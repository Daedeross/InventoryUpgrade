module("onInventoryIncrease", package.seeall)
require("scripts/createNewCharacter")

function main(event, u_level)
    local proto_name = string.format("%s%i", "player-", u_level)
    local new_proto = game.entityprototypes[proto_name]
    if new_proto == nil then
        error("Tried to create invalid entity. :(")
    -- Cannot yet alter prototypes run-time via scripts
    --[[
        new_proto = table.deepcopy(data.raw.player.player)
        new_proto.inventory_size = 60 * (1 + u_level)
        game.entityprototypes[proto_name] = new_proto
    ]]--
    end
    for j, player in ipairs(game.players) do 
        if player ~= nil and player.character ~= nil then
            if player.force.currentresearch.name == event.research and player.force.technologies then
                createNewCharacter.main(player, new_proto)
            end
        end
    end 
end 