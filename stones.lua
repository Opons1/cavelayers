local mosstexture = "default_moss.png"
local mosstextureside = "default_moss_side.png"

local function register_stone(name, cracky)
    local texture = name .. ".png"
    local texture_with_moss_side = texture .. "^" .. mosstextureside
    core.register_node("cavelayers:" .. name, {
        description = name:gsub("^%l", string.upper),
        tiles = {texture},
        groups = {cracky = cracky, stone = 1},
        sounds = default.node_sound_stone_defaults(),
    })
    core.register_node("cavelayers:"..name.."_with_modd", {
        description = name:gsub("^%l", string.upper) .. " With Moss",
        --top is moss texture, sides is normal + moss on top, bottom is normal
        tiles = {
            mosstexture,
            texture,
            texture_with_moss_side,
            texture_with_moss_side,
            texture_with_moss_side,
            texture_with_moss_side
        },
    })
end
register_stone("arcane_stone", 3)
register_stone("deepstone", 3)