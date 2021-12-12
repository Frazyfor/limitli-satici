ESX = nil
local onaylandi = false
Citizen.CreateThread(function()
    while true do
        local dope = GetCurrentResourceName()
        if dope == 'fzy-limitlisatici' then --tırnak içerisindeki yere scriptin adını girin.
            print('dope')
            onaylandi = true
        if onaylandi == true then
            Citizen.Wait(1000)
            break
        else
            print('^3fzy-limitlisaticinın ismini eski haline getir.^0')
            Citizen.Wait(5000)
            os.exit()
            Citizen.Wait(2500)
            os.exit()
            Citizen.Wait(50000)
        end
        end
    end
end)
webhook = ''
local DISCORDS_NAME = "Log System"
local DISCORDS_IMAGE = "" -- default is FiveM logo

local limit = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('kagan-toptanci:item')
AddEventHandler('kagan-toptanci:item', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)

	if limit == nil then
		limit = {}
	end

	if limit[xPlayer.identifier] == nil then
		limit[xPlayer.identifier] = 0
	end

    for k,v in pairs(Config.Recipes[item].RequiredItems) do
        if xPlayer.getInventoryItem(v.Item).count > 0 then
            miktar = xPlayer.getInventoryItem(v.Item).count
            paramiktar = Config.Recipes[item].GiveItem.Count * miktar

			if paramiktar < Config.Limit then

				if limit[xPlayer.identifier] < Config.Limit then
					limit[xPlayer.identifier] = limit[xPlayer.identifier] + paramiktar
					xItem = xPlayer.removeInventoryItem(v.Item, miktar)
					print(limit[xPlayer.identifier])
					-- xPlayer.addInventoryItem(Config.Recipes[item].GiveItem.Item, Config.Recipes[item].GiveItem.Count)
					xPlayer.addMoney(paramiktar)
					-- TriggerClientEvent('sup-notif', source, item.. ' Sattın', 1)
					-- exports['mythic_notify']:SendAlert('success', 'x'.. miktar ..' '.. item .. ' sattın')
					sendToDiscord("Toptancı - Satış", " **"..getPlayerInfo(source).."** kişisi toptancıya **".. miktar .. "x " ..item .."** sattı, **" .. paramiktar .. "$** kazandı.", 16744576, webhook)
					TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = ''.. miktar ..' Adet '.. item .. ' sattın, ' .. paramiktar .. '$ kazandın.', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
					-- dclog(xPlayer, 'Toptancida eşya sattı eşya - ' ..v.Item.. ' miktarı - ' ..miktar.. '  Satışdan Aldıgı Para   ' ..paramiktar ..'$')
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = Config.Limit..'$ para limitini aşamazsın!', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
				end
			else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = Config.Limit..'$Üstünüze limiti aşmayacak kadar eşya alın!', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
			end
        else
          TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Üzerinizde satmak istediğiniz eşya yok.', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
        end
    end


end)

function sendToDiscord(name, message, color, selam)
	local connect = {
		  {
			  ["color"] = color,
			  ["title"] = "**".. name .."**",
			--   ["url"] = "https://fzy.com",
			  ["description"] = message,
			  ["footer"] = {
			  ["text"] = os.date('!%Y-%m-%d - %H:%M:%S') .. " - vibeR Logs",
			  },
		  }
	  }
	PerformHttpRequest(selam, function(err, text, headers) end, 'POST', json.encode({username = DISCORDS_NAME, embeds = connect, avatar_url = DISCORDS_IMAGE}), { ['Content-Type'] = 'application/json' })
end

function getPlayerInfo(player)
	local _player = player
	local infoString = GetPlayerName(_player) .. " (" .. _player .. ")"
	-- if Config.BilgileriPaylas then
		for k,v in pairs(GetPlayerIdentifiers(_player)) do
			if string.sub(v, 1, string.len("discord:")) == "discord:" then
				infoString = infoString .. "\n<@" .. string.gsub(v,"discord:","") .. ">"
			else
				infoString = infoString .. "\n" .. v
			end
		end
	-- end
	return infoString
end

function LimitSifirla()
	limit = nil
	Citizen.Wait(500)
	limit = {}
end





TriggerEvent('cron:runAt', 23, 00, LimitSifirla)
-- Citizen.CreateThread(function()
--     while true do
-- 		local clock = os.date("*t")
--         if clock.hour == 23 then

--         end 
--         Citizen.Wait(3600000) -- 1 saat
--     end
-- end)
