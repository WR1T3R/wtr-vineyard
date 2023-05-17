local Translations = {
	info = {
		header = "Informations",
		blipsinfo = "Blips",
		lightinginfo = "Lighting",
		amountbasket = "Desired baskets",
		amountchoose = "Desired amount",
		basketharvested = "Baskets harvested",
		returninfo = "Return",
		rebirth = "Rebirth",
		rebirthinfo = "You have rebirth",
		amount = "Amount:"
	},
	xp = {
		currentxp = "XP: %{currentxpmore}",
		currentxprebirth = "XP: %{currentxpmore} | Rebirth: %{currentrebirth}"
	},
	targets = {
		activity = "Activity",
		harvest = "Harvest",
		transformation = "Transformation",
		sell = "Selling",
		entersellingzone = "Enter"
	},
	activity = {
		header = "Activity",
		headerstarted = "Current activity..",
		finishharvest = "You have finished harvesting",
		cancelactivity = "Cancel current activity",
		canceledactivity = "You have canceled the activity",
		finishactivity = "Finish the activity",
		finishedactivity = "You have finished the activity",
		progressiondrawtext = "Progression:",
		activityfinisheddrawtext = "Activity finished"
	},
	transformation = {
		header = "Transformation",
		cost = "Requirements:",
		progressbar = "Transformation in progress.."
	},
	sell = {
		header = "Resell",
		addtobasket = "Add to basket",
		removetobasket = "Remove from basket",
		itemsheader = "Items",
		basketheader = "Basket",
		nothinginbasket = "You have nothing in your basket",
		noitemtoaddtobasket = "You have nothing to add in your basket",
		beginselling = "Begin selling",
		storevehicledrawtext = "[E] - Store vehicle"
	},
	error = {
		vehicleinarea = "There's a vehicle in area",
		inventorytofull = "Your inventory is full..",
		notenoughitems = "You are missing an item..",
		deathevent = "Activity cancelled due to your death"
	}
}

Lang = Locale:new({
  phrases = Translations,
  warnOnMissing = true
})