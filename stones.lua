local mosstexture = "default_moss.png"
local mosstextureside = "default_moss_side.png"

--function to make stones

local function register_stone(name, cracky)
    local texture = name .. ".png"
    local texture_with_moss_side = texture .. "^" .. mosstextureside
    local texture_mossy = texture.."^cavelayermoss3.png"
    core.register_node("cavelayers:" .. name, {
        description = name:gsub("^%l", string.upper),
        tiles = {texture},
        groups = {cracky = cracky, stone = 1},
        sounds = default.node_sound_stone_defaults(),
    })
    core.register_node("cavelayers:"..name.."_with_moss", {
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
    core.register_node("cavelayers:mossy_" .. name, {
        description = "Mossy " .. name:gsub("^%l", string.upper),
        tiles = {texture_mossy},
        groups = {cracky = cracky, stone = 1},
        sounds = default.node_sound_stone_defaults(),
    })
end

register_stone("arcane_stone", 3)
register_stone("deepstone", 3)

core.register_node("cavelayers:mossy_stone", {
    description = "Mossy Stone",
    tiles = {"default_stone.png^cavelayermoss3.png"},
    groups = {cracky = 3, stone = 1},
    sounds = default.node_sound_stone_defaults(),
    drop = "default:mossycobble"
})

local graveldata = core.registered_nodes["default:gravel"]
local newgraveldata = table.copy(graveldata)
newgraveldata.tiles = {"default_gravel.png^cavelayermoss3.png"}
newgraveldata.description = "Mossy Gravel"
core.register_node("cavelayers:mossy_gravel", newgraveldata)

local stalactitenodeboxes = {
    [1] = {
	    type = "fixed",
	    fixed = {
		    {-0.5000, -0.5000, -0.5000, 0.5000, 0.5000, 0.5000}
	    }
    },
    [2] = {
	    type = "fixed",
	    fixed = {
		    {-0.4375, -0.5000, -0.4375, 0.4375, 0.5000, 0.4375}
	    }
    },
    [3] = {
        type = "fixed",
        fixed = {
            {-0.3750, -0.5000, -0.3750, 0.3750, 0.5000, 0.3750}
        }
    },
    [4] = {
        type = "fixed",
        fixed = {
            {-0.3125, -0.5000, -0.3125, 0.3125, 0.5000, 0.3125}
        }
    },
    [5] = {
        type = "fixed",
        fixed = {
            {-0.2500, -0.5000, -0.2500, 0.2500, 0.5000, 0.2500}
        }
    },
    [6] = {
        type = "fixed",
        fixed = {
            {-0.1875, -0.5000, -0.1875, 0.1875, 0.5000, 0.1875}
        }
    },
    [7] = {
        type = "fixed",
        fixed = {
            {-0.1250, -0.5000, -0.1250, 0.12500, 0.50000, 0.12500}
        }
    },
    [8] = {
        type = "fixed",
        fixed = {
            {-0.0625, -0.50000, -0.0625,  0.0625,  0.50000,  0.0625}
        }
    },
}
cavelayers.pillars = {}
local function register_pillar(name, desc, nodename)
    local nodedata = core.registered_nodes[nodename]
    if not nodedata then
        error("Node " .. nodename .. " not found for pillar " .. name)
    end
    local groups = nodedata.groups
    local drop = nodedata.drop
    local sounds = nodedata.sounds
    local tiles = nodedata.tiles
    for i = 1, 8 do
        core.register_node("cavelayers:"..name.."_"..i, {
            description = desc .. " " .. i,
            drawtype = "nodebox",
            paramtype = "light",
            paramtype2 = "facedir",
            groups = groups,
            sounds = sounds,
            tiles = tiles,
            drop = drop,
            node_box = stalactitenodeboxes[i],
        })
    end
    for i = 1, 8 do 
        local contentid = core.get_content_id("cavelayers:"..name.."_"..i)
        local prevcontentid, prevcontentid2, nextcontentid, nextcontentid2
        if i ~= 1 then
            prevcontentid = core.get_content_id("cavelayers:"..name.."_"..(i-1))
            if i ~= 2 then
                prevcontentid2 = core.get_content_id("cavelayers:"..name.."_"..(i-2))
            end
        end
        if i ~= 8 then
            nextcontentid = core.get_content_id("cavelayers:"..name.."_"..(i+1))
            if i ~= 7 then
                nextcontentid2 = core.get_content_id("cavelayers:"..name.."_"..(i+2))
            end
        end
        if i == 1 then
            cavelayers.pillars[contentid] = {[1] = nextcontentid}
        elseif i == 8 then
            cavelayers.pillars[contentid] = {[-1] = prevcontentid}
        elseif i == 2 then
            cavelayers.pillars[contentid] = {[1] = nextcontentid, [2] = nextcontentid2, [-1] = prevcontentid}
        elseif i == 7 then
            cavelayers.pillars[contentid] = {[1] = nextcontentid, [-1] = prevcontentid, [-2] = prevcontentid2}
        else
            cavelayers.pillars[contentid] = {[1] = nextcontentid, [2] = nextcontentid2, [-1] = prevcontentid, [-2] = prevcontentid2}
        end
    end
end
register_pillar("stone_pillar", "Stone Pillar", "default:stone")
register_pillar("arcane_stone_pillar", "Arcane Stone Pillar", "cavelayers:arcane_stone")
register_pillar("deepstone_pillar", "Deepstone Pillar", "cavelayers:deepstone")
register_pillar("mossy_stone_pillar", "Mossy Stone Pillar", "cavelayers:mossy_stone")
register_pillar("cobble_pillar", "Cobblestone Pillar", "default:cobble")
register_pillar("mossy_cobble_pillar", "Mossy Cobblestone Pillar", "default:mossycobble")