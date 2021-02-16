local MP = minetest.get_modpath("citygen")
local has_street_signs_mod = minetest.get_modpath("street_signs")

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
					["default:stonebrick"] = true,
					["street_signs:sign_basic"] = true
				}
			}
		}
	})

	if has_street_signs_mod then
		-- draw street names onto signs
		local min, max = mapblock_lib.get_mapblock_bounds_from_mapblock(mapblock_pos)
		local street_signs = minetest.find_nodes_in_area(min, max, {"street_signs:sign_basic"})
		for _, pos in ipairs(street_signs) do
			local meta = minetest.get_meta(pos)
			local txt = data.z_streetname .. "\n" .. data.x_streetname
			meta:set_string("infotext", txt)
			meta:set_string("text", txt)
		end
	end
end

function citygen.render_platform(mapblock_pos)
	if mapblock_pos.y ~= 0 then
		return
	end

	mapblock_lib.deserialize(mapblock_pos, MP .. "/schematics/base/grass_base", {
		use_cache = true
	})
end

function citygen.render_building(mapblock_pos, data)
	if mapblock_pos.y < 0 or mapblock_pos.y > data.height then
		return
	end

	local building_def = citygen.buildings[data.building_type]
	assert(building_def)

	local is_bottom = mapblock_pos.y == 0
	local is_top = mapblock_pos.y == data.height

	local three_slice
	if data.type == "inner" then
		three_slice = building_def.schematics.center
	elseif data.type == "edge" and not data.closed then
		three_slice = building_def.schematics.edge
	elseif data.type == "edge" and data.closed then
		three_slice = building_def.schematics.edge_closed
	elseif data.type == "corner" then
		three_slice = building_def.schematics.corner
	end

	assert(three_slice)

	local schematic

	if is_top then
		schematic = three_slice.top
	elseif is_bottom then
		schematic = three_slice.bottom
	else
		schematic = three_slice.middle
	end

	assert(schematic)

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
				},
				replace = building_def.replace
			}
		}

		mapblock_lib.deserialize(mapblock_pos, schematic, options)
	end
end
