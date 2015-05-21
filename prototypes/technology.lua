-- taken and modified from "LeonsAutomatedUpgradeGeneration" mod

require("config")

----------------------------------------------------------------------------------------------------
-- Variables
----------------------------------------------------------------------------------------------------

maxlevels = MaxInventoryUpgrades                        -- Maximum upgrade-level.
pack_r = 1												-- Necessary RED science packs per research-cycle for the first upgrades.
pack_g = 0												-- Necessary GREEN science packs per research-cycle for the first upgrades.
pack_b = 0												-- Necessary BLUE science packs per research-cycle for the first upgrades.
pack_a = 0												-- Necessary ALIEN science packs per research-cycle for the first upgrades.
countstart_pack = 2										-- See below in 'Main'-part.
countstart_level = 3									-- See below in 'Main'-part. 
packmarker = countstart_pack							-- See below in 'Main'-part.

upg_names_prefix = "inventory-upgrade-"					-- Upgrade name prefix.
upg_icon = "__InventoryUpgrade__/graphics/technology/inv_upgrade.png"
upg_order = "a[inventory]"								-- Order in science-screen.

upg_stageusage = false									-- Should this upgrades have a stagesystem with additional prerequisitions?
upg_stage0modbound = 0.15								-- Edge to stage 1: if modifier is graeter than this value.
upg_stage1reached = false								-- First stage reached and required prerequisition demanded?
upg_stage1prereq = "alien-technology"					-- Needed prerequisition for stage 1.
upg_stage1modbound = 99									-- Edge to stage 1: if modifier is graeter than this value.
upg_stage2reached = false								-- Second Stage reached and required prerequisition demanded?
upg_stage2prereq = "combat-robotics-3"					-- Needed prerequisition for stage 2.



function makeInventoryUpgradeTech (f_level, f_pack_red, f_pack_green, f_pack_blue, f_pack_alien, f_modifier)
    local f_name = string.format("%s%i", upg_names_prefix, f_level)
    local f_result = 
    {
        type = "technology",
        name = f_name,
        icon = upg_icon,
        unit =
		{
			ingredients = {},
			time = 0
		},
        upgrade = "true",
        order = upg_order,
    }
    
    f_result.unit.time = f_level * 20
                                        -- Calculates number of research-cycles 10^(level-1)
    f_result.unit.count = 10 * math.pow(IncreasingFactor, f_level -1)
    
                                        -- Generates prerequisites
	if f_level > 1 then
		f_result.prerequisites = {upg_names_prefix .. (f_level - 1)}
		if upg_stageusage then
			if (f_modifier > upg_stage0modbound) and not upg_stage1reached then
				f_result.prerequisites[#f_result.prerequisites + 1] = upg_stage1prereq
				upg_stage1reached = true
			elseif  (f_modifier > upg_stage1modbound) and not upg_stage2reached then
				f_result.prerequisites[#f_result.prerequisites + 1] = upg_stage2prereq
				upg_stage2reached = true
			end
		end
	end
    if f_pack_red > 0 then
		table.insert(f_result.unit.ingredients, {"science-pack-1", f_pack_red})
	end
	if f_pack_green > 0 then
		table.insert(f_result.unit.ingredients, {"science-pack-2", f_pack_green})
	end
	if f_pack_blue > 0 then
		table.insert(f_result.unit.ingredients, {"science-pack-3", f_pack_blue})
	end
	if f_pack_alien > 0 then
		table.insert(f_result.unit.ingredients, {"alien-science-pack", f_pack_alien})
	end
    
    return f_result
end


----------------------------------------------------------------------------------------------------
-- Main
----------------------------------------------------------------------------------------------------

for i=1,maxlevels do							-- Loop runs from 1 to value of 'maxlevels'.
	if i >= countstart_level then				-- When the number of loop-runs ('i') reaches 'countstart_level', one (or two) of the 'pack_*'-variables will be increased every time the loop runs.
		if packmarker == 3 then					-- If 'packmarker' has the value 3,...
			pack_b = pack_b + 1					-- ... 'pack_b' (necessary BLUE science packs per research-cycle) will be increased by one.
			packmarker = packmarker - 1			-- 'packmarker' gets the value 2.
		elseif packmarker == 2 then				-- If 'packmarker' has the value 2,...
			pack_g = pack_g + 1					-- ... 'pack_g' (necessary GREEN science packs per research-cycle) will be increased by one.
			packmarker = packmarker - 1			-- 'packmarker' gets the value 1.
		elseif packmarker == 1 then				-- If 'packmarker' has the value 1,...
			pack_r = pack_r + 1					-- ... 'pack_r' (necessary RED science packs per research-cycle) and...
			pack_a = pack_r - 2					-- ... 'pack_a' (necessary ALIEN science packs per research-cycle) will be increased by one.
			packmarker = 3						-- 'packmarker' gets the value 3 - and so the fun starts again.
		end
	end

	if upg_staticmodifieradd then
		modifiercounter = upg_staticmodaddition							-- Static modifier addition
	elseif upg_increasingmodifieradd then
		modifiercounter = upg_increasingmodaddition * i					-- Increasing modifier addition
	else
		modifiercounter = pack_r + pack_g + pack_b + pack_a - i			-- Modifiercalculation
	end
    
    data:extend(
    {
        makeInventoryUpgradeTech(i, pack_r, pack_g, pack_b, pack_a, modifiercounter)
    })
end