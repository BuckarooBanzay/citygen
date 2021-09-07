
-- disable mapblock sending optimization
-- the optimization does somehow not work with aligned full/empty(air) mapblocks
-- and resulted in weird unloaded areas in the distance
-- <insert rant about minetest emerge/loading mess here>
minetest.settings:set("block_send_optimize_distance", minetest.settings:get("max_block_send_distance"))
