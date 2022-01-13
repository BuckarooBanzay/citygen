
citygen.register_layout("replace_nth", {
	order = 5,
	layout = function(building_def, min_pos, max_pos)
		assert(type(building_def.pos_y) == "number", "building_def.pos_y is not a number")
		assert(type(building_def.replace_nth) == "number", "building_def.replace_nth is not a number")
		assert(type(building_def.replace_name) == "string", "building_def.replace_name is not a string")

		if building_def.pos_y > max_pos.y or building_def.pos_y < min_pos.y then
			-- y-window does not match
			return
		end

		local i = 0

		for x=min_pos.x, max_pos.x do
			for z=min_pos.z, max_pos.z do
				local pos = { x=x, y=building_def.pos_y, z=z }
				local name = citygen.mapdata.get_name(pos, false)
				if name == building_def.replace_name and i == building_def.replace_nth then
					citygen.mapdata.set_name(pos, building_def.name)
					i = 0
				else
					i = i + 1
				end
			end
		end
	end
})
