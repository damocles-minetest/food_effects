
minetest.register_on_item_eat(function(_, _, itemstack, player)
	local name = itemstack:get_name()
	local has_effect = food_effects.items_with_effects[name]

	if has_effect then
		-- effect sound
		minetest.sound_play("food_effects_spell", {
			to_player = player:get_player_name(),
			gain = 0.7
		})

	else
		-- eat sound
		minetest.sound_play("stamina_eat", {
			to_player = player:get_player_name(),
			gain = 0.7
		})

	end
end)
