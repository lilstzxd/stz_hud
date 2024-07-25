
fx_version 'cerulean'
game 'gta5'

lua54 'yes'

files {
    'nui/index.html',
    'nui/js/*.js',
    'nui/css/*.css'
}

ui_page 'nui/index.html'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua',
    'player.lua'
}

 

dependencies {
	
   'ox_lib'
}
