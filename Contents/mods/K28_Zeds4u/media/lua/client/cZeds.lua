if isServer() then return end

zeds4u = {}
-- ToDo: 
--- Hacer UI basica ingame


function cSearchZeds()
	local args = {}
	local player = getPlayer()
	print ("amore.debug - Client " .. "Searching Zeds")

	sendClientCommand(getPlayer(), 'zeds4u', 'search', args)
end

function cCallZeds(_type)
	local args = { zedClass = _type }
	local player = getPlayer()
	local posX, posY, posZ = math.floor(player:getX()), math.floor(player:getY()), math.floor(player:getZ())
	print ("amore.debug - Client " .. tostring(posX) .. " " .. tostring(posY)  .. tostring(posZ) )

	sendClientCommand(getPlayer(), 'zeds4u', 'summon', args)
end


function zeds4u.doPanic()
	getPlayer():getStats():setPanic(100)
	print ("[Amore.Debug] - doPanic")
	-- valor de 0 a 100
	-- :getStats():getPanic()
	-- :getStats():setPanic(nuevo)
end

function handleServerCommand(module, command, args)
	if module ~= "zeds4u" then return end
	print ("[Amore.Debug] - server command recibido")
	if zeds4u[command] then
		zeds4u[command](args)
	end
end
Events.OnServerCommand.Add(handleServerCommand)