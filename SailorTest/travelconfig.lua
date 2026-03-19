local u1 = {}
local v2 = {
    ["StarterIsland"] = {
        ["Center"] = Vector3.new(108, 71, -234),
        ["Size"] = Vector3.new(455, 280, 350),
        ["DisplayName"] = "Starter Island",
        ["Description"] = "\"Where every journey begins\"",
        ["Icon"] = ""
    },
    ["JungleIsland"] = {
        ["Center"] = Vector3.new(-529, 44, 430),
        ["Size"] = Vector3.new(420, 200, 400),
        ["DisplayName"] = "Jungle Island",
        ["Description"] = "\"Where ancient vines whisper secrets\"",
        ["Icon"] = ""
    },
    ["DesertIsland"] = {
        ["Center"] = Vector3.new(-919, 25, -462),
        ["Size"] = Vector3.new(480, 180, 520),
        ["DisplayName"] = "Desert Island",
        ["Description"] = "\"Scorching sands hide buried treasures\"",
        ["Icon"] = ""
    },
    ["SnowIsland"] = {
        ["Center"] = Vector3.new(-391, 64, -1195),
        ["Size"] = Vector3.new(600, 270, 560),
        ["DisplayName"] = "Snow Island",
        ["Description"] = "\"Frozen peaks guard forgotten mysteries\"",
        ["Icon"] = ""
    },
    ["BossIsland"] = {
        ["Center"] = Vector3.new(812, 23, -1133),
        ["Size"] = Vector3.new(380, 220, 400),
        ["DisplayName"] = "Boss Island",
        ["Description"] = "\"Where legends are forged in battle\"",
        ["Icon"] = ""
    },
    ["ShibuyaStation"] = {
        ["Center"] = Vector3.new(1615, 184, 230),
        ["Size"] = Vector3.new(1350, 500, 1200),
        ["DisplayName"] = "Shibuya Station",
        ["Description"] = "\"The cursed heart of Tokyo\"",
        ["Icon"] = ""
    },
    ["SailorIsland"] = {
        ["Center"] = Vector3.new(221, 68, 797),
        ["Size"] = Vector3.new(494, 192, 562),
        ["DisplayName"] = "Sailor Island",
        ["Description"] = "\"Home of the legendary pirates\"",
        ["Icon"] = ""
    },
    ["HuecoMundo"] = {
        ["Center"] = Vector3.new(-534, 72, 1181),
        ["Size"] = Vector3.new(750, 300, 760),
        ["DisplayName"] = "Hueco Mundo",
        ["Description"] = "\"The hollow world between realms\"",
        ["Icon"] = ""
    },
    ["DungeonIsland"] = {
        ["Center"] = Vector3.new(1374, 20, -907),
        ["Size"] = Vector3.new(300, 100, 250),
        ["DisplayName"] = "Dungeon Island",
        ["Description"] = "\"Ancient temples guard forbidden dungeons\"",
        ["Icon"] = ""
    },
    ["ShinjukuIsland"] = {
        ["Center"] = Vector3.new(300, 50, -2126),
        ["Size"] = Vector3.new(920, 200, 1120),
        ["DisplayName"] = "Shinjuku Island",
        ["Description"] = "\"The cursed ruins of a forgotten district\"",
        ["Icon"] = ""
    },
    ["SlimeIsland"] = {
        ["Center"] = Vector3.new(-1249, 41, 251),
        ["Size"] = Vector3.new(634, 205, 579),
        ["DisplayName"] = "Slime Island",
        ["Description"] = "\"A land devoured by living ooze\"",
        ["Icon"] = ""
    },
    ["AcademyIsland"] = {
        ["Center"] = Vector3.new(954, 48, 1317),
        ["Size"] = Vector3.new(500, 300, 500),
        ["DisplayName"] = "Academy Island",
        ["Description"] = "\"Where warriors sharpen their skills\"",
        ["Icon"] = ""
    },
    ["SoulSocietyIsland"] = {
        ["Center"] = Vector3.new(-1487, 1794, 1721),
        ["Size"] = Vector3.new(1550, 780, 900),
        ["DisplayName"] = "Soul Society",
        ["Description"] = "\"The realm of spirits beyond the gate\"",
        ["Icon"] = ""
    },
    ["JudgementIsland"] = {
        ["Center"] = Vector3.new(-1235, 40, -1274),
        ["Size"] = Vector3.new(650, 280, 600),
        ["DisplayName"] = "Judgement Island",
        ["Description"] = "\"Where fate weighs every soul\"",
        ["Icon"] = ""
    }
}
u1.Zones = v2
u1.Fallback = {
    ["DisplayName"] = "Open Sea",
    ["Description"] = "\"Endless waters stretch to the horizon\"",
    ["Icon"] = ""
}
u1.Settings = {
    ["FadeInTime"] = 0.5,
    ["DisplayTime"] = 3,
    ["FadeOutTime"] = 0.8,
    ["Cooldown"] = 5,
    ["CheckInterval"] = 3
}
function u1.IsInZone(p3, p4) --[[ Line: 140 ]]
    local v5 = p4.Size / 2
    local v6 = p4.Center - v5
    local v7 = p4.Center + v5
    local v8
    if p3.X >= v6.X and (p3.X <= v7.X and (p3.Y >= v6.Y and (p3.Y <= v7.Y and p3.Z >= v6.Z))) then
        v8 = p3.Z <= v7.Z
    else
        v8 = false
    end
    return v8
end
function u1.GetZoneAt(p9) --[[ Line: 153 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    for v10, v11 in pairs(u1.Zones) do
        if u1.IsInZone(p9, v11) then
            return v10, v11
        end
    end
    return nil, u1.Fallback
end
return u1