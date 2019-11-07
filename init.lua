
local MP = minetest.get_modpath("food_effects")

food_effects = {
  HUD_POSITION = {x = 0.05, y = 0.3},
  HUD_ALIGNMENT = {x = 1, y = 0},
  HUD_Y_OFFSET = 0
}

dofile(MP.."/eye_height_monoid.lua")
dofile(MP.."/api.lua")
dofile(MP.."/register.lua")
