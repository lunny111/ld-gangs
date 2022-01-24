--[[
 _                             _____                 _                                  _       
| |                           |  __ \               | |                                | |      
| |    _   _ _ __  _ __  _   _| |  | | _____   _____| | ___  _ __  _ __ ___   ___ _ __ | |_ ___ 
| |   | | | | '_ \| '_ \| | | | |  | |/ _ \ \ / / _ \ |/ _ \| '_ \| '_ ` _ \ / _ \ '_ \| __/ __|
| |___| |_| | | | | | | | |_| | |__| |  __/\ V /  __/ | (_) | |_) | | | | | |  __/ | | | |_\__ \
|______\__,_|_| |_|_| |_|\__, |_____/ \___| \_/ \___|_|\___/| .__/|_| |_| |_|\___|_| |_|\__|___/
                          __/ |                             | |                                 
                         |___/                              |_|                                 
]]


local PlayerData = {}

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

PlayerData = ESX.GetPlayerData()

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)
       
local gangsrc = {} 
local gsfsinirlendi = false
local ballasinirlendi = false
local vagosinirlendi = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.TriggerServerCallback("ld-gangs:server:getTime",function(status)
        if status ~= nil then
            for k,v in pairs(status) do
                gangsrc[k] = v 
            end
        end
    end)
end)

Citizen.CreateThread(function()
    if Config.GsfNPCEnable then
      RequestModel(Config.GsfNPCHash)
          while not HasModelLoaded(Config.GsfNPCHash) do
              Wait(1)
          end
          gsfnpc = CreatePed(1, Config.GsfNPCHash, Config.GsfNPC.x, Config.GsfNPC.y, Config.GsfNPC.z, Config.GsfNPC.h, false, true)
          SetBlockingOfNonTemporaryEvents(gsfnpc, true)
          SetPedDiesWhenInjured(gsfnpc, false)
          SetPedCanPlayAmbientAnims(gsfnpc, true)
          SetPedCanRagdollFromPlayerImpact(gsfnpc, false)
          SetEntityInvincible(gsfnpc, true)
          FreezeEntityPosition(gsfnpc, true)
          if not gsfsinirlendi then
            TaskStartScenarioInPlace(gsfnpc, "WORLD_HUMAN_SMOKING", 0, true);
          end
        end

        if Config.BallasNPCEnable then
            RequestModel(Config.BallasNPCHash)
            while not HasModelLoaded(Config.BallasNPCHash) do
                Wait(1)
            end
            ballasnpc = CreatePed(1, Config.BallasNPCHash, Config.BallasNPC.x, Config.BallasNPC.y, Config.BallasNPC.z, Config.BallasNPC.h, false, true)
            SetBlockingOfNonTemporaryEvents(ballasnpc, true)
            SetPedDiesWhenInjured(ballasnpc, false)
            SetPedCanPlayAmbientAnims(ballasnpc, true)
            SetPedCanRagdollFromPlayerImpact(ballasnpc, false)
            SetEntityInvincible(ballasnpc, true)
            FreezeEntityPosition(ballasnpc, true)
            if not ballasinirlendi then
              TaskStartScenarioInPlace(ballasnpc, "WORLD_HUMAN_SMOKING", 0, true);
            end
          end

          if Config.VagosNPCEnable then
            RequestModel(Config.VagosNPCHash)
            while not HasModelLoaded(Config.VagosNPCHash) do
                Wait(1)
            end
            vagosnpc = CreatePed(1, Config.VagosNPCHash, Config.VagosNPC.x, Config.VagosNPC.y, Config.VagosNPC.z, Config.VagosNPC.h, false, true)
            SetBlockingOfNonTemporaryEvents(vagosnpc, true)
            SetPedDiesWhenInjured(vagosnpc, false)
            SetPedCanPlayAmbientAnims(vagosnpc, true)
            SetPedCanRagdollFromPlayerImpact(vagosnpc, false)
            SetEntityInvincible(vagosnpc, true)
            FreezeEntityPosition(vagosnpc, true)
            if not vagosinirlendi then
              TaskStartScenarioInPlace(vagosnpc, "WORLD_HUMAN_SMOKING", 0, true);
            end
          end
end)  

Citizen.CreateThread(function()
    PlayerData = ESX.GetPlayerData()
	while true do
        Citizen.Wait(0)
        
        local coords = GetEntityCoords(PlayerPedId())

        if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'npcmenu') and IsControlJustReleased(0, 202) or IsControlJustReleased(0, 25) then ESX.UI.Menu.CloseAll() end

		if(GetDistanceBetweenCoords(coords, Config.GsfNPC.x, Config.GsfNPC.y, Config.GsfNPC.z, true) < 2.5) then

            if not Config.GsfJobEnabled then

                if Config.GsfTimerEnable then
                    if gangsrc['gsf'] ~= nil then
                        DrawText3Ds(Config.GsfNPC.x, Config.GsfNPC.y, Config.GsfNPC.z+2.0, "Dostum, daha fazla adam yollayamam. Tekrar yollayabilmem için "..gangsrc['gsf'].." dakika beklemelisin.")
                    else
                        DrawText3Ds(Config.GsfNPC.x, Config.GsfNPC.y, Config.GsfNPC.z+2.0, Config.GsfNPCText)
                        if not gsfsinirlendi and IsControlJustReleased(0, 51) then
                            gsfmenuopen()
                        end
                    end
                else
                    DrawText3Ds(Config.GsfNPC.x, Config.GsfNPC.y, Config.GsfNPC.z+2.0, Config.GsfNPCText)

                    if not gsfsinirlendi and IsControlJustReleased(0, 51) then
                        gsfmenuopen()
                    end
                end   

            else

                if PlayerData.job and PlayerData.job.name == Config.GsfJobName then
                    if Config.GsfTimerEnable then
                        if gangsrc['gsf'] ~= nil then
                            DrawText3Ds(Config.GsfNPC.x, Config.GsfNPC.y, Config.GsfNPC.z+2.0, "Dostum, daha fazla adam yollayamam. Tekrar yollayabilmem için "..gangsrc['gsf'].." dakika beklemelisin.")
                        else
                            DrawText3Ds(Config.GsfNPC.x, Config.GsfNPC.y, Config.GsfNPC.z+2.0, Config.GsfNPCText)
                            if not gsfsinirlendi and IsControlJustReleased(0, 51) then
                                gsfmenuopen()
                            end
                        end
                    else
                        DrawText3Ds(Config.GsfNPC.x, Config.GsfNPC.y, Config.GsfNPC.z+2.0, Config.GsfNPCText)

                        if not gsfsinirlendi and IsControlJustReleased(0, 51) then
                            gsfmenuopen()
                        end
                    end
            
                else
                    DrawText3Ds(Config.GsfNPC.x, Config.GsfNPC.y, Config.GsfNPC.z+2.0, Config.GsfNPCText2)
                end
            end            

        elseif(GetDistanceBetweenCoords(coords, Config.BallasNPC.x, Config.BallasNPC.y, Config.BallasNPC.z, true) < 2.5) and Config.BallasEnable then
            
            if not Config.BallasJobEnabled then

                if Config.BallasTimerEnable then

                    if gangsrc['ballas'] ~= nil then
                        DrawText3Ds(Config.BallasNPC.x, Config.BallasNPC.y, Config.BallasNPC.z+2.0, "Dostum, daha fazla adam yollayamam. Tekrar yollayabilmem için ".. gangsrc['ballas'].. " dakika beklemelisin.")
                    else
                        DrawText3Ds(Config.BallasNPC.x, Config.BallasNPC.y, Config.BallasNPC.z+2.0, Config.BallasNPCText)
                        
                        if not ballasinirlendi and IsControlJustReleased(0, 51) then
                            ballasmenuopen()
                        end
                    end
                else
                    DrawText3Ds(Config.BallasNPC.x, Config.BallasNPC.y, Config.BallasNPC.z+2.0, Config.BallasNPCText)
                        
                    if not ballasinirlendi and IsControlJustReleased(0, 51) then
                        ballasmenuopen()
                    end
                end

            else
                if Config.BallasTimerEnable then
                    if PlayerData.job and PlayerData.job.name == Config.BallasJobName then
                        if gangsrc['ballas'] ~= nil then
                            DrawText3Ds(Config.BallasNPC.x, Config.BallasNPC.y, Config.BallasNPC.z+2.0, "Dostum, daha fazla adam yollayamam. Tekrar yollayabilmem için ".. gangsrc['ballas'].. " dakika beklemelisin.")
                        else
                            DrawText3Ds(Config.BallasNPC.x, Config.BallasNPC.y, Config.BallasNPC.z+2.0, Config.BallasNPCText)
                            if not ballasinirlendi and IsControlJustReleased(0, 51) then
                                ballasmenuopen()
                            end
                        end
                    else
                        DrawText3Ds(Config.BallasNPC.x, Config.BallasNPC.y, Config.BallasNPC.z+2.0, Config.BallasNPCText2)
                    end
                else
                    DrawText3Ds(Config.BallasNPC.x, Config.BallasNPC.y, Config.BallasNPC.z+2.0, Config.BallasNPCText)
                    if not ballasinirlendi and IsControlJustReleased(0, 51) then
                        ballasmenuopen()
                    end
                end
            end

        elseif(GetDistanceBetweenCoords(coords, Config.VagosNPC.x, Config.VagosNPC.y, Config.VagosNPC.z, true) < 2.5) and Config.VagosEnable then
            
            if not Config.VagosJobEnabled then

                if Config.VagosTimerEnable then
                    if gangsrc['vagos'] ~= nil then
                        DrawText3Ds(Config.VagosNPC.x, Config.VagosNPC.y, Config.VagosNPC.z+2.0, "Dostum, daha fazla adam yollayamam. Tekrar yollayabilmem için "..gangsrc['vagos'].." dakika beklemelisin.")
                    else 
                        DrawText3Ds(Config.VagosNPC.x, Config.VagosNPC.y, Config.VagosNPC.z+2.0, Config.VagosNPCText)                  
                        if not vagosinirlendi and IsControlJustReleased(0, 51) then
                            vagosmenuopen()
                        end
                    end
                else
                    DrawText3Ds(Config.VagosNPC.x, Config.VagosNPC.y, Config.VagosNPC.z+2.0, Config.VagosNPCText)                  
                    if not vagosinirlendi and IsControlJustReleased(0, 51) then
                        vagosmenuopen()
                    end
                end
            else
                if PlayerData.job and PlayerData.job.name == Config.VagosJobName then
                    if Config.VagosTimerEnable then
                        if gangsrc['vagos'] ~= nil then
                            DrawText3Ds(Config.VagosNPC.x, Config.VagosNPC.y, Config.VagosNPC.z+2.0, "Dostum, daha fazla adam yollayamam. Tekrar yollayabilmem için ".. gangsrc['vagos'].. " dakika beklemelisin.")
                        else
                            DrawText3Ds(Config.VagosNPC.x, Config.VagosNPC.y, Config.VagosNPC.z+2.0, Config.VagosNPCText)
                            if not vagosinirlendi and IsControlJustReleased(0, 51) then
                                vagosmenuopen()
                            end
                        end
                    else
                        DrawText3Ds(Config.VagosNPC.x, Config.VagosNPC.y, Config.VagosNPC.z+2.0, Config.VagosNPCText)
                        if not vagosinirlendi and IsControlJustReleased(0, 51) then
                            vagosmenuopen()
                        end
                    end
                else
                    DrawText3Ds(Config.VagosNPC.x, Config.VagosNPC.y, Config.VagosNPC.z+2.0, Config.VagosNPCText2)
                end
            end
		end
	end
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 250
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 140)
end

local gangler = {
    [1] = "AMBIENT_GANG_BALLAS",
    [2] = "AMBIENT_GANG_FAMILY",
    [3] = "AMBIENT_GANG_MEXICAN",
}

function gangYap(gang, silah, target)
    SetPedRelationshipGroupHash(gang, 'DrugsNPC')
    GiveWeaponToPed(gang,GetHashKey("WEAPON_ASSAULTRIFLE"),250,false,true)
    SetPedArmour(gang, math.random(250,320))
    SetPedDropsWeaponsWhenDead(gang, false) 
    SetPedShootRate(gang, math.random(500,1000))
    SetPedCombatAttributes(gang, 46, true)
    SetPedFleeAttributes(gang, 0, 0)
    SetPedAsEnemy(gang,true)
    SetPedAccuracy(gang, math.random(75,95))
    SetPedAlertness(gang, 3)
    SetPedCombatRange(gang, 2)
    SetPedCombatMovement(gang, 3)
    local randomcan = math.random(200,250)
    SetEntityHealth(gang, randomcan)
    SetEntityMaxHealth(gang, randomcan)
    TaskCombatPed(gang, target, 0,16)
    SetPedRelationshipGroupHash( gang, GetHashKey("HATES_PLAYER")) 
end

RegisterNetEvent("ld-gangs:client:gsfattackNPC")
AddEventHandler("ld-gangs:client:gsfattackNPC", function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local hashKey = GetHashKey("cs_chengsr")
    local pedType = 5
    local PlayerCords = GetEntityCoords(ped)
    local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(PlayerCords.x + math.random(-60, 60), PlayerCords.y + math.random(-60, 60), PlayerCords.z, 0, 3, 0)

    for i=1,4 do
        RequestModel(hashKey)

        while not HasModelLoaded(hashKey) and RequestModel(hashKey) do
            RequestModel(hashKey)
            Citizen.Wait(0)
        end
    end
    
    ESX.Game.SpawnVehicle(1026149675, spawnPos, spawnHeading, function(gangCar)
        ClearAreaOfVehicles(GetEntityCoords(gangCar), 5000, false, false, false, false, false)
        SetVehicleOnGroundProperly(gangCar)
        SetVehicleColours(gangCar, 49, 49)
        SetEntityMaxSpeed(gangCar, 500.0)
        SetVehicleEnginePowerMultiplier(gangCar, 25.0)
        SetVehicleEngineTorqueMultiplier(gangCar, 25.0)
        gangMember1 = CreatePedInsideVehicle(gangCar, 12, Config.GsfAttackerHashKey, -1, true, false)
        gangMember2 = CreatePedInsideVehicle(gangCar, 12, Config.GsfAttackerHashKey, 0, true, false)
        gangMember3 = CreatePedInsideVehicle(gangCar, 12, Config.GsfAttackerHashKey, 1, true, false)
        gangMember4 = CreatePedInsideVehicle(gangCar, 12, Config.GsfAttackerHashKey, 2, true, false)
        SetEveryoneIgnorePlayer(gangMember1, true)
        SetEveryoneIgnorePlayer(gangMember2, true)
        SetEveryoneIgnorePlayer(gangMember3, true)
        SetEveryoneIgnorePlayer(gangMember4, true)
        gangYap(gangMember1, "WEAPON_ASSAULTRIFLE")
        gangYap(gangMember2, "WEAPON_ASSAULTRIFLE")
        gangYap(gangMember3, "WEAPON_ASSAULTRIFLE")
        gangYap(gangMember4, "WEAPON_ASSAULTRIFLE")
        TaskVehicleDriveToCoord(gangMember1,gangCar,PlayerCords.x,PlayerCords.y,PlayerCords.z,10.0,0,1026149675,8388614,1,true)
    end)
end)

function gsfattackNPC()
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'idgir', {
        title = _U("enter_id_or_name")
    }, function(data, menu)
        local id = tonumber(data.value)
        
        if id == GetPlayerServerId(PlayerId()) then return exports['mythic_notify']:SendAlert("inform", _U("driveby_self"), 6500) end

        if id == nil or id < 0 then
            exports['mythic_notify']:SendAlert('inform', _U("invalid_number"))
        else
            menu.close()
            ESX.TriggerServerCallback("ld-gangs:server:getItemAmount", function(qty)
                if qty >= Config.GsfParaMiktari then
                    TriggerServerEvent('ld-gangs:server:gsfattackNPC', id,'gsf')
                else
                    exports['mythic_notify']:SendAlert("inform",  _U("not_enough_money"..Config.GsfParaMiktari..""), 7500)
                end
            end,"cash")
        end
    end, function(data, menu)
        menu.close()
    end)
end

function gsfmenuopen()
    local elements = {
		{label = 'NPC Gönder',  value = 'npcsaldir'},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'npcmenu', {
        title    = _U("select_action"),
        align    = 'top-left',
		elements = elements	
	}, function(data, menu)
		menu.close()
		if data.current.value == 'npcsaldir' then
			menu.close()
			sorugsf()
		end
    end)
end		

local sinirgsf = 0

function sorugsf()

    ESX.UI.Menu.Open('dialog',GetCurrentResourceName(),'Menu',{title=_U("ask_password_title")},
      function(a,b)
        b.close()
        local player = PlayerPedId()
        
        if sinirgsf > 1 then
           exports['mythic_notify']:SendAlert("inform", _U("angry_npc"), 8500)
           ClearPedTasksImmediately(gsfnpc)
           TaskStartScenarioInPlace(gsfnpc, "WORLD_HUMAN_STAND_MOBILE", 0, true);
           gsfsinirlendi = true
           Wait(15000)
           ClearPedTasksImmediately(gsfnpc)
           gsfsinirlendi = false
           sinirgsf = 0
           TaskStartScenarioInPlace(gsfnpc, "WORLD_HUMAN_SMOKING", 0, true);
           TriggerEvent("ld-gangs:client:gsfattackNPC")
        end

        for k,v in pairs(Config.CursedWordList) do
            if a.value == v then 
                if Config.GsfSinirlenme then
                    if sinirgsf < 2 then
                        exports['mythic_notify']:SendAlert('inform', _U('angry_npc_warning'), 3500)
                        sinirgsf = sinirgsf + 1
                        return
                    end
                    return
                else
                exports['mythic_notify']:SendAlert('inform', _U("angry_npc_warning"), 3500)
                return
                end
            end
        end

        if a.value == Config.GsfSifre then
            exports['mythic_notify']:SendAlert("inform", _U("right_password"), 3500)
            gsfattackNPC()
          Citizen.Wait(500)
        else
            exports['mythic_notify']:SendAlert("inform", _U("wrong_password"), 3500)
          end 
        end,
      function(a,b)b.close()
    end)
end




RegisterNetEvent("ld-gangs:client:ballasattackNPC")
AddEventHandler("ld-gangs:client:ballasattackNPC", function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local hashKey = GetHashKey("cs_chengsr")
    local pedType = 5
    local PlayerCords = GetEntityCoords(ped)
    local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(PlayerCords.x + math.random(-60, 60), PlayerCords.y + math.random(-60, 60), PlayerCords.z, 0, 3, 0)

    for i=1,4 do
        RequestModel(hashKey)

        while not HasModelLoaded(hashKey) and RequestModel(hashKey) do
            RequestModel(hashKey)
            Citizen.Wait(0)
        end
    end
    
    ESX.Game.SpawnVehicle(1026149675, spawnPos, spawnHeading, function(gangCar)
        ClearAreaOfVehicles(GetEntityCoords(gangCar), 5000, false, false, false, false, false)
        SetVehicleOnGroundProperly(gangCar)
        SetVehicleColours(gangCar, 149, 149)
        SetEntityMaxSpeed(gangCar, 500.0)
        SetVehicleEnginePowerMultiplier(gangCar, 25.0)
        SetVehicleEngineTorqueMultiplier(gangCar, 25.0)
        gangMember1 = CreatePedInsideVehicle(gangCar, 12, Config.BallasAttackerHashKey, -1, true, false)
        gangMember2 = CreatePedInsideVehicle(gangCar, 12, Config.BallasAttackerHashKey, 0, true, false)
        gangMember3 = CreatePedInsideVehicle(gangCar, 12, Config.BallasAttackerHashKey, 1, true, false)
        gangMember4 = CreatePedInsideVehicle(gangCar, 12, Config.BallasAttackerHashKey, 2, true, false)
        SetEveryoneIgnorePlayer(gangMember1, true)
        SetEveryoneIgnorePlayer(gangMember2, true)
        SetEveryoneIgnorePlayer(gangMember3, true)
        SetEveryoneIgnorePlayer(gangMember4, true)
        gangYap(gangMember1, "WEAPON_ASSAULTRIFLE")
        gangYap(gangMember2, "WEAPON_ASSAULTRIFLE")
        gangYap(gangMember3, "WEAPON_ASSAULTRIFLE")
        gangYap(gangMember4, "WEAPON_ASSAULTRIFLE")
        TaskVehicleDriveToCoord(gangMember1,gangCar,PlayerCords.x,PlayerCords.y,PlayerCords.z,10.0,0,1026149675,8388614,1,true)
    end)
end)

function ballasattackNPC()
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'idgir', {
        title = _U("enter_id_or_name")
    }, function(data, menu)
        local id = tonumber(data.value)
    
        if id == GetPlayerServerId(PlayerId()) then return exports['mythic_notify']:SendAlert("inform", _U("driveby_self"), 6500) end

        if id == nil or id < 0 then
            exports['mythic_notify']:SendAlert('inform', _U("invalid_number"))
        else
            menu.close()
            ESX.TriggerServerCallback("ld-gangs:server:getItemAmount", function(qty)
                if qty >= Config.BallasParaMiktari then 
                    TriggerServerEvent('ld-gangs:server:ballasattackNPC', id, 'ballas')
                else
                    exports['mythic_notify']:SendAlert("inform",  _U("not_enough_money"..Config.BallasParaMiktari..""), 7500)
                end
            end,"cash")
        end
    end, function(data, menu)
        menu.close()
    end)
end

function ballasmenuopen()
    local elements = {
		{label = _U("send_npc"),  value = 'npcsaldir'},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'npcmenu', {
        title    = _U("select_action"),
        align    = 'top-left',
		elements = elements	
	}, function(data, menu)
		menu.close()
		if data.current.value == 'npcsaldir' then
			menu.close()
			soruballas()
		end
    end)
end		

local sinirballas = 0

function soruballas()

    ESX.UI.Menu.Open('dialog',GetCurrentResourceName(),'Menu',{title=_U("ask_password_title")},
      function(a,b)
        b.close()
        local player = PlayerPedId()
        
        if sinirballas > 1 then
           exports['mythic_notify']:SendAlert("inform", _U("angry_npc"), 8500)
           ClearPedTasksImmediately(ballasnpc)
           TaskStartScenarioInPlace(ballasnpc, "WORLD_HUMAN_STAND_MOBILE", 0, true);
           ballasinirlendi = true
           Wait(15000)
           ClearPedTasksImmediately(ballasnpc)
           ballasinirlendi = false
           sinirballas = 0
           TaskStartScenarioInPlace(ballasnpc, "WORLD_HUMAN_SMOKING", 0, true);
           TriggerEvent("ld-gangs:client:ballasattackNPC")
        end

        for k,v in pairs(Config.CursedWordList) do
            if a.value == v then 
                if Config.BallasSinirlenme then
                    if sinirballas < 2 then
                        exports['mythic_notify']:SendAlert('inform', _U("angry_npc_warning"), 3500)
                        sinirballas = sinirballas + 1
                        return
                    end
                    return
                else
                exports['mythic_notify']:SendAlert('inform', _U("angry_npc_warning"), 3500)
                return
                end
            end
        end

        if a.value == Config.BallasSifre then
            exports['mythic_notify']:SendAlert("inform", _U("right_password"), 3500)
            ballasattackNPC()
          Citizen.Wait(500)
        else
            exports['mythic_notify']:SendAlert("inform", _U("wrong_password"), 3500)
          end 
        end,
      function(a,b)b.close()
    end)
end


RegisterNetEvent("ld-gangs:client:vagosattackNPC")
AddEventHandler("ld-gangs:client:vagosattackNPC", function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local hashKey = GetHashKey("cs_chengsr")
    local pedType = 5
    local PlayerCords = GetEntityCoords(ped)
    local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(PlayerCords.x + math.random(-110, 110), PlayerCords.y + math.random(-60, 60), PlayerCords.z, 0, 3, 0)

    for i=1,4 do
        RequestModel(hashKey)

        while not HasModelLoaded(hashKey) and RequestModel(hashKey) do
            RequestModel(hashKey)
            Citizen.Wait(0)
        end
    end
    
    ESX.Game.SpawnVehicle(1026149675, spawnPos, spawnHeading, function(gangCar)
        ClearAreaOfVehicles(GetEntityCoords(gangCar), 5000, false, false, false, false, false)
        SetVehicleOnGroundProperly(gangCar)
        SetVehicleColours(gangCar, 42, 42)
        SetEntityMaxSpeed(gangCar, 500.0)
        SetVehicleEnginePowerMultiplier(gangCar, 25.0)
        SetVehicleEngineTorqueMultiplier(gangCar, 25.0)
        gangMember1 = CreatePedInsideVehicle(gangCar, 12, Config.VagosAttackerHashKey, -1, true, false)
        gangMember2 = CreatePedInsideVehicle(gangCar, 12, Config.VagosAttackerHashKey, 0, true, false)
        gangMember3 = CreatePedInsideVehicle(gangCar, 12, Config.VagosAttackerHashKey, 1, true, false)
        gangMember4 = CreatePedInsideVehicle(gangCar, 12, Config.VagosAttackerHashKey, 2, true, false)
        SetEveryoneIgnorePlayer(gangMember1, true)
        SetEveryoneIgnorePlayer(gangMember2, true)
        SetEveryoneIgnorePlayer(gangMember3, true)
        SetEveryoneIgnorePlayer(gangMember4, true)
        gangYap(gangMember1, "WEAPON_ASSAULTRIFLE")
        gangYap(gangMember2, "WEAPON_ASSAULTRIFLE")
        gangYap(gangMember3, "WEAPON_ASSAULTRIFLE")
        gangYap(gangMember4, "WEAPON_ASSAULTRIFLE")
        TaskVehicleDriveToCoord(gangMember1,gangCar,PlayerCords.x,PlayerCords.y,PlayerCords.z,10.0,0,1026149675,8388614,1,true)
    end)
end)

function vagosattackNPC()
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'idgir', {
        title = _U("enter_id_or_name")
    }, function(data, menu)
        local id = tonumber(data.value)

        if id == GetPlayerServerId(PlayerId()) then return exports['mythic_notify']:SendAlert("inform", _U("driveby_self"), 6500) end

        if id == nil or id < 0 then -- numara girip girmediğini anlamak için if id then kullanabilirsin
            exports['mythic_notify']:SendAlert('inform', _U("invalid_number"))
        else
            menu.close()
            ESX.TriggerServerCallback("ld-gangs:server:getItemAmount", function(qty)
                if qty >= Config.VagosParaMiktari then
                    TriggerServerEvent('ld-gangs:server:vagosattackNPC', id, 'vagos')
                else
                    exports['mythic_notify']:SendAlert("inform", _U("not_enough_money"..Config.VagosParaMiktari..""), 7500)
                end
            end, "cash")
        end
    end, function(data, menu)
        menu.close()
    end)
end

function vagosmenuopen()
    local elements = {
		{label = 'NPC Gönder',  value = 'npcsaldir'},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'npcmenu', {
        title    = _U("select_action"),
        align    = 'top-left',
		elements = elements	
	}, function(data, menu)
		menu.close()
		if data.current.value == 'npcsaldir' then
			menu.close()
			soruvagos()
		end
    end)
end		

local sinirvagos = 0

function soruvagos()

    ESX.UI.Menu.Open('dialog',GetCurrentResourceName(),'Menu',{title=_U("ask_password_title")},
      function(a,b)
        b.close()
        local player = PlayerPedId()
        
        if sinirvagos > 1 then
           exports['mythic_notify']:SendAlert("inform", _U("angry_npc"), 8500)
           ClearPedTasksImmediately(vagosnpc)
           TaskStartScenarioInPlace(vagosnpc, "WORLD_HUMAN_STAND_MOBILE", 0, true);
           vagosinirlendi = true
           Wait(15000)
           ClearPedTasksImmediately(vagosnpc)
           vagosinirlendi = false
           sinirvagos = 0
           TaskStartScenarioInPlace(vagosnpc, "WORLD_HUMAN_SMOKING", 0, true);
           TriggerEvent("ld-gangs:client:vagosattackNPC")
        end

        for k,v in pairs(Config.CursedWordList) do
            if a.value == v then 
                if Config.VagosSinirlenme then
                    if sinirvagos < 2 then
                        exports['mythic_notify']:SendAlert('inform', _U("angry_npc_warning"), 3500)
                        sinirvagos = sinirvagos + 1
                        return
                    end
                    return
                else
                exports['mythic_notify']:SendAlert('inform', _U("angry_npc_warning"), 3500)
                return
                end
            end
        end

        if a.value == Config.VagosSifre then
            exports['mythic_notify']:SendAlert("inform", _U("right_password"), 3500)
            vagosattackNPC()
          Citizen.Wait(500)
        else
            exports['mythic_notify']:SendAlert("inform", _U("wrong_password"), 3500)
          end 
        end,
      function(a,b)b.close()
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60 * 1000 * 1)

        if gangsrc ~= nil then
            for k,v in pairs(gangsrc) do
                TriggerServerEvent("ld-gangs:server:updatestate",k,v)
            end
        end
    end
end)

RegisterNetEvent("ld-gangs:clientupdatestate")
AddEventHandler("ld-gangs:clientupdatestate",function(state)
    for i,j in pairs(state) do
        if j <= 0 then
            gangsrc[i] = nil
            return
        else
            gangsrc[i] = j
            return
        end
    end
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        DeleteEntity(gangMember1)
        DeleteEntity(gangMember2)
        DeleteEntity(gangMember3)
        DeleteEntity(gangMember4)
        DeleteEntity(gangCar)
        ESX.UI.Menu.CloseAll()
    end
end)