local function register_moss(name, desc, tiles)
    core.register_node("cavelayers:"..name, {
        description = desc,
        --can be dug with fist
        groups = {crumbly = 3},
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
local function register_vine(name, desc, tiles, data)
    if not data then
        data = {}
    end
    if not data.light_source then
        data.light_source = 0
    end
    if not data.selection_box then
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
        selection_box = data.selection_box,
        groups = {snappy = 3, vines = 1},
        sounds = default.node_sound_leaves_defaults(),
        tiles = tiles,
        walkable = false,
        climbable = true,
        light_source = data.light_source,
    })
end
core.register_abm({
    label = "Cavelayer Vine Growth",
    nodenames = {"group:vines"},
    interval = 60,
    chance = 10,
    action = function(pos, node)
        local below = {x = pos.x, y = pos.y - 1, z = pos.z}
        local belownode = core.get_node(below)
        if belownode and belownode.name == "air" then
            core.set_node(below, {name = node.name})
        end
    end,
})
register_moss("jungle_moss", "Jungle Moss", {"cavelayersjunglemoss.png"})
register_moss("lush_moss", "Lush Moss", {"cavelayerslushmoss.png"})
register_moss("heavy_moss", "Heavy Moss", {"default_moss.png"})
register_moss("swampy_moss", "Swampy Moss", {"cavelayersswampymoss.png"})
register_vine("lush_vine", "Lush Vine", {"cavelayerslushvine.png"}, {selection_box = {
    type = "fixed",
    fixed = {
        {-0.2500, -0.5000, -0.2500, 0.2500, 0.5000, 0.2500}
    }
}})
register_vine("lush_vine_large", "Lush Vine Large", {"cavelayerslushvinelarge.png"})
register_vine("glowing_vine", "Glowing Vine", {"cavelayersglowingvine.png"}, {light_source = 12})
register_vine("jungle_vine", "Jungle Vine", {"cavelayersjunglevine.png"})