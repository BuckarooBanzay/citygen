local MP = minetest.get_modpath("citygen")

function citygen.generate_street(mapblock_pos)

	local options = {
		use_cache = true
	}

	local schematic

	local x_match = mapblock_pos.x % citygen.road_interval == 0
	local z_match = mapblock_pos.z % citygen.road_interval == 0

	local is_crossing = (z_match and mapblock_pos.x % citygen.road_crossing_interval == 0) or
		(x_match and mapblock_pos.z % citygen.road_crossing_interval == 0)

	if x_match and z_match then
		schematic = MP .. "/schematics/street/street_all_sides"
	elseif x_match or z_match then
		options.transform = {
			rotate = {
				axis = "y",
				angle = x_match and 90 or 0,
				disable_orientation = true
			}
		}
		if is_crossing then
			schematic = MP .. "/schematics/street/street_straight_crossing"
		else
			schematic = MP .. "/schematics/street/street_straight"
		end
	end

	if schematic then
		mapblock_lib.deserialize(mapblock_pos, schematic, options)
	end

end
