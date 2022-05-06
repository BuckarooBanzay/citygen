
-- assign street names
local has_street_signs_mod = minetest.get_modpath("street_signs")
local all_directions_options = nil
if has_street_signs_mod then
	local content_street_sign = minetest.get_content_id("street_signs:sign_basic")
	all_directions_options = {
		on_metadata = function(pos, content_id, meta)
			local mapblock_pos = mapblock_lib.get_mapblock(pos)
			local root_pos = citygen.get_root_pos(mapblock_pos)
			local x_streetname = citygen.get_street_name(root_pos.x + 2000)
			local z_streetname = citygen.get_street_name(root_pos.z + 4000)

			if content_id == content_street_sign then
				-- write street name
				local txt = z_streetname .. "\n" .. x_streetname
				meta:set_string("infotext", txt)
				meta:set_string("text", txt)
			end
		end
	}
end

-- local the street catalog
local catalog = mapblock_lib.get_catalog(citygen.MP .. "/schematics/street.zip")
assert(catalog, "catalog present")
assert(vector.equals(catalog:get_size(), {x=4, y=2, z=2}), "catalog size matches")

-- positions inside the catalog
local catalog_pos = {
	all_directions = {x=0, y=1, z=1},
	three_sides = {x=1, y=1, z=0},
	corner = {x=0, y=1, z=0},
	straight = {x=1, y=1, z=1}
}

local mapblocks = {
	all_directions = catalog:prepare(catalog_pos.all_directions, all_directions_options),
	three_sides = {},
	corner = {},
	straight = {}
}

-- prepare mapblocks in all needed rotations
for _, angle in ipairs({0,90,180,270}) do
	local options = {
		transform = {
			rotate = {
				axis = "y",
				angle = angle
			},
			disable_orientation = {
				["default:stonebrick"] = true
			}
		}
	}
	mapblocks.three_sides[angle] = catalog:prepare(catalog_pos.three_sides, options)
	mapblocks.corner[angle] = catalog:prepare(catalog_pos.corner, options)

	if angle <= 90 then
		mapblocks.straight[angle] = catalog:prepare(catalog_pos.straight, options)
	end
end

local function get_neighbor_info(mapblock_pos)
	local x_plus = citygen.get_cityblock_mapblock(vector.add(mapblock_pos, {x=1, y=0, z=0}))
	local z_plus = citygen.get_cityblock_mapblock(vector.add(mapblock_pos, {x=0, y=0, z=1}))
	local x_minus = citygen.get_cityblock_mapblock(vector.add(mapblock_pos, {x=-1, y=0, z=0}))
	local z_minus = citygen.get_cityblock_mapblock(vector.add(mapblock_pos, {x=0, y=0, z=-1}))

	return {
		x_plus = x_plus and x_plus.renderer == "street",
		z_plus = z_plus and z_plus.renderer == "street",
		x_minus = x_minus and x_minus.renderer == "street",
		z_minus = z_minus and z_minus.renderer == "street",
	}
end

-- register renderer
citygen.register_renderer("street", function(mapblock_pos)
	if mapblock_pos.y ~= 0 then
		-- only place on y=0
		return
	end

	local ni = get_neighbor_info(mapblock_pos)

	if ni.x_plus and ni.x_minus and ni.z_plus and ni.z_minus then
		mapblocks.all_directions(mapblock_pos)
	elseif ni.x_plus and ni.x_minus then
		mapblocks.straight[0](mapblock_pos)
	elseif ni.z_minus and ni.z_minus then
		mapblocks.straight[90](mapblock_pos)
	end

end)