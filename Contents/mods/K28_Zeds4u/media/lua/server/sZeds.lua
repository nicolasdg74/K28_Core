-- Docs
--- zombie ai is shared by the clients, the owner is the client who is currently simulating that zombie
---  i can't update a cell outside of it being loaded probl
-- Zombies only save health, location, outfitId, and a few other things

-- Notas:
--- No hay persistencia de los Zeds cuando se cambia de zona

-- ToDo: 
--- Parshear celdas cuando se descubren para que en funcion de la celda descubierta tenga unas propiedades los Zeds

-- Done:
--- Que el Zeds tenga un outfit especifico.
--- Que el zed no aparezca sentado
--- chequear makeInactive es necesario o no
--- Check MP
--- Cuando se cree el Zed al seleccionarlo que detecte que es un zeds vivo en la casilla seleccionada


if isClient() then return end

local specialZedList = ArrayList.new()
local updateAffectedZeds = 0
local SPEED_SPRINTER = 1
local SPEED_FAST_SHAMBLER = 2
local SPEED_SHAMBLER = 3
-- local SPEED_RANDOM = 4 ??

local CLASS_SPRINTER = "Sprinter"
local CLASS_TANK = "Tank"
local CLASS_ENTITY = "Entity"

local function update_Zed(_zombie, _class)
	if (_class == CLASS_ENTITY) then
		getSandboxOptions():set("ZombieLore.Speed", SPEED_FAST_SHAMBLER)
		_zombie:makeInactive(true)
		_zombie:makeInactive(false)
		_zombie:DoZombieStats()
		_zombie:setHealth(30)
		local zid = _zombie:getOnlineID()
		print ("[amore.debug] - New Zed ".._class.." - Online ZombieID: " .. tostring(zid)) -- .. " - OnlineID: " .. tostring(_zombie:OnlineID) )
		getSandboxOptions():set("ZombieLore.Speed", SPEED_FAST_SHAMBLER)
	end


	if (_class == CLASS_TANK) then
		getSandboxOptions():set("ZombieLore.Speed", SPEED_FAST_SHAMBLER)
		_zombie:makeInactive(true)
		_zombie:makeInactive(false)
		_zombie:DoZombieStats()
		_zombie:setHealth(30)
		local zid = _zombie:getOnlineID()
		print ("[amore.debug] - New Zed ".._class.." - Online ZombieID: " .. tostring(zid)) -- .. " - OnlineID: " .. tostring(_zombie:OnlineID) )
		getSandboxOptions():set("ZombieLore.Speed", SPEED_FAST_SHAMBLER)
	end

	if (_class == CLASS_SPRINTER) then
		getSandboxOptions():set("ZombieLore.Speed", SPEED_SPRINTER)
		_zombie:makeInactive(true)
		_zombie:makeInactive(false)
		_zombie:DoZombieStats()
		_zombie:setHealth(2)
		local zid = _zombie:getOnlineID()
		print ("[amore.debug] - Server - Update Zed SPRINTER - ZombieID: " .. tostring(zid)) -- .. " - OnlineID: " .. tostring(_zombie:OnlineID))
		getSandboxOptions():set("ZombieLore.Speed", SPEED_FAST_SHAMBLER)
	end
end



-------------------------------------------------------------------------------------------------------------

local function printZedInfo(_text, _zed)
	local zid = tostring(_zed:getOnlineID())
	local health = tostring(_zed:getHealth())
	local outfit = _zed:getOutfitName()
	if (outfit == nil) then
		outfit = "n/a"
	end
	print ("[amore.debug] - " .. _text .." - ZombieID: " .. zid .. " Health: " .. health .. " Outfit: " .. outfit)
end
-- https://discord.com/channels/136501320340209664/232196827577974784/1040911416904929280

local zeds4u = {}
function zeds4u.search_Zeds()
	zeds = getCell():getZombieList()
	print ("[Amore.Debug] - " .. "Zeds: " .. tostring(zeds:size()) )
	for i = 0, zeds:size() - 1 do
		local str = "Parseando Zed: " .. tostring(i+1) .. "/".. tostring(zeds:size())
		local zed = zeds:get(i)
		printZedInfo(str , zed)
	end
end

-------------------------------------------------------------------------------------------------------------

local ClientCommands = {}
function ClientCommands.summon(player, args)
    local playerOnlineID = player:getOnlineID()
	local posX, posY, posZ = math.floor(player:getX()), math.floor(player:getY()), math.floor(player:getZ())

	print ("[Amore.Debug] - Zeds4u summon "..args.zedClass)
	if (args.zedClass == CLASS_SPRINTER) then
		local outfit = "FitnessInstructor"
		local femaleChance = 50
		local zombies = addZombiesInOutfit(posX, posY, posZ, 1, outfit, femaleChance)
		local zombie = zombies:get(0)
		update_Zed(zombie, args.zedClass)
	end

	if (args.zedClass == CLASS_TANK) then
		local outfit = "Inmate"
		local femaleChance = 0
		local zombies = addZombiesInOutfit(posX, posY, posZ, 1, outfit, femaleChance)
		local zombie = zombies:get(0)
		update_Zed(zombie, args.zedClass)
	end

	if (args.zedClass == CLASS_ENTITY) then
		local outfit = "NBEntity"
		local femaleChance = 0
		local zombies = addZombiesInOutfit(posX, posY, posZ, 1, outfit, femaleChance)
		local zombie = zombies:get(0)
		update_Zed(zombie, args.zedClass)
		specialZedList:add(zombie)
	end

end

OnClientCommand = function(module, command, player, args)
	if module == 'zeds4u' and ClientCommands[command] then
		ClientCommands[command](player, args)
	end
	if module == 'zeds4u' and command == 'search' then
		zeds4u.search_Zeds()
	end
end
Events.OnClientCommand.Add(OnClientCommand)

-------------------------------------------------------------------------------------------------------------



function handleOnTick(tick)
	if updateAffectedZeds + 10000 > getTimestampMs() then return end
	-- print ("[Amore.Debug] - Zeds4u handleontick")
	updateAffectedZeds = getTimestampMs()
	-- print ("[Amore.Debug] - zeds especiales: "..tostring(specialZedList:size()))
	for i = specialZedList:size()-1, 0, -1 do
		if not specialZedList:get(i):isAlive() then
			specialZedList:remove(i)
		end
	end
	for i = 0, specialZedList:size()-1, 1 do
		local affectedPlayers = getAffectedPlayersBySpecialZombie(specialZedList:get(i))
		for x = 0, affectedPlayers:size()-1, 1 do
			local affectedPlayer = affectedPlayers:get(x)
			sendServerCommand(affectedPlayer, "zeds4u", "doPanic", {})
		end
	end
end
Events.OnTick.Add(handleOnTick)


function handleOnInitGlobalModData(isNewGame)
	updateAffectedZeds = getTimestampMs()
end
Events.OnInitGlobalModData.Add(handleOnInitGlobalModData)

print ("[Amore.Debug] - sZeds loaded")
return zeds4u