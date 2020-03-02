
minetest.log("warning", "[TEST] integration-test enabled!")

local function shutdown_success()
	local data = minetest.write_json({ success = true }, true);
	local file = io.open(minetest.get_worldpath().."/integration_test.json", "w" );
	if file then
		file:write(data)
		file:close()
	end

	minetest.log("warning", "[TEST] integration tests done!")
	minetest.request_shutdown("success")
end

minetest.register_on_mods_loaded(function()
	local origin = {x=0, y=0, z=0}
	minetest.emerge_area(vector.subtract(origin, 100), vector.add(origin, 100), function(blockpos, _, calls_remaining)
		minetest.log("action", "Emerged: " .. minetest.pos_to_string(blockpos))
		if calls_remaining == 0 then
			shutdown_success()
		end
	end)
end)
