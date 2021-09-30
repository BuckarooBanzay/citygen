-- Source: https://github.com/faker-ruby/faker/blob/master/lib/locales/en/address.yml

local MP = minetest.get_modpath("citygen")

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
-- https://stackoverflow.com/questions/11201262/how-to-read-data-from-a-file-in-lua
local function lines_from(file)
    local lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = line
    end
    return lines
end

local prefixes = lines_from(MP .. "/util/street_prefixes.txt")
local suffixes = lines_from(MP .. "/util/street_suffixes.txt")

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
