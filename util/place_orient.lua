
--- place and orient a schematic based on its surroundings
-- @param mapblock_pos the position to place it
function citygen.place_and_orient(mapblock_pos, schematics, connected_group, options)
    assert(type(schematics.all_sides) == "string", "schematics does not contain an 'all_sides' block")
    assert(type(schematics.straight) == "string", "schematics does not contain an 'straight' block")

    options = options or {}
    options.use_cache = true
    -- TODO: T-junction, dead-end, elbow

    local all_neighbors = {
        { x=1, z=0 },
        { x=-1, z=0 },
        { x=0, z=1 },
        { x=0, z=-1 }
    }
    if citygen.layout_check_neighbors({ group = connected_group }, mapblock_pos, all_neighbors) then
        -- all sides
        mapblock_lib.deserialize(mapblock_pos, schematics.all_sides, options)
        return
    end

    if citygen.layout_check_neighbors({ group = connected_group }, mapblock_pos, {{x=1,z=0},{x=-1,z=0}}) then
        -- x-direction
        mapblock_lib.deserialize(mapblock_pos, schematics.straight, options)
    end

    if citygen.layout_check_neighbors({ group = connected_group }, mapblock_pos, {{x=0,z=1},{x=0,z=-1}}) then
        -- z-direction
        options.transform = {
            rotate = {
                axis = "y",
                angle = 90,
                disable_orientation = {
                    ["default:stonebrick"] = true,
                    ["street_signs:sign_basic"] = true
                }
            }
        }
        mapblock_lib.deserialize(mapblock_pos, schematics.straight, options)
    end
end