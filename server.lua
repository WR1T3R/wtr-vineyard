local QBCore = exports["qb-core"]:GetCoreObject()

RegisterNetEvent("vineyard:server:updateXP", function(rebirth, xp)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if not Player then return end
	if rebirth then
		Player.Functions.SetMetaData("vineyardxp", 0)
		Player.Functions.SetMetaData("vineyardrebirth", Player.PlayerData.metadata["vineyardrebirth"] + 1)
	else
		Player.Functions.SetMetaData("vineyardxp", Player.PlayerData.metadata["vineyardxp"] + xp)
	end
end)

RegisterNetEvent("vineyard:server:setupItems", function(func, item, amount, info, slot)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local i = tostring(item)
	local a = tonumber(amount)
	local Weight = QBCore.Player.GetTotalWeight(Player.PlayerData.items)
	if not Player then return end
	if func == "remove" then
		Player.Functions.RemoveItem(i, a, slot, info)
		TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[i], "remove", a)
	elseif func == "add" then
		if (Weight + (QBCore.Shared.Items[i]['weight'] * tonumber(a))) <= Shared.Inventory.MaxWeight then
			Player.Functions.AddItem(i, a, slot, info)
			TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[i], "add", a)
		else
			QBCore.Functions.Notify(src, Lang:t("error.inventorytofull"), "error")
		end
	end
end)

RegisterNetEvent("vineyard:server:setupMoney", function(func, currency, amount)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if not Player then return end
	if func == "remove" then
		Player.Functions.RemoveMoney(currency, amount)
	elseif func == "add" then
		Player.Functions.AddMoney(currency, amount)
	end
end)

QBCore.Functions.CreateCallback("vineyard:server:getItemWeight", function(source, cb, item, amount)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if not Player then return end
	if not item then return end
	local Weight = QBCore.Player.GetTotalWeight(Player.PlayerData.items)
	if (Weight + (QBCore.Shared.Items[item]['weight'] * tonumber(amount))) <= Shared.Inventory.MaxWeight then
		cb(true)
	else
		QBCore.Functions.Notify(src, Lang:t("error.inventorytofull"), "error")
		cb(false)
	end
end)

QBCore.Functions.CreateCallback("vineyard:server:getItemCount", function(source, cb, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local ItemToCheck = Player.Functions.GetItemByName(item)
	if not ItemToCheck then cb(0) else cb(ItemToCheck.amount) end
end)