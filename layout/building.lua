
citygen.register_layout("building", {
	order = 10,
	type = "multi",
	layout = function(building_defs, min_pos, max_pos)
		local building_def = building_defs[1]
		local base_y = 0
		if base_y > max_pos.y or base_y < min_pos.y then
			-- base-y not found in this cityblock, skip layouting
			return
		end

		for x=min_pos.x+1, min_pos.x+5 do
			for z=min_pos.z+1, min_pos.z+5 do
				for y=base_y, base_y+5 do
					local pos = {x=x, y=y, z=z}
					citygen.mapdata.set_name(pos, building_def.name)
				end
			end
		end

		--local pmgr = citygen.create_perlin_manager(min_pos)

		-- TODO
	end
})
