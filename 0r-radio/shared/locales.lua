local function loadLocaleFile(locale)
	local resourceName = GetCurrentResourceName()
	local file = LoadResourceFile(resourceName, ('locales/%s.lua'):format(locale))
	if not file then
		file = LoadResourceFile(resourceName, 'locales/en.lua')
		CreateThread(function()
			print(('Locale file "%s" not found, falling back to default "en".'):format(locale))
		end)
	end
	return file
end

local function loadLocale(locale)
	local file = loadLocaleFile(locale)
	local data, err = load(file)
	if err then
		error(err)
	end
	return data()
end

-- Dil dosyasını yükler ve verileri saklar
locales = loadLocale(Config.Locale)

-- Anahtar için yerel metni alır ve yerel verilerle biçimlendirir
---@param key string
---@return string
function _t(key, ...)
	if locales[key] then
		return locales[key]:format(...)
	end
	return key
end
