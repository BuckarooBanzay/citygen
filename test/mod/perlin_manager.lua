
return function(callback)
    print("Testing perlin manager")
    local root_pos = { x=0, z=0 }
    local pmgr = citygen.create_perlin_manager(root_pos)
    local partitions = citygen.partition(50, 50, 5, pmgr)
    print(dump(partitions))
    assert(#partitions > 1, "partitions created")
    callback()
end