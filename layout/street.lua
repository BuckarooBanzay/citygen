local rnd = tonumber(string.sub(minetest.get_mapgen_setting("seed"), 1, 7))

citygen.register_layout("street", {
	order = 1,
	layout = function(building_def, min_pos, max_pos)
		assert(type(building_def.pos_y) == "number", "building_def.pos_y is not a number")

		if building_def.pos_y > max_pos.y or building_def.pos_y < min_pos.y then
			-- y-window does not match
			return
		end
		-- TODO: select by biome/region/etc

		local x_streetname = citygen.get_street_name(rnd + min_pos.z)
		local z_streetname = citygen.get_street_name(rnd + 2048 + min_pos.x)

		for x=min_pos.x, max_pos.x do
			local pos = { x=x, y=building_def.pos_y, z=min_pos.z }
			citygen.mapdata.set_name(pos, building_def.name)
			citygen.mapdata.set_group(pos, "street")
			citygen.mapdata.set_attribute(pos, "x_streetname", x_streetname)
			citygen.mapdata.set_attribute(pos, "z_streetname", z_streetname)
		end
		for z=min_pos.z, max_pos.z do
			local pos = { x=min_pos.x, y=building_def.pos_y, z=z }
			citygen.mapdata.set_name(pos, building_def.name)
			citygen.mapdata.set_group(pos, "street")
			citygen.mapdata.set_attribute(pos, "x_streetname", x_streetname)
			citygen.mapdata.set_attribute(pos, "z_streetname", z_streetname)
		end
	end
})
