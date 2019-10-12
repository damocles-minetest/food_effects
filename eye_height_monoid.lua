
local function mult(x, y) return x * y end

local function mult_fold(elems)
	local tot = 1

	for _, v in pairs(elems) do
		tot = tot * v
	end

	return tot
end

food_effects.eye_height_monoid = player_monoids.make_monoid({
	combine = mult,
	fold = mult_fold,
	identity = 1,
	apply = function(multiplier, player)
    player:set_properties({
			eye_height = 1.625 * multiplier
		})
	end,
})
