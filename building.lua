local MP = minetest.get_modpath("citygen")

function citygen.generate_building(mapblock_pos)

	-- corners

	local zplus_xplus_corner =
		(mapblock_pos.x+1) % citygen.road_interval == 0 and
		(mapblock_pos.z+1) % citygen.road_interval == 0

	local zplus_xminus_corner =
		(mapblock_pos.x-1) % citygen.road_interval == 0 and
		(mapblock_pos.z+1) % citygen.road_interval == 0

	local zminus_xplus_corner =
		(mapblock_pos.x+1) % citygen.road_interval == 0 and
		(mapblock_pos.z-1) % citygen.road_interval == 0

	local zminus_xminus_corner =
		(mapblock_pos.x-1) % citygen.road_interval == 0 and
		(mapblock_pos.z-1) % citygen.road_interval == 0

	-- straight parts

	local xplus_straight =
		(mapblock_pos.x+1) % citygen.road_interval == 0 and
		mapblock_pos.z % citygen.road_interval > 0

	local xminus_straight =
		(mapblock_pos.x-1) % citygen.road_interval == 0 and
		mapblock_pos.z % citygen.road_interval > 0

	local zplus_straight =
		(mapblock_pos.z+1) % citygen.road_interval == 0 and
		mapblock_pos.x % citygen.road_interval > 0

	local zminus_straight =
		(mapblock_pos.z-1) % citygen.road_interval == 0 and
		mapblock_pos.x % citygen.road_interval > 0

	local options = {
		use_cache = true,
		transform = {
			rotate = {
				axis = "y",
				angle = 0
			}
		}
	}

	local is_corner =
		zplus_xplus_corner or
		zplus_xminus_corner or
		zminus_xplus_corner or
		zminus_xminus_corner

	local is_straight =
		not is_corner and
		(xplus_straight or xminus_straight or zplus_straight or zminus_straight)

	local is_road = mapblock_pos.x % citygen.road_interval == 0 or
		mapblock_pos.z % citygen.road_interval == 0

	if is_corner then
		if zplus_xplus_corner then
			options.transform.rotate.angle = 270
		elseif zplus_xminus_corner then
			options.transform.rotate.angle = 180
		elseif zminus_xplus_corner then
			options.transform.rotate.angle = 0
		elseif zminus_xminus_corner then
			options.transform.rotate.angle = 90
		end
	elseif is_straight then
		if xplus_straight then
			options.transform.rotate.angle = 0
		elseif xminus_straight then
			options.transform.rotate.angle = 180
		elseif zplus_straight then
			options.transform.rotate.angle = 270
		elseif zminus_straight then
			options.transform.rotate.angle = 90
		end
	end

	if mapblock_pos.y == 0 then
		-- lower part
		if is_corner then
			mapblock_lib.deserialize(mapblock_pos, MP .. "/schematics/building/building_lower_corner", options)
		elseif is_straight then
			mapblock_lib.deserialize(mapblock_pos, MP .. "/schematics/building/building_lower_straight", options)
		elseif not is_road then
			mapblock_lib.deserialize(mapblock_pos, MP .. "/schematics/building/building_lower_center", options)
		end
	elseif mapblock_pos.y > 0 and mapblock_pos.y < 5 then
		-- middle
		if is_corner then
			mapblock_lib.deserialize(mapblock_pos, MP .. "/schematics/building/building_middle_corner", options)
		elseif is_straight then
			mapblock_lib.deserialize(mapblock_pos, MP .. "/schematics/building/building_middle_straight", options)
		end
	elseif mapblock_pos.y == 5 then
		-- top
		if is_corner then
			mapblock_lib.deserialize(mapblock_pos, MP .. "/schematics/building/building_top_corner", options)
		elseif is_straight then
			mapblock_lib.deserialize(mapblock_pos, MP .. "/schematics/building/building_top_straight", options)
		elseif not is_road then
			mapblock_lib.deserialize(mapblock_pos, MP .. "/schematics/building/building_top_center", options)
		end
	end
end
