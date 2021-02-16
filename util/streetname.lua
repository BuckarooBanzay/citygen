-- Source: https://github.com/faker-ruby/faker/blob/master/lib/locales/en/address.yml

local MP = minetest.get_modpath("citygen")

local function readvalues(filename)
	local file, err = io.open(filename,"r")
	if file then
		local txt = file:read("*a")
		local result = {}
		for entry in string.gmatch(txt, "([^,]+)") do
			table.insert(result, entry)
		end
		return result
	else
		error("read error", err)
	end
end

local prefixes = readvalues(MP .. "/util/street_prefixes.txt")
local suffixes = readvalues(MP .. "/util/street_suffixes.txt")

minetest.register_chatcommand("streetname", {
	func = function()
		return true, prefixes[math.random(#prefixes)] .. " " .. suffixes[math.random(#suffixes)]
	end
})
