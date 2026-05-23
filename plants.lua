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
    core.register_craft({
        type = "shapeless",
        output = "cavelayers:"..name.."_carpet 8",
        recipe = {"cavelayers:"..name},
    })
end
local function register_vine(name, desc, tiles, selectionbox)
    if not selectionbox then
        selectionbox = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
            }
        }
    end
    core.register_node("cavelayers:"..name, {
        inventory_image = tiles[1],
        description = desc,
        drawtype = "plantlike",
        paramtype = "light",
        selection_box = selectionbox,
        groups = {snappy = 3},
        sounds = default.node_sound_leaves_defaults(),
        tiles = tiles,
        walkable = false,
        climbable = true,
        
    })
end
register_moss("jungle_moss", "Jungle Moss", {"cavelayersjunglemoss.png"})
register_moss("lush_moss", "Lush Moss", {"cavelayerslushmoss.png"})
register_vine("lush_vine", "Lush Vine", {"cavelayerslushvine.png"}, {
	type = "fixed",
	fixed = {
		{-0.2500, -0.5000, -0.2500, 0.2500, 0.5000, 0.2500}
	}
})