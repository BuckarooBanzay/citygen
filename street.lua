
local c_sidewalk = minetest.get_content_id("default:stonebrick")
local c_street = minetest.get_content_id("default:stone")

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

function citygen.generate_street(data, area, direction, _, min_pos, max_pos)
  -- street base layer
  set_nodes(
    data, area, c_street,
    { x=min_pos.x, y=min_pos.y, z=min_pos.z },
    { x=max_pos.x, y=min_pos.y, z=max_pos.z }
  )

  -- sidewalks
  -- local sidewalk_width = 2
  if direction == citygen.DIRECTION_BOTH then
    set_nodes(
      data, area, c_sidewalk,
      { x=min_pos.x, y=min_pos.y+1, z=min_pos.z },
      { x=min_pos.x+2, y=min_pos.y+1, z=min_pos.z+2 }
    )

		set_nodes(
      data, area, c_sidewalk,
			{ x=max_pos.x-2, y=min_pos.y+1, z=max_pos.z-2 },
      { x=max_pos.x, y=min_pos.y+1, z=max_pos.z }
    )

    set_nodes(
      data, area, c_sidewalk,
      { x=max_pos.x-2, y=min_pos.y+1, z=min_pos.z },
      { x=max_pos.x, y=min_pos.y+1, z=min_pos.z+2 }
    )

    set_nodes(
      data, area, c_sidewalk,
      { x=min_pos.x, y=min_pos.y+1, z=max_pos.z-2 },
      { x=min_pos.x+2, y=min_pos.y+1, z=max_pos.z }
    )

  elseif direction == citygen.DIRECTION_EAST_WEST then
    set_nodes(
      data, area, c_sidewalk,
      { x=min_pos.x, y=min_pos.y+1, z=min_pos.z },
      { x=max_pos.x, y=min_pos.y+1, z=min_pos.z+2 }
    )

		set_nodes(
			data, area, c_sidewalk,
			{ x=min_pos.x, y=min_pos.y+1, z=max_pos.z-2 },
			{ x=max_pos.x, y=min_pos.y+1, z=max_pos.z }
		)

  elseif direction == citygen.DIRECTION_NORTH_SOUTH then
    set_nodes(
      data, area, c_sidewalk,
      { x=min_pos.x, y=min_pos.y+1, z=min_pos.z },
      { x=min_pos.x+2, y=min_pos.y+1, z=max_pos.z }
    )

		set_nodes(
      data, area, c_sidewalk,
      { x=max_pos.x-2, y=min_pos.y+1, z=min_pos.z },
      { x=max_pos.x, y=min_pos.y+1, z=max_pos.z }
    )

  end
end
