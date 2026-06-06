minetest.register_node("cavelayers:swamp_water_source", {
	description = "Swamp Water Source",
	drawtype = "liquid",
	waving = 1,
	tiles = {
		{
			name = "default_water_source_animated.png^[colorize:#2a5a0f:210", -- Heavy algae green overlay
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "default_water_source_animated.png^[colorize:#2a5a0f:210",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 2,
	liquidtype = "source",
	liquid_alternative_flowing = "cavelayers:swamp_water_flowing",
	liquid_alternative_source = "cavelayers:swamp_water_source",
	liquid_viscosity = 3,
	post_effect_color = {a = 150, r = 25, g = 65, b = 10}, -- Much greener, more opaque underwater view
	groups = {water = 3, liquid = 3, cools_lava = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("cavelayers:swamp_water_flowing", {
	description = "Flowing Swamp Water",
	drawtype = "flowingliquid",
	waving = 1,
	tiles = {"default_water.png^[colorize:#2a5a0f:210"},
	special_tiles = {
		{
			name = "default_water_flowing_animated.png^[colorize:#2a5a0f:210",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "default_water_flowing_animated.png^[colorize:#2a5a0f:210",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "cavelayers:swamp_water_flowing",
	liquid_alternative_source = "cavelayers:swamp_water_source",
	liquid_viscosity = 3,
	post_effect_color = {a = 150, r = 25, g = 65, b = 10},
	groups = {water = 3, liquid = 3, not_in_creative_inventory = 1, cools_lava = 1},
	sounds = default.node_sound_water_defaults(),
})
