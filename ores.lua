core.register_node("cavelayers:stone_with_swamp_mineral", {
	description = "Swamp Mineral Ore",
	tiles = {"default_stone.png^cavelayers_swamp_mineral.png"},
	groups = {cracky = 1},
	sounds = default.node_sound_stone_defaults(),
    drop = "cavelayers:swamp_ore"
})
core.register_craftitem("cavelayers:swamp_ore", {
    description = "Swamp Ore",
    inventory_image = "cavelayers_swamp_ore.png"
})