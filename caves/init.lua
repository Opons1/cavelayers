local function df(name)
    dofile(core.get_modpath("cavelayers").."/caves/"..name)
end
df("layer3.lua")