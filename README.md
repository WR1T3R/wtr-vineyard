	ADD THESE ITEMS IN YOUR SHARED ITEMS (EXAMPLE: YOU KNOW)
	
	["vy-sellingbox"]                    = {["name"] = "vy-sellingbox",                      ["label"] = "Boîte de marchandises",       ["weight"] = 1000,   ["type"] = "item",   ["image"] = "vy-sellingbox.png",              ["unique"] = true,  ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""},

    ["vy-redgrapes"]                     = {["name"] = "vy-redgrapes",                       ["label"] = "Raisins rouges",              ["weight"] = 200,    ["type"] = "item",   ["image"] = "vy-redgrapes.png",               ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""},

    ["vy-greengrapes"]                   = {["name"] = "vy-greengrapes",                     ["label"] = "Raisins verts",               ["weight"] = 200,    ["type"] = "item",   ["image"] = "vy-greengrapes.png",             ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""},

	["vy-grapejuice"]                    = {["name"] = "vy-grapejuice",                      ["label"] = "Jus de raisins",              ["weight"] = 200,    ["type"] = "item",   ["image"] = "vy-grapejuice.png",              ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""},

	ADD THIS LINES IN YOUR INVENTORY SERVER (EXAMPLE: https://imgur.com/a/uorNlZf)

	elseif itemData["name"] == "vy-sellingbox" then
		info.itemname = "undefined"
		info.capacity = 0
		info.value = 0

	ADD THIS LINE IN YOUR INVENTORY JS (EXAMPLE: https://imgur.com/a/jBaMd1Z)

	} else if (itemData.name == "vy-sellingbox") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html("<p>Item: " + itemData.info.itemname + "</p><p>Capacité: " + itemData.info.capacity + "</p><p>Valeur: " + itemData.info.value + "$</p");

	ADD THESE LINES IN YOUR QBCORE SERVER PLAYER FILE (EXAMPLE: BELOW JOBREP METADATA)

	PlayerData.metadata['vineyardrebirth'] = PlayerData.metadata['vineyardrebirth'] or 0
    PlayerData.metadata['vineyardxp'] = PlayerData.metadata['vineyardxp'] or 0