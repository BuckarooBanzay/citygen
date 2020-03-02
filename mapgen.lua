

local street_y_mapblock = 0
local pilot_street_modulo = 10


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

        if mapblock_y == street_y_mapblock then
          -- y coords match for street
          local street_x_match = mapblock_x % pilot_street_modulo == 0
          local street_z_match = mapblock_z % pilot_street_modulo == 0

          local direction

          if street_x_match and street_z_match then
            direction = citygen.DIRECTION_BOTH
          elseif street_x_match then
            direction = citygen.DIRECTION_NORTH_SOUTH
          elseif street_z_match then
            direction = citygen.DIRECTION_EAST_WEST
          end

          if direction then
            -- x/z coords match for street
            dirty = true
            citygen.generate_street(data, area, direction, mapblock_pos, min_pos, max_pos)
          end
        end
      end
    end
  end



  if dirty then
    vm:set_data(data)
    vm:write_to_map()
  end
end)
