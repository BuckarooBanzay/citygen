local rnd = tonumber(string.sub(minetest.get_mapgen_setting("seed"), 1, 7))

citygen.register_layout("street", {
	order = 1,
	layout = function(building_defs, layout, root_pos)
		assert(#building_defs > 0, "no streets found")
		-- default to first street definition found
		-- TODO: select by biome/region/etc
		local building_def = building_defs[1]

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
