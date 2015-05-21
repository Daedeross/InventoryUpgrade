require ("prototypes.demo-player-animations")

function makePlayerPrototype(f_level)
    local f_name = string.format("player-%i", f_level)
    local f_result =
    {
        type = "player",
        name = f_name,
        icon = "__base__/graphics/icons/player.png",
        flags = {"pushable", "placeable-off-grid", "breaths-air", "not-repairable", "not-on-map"},
        max_health = 100,
        healing_per_tick = 0.01,
        collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
        selection_box = {{-0.4, -1.4}, {0.4, 0.2}},
        crafting_categories = {"crafting"},
        mining_categories = {"basic-solid"},
        inventory_size = 60 + (f_level * 20),
        build_distance = 6,
        drop_item_distance = 6,
        reach_distance = 6,
        reach_resource_distance = 2.7,
        ticks_to_keep_gun = 600,
        ticks_to_keep_aiming_direction = 100,
        damage_hit_tint = {r = 1, g = 0, b = 0, a = 0},
        running_speed = 0.15,
        distance_per_frame = 0.13,
        maximum_corner_sliding_distance = 0.7,
        subgroup = "creatures",
        order="a",
        eat =
        {
          {
            filename = "__base__/sound/eat.ogg",
            volume = 1
          }
        },
        heartbeat =
        {
          {
            filename = "__base__/sound/heartbeat.ogg"
          }
        },

        animations =
        {
          {
            idle =
            {
              layers =
              {
                playeranimations.level1.idle,
                playeranimations.level1.idlemask,
              }
            },
            idle_with_gun =
            {
              layers =
              {
                playeranimations.level1.idlewithgun,
                playeranimations.level1.idlewithgunmask,
              }
            },
            mining_with_hands =
            {
              layers =
              {
                playeranimations.level1.miningwithhands,
                playeranimations.level1.miningwithhandsmask,
              }
            },
            mining_with_tool =
            {
              layers =
              {
                playeranimations.level1.miningwithtool,
                playeranimations.level1.miningwithtoolmask,
              }
            },
            running_with_gun =
            {
              layers =
              {
                playeranimations.level1.runningwithgun,
                playeranimations.level1.runningwithgunmask,
              }
            },
            running =
            {
              layers =
              {
                playeranimations.level1.running,
                playeranimations.level1.runningmask,
              }
            }
          },
          {
            -- heavy-armor is not in the demo
            armors = data.isdemo and {"basic-armor"} or {"basic-armor", "heavy-armor"},
            idle =
            {
              layers =
              {
                playeranimations.level1.idle,
                playeranimations.level1.idlemask,
                playeranimations.level2addon.idle,
                playeranimations.level2addon.idlemask
              }
            },
            idle_with_gun =
            {
              layers =
              {
                playeranimations.level1.idlewithgun,
                playeranimations.level1.idlewithgunmask,
                playeranimations.level2addon.idlewithgun,
                playeranimations.level2addon.idlewithgunmask,
              }
            },
            mining_with_hands =
            {
              layers =
              {
                playeranimations.level1.miningwithhands,
                playeranimations.level1.miningwithhandsmask,
                playeranimations.level2addon.miningwithhands,
                playeranimations.level2addon.miningwithhandsmask,
              }
            },
            mining_with_tool =
            {
              layers =
              {
                playeranimations.level1.miningwithtool,
                playeranimations.level1.miningwithtoolmask,
                playeranimations.level2addon.miningwithtool,
                playeranimations.level2addon.miningwithtoolmask,
              }
            },
            running_with_gun =
            {
              layers =
              {
                playeranimations.level1.runningwithgun,
                playeranimations.level1.runningwithgunmask,
                playeranimations.level2addon.runningwithgun,
                playeranimations.level2addon.runningwithgunmask,
              }
            },
            running =
            {
              layers =
              {
                playeranimations.level1.running,
                playeranimations.level1.runningmask,
                playeranimations.level2addon.running,
                playeranimations.level2addon.runningmask,
              }
            }
          },
          {
            -- modular armors are not in the demo
            armors = data.isdemo and {} or {"basic-modular-armor", "power-armor", "power-armor-mk2"},
            idle =
            {
              layers =
              {
                playeranimations.level1.idle,
                playeranimations.level1.idlemask,
                playeranimations.level3addon.idle,
                playeranimations.level3addon.idlemask
              }
            },
            idle_with_gun =
            {
              layers =
              {
                playeranimations.level1.idlewithgun,
                playeranimations.level1.idlewithgunmask,
                playeranimations.level3addon.idlewithgun,
                playeranimations.level3addon.idlewithgunmask,
              }
            },
            mining_with_hands =
            {
              layers =
              {
                playeranimations.level1.miningwithhands,
                playeranimations.level1.miningwithhandsmask,
                playeranimations.level3addon.miningwithhands,
                playeranimations.level3addon.miningwithhandsmask,
              }
            },
            mining_with_tool =
            {
              layers =
              {
                playeranimations.level1.miningwithtool,
                playeranimations.level1.miningwithtoolmask,
                playeranimations.level3addon.miningwithtool,
                playeranimations.level3addon.miningwithtoolmask,
              }
            },
            running_with_gun =
            {
              layers =
              {
                playeranimations.level1.runningwithgun,
                playeranimations.level1.runningwithgunmask,
                playeranimations.level3addon.runningwithgun,
                playeranimations.level3addon.runningwithgunmask,
              }
            },
            running =
            {
              layers =
              {
                playeranimations.level1.running,
                playeranimations.level1.runningmask,
                playeranimations.level3addon.running,
                playeranimations.level3addon.runningmask,
              }
            }
          }
        },
        light =
        {
            {
                minimum_darkness = 0.3,
                intensity = 0.4,
                size = 25,
            },
            {
                type = "oriented",
                minimum_darkness = 0.3,
                picture =
                {
                    filename = "__core__/graphics/light-cone.png",
                    priority = "medium",
                    scale = 2,
                    width = 200,
                    height = 200
                },
                shift = {0, -13},
                size = 2,
                intensity = 0.6
            },
        },
        mining_speed = 0.01,
        mining_with_hands_particles_animation_positions = {29, 63},
        mining_with_tool_particles_animation_positions = {28},
        running_sound_animation_positions = {14, 29}
    }
    return f_result
end

-- Main

for i = 1, MaxInventoryUpgrades do
    data:extend({
        makePlayerPrototype(i)
    })
end

