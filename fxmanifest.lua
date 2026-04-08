fx_version 'cerulean'
game 'gta5'

version '1.0.0'

ui_page 'html/ui.html'

client_scripts {
	'config.lua',
	'client.lua',
}

server_scripts {
	'config.lua',
	'server.lua',
}

files {
	'html/ui.html',
	'html/*.css',
	'html/*.js',
	'html/img/*.png',
	'html/img/*.jpg',
}

lua54 'yes'
