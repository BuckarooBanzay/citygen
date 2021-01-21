local MP = minetest.get_modpath("citygen")

minetest.register_on_generated(function(minp, maxp)
	local start = os.clock()
	-- 5x5x5 mapblocks per chunk
	assert((maxp.x - minp.x + 1) == 80)

	local min_mapblock = mapblock_lib.get_mapblock(minp)
	local max_mapblock = mapblock_lib.get_mapblock(maxp)

	for z=min_mapblock.z,max_mapblock.z do
	for x=min_mapblock.x,max_mapblock.x do
	for y=min_mapblock.y,max_mapblock.y do
		local mapblock_pos = { x=x, y=y, z=z }

		if mapblock_pos.y == 0 then
			local options = {
				use_cache = true
			}

			if mapblock_pos.x % 10 == 0 and mapblock_pos.z % 10 == 0 then
				mapblock_lib.deserialize(mapblock_pos, MP .. "/schematics/street/street_all_sides", options)
			elseif mapblock_pos.x % 10 == 0 then
				options.transform = {
					rotate = {
						axis = "y",
						angle = 90,
						disable_orientation = true
					}
				}
				mapblock_lib.deserialize(mapblock_pos, MP .. "/schematics/street/street_straight", options)
			elseif mapblock_pos.z % 10 == 0 then
				options.transform = {
					rotate = {
						axis = "y",
						angle = 0,
						disable_orientation = true
					}
				}
				mapblock_lib.deserialize(mapblock_pos, MP .. "/schematics/street/street_straight", options)
			end
		end

	end --y
	end --x
	end --z

	local diff = os.clock() - start
	print("[citygen] chunk@minp " .. minetest.pos_to_string(minp) .. " took " .. diff .. " seconds")

end)
