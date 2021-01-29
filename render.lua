local MP = minetest.get_modpath("citygen")

function citygen.render_sewer(mapblock_pos, data)
	if mapblock_pos.y ~= -1 then
		return
	end

	local angle = 0
	local schematic

	if data.direction == "all" then
		schematic = MP .. "/schematics/sewer/sewer_all_sides"
	elseif data.sewer_access then
		schematic = MP .. "/schematics/sewer/sewer_straight_access"
	else
		schematic = MP .. "/schematics/sewer/sewer_straight"
	end

	if data.direction == "z+z-" then
		angle = 90
	end

	mapblock_lib.deserialize(mapblock_pos, schematic, {
		use_cache = true,
		transform = {
			rotate = {
				axis = "y",
				angle = angle
			}
		}
	})
end

function citygen.render_street(mapblock_pos, data)
	if mapblock_pos.y ~= 0 then
		return
	end

	local angle = 0
	local schematic

	if data.direction == "all" then
		schematic = MP .. "/schematics/street/street_all_sides"
	elseif data.sewer_access then
		schematic = MP .. "/schematics/street/street_straight_sewer_access"
	elseif data.crossing then
		schematic = MP .. "/schematics/street/street_straight_crossing"
	else
		schematic = MP .. "/schematics/street/street_straight"
	end

	if data.direction == "z+z-" then
		angle = 90
	end

	mapblock_lib.deserialize(mapblock_pos, schematic, {
		use_cache = true,
		transform = {
			rotate = {
				axis = "y",
				angle = angle,
				disable_orientation = {
					["default:stonebrick"] = true
				}
			}
		}
	})
end

function citygen.render_platform(mapblock_pos)
	if mapblock_pos.y ~= 0 then
		return
	end

	mapblock_lib.deserialize(mapblock_pos, MP .. "/schematics/base/stone_base", {
		use_cache = true
	})
end

function citygen.render_building(mapblock_pos, data)
	if mapblock_pos.y < 0 or mapblock_pos.y > data.height then
		return
	end

	local is_bottom = mapblock_pos.y == 0
	local is_top = mapblock_pos.y == data.height

	local schematic

	if data.type == "inner" then
		if is_bottom then
			schematic = MP .. "/schematics/building/building_lower_center"
		elseif is_top then
			schematic = MP .. "/schematics/building/building_top_center"
		else
			schematic = MP .. "/schematics/building/building_middle_center"
		end
	elseif data.type == "edge" then
		if is_bottom then
			schematic = MP .. "/schematics/building/building_lower_straight"
		elseif is_top then
			schematic = MP .. "/schematics/building/building_top_straight"
		else
			schematic = MP .. "/schematics/building/building_middle_straight"
		end
		if data.closed then
			-- closed corner
			schematic = schematic .. "_closed"
		end
	elseif data.type == "corner" then
		if is_bottom then
			schematic = MP .. "/schematics/building/building_lower_corner"
		elseif is_top then
			schematic = MP .. "/schematics/building/building_top_corner"
		else
			schematic = MP .. "/schematics/building/building_middle_corner"
		end
	end

	local angle = 0

	if data.direction == "x+" or data.direction == "x+z-" then
		angle = 0
	elseif data.direction == "x-" or data.direction == "x-z+" then
		angle = 180
	elseif data.direction == "z+" or data.direction == "x+z+" then
		angle = 270
	elseif data.direction == "z-" or data.direction == "x-z-" then
		angle = 90
	end

	if schematic then
		local options = {
			use_cache = true,
			transform = {
				rotate = {
					axis = "y",
					angle = angle
				}
			}
		}

		mapblock_lib.deserialize(mapblock_pos, schematic, options)
	end
end
