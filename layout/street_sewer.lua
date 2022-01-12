
citygen.register_layout("street_sewer", {
	order = 5,
	layout = function(building_def, min_pos, max_pos)
		assert(type(building_def.pos_y) == "number", "building_def.pos_y is not a number")
		assert(type(building_def.mod_x) == "number", "building_def.mod_x is not a number")
		assert(type(building_def.mod_z) == "number", "building_def.mod_z is not a number")
		assert(type(building_def.replace) == "string", "building_def.replace is not a string")

		if building_def.pos_y > max_pos.y or building_def.pos_y < min_pos.y then
			-- y-window does not match
			return
		end

		local replace_name = building_def.replace

		for x=min_pos.x, max_pos.x do
			for z=min_pos.z, max_pos.z do
				local pos = { x=x, y=building_def.pos_y, z=z }
				local name = citygen.mapdata.get_name(pos, false)
				if (x % building_def.mod_x == 0 or z % building_def.mod_z == 0) and name == replace_name then
					citygen.mapdata.set_name(pos, building_def.name)
				end
			end
		end
	end
})
