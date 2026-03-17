local u1 = {}
local v2 = {
    ["Starter"] = {
        ["IslandFolder"] = "StarterIsland",
        ["DisplayName"] = "Starter Island",
        ["Description"] = "Where every journey begins",
        ["Image"] = "rbxassetid://113511577977545",
        ["Order"] = 1,
        ["IsSpecial"] = false,
        ["SpecialText"] = nil
    },
    ["Jungle"] = {
        ["IslandFolder"] = "JungleIsland",
        ["DisplayName"] = "Jungle Island",
        ["Description"] = "Where ancient vines whisper secrets",
        ["Image"] = "rbxassetid://129372855118178",
        ["Order"] = 2,
        ["IsSpecial"] = false,
        ["SpecialText"] = nil
    },
    ["Desert"] = {
        ["IslandFolder"] = "DesertIsland",
        ["DisplayName"] = "Desert Island",
        ["Description"] = "Scorching sands hide buried treasures",
        ["Image"] = "rbxassetid://110313344834898",
        ["Order"] = 3,
        ["IsSpecial"] = false,
        ["SpecialText"] = nil
    },
    ["Snow"] = {
        ["IslandFolder"] = "SnowIsland",
        ["DisplayName"] = "Snow Island",
        ["Description"] = "Frozen peaks guard forgotten mysteries",
        ["Image"] = "rbxassetid://83052479758564",
        ["Order"] = 4,
        ["IsSpecial"] = false,
        ["SpecialText"] = nil
    },
    ["Sailor"] = {
        ["IslandFolder"] = "SailorIsland",
        ["DisplayName"] = "Sailor Island",
        ["Description"] = "Home of the legendary pirates",
        ["Image"] = "rbxassetid://82578960342899",
        ["Order"] = 5,
        ["IsSpecial"] = false,
        ["SpecialText"] = nil
    },
    ["Shibuya"] = {
        ["IslandFolder"] = "ShibuyaStation",
        ["DisplayName"] = "Shibuya Station",
        ["Description"] = "The cursed heart of Tokyo",
        ["Image"] = "rbxassetid://115929738096973",
        ["Order"] = 6,
        ["IsSpecial"] = false,
        ["SpecialText"] = nil
    },
    ["HuecoMundo"] = {
        ["IslandFolder"] = "HuecoMundo",
        ["DisplayName"] = "Hueco Mundo",
        ["Description"] = "The hollow world between realms",
        ["Image"] = "rbxassetid://100183863159412",
        ["Order"] = 7,
        ["IsSpecial"] = false,
        ["SpecialText"] = nil
    },
    ["Boss"] = {
        ["IslandFolder"] = "BossIsland",
        ["DisplayName"] = "Boss Island",
        ["Description"] = "Where legends are forged in battle",
        ["Image"] = "rbxassetid://122454663704181",
        ["Order"] = 8,
        ["IsSpecial"] = false,
        ["SpecialText"] = nil
    },
    ["Dungeon"] = {
        ["IslandFolder"] = "Main Temple",
        ["DisplayName"] = "Dungeon Island",
        ["Description"] = "Ancient temples guard forbidden dungeons",
        ["Image"] = "rbxassetid://121825909752146",
        ["Order"] = 9,
        ["IsSpecial"] = false,
        ["SpecialText"] = nil
    },
    ["Shinjuku"] = {
        ["IslandFolder"] = "ShinjukuIsland",
        ["DisplayName"] = "Shinjuku Island",
        ["Description"] = "The cursed ruins of a forgotten district",
        ["Image"] = "rbxassetid://120825915701259",
        ["Order"] = 10,
        ["IsSpecial"] = false,
        ["SpecialText"] = nil
    },
    ["Slime"] = {
        ["IslandFolder"] = "SlimeIsland",
        ["DisplayName"] = "Slime Island",
        ["Description"] = "A land devoured by living ooze",
        ["Image"] = "rbxassetid://72917877343567",
        ["Order"] = 12,
        ["IsSpecial"] = false,
        ["SpecialText"] = nil
    },
    ["Academy"] = {
        ["IslandFolder"] = "AcademyIsland",
        ["DisplayName"] = "Academy Island",
        ["Description"] = "Where warriors sharpen their skills",
        ["Image"] = "rbxassetid://90484672897942",
        ["Order"] = 13,
        ["IsSpecial"] = false,
        ["SpecialText"] = nil
    },
    ["Judgement"] = {
        ["IslandFolder"] = "JudgementIsland",
        ["DisplayName"] = "Judgement Island",
        ["Description"] = "Where rival blades decide destiny",
        ["Image"] = "rbxassetid://95835325464771",
        ["Order"] = 14,
        ["IsSpecial"] = false,
        ["SpecialText"] = nil
    },
    ["SoulSociety"] = {
        ["IslandFolder"] = "SoulSocietyIsland",
        ["DisplayName"] = "Soul Society",
        ["Description"] = "The realm of spirits beyond the gate",
        ["Image"] = "rbxassetid://86755418206490",
        ["Order"] = 15,
        ["IsSpecial"] = true,
        ["SpecialText"] = "Requires Hogyoku Quest",
        ["RequiresQuestline"] = "HogyokuUnlock"
    }
}
u1.Portals = v2
u1.PromptSettings = {
    ["ActionText"] = "Open Map",
    ["HoldDuration"] = 0.3,
    ["MaxActivationDistance"] = 8,
    ["KeyboardKeyCode"] = Enum.KeyCode.E,
    ["GamepadKeyCode"] = Enum.KeyCode.ButtonX
}
u1.TeleportSettings = {
    ["SpawnHeightOffset"] = 3,
    ["RaycastDistance"] = 100,
    ["HorizontalOffset"] = 5,
    ["TeleportCooldown"] = 1
}
function u1.GetPortal(p3) --[[ Line: 160 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    return u1.Portals[p3]
end
function u1.GetSortedPortals() --[[ Line: 164 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v4 = {}
    for v5, v6 in pairs(u1.Portals) do
        table.insert(v4, {
            ["id"] = v5,
            ["data"] = v6
        })
    end
    table.sort(v4, function(p7, p8) --[[ Line: 169 ]]
        return (p7.data.Order or 999) < (p8.data.Order or 999)
    end)
    return v4
end
return u1