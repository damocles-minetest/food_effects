
local has_hudbars = minetest.get_modpath("hudbars")

food_effects.register = function(foodname, monoid, value, seconds, enable_hud)

	-- playername -> timeout
	local data = {}
	enable_hud = enable_hud and has_hudbars

	if enable_hud then

		local itemdef = minetest.registered_items[foodname]
		local image = itemdef.inventory_image

	        hb.register_hudbar(foodname, 0xFFFFFF, "XP", {
			icon = image,
			bgicon = "hudbars_bar_background.png",
			bar = "hudbars_bar_breath.png"
		}, 0, 10, false)


		minetest.register_on_joinplayer(function(player)
			hb.init_hudbar(player, foodname, 0, 10, true)
		end)
	end

	local timer = 0
	minetest.register_globalstep(function(dtime)
		timer = timer + dtime
		if timer < 1 then
			return
		end
		timer = 0

		for playername in pairs(data) do
			local time = data[playername]
			time = time - dtime

			local player = minetest.get_player_by_name(playername)

			if time < 0 then
				time = nil
				hb.change_hudbar(player, foodname, 0)
				if player then
					monoid:del_change(player, foodname)
				end
			else
				hb.change_hudbar(player, foodname, time)
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



