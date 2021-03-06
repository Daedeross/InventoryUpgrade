module("createNewCharacter", package.seeall)

function main (player, new_proto)
    --game.player.print("bar")
    local old_player = player
    local player_pos = game.findnoncollidingposition(old_player.character.prototype.name, old_player.position, 25, 1)
    local new_player = game.createentity{name = new_proto.name, position=player_pos, force=player.force}
    
    local items = {}
    if old_player.hasitemsinside() or old_player.cursorstack ~= nil then
        
        local n = 1
        local playerquickbar = old_player.getinventory(defines.inventory.playerquickbar)
        for i = 1, #playerquickbar do
            if playerquickbar[i] ~= nil then
                items[n] = {name=playerquickbar[i].name,count=playerquickbar[i].count}
                n = n + 1
            end
        end
        old_player.getinventory(defines.inventory.playerquickbar).clear()
        local playermain = old_player.getinventory(defines.inventory.playermain) 
        for i = 1, #playermain do
            if playermain[i] ~= nil then
                items[n] = {name=playermain[i].name,count=playermain[i].count}
                n = n + 1
            end
        end
        old_player.getinventory(defines.inventory.playermain).clear()
        local playerguns = old_player.getinventory(defines.inventory.playerguns) 
        for i = 1, #playerguns do
            if playerguns[i] ~= nil then
                items[n] = {name=playerguns[i].name,count=playerguns[i].count}
                n = n + 1
            end
        end
        old_player.getinventory(defines.inventory.playerguns).clear()
        local playertools = old_player.getinventory(defines.inventory.playertools) 
        for i = 1, #playertools do
            if playertools[i] ~= nil then
                items[n] = {name=playertools[i].name,count=playertools[i].count}
                n = n + 1
            end
        end
        old_player.getinventory(defines.inventory.playertools).clear()
        local playerammo = old_player.getinventory(defines.inventory.playerammo) 
        for i = 1, #playerammo do
            if playerammo[i] ~= nil then
                items[n] = {name=playerammo[i].name,count=playerammo[i].count}
                n = n + 1
            end
        end
        old_player.getinventory(defines.inventory.playerammo).clear()
        local playerarmor = old_player.getinventory(defines.inventory.playerarmor) 
        for i = 1, #playerarmor do
            if playerarmor[i] ~= nil then
                items[n] = {name=playerarmor[i].name,count=playerarmor[i].count}
                n = n + 1
            end
        end
        old_player.getinventory(defines.inventory.playerarmor).clear()
    end 
    old_player.character.destroy()
    for i = 1, #items do 
        new_player.insert(items[i]) 
    end 
    old_player.setcontroller({type = defines.controllers.character, character = new_player}) 

end