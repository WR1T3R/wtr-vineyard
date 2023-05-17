fx_version "cerulean"

game "gta5"

author "W r i t e r#5891"
description "Vineyard script for QBCore"
lua54 "yes"

client_scripts {
	"client.lua"
}
server_scripts {
	"server.lua",
}

shared_scripts {
	"shared.lua",
	"@ox_lib/init.lua",
	"@qb-core/shared/locale.lua",
	"locales/en.lua"
  --"locales/fr.lua"
}