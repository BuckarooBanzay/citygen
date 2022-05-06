
minetest.register_on_generated(function(minp, maxp)
	local min_mapblock = mapblock_lib.get_mapblock(minp)
	local max_mapblock = mapblock_lib.get_mapblock(maxp)

	for z=min_mapblock.z,max_mapblock.z do
	for x=min_mapblock.x,max_mapblock.x do
	for y=min_mapblock.y,max_mapblock.y do
		local mapblock_pos = { x=x, y=y, z=z }
		local data = citygen.get_cityblock_mapblock(mapblock_pos)
		if data then
			local renderer = citygen.get_renderer(data.renderer)
			if renderer then
				renderer(mapblock_pos, data)
			end
		end
	end --y
	end --x
	end --z
end)
