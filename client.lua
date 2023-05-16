local QBCore = exports["qb-core"]:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local Act = {Started = false, Current = nil, AmountNeeded = 0, Progression = 0, Vehicle = nil, Blips = false, Particles = false, Finished = false}
local Loaded = {Props = {}, Blips = {}, Particles = {}}
local Sell = {Basket = {}, Vehicle = nil, ActStarted = false, CurrentPos = nil, SellBlip = nil, SellBlipPoints = nil}
function LoadStart()
	local coords = Shared.Ped.Coords
	local model = type(Shared.Ped.Model) == "string" and joaat(Shared.Ped.Model) or Shared.Ped.Model
	lib.requestModel(model)
	starter = CreatePed(0, model, coords, coords.w, false, true)
	FreezeEntityPosition(starter, true)
	SetEntityInvincible(starter, true)
	SetBlockingOfNonTemporaryEvents(starter, true)
	local blips = AddBlipForCoord(coords)
	SetBlipSprite(blips, Shared.Blips.Starter.Sprite)
	SetBlipDisplay(blips, 4)
	SetBlipScale(blips, 0.6)
	SetBlipAsShortRange(blips, true)
	SetBlipColour(blips, Shared.Blips.Starter.Colour)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName(Shared.Blips.Starter.Name)
	EndTextCommandSetBlipName(blips)
	if Shared.Ped.Model == "csb_ary_02" then
		SetPedComponentVariation(starter, 3, 3, 0, 0)
		SetPedComponentVariation(starter, 8, 3, 0, 0)
		SetPedComponentVariation(starter, 4, 2, 0, 0)
		SetPedComponentVariation(starter, 6, 1, 0, 0)
		GiveWeaponToPed(starter, "weapon_minigun", 999, false, false)
		SetCurrentPedWeapon(starter, "weapon_minigun", true)
		SetPedCanBeTargetted(starter, false)
	end
	exports["qb-target"]:AddTargetEntity(starter, {
		options = {
			{
				action = function()
					GetAct()
				end,
				icon = "fas fa-circle-check",
				label = Lang:t("targets.activity"),
				canInteract = function()
					if Sell.ActStarted then return false else return true end
				end
			},
			{
				action = function()
					Selling()
				end,
				icon = "fas fa-car",
				label = Lang:t("targets.sell"),
				canInteract = function()
					if Shared.Module.Selling then
						if Sell.ActStarted then
							return false
						else
							return true
						end
					end
				end,
			}
		},
		distance = 5.0,
  	})
	for _, v in pairs(Shared.Transformation.Places) do
		exports['qb-target']:AddBoxZone("Transfo".._, v.Coords, v.Length, v.Width, {
			name = "Transfo".._,
			heading = v.Coords[4],
			debugPoly = false,
			minZ = v.minZ,
			maxZ = v.maxZ,
			}, {
			options = {
			{
				action = function()
					local cfg = Shared.Transformation.Transformation
					local transformation = {id = "transformation", title = Lang:t("transformation.header"), options = {}}
					for i = 1, #cfg do
						transformation.options[#transformation.options + 1] = {
							title = QBCore.Shared.Items[cfg[i].ItemReceived].label,
							description = string.format("%s %dx %s", Lang:t("transformation.cost"), cfg[i].Cost.Amount, string.lower(QBCore.Shared.Items[cfg[i].Cost.Item].label)),
							icon = string.format("nui://%s/html/images/%s.png", Shared.Inventory.Export, cfg[i].ItemReceived),
							onSelect = function()
								local input = lib.inputDialog(QBCore.Shared.Items[cfg[i].ItemReceived].label, {
									{type = "slider", label = Lang:t("info.amountchoose"), icon = "fas-fa-circle-check", required = true, min = 1, max = Shared.Transformation.MaxInput}
								})
								if not input then return lib.showContext("transformation") end
								QBCore.Functions.TriggerCallback("vineyard:server:getItemCount", function(check)
									QBCore.Functions.TriggerCallback("vineyard:server:getItemWeight", function(result)
										if QBCore.Functions.HasItem(cfg[i].Cost.Item, (cfg[i].Cost.Amount * input[1])) then
											if result then
												if lib.progressCircle({
													label = Lang:t("transformation.progressbar"),
													duration = 5000,
													position = 'bottom',
													useWhileDead = false,
													canCancel = true,
													disable = {
														move = true,
													},
													anim = {
														dict = Shared.Transformation.Animation.Dict,
														clip = Shared.Transformation.Animation.Clip
													},
												}) then 
													TriggerServerEvent("vineyard:server:setupItems", "remove", cfg[i].Cost.Item, (cfg[i].Cost.Amount * input[1]))
													TriggerServerEvent("vineyard:server:setupItems", "add", cfg[i].ItemReceived, input[1])
												end
											end
										else
											QBCore.Functions.Notify(string.format("%s (%dx %s)", Lang:t("error.notenoughitems"), tonumber((cfg[i].Cost.Amount * input[1]) - check), string.lower(QBCore.Shared.Items[cfg[i].Cost.Item].label)), "error")
										end
									end, cfg[i].ItemReceived, input[1])
								end, cfg[i].Cost.Item)
							end
						}
					end
					lib.registerContext(transformation)
					lib.showContext("transformation")
				end,
				icon = "fas fa-wine-glass",
				label = Lang:t("targets.transformation"),
				canInteract = function()
					return Shared.Module.Transformation
				end
			},
		},
		distance = 2.5
		})
	end
end

function GetAct()
	if Act.Started then l = Lang:t("activity.headerstarted") else l = Lang:t("activity.header") end
	local actm = {id = "actm", title = l, options = {}}
	if not Act.Started then
		if Shared.Module.XP then 
			if Shared.Module.Rebirth and PlayerData.metadata["vineyardrebirth"] >= 1 then
				actm.options[#actm.options + 1] = {title = Lang:t("xp.currentxprebirth", {currentxpmore = PlayerData.metadata["vineyardxp"], currentrebirth = PlayerData.metadata["vineyardrebirth"]}), icon = "fas fa-circle-check"}
			else
				actm.options[#actm.options + 1] = {title = Lang:t("xp.currentxp", {currentxpmore = PlayerData.metadata["vineyardxp"]}), icon = "fas fa-circle-check"}
			end 
		end
		for i = 1, #Shared.Activity do
			local cfg = Shared.Activity
			actm.options[#actm.options + 1] = {
				title = cfg[i].Label, 
				icon = "fas fa-"..i,
				onSelect = function()
					local input = lib.inputDialog(Lang:t("info.header"), {
						{type = 'checkbox', label = Lang:t("info.blipsinfo")},
						{type = 'checkbox', label = Lang:t("info.lightninginfo")},
						{type = "slider", label = Lang:t("info.amountbasket"), icon = "fas-fa-circle-check", required = true, min = 1, max = #Shared.VineZone[i]}
					})
					if not input then return lib.showContext("actm") end
					TriggerEvent("vineyard:client:startAct", i, input[1], input[2], input[3])
				end,
			}
		end
		if Shared.Module.XP and Shared.Module.Rebirth then
			if PlayerData.metadata["vineyardxp"] >= Shared.XP.XPForRebirth then
				actm.options[#actm.options + 1] = {
					title = Lang:t("info.rebirth"), 
					icon = "fas fa-circle-check", 
					onSelect = function()  
						QBCore.Functions.Notify(Lang:t("info.rebirthinfo"), "success")
						TriggerServerEvent("InteractSound_SV:PlayOnSource", "valorantace", 0.1)
						TriggerServerEvent("vineyard:server:updateXP", true, 0)
					end
				}
			end
		end
	else
		if Act.Blips then tbl = "🟢" else tbl = "🔴" end if Act.Particles then tbp = "🟢" else tbp = "🔴" end
		local label = string.format("%s [%d/%d]\n%s [%s]\n%s [%s]", Lang:t("info.basketharvested"), Act.Progression, Act.AmountNeeded, Lang:t("info.blipsinfo"), tbl, Lang:t("info.lightninginfo"), tbp)
		local actstarted = {id = "actstarted", title = Lang:t("activity.headerstarted"), options = {}}
		actm.options[#actm.options + 1] = {title = label, icon = "fas fa-hands"}
		if not Act.Finished then
			actm.options[#actm.options + 1] = {
				title = Lang:t("activity.cancelactivity"), 
				icon = "fas fa-circle-check", 
				onSelect = function() 
					QBCore.Functions.Notify(Lang:t("activity.canceledactivity"), "primary")
					UnloadComponents()
				end
			}
		else
			actm.options[#actm.options + 1] = {
				title = Lang:t("activity.finishactivity"), 
				icon = "fas fa-hands",
				onSelect = function()
					QBCore.Functions.Notify(Lang:t("activity.finishedactivity"), "primary")
					UnloadComponents()
				end,
			}
		end
	end
	lib.registerContext(actm)
	lib.showContext("actm")
end

RegisterNetEvent("vineyard:client:startAct", function(act, b, part, nb)
  	if not IsAnyVehicleNearPoint(Shared.Vehicle.Coords, 5.0) then
		Act.Started = true
		Act.Current = Shared.Activity[act]
		lib.showTextUI(string.format("%s %d/%d", Lang:t("activity.progressiondrawtext"), Act.Progression, nb), {position = "left-center"})
		for i = 1, nb do
			local cfg = Shared.VineZone[act]
			local model = type(Shared.VineProps) == 'string' and joaat(Shared.VineProps) or Shared.VineProps
			if b then
				blips = AddBlipForCoord(cfg[i].x, cfg[i].y, cfg[i].z)
				SetBlipSprite (blips, Shared.Blips.Activity.Sprite)
				SetBlipDisplay(blips, 4)
				SetBlipScale  (blips, 0.6)
				SetBlipAsShortRange(blips, true)
				SetBlipColour(blips, Shared.Blips.Activity.Colour)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentSubstringPlayerName(Shared.Blips.Activity.Name)
				EndTextCommandSetBlipName(blips)
				Loaded.Blips[i] = blips
				Act.Blips = true
			end
			if part then
				lib.requestNamedPtfxAsset("core")
				UseParticleFxAssetNextCall("core") 
				particles = StartParticleFxLoopedAtCoord("fire_wrecked_plane_cockpit", cfg[i].x, cfg[i].y, cfg[i].z, 0.0, 0.0, 0.0, 0.0, 0.01, false, false, false, false)
				Loaded.Particles[i] = particles
				Act.Particles = true
			end
			lib.requestModel(model)
			local props = CreateObject(model, cfg[i].x, cfg[i].y, cfg[i].z - 1, false, false, false)
			while not DoesEntityExist(props) do Wait(10) end
			PlaceObjectOnGroundProperly(props)
			SetEntityAsMissionEntity(props, true, true)
			FreezeEntityPosition(props, true)
			Loaded.Props[i] = props
			exports['qb-target']:AddTargetEntity(props, {
				options = {
					{
						action = function()
							local reward = Shared.Activity[act].Rewards[math.random(1, #Shared.Activity[act].Rewards)]
							local amount = math.random(reward.Amount.min, reward.Amount.max)
							QBCore.Functions.TriggerCallback("vineyard:server:getItemWeight", function(result)
								if result then
									Act.Progression = Act.Progression + 1
									RemoveBlip(Loaded.Blips[i])
									StopParticleFxLooped(Loaded.Particles[i], 0)
									DeleteObject(props)
									lib.showTextUI(string.format("%s %d/%d", Lang:t("activity.progressiondrawtext"), Act.Progression, Act.AmountNeeded), {position = "left-center"})
									if Act.Progression == Act.AmountNeeded then
										Act.Finished = true
										lib.showTextUI(Lang:t("activity.activityfinisheddrawtext"), {position = "left-center"})
										QBCore.Functions.Notify(Lang:t("activity.finishharvest"), "primary")
									end
									if Shared.Module.XP then
										TriggerServerEvent("vineyard:server:updateXP", false, Shared.XP.XPPerHarvest)
									end
									TriggerServerEvent("vineyard:server:setupItems", "add", reward.Item, amount)
								end
							end, reward.Item, amount)
						end,
						icon = "fas fa-hands",
						label = Lang:t("targets.harvest"),
					},
				},
				distance = 3.0
			})
			Act.AmountNeeded = nb
		end
		QBCore.Functions.SpawnVehicle(Shared.Vehicle.Model, function(veh)
			SetVehicleNumberPlateText(veh, "VINE"..tostring(math.random(1000, 9999)))
			SetVehicleDirtLevel(veh, 0)
			exports[Shared.FuelExport]:SetFuel(veh, 100.0)
			TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
			SetVehicleEngineOn(veh, true, true)
			Act.Vehicle = veh
		end, Shared.Vehicle.Coords, true)
	else 
		QBCore.Functions.Notify(Lang:t("error.vehicleinarea"), 'error')
	end
end)

function Selling()
	local selling = {id = "selling", title = Lang:t("sell.header"), options = {}}
	local count = 0
	for i = 1, #Shared.Selling.ItemsAvailable do
		local cfg = Shared.Selling.ItemsAvailable
		if QBCore.Functions.HasItem(cfg[i].Item, 1) then
			count = count + 1
			selling.options[#selling.options + 1] = {
				title = QBCore.Shared.Items[cfg[i].Item].label,
				icon = string.format("nui://%s/html/images/%s.png", Shared.Inventory.Export, cfg[i].Item),
				onSelect = function()
					QBCore.Functions.TriggerCallback("vineyard:server:getItemCount", function(result)
						local input = lib.inputDialog(Lang:t("sell.addtobasket"), {
							{type = "slider", label = Lang:t("info.amountchoose"), icon = "fas-fa-circle-check", required = true, min = 1, max = result}
						})
						if not input then Wait(100) lib.showContext("selling") end
						if input and input[1] then
							cfg[i].inBasket = true
							TriggerServerEvent("vineyard:server:setupItems", "remove", cfg[i].Item, input[1])
							if not Sell.Basket[cfg[i]] then Sell.Basket[cfg[i]] = input[1] else Sell.Basket[cfg[i]] = Sell.Basket[cfg[i]] + input[1] end
							Wait(100)
							Selling()
						end
					end, cfg[i].Item)
				end
			}
		end
	end
	if count == 0 then selling.options[#selling.options + 1] = {title = Lang:t("sell.noitemtoaddtobasket"), icon = "fas fa-circle-xmark"} end
	selling.options[#selling.options + 1] = {
		title = Lang:t("sell.basketheader"),
		icon = "fas fa-shopping-cart",
		onSelect = function()
			local a = 0
			local basketmenu = {id = "basketmenu", title = Lang:t("sell.basketheader"), options = {}}
			for _, v in pairs(Sell.Basket) do 
				a = a + 1
				if _.inBasket then
					basketmenu.options[#basketmenu.options + 1] = {
						title = string.format("%dx %s", v, QBCore.Shared.Items[_.Item].label),
						icon = string.format("nui://%s/html/images/%s.png", Shared.Inventory.Export, _.Item),
						onSelect = function()
							local inputid = lib.inputDialog(Lang:t("sell.removetobasket"), {
								{type = "slider", label = Lang:t("info.amountchoose"), icon = "fas-fa-circle-check", required = true, min = 1, max = v}
							})
							if inputid and inputid[1] then
								if inputid[1] == v then  
									_.inBasket = false Sell.Basket[_] = nil TriggerServerEvent("vineyard:server:setupItems", "add", _.Item, v)	
								elseo
									Sell.Basket[_] = Sell.Basket[_] - inputid[1] TriggerServerEvent("vineyard:server:setupItems", "add", _.Item, inputid[1]) 
								end
								Wait(100)
								Selling() 
							else
								lib.showContext("basketmenu")
							end
						end
					}
				end
			end
			if a == 0 then 
				basketmenu.options[#basketmenu.options + 1] = {title = Lang:t("sell.nothinginbasket"), icon = "fas fa-circle-xmark"} 
			else
				basketmenu.options[#basketmenu.options + 1] = {title = Lang:t("sell.beginselling"), icon = "fas fa-car", onSelect = function() StartSelling() end} 
			end
			basketmenu.options[#basketmenu.options + 1] = {
				title = Lang:t("info.returninfo"),
				icon = "fas fa-rotate-left",
				onSelect = function()
					lib.showContext("selling")
				end
			}
			lib.registerContext(basketmenu)
			lib.showContext("basketmenu")
		end
	}
	lib.registerContext(selling)
	lib.showContext("selling")
end

function StartSelling()
	local sellPos = Shared.Selling.ResellEmplacement
	local sellB, sellBR = AddBlipForCoord(sellPos.Coords.x, sellPos.Coords.y, sellPos.Coords.z), AddBlipForCoord(sellPos.Coords.x, sellPos.Coords.y, sellPos.Coords.z)
	local sphere1 = lib.zones.sphere({
		coords = vec3(Shared.Selling.Vehicle.Coords.x, Shared.Selling.Vehicle.Coords.y, Shared.Selling.Vehicle.Coords.z),
		radius = 2,
		debug = false,
		inside = onInsideZone,
		onExit = onExitZone
	})
	local sphere2 = lib.zones.sphere({
		coords = vec3(sellPos.Coords.x, sellPos.Coords.y, sellPos.Coords.z),
		radius = 3,
		debug = false,
		onEnter = onEnterSellPoints
	})
	for _, v in pairs(Sell.Basket) do
		TriggerServerEvent("vineyard:server:setupItems", "add", "vy-sellingbox", 1, {itemname = _.Item, capacity = tonumber(v), value = tonumber(v * _.PriceToSell)})
	end
	Sell.Basket = {}
	SetBlipSprite(sellB, Shared.Selling.Blips.Sprite)
	SetBlipDisplay(sellB, 4)
	SetBlipScale(sellB, 0.7)
	SetBlipColour(sellB, Shared.Selling.Blips.Colour)
	SetBlipAsShortRange(sellB, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Shared.Selling.Blips.Name)
	EndTextCommandSetBlipName(delb)
	SetBlipRoute(sellBR, true)
	SetBlipRouteColour(sellBR, Shared.Selling.Blips.Colour)
	SetBlipAlpha(sellBR, 0)
	Sell.SellBlip = sellB
	Sell.SellBlipPoints = sellBR
	QBCore.Functions.SpawnVehicle(Shared.Selling.Vehicle.Model, function(veh)
		SetVehicleNumberPlateText(veh, "VINE"..tostring(math.random(1000, 9999)))
		SetVehicleDirtLevel(veh, 0)
		exports[Shared.FuelExport]:SetFuel(veh, 100.0)
		TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
		SetVehicleEngineOn(veh, true, true)
		TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
		Sell.Vehicle = veh
		Sell.ActStarted = true
	end, Shared.Selling.Vehicle.Coords, true)
	exports['qb-target']:AddBoxZone("ResellObject", sellPos.Coords, sellPos.Length, sellPos.Width, {
		name = "ResellObject",
		heading = sellPos.Coords[4],
		debugPoly = false,
		minZ = sellPos.minZ,
		maxZ = sellPos.maxZ,
	}, {
		options = {
			{
				action = function()
					EnterSellingZone()
				end,
				icon = "fas fa-circle-check",
				label = Lang:t("targets.entersellingzone"),
				canInteract = function()
					if Shared.Module.Selling and Sell.ActStarted and not IsPedInAnyVehicle(PlayerPedId()) then return true end
				end
			},
		},
		distance = 4.5
	})
end

function EnterSellingZone()
	local m = type(Shared.Selling.PedModel) == "string" and joaat(Shared.Selling.PedModel) or Shared.Selling.PedModel
	local coordsP = GetEntityCoords(PlayerPedId())
	local headingP = GetEntityHeading(PlayerPedId())
	local ap = 0
	local camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1911.96, -568.92, 20.8, -30.0 , 0.0, 190.69, 60.0, false, 0)
	Sell.CurrentPos = vector4(coordsP[1], coordsP[2], coordsP[3], headingP)
	exports["qb-target"]:RemoveZone("ResellObject")
	DoScreenFadeOut(1300)
	Wait(1200)
	SetEntityCoords(PlayerPedId(), -1902.38, -572.73, 18.1, false, false, false, true)
	SetEntityHeading(PlayerPedId(), 140.87)
	lib.requestModel(m)
	local sellped = CreatePed(0, m, vector3(-1912.6, -571.67, 18.1), 222.38, false, true)
	lib.requestAnimDict("timetable@reunited@ig_10")
	TaskPlayAnim(sellped, "timetable@reunited@ig_10", "base_amanda", 8.0, 1.0, -1, 15, 0, 0, 0, 0)
	Wait(800)
	SetCamActive(camera, true)
	RenderScriptCams(true, false, 1, true, true)
	DoScreenFadeIn(3000)
	TaskGoStraightToCoord(PlayerPedId(), -1910.37, -572.81, 19.1, 1.0, 8000, 49.31, 0.0)
	Wait(5100)
	for i = 1, 150, 1 do
		Draw3DText(vector3(-1912.86, -571.03, 19.6), Lang:t("sell.interactiontoped").." "..PlayerData.charinfo.firstname.." "..PlayerData.charinfo.lastname)
	end
	for _, v in pairs(PlayerData.items) do
		if v.name == "vy-sellingbox" then
			TriggerServerEvent("vineyard:server:setupItems", "remove", "vy-sellingbox", 1, nil, v.slot)
			ap = ap + v.info.value
		end
		Wait(100)
	end
	lib.requestAnimDict("mp_safehouselost@")
	TaskPlayAnim(PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0)
	Wait(4000)
	TriggerServerEvent("vineyard:server:setupMoney", "add", Shared.Currency, tonumber(ap))
	TaskGoStraightToCoord(PlayerPedId(), -1902.06, -572.26, 19.1, 1.0, 8000, 316.49, 0.0)
	Wait(2900)
	DoScreenFadeOut(2000)
	Wait(2000)
	DeletePed(sellped)
	SetCamActive(camera, false)
	DestroyCam(camera, true)
	RenderScriptCams(false, false, 1, true, true)
	DoScreenFadeIn(1000)
	TaskWarpPedIntoVehicle(PlayerPedId(), Sell.Vehicle, -1)
	RemoveBlip(Sell.SellBlip)
end

function onInsideZone()
	if Sell.ActStarted then
		lib.showTextUI(Lang:t("sell.storevehicledrawtext"), {position = "left-center"})
		if IsControlPressed(0, Shared.Keys.StoreVehicle) then
			DeleteVehicle(Sell.Vehicle)
			Sell.ActStarted = false
			lib.hideTextUI()
		end
	end
end

function onEnterSellPoints()
	RemoveBlip(Sell.SellBlipPoints)
end

function onExitZone()
	lib.hideTextUI()
end

function UnloadComponents()
	if not Loaded.Blips then return end
	if not Loaded.Props then return end
	if not Loaded.Particles then return end
	for k, blips in pairs(Loaded.Blips) do RemoveBlip(blips) end
	for k, props in pairs(Loaded.Props) do DeleteObject(props) end
	for k, particles in pairs(Loaded.Particles) do StopParticleFxLooped(particles, 0) end
	if Act.Vehicle then DeleteVehicle(Act.Vehicle) end
	if Sell.Vehicle then DeleteVehicle(Sell.Vehicle) end
	lib.hideTextUI()
	Act.Progression = 0
	Act.AmountNeeded = 0
	Act.Started = false
	Act.Blips = false
	Act.Particles = false
	Act.Finished = false
end

function Draw3DText(coords, str)
    local onScreen, worldX, worldY = World3dToScreen2d(coords.x, coords.y, coords.z)
    local camCoords = GetGameplayCamCoord()
    local scale = 200 / (GetGameplayCamFov() * #(camCoords - coords))
    if onScreen then
        SetTextScale(1.0, 0.5 * scale)
        SetTextFont(4)
        SetTextColour(255, 255, 255, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextProportional(1)
        SetTextOutline()
        SetTextCentre(1)
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringPlayerName(str)
        EndTextCommandDisplayText(worldX, worldY)
    end
end

AddEventHandler('gameEventTriggered', function(name, args)
	local player = args[1]
	if not player then return end
	if not IsEntityDead(PlayerPedId()) then return end
	UnloadComponents()
	QBCore.Functions.Notify(Lang:t("error.deathevent"), "error")
 end)

RegisterNetEvent("QBCore:Player:SetPlayerData", function(newData)
  PlayerData = newData
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
	LoadStart()
end)

AddEventHandler("onResourceStop", function(resource)
	if not GetCurrentResourceName() == resource then return end
	UnloadComponents()
end)
AddEventHandler("onResourceStart", function(resource)
	if not GetCurrentResourceName() == resource then return end
	LoadStart()
end)