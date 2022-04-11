fx_version 'cerulean'
game 'gta5'

description 'QB-Realestate job'
version '1.0.0'

shared_scripts {
	'config.lua',
    '@qb-core/shared/locale.lua',
	'locales/en.lua'
}

client_scripts {
	'client/main.lua',
	'client/menu.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua',
	'server/menu.lua',
}


lua54 'yes'