shared_script '@user-data/ai_module_fg-obfuscated.lua'
fx_version('cerulean')
game('gta5')
lua54 'yes'

description = 'Radio Script, QB Framework, pma-voice and saltychat.'
author = 'aliko.'
version = '1.1.0'

client_scripts {
	'client/main.lua',
	'client/utils.lua',
	'client/functions.lua',
	'client/loops.lua',
	'client/events.lua'
}
server_script 'server/server.lua'

shared_script 'shared/**/*'

shared_script '@es_extended/imports.lua'

ui_page 'web/build/index.html'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua'
}

files {
	'locales/**/*',
	'web/build/index.html',
	'web/build/**/*',
}

dependency "pma-voice"

escrow_ignore {
	'client/main.lua',
	'client/utils.lua',
	'client/functions.lua',
	'client/loops.lua',
	'client/events.lua',
	'server/server.lua',
	'shared/config.lua',
	'shared/locales.lua',
	'locales/en.lua'
}

dependency '/assetpacks'