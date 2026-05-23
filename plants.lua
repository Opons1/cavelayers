local function register_moss(name, desc, tiles)
    core.register_node("cavelayers:"..name, {
        description = desc,
        --can be dug with fist
        groups = {crumbly = 3, falling_node = 1},
        sounds = default.node_sound_dirt_defaults(),
        tiles = tiles,
    })
    core.register_node("cavelayers:"..name.."_carpet", {
    node_box = {
	    type = "fixed",
	    fixed = {
		    {-0.5000, -0.5000, -0.5000, 0.5000, -0.4375, 0.5000}
	    }
    },
        drawtype = "nodebox",
        paramtype = "light",
        paramtype2 = "facedir",
        description = desc.." Carpet",
        groups = {crumbly = 3, falling_node = 1},
        sounds = default.node_sound_dirt_defaults(),
        tiles = tiles,
    })
end
register_moss("cavelayermoss1", "Cave Moss 1", {"cavelayerjunglemossblock.png"})