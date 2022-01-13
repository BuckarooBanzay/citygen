
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
    for _, building_def in pairs(citygen.get_buildings()) do
        assert(type(building_def.name) == "string", "building_def without name registered")
        assert(type(building_def.layout) == "string", "layout not found on building: " .. building_def.name)
        assert(type(building_def.renderer) == "string", "renderer not found on building: " .. building_def.name)

        local list = buildings_by_layout[building_def.layout]
        if not list then
            list = {}
            buildings_by_layout[building_def.layout] = list
        end
        table.insert(list, building_def)
    end
end)

function citygen.populate_layout(root_pos)
    for _, layout_def in ipairs(ordered_layouts) do
        local building_defs = buildings_by_layout[layout_def.name] or {}
        local max_pos = vector.add(root_pos, citygen.cityblock_size-1)

        if layout_def.type == "multi" then
            -- pass all building-defs with the given layout
            layout_def.layout(building_defs, root_pos, max_pos)
        else
            -- pass every building-def one-by-one
            for _, building_def in ipairs(building_defs) do
                layout_def.layout(building_def, root_pos, max_pos)
            end
        end
    end
end