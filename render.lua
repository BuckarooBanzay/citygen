
function citygen.render(mapblock_pos)
    local name = citygen.mapdata.get_name(mapblock_pos)
    if not name then
        return
    end

    local building_def = citygen.get_building(name)
    assert(building_def, "building_def not found: " .. name)

    if building_def then
        local renderer = citygen.get_renderer(building_def.renderer)
        renderer.render(building_def, mapblock_pos)
    end
end