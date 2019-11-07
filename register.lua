

food_effects.register("farming:coffee_cup", player_monoids.speed, 2, 10, true)
food_effects.register("flowers:mushroom_brown", player_monoids.jump, 2, 10, true)

food_effects.register("flowers:mushroom_red", player_monoids.visual_size, {x=2, y=2}, 15, true)
food_effects.register("flowers:mushroom_red", player_monoids.collisionbox, {x=2, y=2, z=2}, 15)
food_effects.register("flowers:mushroom_red", food_effects.eye_height_monoid, 2, 15)

food_effects.register("farming:peas", player_monoids.visual_size, {x=0.3, y=0.3}, 15, true)
food_effects.register("farming:peas", player_monoids.collisionbox, {x=0.3, y=0.3, z=0.3}, 15)
food_effects.register("farming:peas", food_effects.eye_height_monoid, 0.3, 15)

food_effects.register_callback("farming:garlic", 10, true, function(player)
  local pos = player:get_pos()
  local objs = minetest.get_objects_inside_radius(pos, 4)

  for _, obj in ipairs(objs) do
    local ent = obj:get_luaentity()

    if ent and ent.name and obj.punch and not ent.passive and ent.type == "monster" then
      obj:punch(player, 1.0, {
        full_punch_interval = 1.0,
        damage_groups= {fleshy = 3},
      })

      return
    end
  end
end)
