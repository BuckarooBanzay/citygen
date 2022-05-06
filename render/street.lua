
local catalog = mapblock_lib.get_catalog(citygen.MP .. "/schematics/street.zip")
assert(catalog)

citygen.register_renderer("street", function(mapblock_pos)
    if mapblock_pos.y ~= 0 then
        -- only place on y=0
        return
    end
    catalog:deserialize({x=0,y=1,z=0}, mapblock_pos)
end)