cavelayers = {}
--liquids do not work with caves 
core.set_mapgen_setting("mgv7_large_cave_flooded", "0", true)
--dungeons bad for caves as well
core.set_mapgen_setting("mgv7_dungeon_ymax", "-31000", true)


--offsets where caves start spawning
local y_offset = 0

--registers the stones
dofile(minetest.get_modpath("cavelayers") .. "./stones.lua")
--registers the plants
dofile(minetest.get_modpath("cavelayers") .. "./plants.lua")

--contentids
local c_sand = core.get_content_id("default:sand")
local c_gravel = core.get_content_id("default:gravel")
local c_dirt = core.get_content_id("default:dirt")
local c_water = core.get_content_id("default:water_source")
local c_silver_sand = core.get_content_id("default:silver_sand")
local c_stone = core.get_content_id("mapgen_stone")
local c_mossy_cobble = core.get_content_id("default:mossycobble")
local c_cobble = core.get_content_id("default:cobble")
local stones = {c_stone, c_mossy_cobble, c_cobble}
local c_arcane_stone = core.get_content_id("cavelayers:arcane_stone")
local c_air = core.get_content_id("air")
local c_permafrost = core.get_content_id("default:permafrost")
local c_permafrost_with_moss = core.get_content_id("default:permafrost_with_moss")
local c_deepstone = core.get_content_id("cavelayers:deepstone")
local c_slab_mossycobble = core.get_content_id("stairs:slab_mossycobble")
local c_slab_cobble = core.get_content_id("stairs:slab_cobble")
local c_mossy_stone = core.get_content_id("cavelayers:mossy_stone")
local c_sandstone = core.get_content_id("default:sandstone")
local c_silver_sandstone = core.get_content_id("default:silver_sandstone")
local c_mossy_gravel = core.get_content_id("cavelayers:mossy_gravel")
local c_stone_pillar_1 = core.get_content_id("cavelayers:stone_pillar_1")
local c_arcane_stone_pillar_1 = core.get_content_id("cavelayers:arcane_stone_pillar_1")
local c_deepstone_pillar_1 = core.get_content_id("cavelayers:deepstone_pillar_1")
local c_mossy_stone_pillar_1 = core.get_content_id("cavelayers:mossy_stone_pillar_1")
local c_cobble_pillar_1 = core.get_content_id("cavelayers:cobble_pillar_1")
local c_mossy_cobble_pillar_1 = core.get_content_id("cavelayers:mossy_cobble_pillar_1")
--layer 2
local c_lush_moss = core.get_content_id("cavelayers:lush_moss")
local c_lush_moss_carpet = core.get_content_id("cavelayers:lush_moss_carpet")
local c_lush_vine = core.get_content_id("cavelayers:lush_vine")
local c_lush_vine_large = core.get_content_id("cavelayers:lush_vine_large")
local c_glowing_vine = core.get_content_id("cavelayers:glowing_vine")
local c_water_flowing = core.get_content_id("default:water_flowing")
local c_clay = core.get_content_id("default:clay")
local c_heavy_moss = core.get_content_id("cavelayers:heavy_moss")
local c_lava = core.get_content_id("default:lava_source")
local c_lava_flowing = core.get_content_id("default:lava_flowing")
local c_river_water = core.get_content_id("default:river_water_source")
--random number generator
local seed = 99
local pr = PseudoRandom(seed)

--stones for layer 1
local stones = {c_stone, c_mossy_cobble, c_cobble, c_mossy_stone}
local floorstones = {c_slab_mossycobble, c_slab_cobble, c_mossy_stone, c_mossy_cobble}
--stalactites for layer 1
local stalactites1 = {c_stone_pillar_1, c_mossy_stone_pillar_1, c_cobble_pillar_1, c_mossy_cobble_pillar_1,
}
--function to get a random node from a list of nodes
local function randomstone(stones)
    return stones[pr:next(1, #stones)]
end

local nodestoreplacewithstone = {
    [c_dirt] = true,
    [c_stone] = true,
    [c_silver_sand] = true,
}

local mossycavestones = {
    [c_mossy_gravel] = true,
    [c_mossy_stone] = true,
    [c_cobble] = true,
    [c_stone] = true,
    [c_mossy_stone] = true,
    [c_gravel] = true,
}
local maxy = 100

local function findcavelayer(y)
    local layer = math.floor((y + pr:next(-3, 3) + y_offset) / -200) + 1
    return layer
end
--mossy cave replacement functions
local mossycavesreplace = {
    [c_gravel] = function(c_1up, c_1down)
        local num = pr:next(1, 2)
        if num == 2 then
            return c_mossy_gravel
        end
    end,
    [c_stone] = function(c_1up, c_1down)
        if c_1up == c_air then
            return randomstone(floorstones)
        elseif c_1down == c_air then
            local randomnum = pr:next(1, 10)
            if randomnum == 1 then
                return randomstone(stalactites1)
            else
                return randomstone(stones)
            end
        else
            return randomstone(stones)
        end
    end,
    [c_dirt] = function(c_1up, c_1down)
        if c_1up == c_air then
            return randomstone(floorstones)
        else
            return randomstone(stones)
        end
    end,
    [c_silver_sand] = function(c_1up, c_1down)
        if c_1up == c_air then
            return randomstone(floorstones)
        else
            return randomstone(stones)
        end
    end,
    [c_air] = function(c_1up, c_1down)
        if mossycavestones[c_1up] then
        end
    end,
    [c_sand] = function(c_1up, c_1down)
        if c_1up == c_air then
            return randomstone(floorstones)
        else
            if c_1up == c_water then
                local num = pr:next(1, 2)
                if num == 2 then
                    return c_sandstone
                end
            else
                return randomstone(stones)
            end
        end
    end,
    [c_lava] = function(c_1up, c_1down)
        return c_air
    end,
    [c_lava_flowing] = function(c_1up, c_1down)
        return c_air
    end,
}
local function progress_stalactite(vi, data, vi1up, vi1down)
    local node = data[vi]
    local nodeabove = data[vi1up]
    if node == c_air then
        if cavelayers.pillars[nodeabove] and cavelayers.pillars[nodeabove][1] then
            local num = pr:next(1, 2)
            local nextnode = cavelayers.pillars[nodeabove][num]
            local nextnode1
            if data[vi1down] ~= c_air and data[vi1down] ~= c_water then
                nextnode1 = cavelayers.pillars[nodeabove][-num]
            end
            if nextnode1 then
                data[vi] = nextnode1
            elseif nextnode then
                data[vi] = nextnode
            end
        end
    end
end

local mossiercavesvines = {
    [c_lush_vine] = true,
    [c_lush_vine_large] = true,
    [c_glowing_vine] = true,
}
local mossycavesbasicallyair = {
    [c_air] = true,
    [c_water] = true,
    [c_water_flowing] = true,
    [c_lava] = true,
    [c_lava_flowing] = true,
}
local mossiercavesfloor = {c_heavy_moss, c_lush_moss}
local mossiercavesreplaceair = function(c_1up, c_1down)
    if c_1up == c_lush_moss and c_1down == c_air then
        local num = pr:next(1, 21)
        if num == 1 then
            return c_glowing_vine
        elseif num <= 4 then
            return c_lush_vine_large
        elseif num <=6 then
            return c_lush_vine
        else 
            return c_air
        end
    end
    if mossiercavesvines[c_1up] and mossycavesbasicallyair[c_1down] then
        local num = pr:next(1, 10)
        if num > 1 then
            return c_1up
        end
    end
    return c_air
end

local mossiercavesreplace = {
    [c_stone] = function(c_1up, c_1down)
        if mossycavesbasicallyair[c_1up] then
            return randomstone(mossiercavesfloor)
        elseif mossycavesbasicallyair[c_1down] then
            return c_lush_moss
        elseif c_1up == c_river_water then
            return c_clay
        else
            return randomstone(stones)
        end
    end,
    [c_air] = function(c_1up, c_1down)
        return mossiercavesreplaceair(c_1up, c_1down)
    end,
    [c_water] = function(c_1up, c_1down)
        return mossiercavesreplaceair(c_1up, c_1down)
    end,
    [c_water_flowing] = function(c_1up, c_1down)
        return mossiercavesreplaceair(c_1up, c_1down)
    end,
    [c_lava] = function(c_1up, c_1down)
        return mossiercavesreplaceair(c_1up, c_1down)
    end,
    [c_lava_flowing] = function(c_1up, c_1down)
        return mossiercavesreplaceair(c_1up, c_1down)
    end,
    [c_silver_sand] = function(c_1up, c_1down)
        return c_clay
    end,
    [c_gravel] = function(c_1up, c_1down)
        return c_clay
    end,

    
}
local layers = {
    --mossy caves
    [1] = function(data, area, x, y, z)
        local vi = area:index(x, y, z)
        local vi1up = area:index(x, y + 1, z)
        local vi1down = area:index(x, y - 1, z)
        local c_1up = data[vi1up]
        local c_1down = data[vi1down]
        data[vi] = mossycavesreplace[data[vi]] and mossycavesreplace[data[vi]](c_1up, c_1down) or data[vi]
        if cavelayers.pillars[data[vi1up]] then
            progress_stalactite(vi, data, vi1up, vi1down)
        end
    end,
    --mossier caves
    [2] = function(data, area, x, y, z)
        local vi = area:index(x, y, z)
        local vi1up = area:index(x, y + 1, z)
        local vi1down = area:index(x, y - 1, z)
        local c_1up = data[vi1up]
        local c_1down = data[vi1down]
        data[vi] = mossiercavesreplace[data[vi]] and mossiercavesreplace[data[vi]](c_1up, c_1down) or data[vi]
        if c_1down == c_stone and c_1up == c_air then
            local vi1 = area:index(x+1, y, z)
            local vi2 = area:index(x-1, y, z)
            local vi3 = area:index(x, y, z+1)
            local vi4 = area:index(x, y, z-1)
            local c_1up = data[vi1]
            local c_2up = data[vi2]
            local c_3up = data[vi3]
            local c_4up = data[vi4]
            if not mossycavesbasicallyair[c_1up] and not mossycavesbasicallyair[c_2up] and not mossycavesbasicallyair[c_3up] and not mossycavesbasicallyair[c_4up] then
            data[vi] = c_river_water
            end 
        end
    end,
}
core.register_on_generated(function(minp, maxp, seed)

    local vm, emin, emax = core.get_mapgen_object("voxelmanip")

    local area = VoxelArea:new({
        MinEdge = emin,
        MaxEdge = emax
    })

    local data = vm:get_data()
    if maxp.y > maxy or minp.y > maxy then
        return
    end
    for z = minp.z, maxp.z do
        for y = maxp.y, minp.y, -1 do
            if y < 0 then
                local layer = findcavelayer(y)
                for x = minp.x, maxp.x do
                    if layers[layer] then
                        layers[layer](data, area, x, y, z)
                    end
                end
            end
        end
    end
    vm:set_data(data)
    vm:update_liquids()
    vm:calc_lighting()
    vm:write_to_map()
end)