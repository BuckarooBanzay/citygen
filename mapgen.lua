
local c_sidewalk = minetest.get_content_id("default:stonebrick")
local c_street = minetest.get_content_id("default:stone")

local street_y_pos = 1
local pilot_street_modulo = 10

local DIRECTION_NORTH_SOUTH = 1
local DIRECTION_EAST_WEST = 2
local DIRECTION_BOTH = 3

local function set_nodes(data, area, contentid, pos1, pos2)
  for x = pos1.x, pos2.x do
    for y = pos1.y, pos2.y do
      for z = pos1.z, pos2.z do
        local i = area:index(x, y, z)
        data[i] = contentid
      end
    end
  end
end

local function generate_street(data, area, direction, blockpos, min_pos, max_pos)
  minetest.log("action", "Generating street at: " .. minetest.pos_to_string(blockpos) ..
    " direction: " .. direction)

  -- street base layer
  set_nodes(
    data, area, c_street,
    { x=min_pos.x, y=street_y_pos, z=min_pos.z },
    { x=max_pos.x, y=street_y_pos, z=max_pos.z }
  )

  -- sidewalks
  if direction == DIRECTION_BOTH then
    set_nodes(
      data, area, c_sidewalk,
      { x=min_pos.x, y=street_y_pos+1, z=min_pos.z },
      { x=min_pos.x+2, y=street_y_pos+1, z=min_pos.z+2 }
    )

    set_nodes(
      data, area, c_sidewalk,
      { x=max_pos.x, y=street_y_pos+1, z=max_pos.z },
      { x=max_pos.x-2, y=street_y_pos+1, z=max_pos.z-2 }
    )

    set_nodes(
      data, area, c_sidewalk,
      { x=max_pos.x, y=street_y_pos+1, z=min_pos.z },
      { x=max_pos.x-2, y=street_y_pos+1, z=min_pos.z+2 }
    )

    set_nodes(
      data, area, c_sidewalk,
      { x=min_pos.x, y=street_y_pos+1, z=max_pos.z },
      { x=min_pos.x+2, y=street_y_pos+1, z=max_pos.z-2 }
    )


  elseif direction == DIRECTION_EAST_WEST then
    set_nodes(
      data, area, c_sidewalk,
      { x=min_pos.x, y=street_y_pos+1, z=min_pos.z },
      { x=min_pos.x+2, y=street_y_pos+1, z=max_pos.z }
    )

    set_nodes(
      data, area, c_sidewalk,
      { x=max_pos.x, y=street_y_pos+1, z=min_pos.z },
      { x=max_pos.x-2, y=street_y_pos+1, z=max_pos.z }
    )

  elseif direction == DIRECTION_NORTH_SOUTH then
    set_nodes(
      data, area, c_sidewalk,
      { x=min_pos.x, y=street_y_pos+1, z=min_pos.z },
      { x=min_pos.x, y=street_y_pos+1, z=max_pos.z }
    )

    set_nodes(
      data, area, c_sidewalk,
      { x=max_pos.x, y=street_y_pos+1, z=min_pos.z },
      { x=max_pos.x, y=street_y_pos+1, z=max_pos.z }
    )

  end
end

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

        if min_pos.y < street_y_pos and max_pos.y > street_y_pos then
          local street_x_match = mapblock_x % pilot_street_modulo == 0
          local street_z_match = mapblock_z % pilot_street_modulo == 0

          local direction

          if street_x_match and street_z_match then
            direction = DIRECTION_BOTH
          elseif street_x_match then
            direction = DIRECTION_EAST_WEST
          elseif street_z_match then
            direction = DIRECTION_NORTH_SOUTH
          end

          if direction then
            dirty = true
            generate_street(data, area, direction, mapblock_pos, min_pos, max_pos)
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
