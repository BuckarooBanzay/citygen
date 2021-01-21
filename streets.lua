local MP = minetest.get_modpath("citygen")

function citygen.generate_street(mapblock_pos)
	if mapblock_pos.x % citygen.road_interval == 0 and mapblock_pos.z % citygen.road_interval == 0 then
		mapblock_lib.deserialize(mapblock_pos, MP .. "/schematics/street/street_all_sides", {
			use_cache = true
		})
	elseif mapblock_pos.x % citygen.road_interval == 0 then
		mapblock_lib.deserialize(mapblock_pos, MP .. "/schematics/street/street_straight", {
			use_cache = true,
			transform = {
				rotate = {
					axis = "y",
					angle = 90,
					disable_orientation = true
				}
			}
		})
	elseif mapblock_pos.z % citygen.road_interval == 0 then
		mapblock_lib.deserialize(mapblock_pos, MP .. "/schematics/street/street_straight", {
			use_cache = true,
			transform = {
				rotate = {
					axis = "y",
					angle = 0,
					disable_orientation = true
				}
			}
		})
	end
end
