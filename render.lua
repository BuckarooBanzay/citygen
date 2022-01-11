
function citygen.render(mapblock_pos)
    local layout_data = citygen.get_mapblock_layout(mapblock_pos)
    for name in pairs(layout_data.names) do
        local building_def = citygen.get_building(name)
        assert(building_def, "Building not found: " .. name)

        local renderer = citygen.get_renderer(building_def.renderer)
        renderer.render(building_def, layout_data, mapblock_pos)
    end
end