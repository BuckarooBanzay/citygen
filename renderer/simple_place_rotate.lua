
local has_street_signs_mod = minetest.get_modpath("street_signs")

local content_street_sign = -1
if has_street_signs_mod then
	content_street_sign = minetest.get_content_id("street_signs:sign_basic")
end

citygen.register_renderer("simple_place_rotate", {
	render = function(building_def, mapblock_pos)
		if mapblock_pos.y ~= building_def.pos_y then
			return
		end

		local on_metadata = function(_, content_id, meta)
			if content_id == content_street_sign then
				-- write street name
				local z_streetname = citygen.mapdata.get_attribute(mapblock_pos, "z_streetname")
				local x_streetname = citygen.mapdata.get_attribute(mapblock_pos, "x_streetname")

				local txt = z_streetname .. "\n" .. x_streetname
				meta:set_string("infotext", txt)
				meta:set_string("text", txt)
			end
		end

		citygen.place_and_orient(mapblock_pos, building_def.schematics, "street", { on_metadata = on_metadata })
	end
})
