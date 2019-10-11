

food_effects.register = function(foodname, monoid, value, seconds)

	-- playername -> timeout
	local data = {}

	minetest.register_globalstep(function(dtime)
		for playername in pairs(data) do
			local time = data[playername]
			time = time - dtime

			if time < 0 then
				time = nil
				local player = minetest.get_player_by_name(playername)
				if player then
					monoid:del_change(player, foodname)
				end
			end
			data[playername] = time
		end
	end)


	minetest.register_on_item_eat(function(_, _, itemstack, player)
		local name = itemstack:get_name()
		if name == foodname then
			monoid:add_change(player, value, foodname)
			data[player:get_player_name()] = seconds
		end
	end)
end



