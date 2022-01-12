require("mineunit")

mineunit("core")
mineunit("player")
mineunit("default/functions")

sourcefile("spec/common")
sourcefile("init")

describe("layout_class", function()
	it("creates a new entry", function()
		local layout = citygen.new_layout()
		layout:set_name(1,1, "myname")
		local entry = layout:get_entry(1,1)
		assert.equals(true, entry.names["myname"])
	end)
end)

