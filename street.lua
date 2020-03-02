
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

function citygen.generate_street(data, area, mapblock_pos, min_pos, max_pos)
  -- street base layer
  set_nodes(
    data, area, c_street,
    { x=min_pos.x, y=min_pos.y, z=min_pos.z },
    { x=max_pos.x, y=min_pos.y, z=max_pos.z }
  )

  -- sidewalks
  -- local sidewalk_width = 2

	-- south-east corner
  set_nodes(
    data, area, c_sidewalk,
    { x=min_pos.x, y=min_pos.y+1, z=min_pos.z },
    { x=min_pos.x+2, y=min_pos.y+1, z=min_pos.z+2 }
  )

	-- north-west corner
	set_nodes(
    data, area, c_sidewalk,
		{ x=max_pos.x-2, y=min_pos.y+1, z=max_pos.z-2 },
    { x=max_pos.x, y=min_pos.y+1, z=max_pos.z }
  )

	-- north-east corner
  set_nodes(
    data, area, c_sidewalk,
    { x=max_pos.x-2, y=min_pos.y+1, z=min_pos.z },
    { x=max_pos.x, y=min_pos.y+1, z=min_pos.z+2 }
  )

	-- south-west corner
  set_nodes(
    data, area, c_sidewalk,
    { x=min_pos.x, y=min_pos.y+1, z=max_pos.z-2 },
    { x=min_pos.x+2, y=min_pos.y+1, z=max_pos.z }
  )

	-- check north border
	if not citygen.is_street_mapblock(vector.add(mapblock_pos, {x=0, y=0, z=1})) then
		set_nodes(
	    data, area, c_sidewalk,
			{ x=min_pos.x+2, y=min_pos.y+1, z=max_pos.z-2 },
	    { x=max_pos.x-2, y=min_pos.y+1, z=max_pos.z }
	  )
	end

	-- check south border
	if not citygen.is_street_mapblock(vector.add(mapblock_pos, {x=0, y=0, z=-1})) then
		set_nodes(
	    data, area, c_sidewalk,
			{ x=min_pos.x+2, y=min_pos.y+1, z=min_pos.z },
	    { x=max_pos.x-2, y=min_pos.y+1, z=min_pos.z+2 }
	  )
	end

	-- check east border
	if not citygen.is_street_mapblock(vector.add(mapblock_pos, {x=-1, y=0, z=0})) then
		set_nodes(
	    data, area, c_sidewalk,
			{ x=min_pos.x, y=min_pos.y+1, z=min_pos.z+2 },
	    { x=min_pos.x+2, y=min_pos.y+1, z=max_pos.z-2 }
	  )
	end

	-- check west border
	if not citygen.is_street_mapblock(vector.add(mapblock_pos, {x=1, y=0, z=0})) then
		set_nodes(
	    data, area, c_sidewalk,
			{ x=max_pos.x-2, y=min_pos.y+1, z=min_pos.z+2 },
	    { x=max_pos.x, y=min_pos.y+1, z=max_pos.z-2 }
	  )
	end

end
