function minetest.get_mapgen_setting(key)
	if key == "mg_name" then
		return "singlenode"
	elseif key == "seed" then
		return "1234567890"
	end
end