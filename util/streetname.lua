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

function citygen.get_street_name(rnd_num)
	local prefix_n = rnd_num % #prefixes
	local suffix_n = rnd_num % #suffixes
	return prefixes[prefix_n] .. " " .. suffixes[suffix_n]
end

minetest.register_chatcommand("streetname", {
	func = function(_, p)
		return true, citygen.get_street_name(tonumber(p))
	end
})
