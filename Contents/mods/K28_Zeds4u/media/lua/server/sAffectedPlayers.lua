 --- gets the player array affected by zombie special aura
---@param zombie IsoZombie
---@return ArrayList -- ArrayList<IsoPlayer>
function getAffectedPlayersBySpecialZombie(zombie)
    if zombie == nil then return ArrayList.new() end
    local zombieSquare = zombie:getSquare()
    print ("[Amore.Debug] - zombieSquare: x: "..tostring(zombieSquare:getX()).." - y: "..tostring(zombieSquare:getY()))
    local players = getOnlinePlayers()
    local affectedPlayers = ArrayList.new()
    local zombieSpecialArea = 10

    for i = 0, players:size()-1, 1 do
        local currentPlayer = players:get(i);
        if currentPlayer ~= nil then 
            if zombieSquare:DistTo(currentPlayer:getSquare()) < zombieSpecialArea then
                affectedPlayers:add(currentPlayer)
                print ("[Amore.Debug] - Distancia: "..tostring(zombieSquare:DistTo(currentPlayer:getSquare())).." - Affected Player: "..currentPlayer:getFullName())
            end    
        end

    end

    return affectedPlayers
end 