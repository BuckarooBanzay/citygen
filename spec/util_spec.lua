require("mineunit")

mineunit("core")
mineunit("default/functions")

sourcefile("spec/common")
sourcefile("init")

describe("citygen.get_root_pos", function()
	it("returns proper values", function()
        assert.equals(20, citygen.cityblock_size)

        local root_pos = citygen.get_root_pos({ x=1, y=1, z=1 })
        assert.equals(0, root_pos.x)
        assert.equals(0, root_pos.y)
        assert.equals(0, root_pos.z)

        root_pos = citygen.get_root_pos({ x=-1, y=-1, z=-1 })
        assert.equals(-20, root_pos.x)
        assert.equals(-20, root_pos.y)
        assert.equals(-20, root_pos.z)

        root_pos = citygen.get_root_pos({ x=19, y=-1, z=-1 })
        assert.equals(0, root_pos.x)
        assert.equals(-20, root_pos.y)
        assert.equals(-20, root_pos.z)

        root_pos = citygen.get_root_pos({ x=20, y=-1, z=-1 })
        assert.equals(20, root_pos.x)
        assert.equals(-20, root_pos.y)
        assert.equals(-20, root_pos.z)
    end)
end)

