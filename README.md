## Dependencies
1. qb-core
2. qb-inventory
3. ox_lib
4. ox_target
5. Pre-configured on dolu's vineyard mapping

## Inventory

1. Go to your qb-inventory/html/images and the images from images folder

2. Go to your qb-inventory/shared/items.lua and add this:

```lua
["vy-sellingbox"]                    = {["name"] = "vy-sellingbox",                      ["label"] = "Box of goods",                ["weight"] = 1000,   ["type"] = "item",   ["image"] = "vy-sellingbox.png",              ["unique"] = true,  ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""},

["vy-redgrapes"]                     = {["name"] = "vy-redgrapes",                       ["label"] = "Red grapes",                  ["weight"] = 200,    ["type"] = "item",   ["image"] = "vy-redgrapes.png",               ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""},

["vy-greengrapes"]                   = {["name"] = "vy-greengrapes",                     ["label"] = "Green grapes",                ["weight"] = 200,    ["type"] = "item",   ["image"] = "vy-greengrapes.png",             ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""},

["vy-grapejuice"]                    = {["name"] = "vy-grapejuice",                      ["label"] = "Grape juice",                 ["weight"] = 200,    ["type"] = "item",   ["image"] = "vy-grapejuice.png",              ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = ""},
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
	$(".item-info-description").html("<p>Item: " + itemData.info.itemname + "</p><p>Capacity: " + itemData.info.capacity + "</p><p>Value: " + itemData.info.value + "$</p");
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