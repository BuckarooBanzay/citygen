
citygen.register_renderer("12-part", {
	render = function(building_def, mapblock_pos)

        local x_plus = citygen.mapdata.get_name(vector.add(mapblock_pos, {x=1, y=0, z=0})) == building_def.name
        local x_minus = citygen.mapdata.get_name(vector.add(mapblock_pos, {x=-1, y=0, z=0})) == building_def.name
        local y_plus = citygen.mapdata.get_name(vector.add(mapblock_pos, {x=0, y=1, z=0})) == building_def.name
        local y_minus = citygen.mapdata.get_name(vector.add(mapblock_pos, {x=0, y=-1, z=0})) == building_def.name
        local z_plus = citygen.mapdata.get_name(vector.add(mapblock_pos, {x=0, y=0, z=1})) == building_def.name
        local z_minus = citygen.mapdata.get_name(vector.add(mapblock_pos, {x=0, y=0, z=-1})) == building_def.name

        local schematic
        local options = {
            use_cache = true,
            transform = {
                rotate = {
                    axis = "y",
                    angle = 0
                }
            }
        }

        -- TODO: refactor top/middle/bottom selection

        if x_plus and x_minus and z_plus and z_minus then
            -- center
            if y_plus and y_minus then
                schematic = building_def.schematics.center.middle
            elseif y_plus and not y_minus then
                schematic = building_def.schematics.center.bottom
            elseif not y_plus and y_minus then
                schematic = building_def.schematics.center.top
            end

        elseif x_plus and not x_minus and z_plus and not z_minus then
            -- x+ z+
            options.transform.rotate.angle = 90
            if y_plus and y_minus then
                schematic = building_def.schematics.corner.middle
            elseif y_plus and not y_minus then
                schematic = building_def.schematics.corner.bottom
            elseif not y_plus and y_minus then
                schematic = building_def.schematics.corner.top
            end

        elseif x_plus and not x_minus and not z_plus and z_minus then
            -- x+ z-
            options.transform.rotate.angle = 180
            if y_plus and y_minus then
                schematic = building_def.schematics.corner.middle
            elseif y_plus and not y_minus then
                schematic = building_def.schematics.corner.bottom
            elseif not y_plus and y_minus then
                schematic = building_def.schematics.corner.top
            end

        elseif not x_plus and x_minus and not z_plus and z_minus then
            -- x- z-
            options.transform.rotate.angle = 270
            if y_plus and y_minus then
                schematic = building_def.schematics.corner.middle
            elseif y_plus and not y_minus then
                schematic = building_def.schematics.corner.bottom
            elseif not y_plus and y_minus then
                schematic = building_def.schematics.corner.top
            end

        elseif not x_plus and x_minus and z_plus and not z_minus then
            -- x- z+
            options.transform.rotate.angle = 0
            if y_plus and y_minus then
                schematic = building_def.schematics.corner.middle
            elseif y_plus and not y_minus then
                schematic = building_def.schematics.corner.bottom
            elseif not y_plus and y_minus then
                schematic = building_def.schematics.corner.top
            end

        elseif x_plus and x_minus and z_plus and not z_minus then
            -- z-
            options.transform.rotate.angle = 90
            if y_plus and y_minus then
                schematic = building_def.schematics.edge.middle
            elseif y_plus and not y_minus then
                schematic = building_def.schematics.edge.bottom
            elseif not y_plus and y_minus then
                schematic = building_def.schematics.edge.top
            end

        elseif x_plus and x_minus and not z_plus and z_minus then
            -- z+
            options.transform.rotate.angle = 270
            if y_plus and y_minus then
                schematic = building_def.schematics.edge.middle
            elseif y_plus and not y_minus then
                schematic = building_def.schematics.edge.bottom
            elseif not y_plus and y_minus then
                schematic = building_def.schematics.edge.top
            end

        elseif not x_plus and x_minus and z_plus and z_minus then
            -- x+
            options.transform.rotate.angle = 0
            if y_plus and y_minus then
                schematic = building_def.schematics.edge.middle
            elseif y_plus and not y_minus then
                schematic = building_def.schematics.edge.bottom
            elseif not y_plus and y_minus then
                schematic = building_def.schematics.edge.top
            end

        elseif x_plus and not x_minus and z_plus and z_minus then
            -- x-
            options.transform.rotate.angle = 180
            if y_plus and y_minus then
                schematic = building_def.schematics.edge.middle
            elseif y_plus and not y_minus then
                schematic = building_def.schematics.edge.bottom
            elseif not y_plus and y_minus then
                schematic = building_def.schematics.edge.top
            end
        end

        if not schematic then
            -- TODO
            return
        end

        mapblock_lib.deserialize(mapblock_pos, schematic, options)
	end
})
