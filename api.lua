
local HUD_POSITION = {x = 0.05, y = 0.3}
local HUD_ALIGNMENT = {x = 1, y = 0}
local HUD_Y_OFFSET = 0

-- itemname => true
local items_with_effects = {}

food_effects.register = function(foodname, monoid, value, seconds, enable_hud)

	items_with_effects[foodname] = true

	-- playername -> timeout
	local data = {}
	-- playername -> {}
	local hud = {}
	local hud_image = ""

	if enable_hud then

		local itemdef = minetest.registered_items[foodname]
		hud_image = itemdef.inventory_image

		minetest.register_on_joinplayer(function(player)
			local hud_data = {}
			hud[player:get_player_name()] = hud_data

			hud_data.time = player:hud_add({
		    hud_elem_type = "text",
		    position = HUD_POSITION,
		    offset = {x = 0,   y = 0 + HUD_Y_OFFSET},
		    text = "",
		    alignment = HUD_ALIGNMENT,
		    scale = {x = 100, y = 100},
		    number = 0x00FF00
		  })

			hud_data.img = player:hud_add({
		    hud_elem_type = "image",
		    position = HUD_POSITION,
		    offset = {x = -32,   y = -8 + HUD_Y_OFFSET},
		    text = "",
		    alignment = HUD_ALIGNMENT,
		    scale = {x = 2, y = 2},
		  })

			HUD_Y_OFFSET = HUD_Y_OFFSET + 24

		end)

		minetest.register_on_leaveplayer(function(player)
			hud[player:get_player_name()] = nil
		end)
	end

	local timer = 0
	minetest.register_globalstep(function(dtime)
		timer = timer + dtime
		if timer < 0.2 then
			return
		end
		timer = 0

		for playername in pairs(data) do
			local time = data[playername]
			time = time - 0.2

			local player = minetest.get_player_by_name(playername)

			if time < 0 then
				time = nil
				if enable_hud then
					local hud_data = hud[playername]
					player:hud_change(hud_data.time, "text", "")
					player:hud_change(hud_data.img, "text", "")
				end
				if player then
					monoid:del_change(player, foodname)

					minetest.sound_play("food_effects_out", {
						to_player = player:get_player_name(),
						gain = 0.7
					})
				end
			elseif enable_hud then
				local hud_data = hud[playername]
				player:hud_change(hud_data.time, "text", math.floor(time*10)/10 .. " s")
				player:hud_change(hud_data.img, "text", hud_image)
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

minetest.register_on_item_eat(function(_, _, itemstack, player)
	local name = itemstack:get_name()
	local has_effect = items_with_effects[name]

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
