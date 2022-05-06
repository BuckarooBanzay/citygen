
return function(callback)
    print("util tests")
    local root_pos = citygen.get_root_pos({ x=10, y=0, z=0 })
    assert(root_pos.x == 0, "x-pos matches")
    assert(root_pos.z == 0, "z-pos matches")

    root_pos = citygen.get_root_pos({ x=21, y=0, z=0 })
    assert(root_pos.x == 20, "x-pos matches")
    assert(root_pos.z == 0, "z-pos matches")

    callback()
end

