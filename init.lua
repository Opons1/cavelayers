cavelayers = {}
dofile(minetest.get_modpath("cavelayers") .. "./stones.lua")
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
local stones = {c_stone, c_mossy_cobble, c_cobble}
local seed = 99
local PsuedoRandom = PseudoRandom(seed)
local c_slab_mossycobble = core.get_content_id("stairs:slab_mossycobble")
local c_slab_cobble = core.get_content_id("stairs:slab_cobble")

local function randomstone()
    return stones[PsuedoRandom:next(1, #stones)]
end

local nodestoreplacewithstone = {
    [c_dirt] = true,
    [c_stone] = true,
    [c_silver_sand] = true,
    [c_sand] = true,
    [c_gravel] = true,
}
core.register_on_generated(function(minp, maxp, seed)

    local vm, emin, emax = core.get_mapgen_object("voxelmanip")

    local area = VoxelArea:new({
        MinEdge = emin,
        MaxEdge = emax
    })

    local data = vm:get_data()

    for z = minp.z, maxp.z do
        for y = minp.y, maxp.y do
            for x = minp.x, maxp.x do
                local vi = area:index(x, y, z)
                local vi1up = area:index(x, y + 1, z)
                local vi1down = area:index(x, y - 1, z)
                if y <= 100 then
                    if nodestoreplacewithstone[data[vi]] then
                        if data[vi1up] == c_air then
                            local randomnum = PsuedoRandom:next(1, 4)
                            if randomnum == 1 then
                                data[vi1up] = c_slab_mossycobble
                            elseif randomnum == 2 then
                                data[vi1up] = randomstone()
                            elseif randomnum == 3 then
                                data[vi1up] = c_slab_cobble
                            elseif randomnum == 4 then
                                data[vi1up] = c_mossy_cobble
                            end
                        elseif data[vi1down] == c_air then
                            local chance = PsuedoRandom:next(1, 7)
                            if chance == 1 then
                                local length = PsuedoRandom:next(1, 5)
                                data[vi] = randomstone()
                                for i = 1, length do
                                    local vidown = area:index(x, y - i, z)
                                    if data[vidown] == c_air then
                                        data[vidown] = randomstone()
                                    end
                                end
                            else 
                                data[vi] = c_air
                            end
                        end
                        data[vi] = randomstone()
                    end
                end
            end
        end
    end

    vm:set_data(data)
    vm:write_to_map()
end)