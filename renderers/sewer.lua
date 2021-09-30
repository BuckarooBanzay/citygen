local MP = minetest.get_modpath("citygen")

citygen.register_renderer(function(mapblock_pos, data)
	if not data.groups.street or mapblock_pos.y ~= -1 then
		return
	end

	local angle = 0
	local schematic

	if data.direction == "all" then
		schematic = MP .. "/schematics/sewer/sewer_all_sides"
	elseif data.groups.sewer_access then
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
end)