
minetest.register_on_generated(function(minp)

  local chunkpos = citygen.get_chunkpos_from_pos(minp)
  local min_mapblock, max_mapblock = citygen.get_mapblocks_from_chunk(chunkpos)

  local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")

	local data = vm:get_data()
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
  local dirty = false

  for mapblock_x = min_mapblock.x, max_mapblock.x do
    for mapblock_y = min_mapblock.y, max_mapblock.y do
      for mapblock_z = min_mapblock.z, max_mapblock.z do
        local mapblock_pos = { x = mapblock_x, y = mapblock_y, z = mapblock_z }
        local min_pos, max_pos = citygen.get_blocks_from_mapblock(mapblock_pos)

        if citygen.is_street_mapblock(mapblock_pos) then
            dirty = true
            citygen.generate_street(data, area, mapblock_pos, min_pos, max_pos)
        end
      end
    end
  end



  if dirty then
    vm:set_data(data)
    vm:write_to_map()
  end
end)
