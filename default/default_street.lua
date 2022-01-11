local MP = minetest.get_modpath("citygen")

citygen.register_building("citygen:default_street", {
	renderer = "street",
	layout = "street",
	schematics = {
		all_sides = MP .. "/schematics/street/street_all_sides",
		crossing = MP .. "/schematics/street/street_straight_crossing",
		straight = MP .. "/schematics/street/street_straight",
		sewer = MP .. "/schematics/street/street_straight_sewer_access"
	}
})

local rnd = tonumber(string.sub(minetest.get_mapgen_setting("seed"), 1, 7))

citygen.register_layout("street", {
	order = 1,
	layout = function(building_def, layout, root_pos)
		local x_streetname = citygen.get_street_name(rnd + root_pos.z)
		local z_streetname = citygen.get_street_name(rnd + 2048 + root_pos.x)

		local size_x, size_z = layout:get_size()
		for x=1, size_x do
			layout:set_name(x, 1, building_def.name)
			layout:set_group(x, 1, "street")
			layout:set_attribute(x, 1, "x_streetname", x_streetname)
			layout:set_attribute(x, 1, "z_streetname", z_streetname)
		end
		for z=1, size_z do
			layout:set_name(1, z, building_def.name)
			layout:set_group(1, z, "street")
			layout:set_attribute(1, z, "x_streetname", x_streetname)
			layout:set_attribute(1, z, "z_streetname", z_streetname)
		end
	end
})

local has_street_signs_mod = minetest.get_modpath("street_signs")

local content_street_sign = -1
if has_street_signs_mod then
	content_street_sign = minetest.get_content_id("street_signs:sign_basic")
end

citygen.register_renderer("street", {
	render = function(building_def, layout_data, mapblock_pos)
		if mapblock_pos.y ~= 0 then
			return
		end

		local on_metadata = function(_, content_id, meta)
			if content_id == content_street_sign then
				-- write street name
				local txt = layout_data.attributes.z_streetname .. "\n" .. layout_data.attributes.x_streetname
				meta:set_string("infotext", txt)
				meta:set_string("text", txt)
			end
		end

		local all_neighbors = {
			{ x=1, z=0 },
			{ x=-1, z=0 },
			{ x=0, z=1 },
			{ x=0, z=-1 }
		}
		if citygen.layout_check_neighbors({ group = "street" }, mapblock_pos, all_neighbors) then
			-- all sides
			mapblock_lib.deserialize(mapblock_pos, building_def.schematics.all_sides, {
				use_cache = true,
				on_metadata = on_metadata
			})
			return
		end

		if citygen.layout_check_neighbors({ group = "street" }, mapblock_pos, {{x=1,z=0},{x=-1,z=0}}) then
			-- x-direction
			mapblock_lib.deserialize(mapblock_pos, building_def.schematics.straight, {
				use_cache = true,
				on_metadata = on_metadata
			})
		end

		if citygen.layout_check_neighbors({ group = "street" }, mapblock_pos, {{x=0,z=1},{x=0,z=-1}}) then
			-- z-direction
			mapblock_lib.deserialize(mapblock_pos, building_def.schematics.straight, {
				use_cache = true,
				transform = {
					rotate = {
						axis = "y",
						angle = 90,
						disable_orientation = {
							["default:stonebrick"] = true,
							["street_signs:sign_basic"] = true
						}
					}
				},
				on_metadata = on_metadata
			})
		end

	end
})
