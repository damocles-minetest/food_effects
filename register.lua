

food_effects.register("farming:coffee_cup", player_monoids.speed, 2, 10, true)
food_effects.register("flowers:mushroom_brown", player_monoids.jump, 2, 10, true)

food_effects.register("flowers:mushroom_red", player_monoids.visual_size, {x=2, y=2}, 15, true)
food_effects.register("flowers:mushroom_red", player_monoids.collisionbox, {x=2, y=2, z=2}, 15)
food_effects.register("flowers:mushroom_red", food_effects.eye_height_monoid, 2, 15)

food_effects.register("farming:peas", player_monoids.visual_size, {x=0.3, y=0.3}, 15, true)
food_effects.register("farming:peas", player_monoids.collisionbox, {x=0.3, y=0.3, z=0.3}, 15)
food_effects.register("farming:peas", food_effects.eye_height_monoid, 0.3, 15)
