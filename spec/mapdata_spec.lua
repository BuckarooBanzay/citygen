require("mineunit")

mineunit("core")
mineunit("player")
mineunit("default/functions")

sourcefile("spec/common")
sourcefile("init")

describe("citygen.mapdata", function()
	it("returns proper values", function()
		local pos = { x=1, y=2, z=3 }
		citygen.mapdata.set_name(pos, "previous_myname")
		citygen.mapdata.set_name(pos, "myname")
		citygen.mapdata.set_group(pos, "street")
		citygen.mapdata.set_attribute(pos, "x", 200)

		assert.equals("myname", citygen.mapdata.get_name(pos))
		assert.equals(true, citygen.mapdata.has_group(pos, "street"))
		assert.equals(200, citygen.mapdata.get_attribute(pos, "x"))
	end)
end)

