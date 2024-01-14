-- guia para configurar clips de sonidos: https://pzwiki.net/wiki/Scripts_guide/Sound_Script_Guide

sonidos_ContextMenu = {};

function sonidos_ContextMenu.reproducir (playerObj, _type)
    -- addSound(playerObj, square:getX(), square:getY(), square:getZ(), radius, volume) <-- addSound es para atraer Zeds, no reproduce sonidos
    -- playerObj:playSound(_type) --  <-- con /invisible no funciona
    -- getSoundManager():PlaySound(_type,false,1); -- <-- otra manera de invocar playSound, solo funciona en local
    -- getSoundManager():PlayWorldSound(_type, false, playerObj:getCurrentSquare(), 0.5, 300, 0.7, false) ;
    getSoundManager():PlayWorldSound(_type, false, playerObj:getCurrentSquare(), 0.5, 300, 0.7, false) ;
end

sonidos_ContextMenu.doMenu = function(player, context, worldobjects, test)
    if not (isClient() and (isAdmin() or getAccessLevel() == "moderator")) then return true; end
    if test and ISWorldObjectContextMenu.Test then return true end

    local playerObj = getSpecificPlayer(player)
      
    local option = context:addDebugOption("Sonidos", worldobjects, nil);
    local subMenu = ISContextMenu:getNew(context);
    context:addSubMenu(option, subMenu);

    -- submenu completo
    local enteOption = subMenu:addOption("Ente", worldobjects, nil);
    local enteSubMenu = subMenu:getNew(subMenu);
    enteSubMenu:addSubMenu(enteOption, enteSubMenu);    
    enteSubMenu:addOption("Ente_001", playerObj, sonidos_ContextMenu.reproducir, "sonidos_Ente_001");
    enteSubMenu:addOption("Ente_002", playerObj, sonidos_ContextMenu.reproducir, "sonidos_Ente_002");
    enteSubMenu:addOption("Ente_003", playerObj, sonidos_ContextMenu.reproducir, "sonidos_Ente_003");
    enteSubMenu:addOption("Ente_004", playerObj, sonidos_ContextMenu.reproducir, "sonidos_Ente_004");
    enteSubMenu:addOption("Ente_005", playerObj, sonidos_ContextMenu.reproducir, "sonidos_Ente_005");
    enteSubMenu:addOption("Ente_006", playerObj, sonidos_ContextMenu.reproducir, "sonidos_Ente_006");
    enteSubMenu:addOption("Ente_007", playerObj, sonidos_ContextMenu.reproducir, "sonidos_Ente_007");

    -- submenu completo
    local screamerOption = subMenu:addOption("Screamer", worldobjects, nil);
    local screamerSubMenu = subMenu:getNew(subMenu);
    subMenu:addSubMenu(screamerOption, screamerSubMenu);
    screamerSubMenu:addOption("Screamer_001", playerObj, sonidos_ContextMenu.reproducir, "sonidos_screamer_001");
    screamerSubMenu:addOption("Screamer_002", playerObj, sonidos_ContextMenu.reproducir, "sonidos_screamer_002");
    screamerSubMenu:addOption("Screamer_003", playerObj, sonidos_ContextMenu.reproducir, "sonidos_screamer_003");
    screamerSubMenu:addOption("Screamer_004", playerObj, sonidos_ContextMenu.reproducir, "sonidos_screamer_004");

    -- submenu completo
    local NecroaracnidoOption = subMenu:addOption("Necroaracnido", worldobjects, nil);
    local NecroaracnidoSubMenu = subMenu:getNew(subMenu);
    subMenu:addSubMenu(NecroaracnidoOption, NecroaracnidoSubMenu);
    NecroaracnidoSubMenu:addOption("Necroaracnido_001", playerObj, sonidos_ContextMenu.reproducir, "sonidos_Necroaracnido_001");
    NecroaracnidoSubMenu:addOption("Necroaracnido_002", playerObj, sonidos_ContextMenu.reproducir, "sonidos_Necroaracnido_002");
    NecroaracnidoSubMenu:addOption("Necroaracnido_003", playerObj, sonidos_ContextMenu.reproducir, "sonidos_Necroaracnido_003");

    -- submenu completo
    local ambientalOption = subMenu:addOption("Ambiental", worldobjects, nil);
    local ambientalSubMenu = subMenu:getNew(subMenu);
    subMenu:addSubMenu(ambientalOption, ambientalSubMenu);
    ambientalSubMenu:addOption("alarma", playerObj, sonidos_ContextMenu.reproducir, "alarma");
end
Events.OnFillWorldObjectContextMenu.Add(sonidos_ContextMenu.doMenu);