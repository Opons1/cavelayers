core.register_tool("cavelayers:swamp_knife", {
    description = "Swamp Knife",
    inventory_image = "cavelayers_swamp_knife.png",
    range = 2,
    tool_capabilities = {
        full_punch_interval = 0.3,
        max_drop_level = 0,
        groupcaps = {
            vines = {times = {[1] = 0.3, [2] = 0.2, [3] = 0.1}, uses = 20, maxlevel = 1},
        },
        damage_groups = {fleshy = 5},
    },
    	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "object" then
			local target = pointed_thing.ref
			-- Check if the target is an actual player entity
			if target:is_player() then
				statuseffect_monoids.apply_poison(target, 2, 5)
				-- Play an optional punch sound effect
				core.sound_play("player_damage", {
					pos = target:get_pos(),
					gain = 0.5,
				}, true)
			end
		end
	end,
})