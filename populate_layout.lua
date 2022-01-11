
-- layout sorted by "order"
local ordered_layouts = {}

-- [layout-name] => {building, building, ...}
local buildings_by_layout = {}

minetest.register_on_mods_loaded(function()
    -- create lookup tables
    -- TODO: validate layout- and renderer-names

    -- layouts by order
    for _, layout_def in pairs(citygen.get_layouts()) do
        table.insert(ordered_layouts, layout_def)
    end
    table.sort(ordered_layouts, function(a, b)
        return a.order < b.order
    end)

    -- buildings by layout-name
    for _, building in pairs(citygen.get_buildings()) do
        local list = buildings_by_layout[building.layout]
        if not list then
            list = {}
            buildings_by_layout[building.layout] = list
        end
        table.insert(list, building)
    end
end)

function citygen.populate_layout(root_pos)
    local layout = citygen.new_layout(citygen.cityblock_size, citygen.cityblock_size)

    for _, layout_def in ipairs(ordered_layouts) do
        for _, building_def in ipairs(buildings_by_layout[layout_def.name] or {}) do
            layout_def.layout(building_def, layout, root_pos)
            -- TODO
        end
    end

    return layout
end