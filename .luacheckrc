
globals = {
	"citygen",
	minetest = {
		fields = {
			-- mocked in testing
			"get_mapgen_setting"
		}
	}
}

read_globals = {
	-- Stdlib
	string = {fields = {"split"}},
	table = {fields = {"copy", "getn"}},

	-- Minetest
	"vector", "ItemStack",
	"dump", "VoxelArea",

	-- deps
	"minetest",
	"mapblock_lib",

	-- testing
	"mineunit", "sourcefile"
}
