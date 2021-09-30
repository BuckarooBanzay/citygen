local MP = minetest.get_modpath("citygen")

citygen.register_renderer(function(mapblock_pos, data)
    if not data.groups.platform or mapblock_pos.y ~= 0 then
		return
	end

	mapblock_lib.deserialize(mapblock_pos, MP .. "/schematics/base/grass_base", {
		use_cache = true
	})
end)