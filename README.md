## Inventory

1. Go to your qb-inventory/html/images and the images from images folder

2. Go to your qb-inventory/shared/items.lua and add this:

```lua
	["vy-sellingbox"]                    = {["name"] = "vy-sellingbox",                      ["label"] = "Boîte de marchandises",       ["weight"] = 1000,   ["type"] = "item",   ["image"] = "vy-sellingbox.png",              ["unique"] = true,  ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""},

	["vy-redgrapes"]                     = {["name"] = "vy-redgrapes",                       ["label"] = "Raisins rouges",              ["weight"] = 200,    ["type"] = "item",   ["image"] = "vy-redgrapes.png",               ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""},

	["vy-greengrapes"]                   = {["name"] = "vy-greengrapes",                     ["label"] = "Raisins verts",               ["weight"] = 200,    ["type"] = "item",   ["image"] = "vy-greengrapes.png",             ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""},

	["vy-grapejuice"]                    = {["name"] = "vy-grapejuice",                      ["label"] = "Jus de raisins",              ["weight"] = 200,    ["type"] = "item",   ["image"] = "vy-grapejuice.png",              ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""},
```

3. Go to your qb-inventory/server/main.lua and add this:

```lua
	elseif itemData["name"] == "vy-sellingbox" then
		info.itemname = "undefined"
		info.capacity = 0
		info.value = 0
```

Example:
https://imgur.com/a/uorNlZf

4. Go to your qb-inventory/html/js/app.js and add this:

```js
	} else if (itemData.name == "vy-sellingbox") {
		$(".item-info-title").html("<p>" + itemData.label + "</p>");
		$(".item-info-description").html("<p>Item: " + itemData.info.itemname + "</p><p>Capacité: " + itemData.info.capacity + "</p><p>Valeur: " + itemData.info.value + "$</p");
```

Example:
https://imgur.com/a/jBaMd1Z

## Metadata

1. Go to your qb-core/server/player.lua and add this:

```lua
	PlayerData.metadata['vineyardrebirth'] = PlayerData.metadata['vineyardrebirth'] or 0
	PlayerData.metadata['vineyardxp'] = PlayerData.metadata['vineyardxp'] or 0
```

Example:
https://imgur.com/a/oVZoAIN