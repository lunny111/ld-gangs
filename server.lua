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
local gangs = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("ld-gangs:server:parakesBallas")
AddEventHandler("ld-gangs:server:parakesBallas", function(source)
	local ply = ESX.GetPlayerFromId(source)
	
	ply.removeMoney(Config.BallasParaMiktari)
end)

RegisterServerEvent("ld-gangs:server:parakesGsf")
AddEventHandler("ld-gangs:server:parakesGsf", function(source)
	local ply = ESX.GetPlayerFromId(source)
	
	ply.removeMoney(Config.GsfParaMiktari)
end)

RegisterServerEvent("ld-gangs:server:parakesVagos")
AddEventHandler("ld-gangs:server:parakesVagos", function(source)
	local ply = ESX.GetPlayerFromId(source)
	
	ply.removeMoney(Config.VagosParaMiktari)
end)

RegisterServerEvent("ld-gangs:server:gsfattackNPC")
AddEventHandler("ld-gangs:server:gsfattackNPC", function(id,gang)
	local found = ESX.GetPlayerFromId(tonumber(id))
	
	if found then 
		gangs[gang] = Config.UpdateTime
		TriggerClientEvent("ld-gangs:client:gsfattackNPC", id)
		TriggerEvent("ld-gangs:server:parakesGsf", source)
		TriggerClientEvent("ld-gangs:clientupdatestate",-1,gangs)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U("sent_members"), length = 10500 })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U("player_not_online"), length = 4300 })
    end
end)

RegisterServerEvent("ld-gangs:server:ballasattackNPC")
AddEventHandler("ld-gangs:server:ballasattackNPC", function(id,gang)
	local found = ESX.GetPlayerFromId(tonumber(id))
	
	if found then 
		gangs[gang] = Config.UpdateTime
		TriggerClientEvent("ld-gangs:client:ballasattackNPC", id)
		TriggerEvent("ld-gangs:server:parakesBallas", source)
		TriggerClientEvent("ld-gangs:clientupdatestate",-1,gangs)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U("sent_members"), length = 10500 })
    else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U("player_not_online"), length = 4300 })
    end
end)

RegisterServerEvent("ld-gangs:server:vagosattackNPC")
AddEventHandler("ld-gangs:server:vagosattackNPC", function(id,gang)
	local found = ESX.GetPlayerFromId(tonumber(id))
	
    if found then 
		TriggerClientEvent("ld-gangs:client:vagosattackNPC", id)
		TriggerEvent("ld-gangs:server:parakesVagos", source)
		gangs[gang] = Config.UpdateTime
		TriggerClientEvent("ld-gangs:clientupdatestate",-1,gangs)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U("sent_members"), length = 10500 })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U("player_not_online"), length = 4300 })
    end
end)

ESX.RegisterServerCallback('ld-gangs:server:getTime',function(source,cb)
	if gangs ~= nil then
		cb(gangs)
	end
end)

RegisterServerEvent("ld-gangs:server:updatestate")
AddEventHandler("ld-gangs:server:updatestate",function(gang,state)
	gangs[gang] = state - 1
	TriggerClientEvent("ld-gangs:clientupdatestate",-1,gangs)
end)

RegisterServerEvent("ld-gangs:server:updateTime")
AddEventHandler("ld-gangs:server:updateTime",function(gang,state)
	gangs[gang] = state
	TriggerClientEvent("ld-gangs:clientupdatestate",-1,gangs)
end)

ESX.RegisterServerCallback('ld-gangs:server:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count
	
	cb(quantity)
end)

ESX.RegisterServerCallback('ld-gangs:server:getName', function(target, data)
    local Identifier = ESX.GetPlayerFromId(target).identifier

    MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

        data(result[1].firstname, result[1].lastname)
    end)
end)
