
minetest.register_on_generated(function(minp, maxp)
	local start = os.clock()

	local min_mapblock = mapblock_lib.get_mapblock(minp)
	local max_mapblock = mapblock_lib.get_mapblock(maxp)

	for z=min_mapblock.z,max_mapblock.z do
	for x=min_mapblock.x,max_mapblock.x do
	for y=min_mapblock.y,max_mapblock.y do
		local mapblock_pos = { x=x, y=y, z=z }

		if mapblock_pos.y == 0 then
			citygen.generate_street(mapblock_pos)
		end

		if mapblock_pos.y >= 0 and mapblock_pos.y <= 5 then
			citygen.generate_building(mapblock_pos)
		end

	end --y
	end --x
	end --z

	local diff = os.clock() - start
	print("[citygen] chunk@minp " .. minetest.pos_to_string(minp) .. " took " .. diff .. " seconds")

end)
