
zeds4u_ContextMenu = {};

function zeds4u_ContextMenu.searchZeds (playerObj)
    -- addSound(playerObj, square:getX(), square:getY(), square:getZ(), radius, volume)
	-- print ("amore.debug - Client ".."show panel selected")
    --playerObj:Say("oh ho")
    cSearchZeds()
end

function zeds4u_ContextMenu.summon (playerObj, _type)
    -- -- addSound(playerObj, square:getX(), square:getY(), square:getZ(), radius, volume)
	cCallZeds(_type)
    --playerObj:Say("oh ho" .. _type)
end

zeds4u_ContextMenu.doMenu = function(player, context, worldobjects, test)
    if not (isClient() and (isAdmin() or getAccessLevel() == "moderator")) then return true; end
    if test and ISWorldObjectContextMenu.Test then return true end

    local playerObj = getSpecificPlayer(player)
      
    local option = context:addDebugOption("Zeds4u", worldobjects, nil);
    local subMenu = ISContextMenu:getNew(context);
    context:addSubMenu(option, subMenu);

    subMenu:addOption("Search Zeds", playerObj, zeds4u_ContextMenu.searchZeds);
    subMenu:addOption("Sprinter", playerObj, zeds4u_ContextMenu.summon, "Sprinter");
    subMenu:addOption("Tank", playerObj, zeds4u_ContextMenu.summon, "Tank");
    subMenu:addOption("Entidad", playerObj, zeds4u_ContextMenu.summon, "Entity");

end
Events.OnFillWorldObjectContextMenu.Add(zeds4u_ContextMenu.doMenu);