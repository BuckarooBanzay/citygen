
citygen.register_layout("building", {
	order = 10,
	type = "multi",
	layout = function(building_defs, min_pos, max_pos)
		local base_y = 0
		if base_y > max_pos.y or base_y < min_pos.y then
			-- base-y not found in this cityblock, skip layouting
			return
		end

		-- TODO
	end
})
