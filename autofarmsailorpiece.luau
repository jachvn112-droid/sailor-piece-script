--[[
    ╔══════════════════════════════════════════╗
    ║  Sailor Piece Hub v3 — NovaLib Remake    ║
    ║  Author: jachvn112-droid                 ║
    ║  UI: NovaLib | Game: Sailor Piece        ║
    ╚══════════════════════════════════════════╝
]]

-- ══════════════════════════════════════════
-- 0. SERVICES & GLOBALS
-- ══════════════════════════════════════════
local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RepStorage   = game:GetService("ReplicatedStorage")
local UIS          = game:GetService("UserInputService")

local player       = Players.LocalPlayer
local questcheck   = require(RepStorage.Modules.QuestConfig)
local checkmap     = require(RepStorage.TravelConfig)

-- State
getgenv().IsFarm         = false
getgenv().SelectedMob    = nil       -- nil = auto theo level
getgenv().WeaponMode     = "Melee"   -- "Melee" | "Fruit"
getgenv().SelectedSkill  = 0         -- 0=None, 1-5=Z/X/C/V/F
getgenv().AttackCooldown = 0.3
getgenv().IsTeleporting  = false

-- ══════════════════════════════════════════
-- 1. ANTI-KICK + ANTI-TP-BACK HOOK
-- ══════════════════════════════════════════
-- Tên remote mà game dùng để kiểm tra vị trí / tele về chỗ cũ
local BLOCKED_REMOTES = {
    sanity = true, checksanity = true, positioncheck = true,
    antiteleport = true, validateposition = true, checkpos = true,
    anticheat = true, positionvalidate = true, sanitycheck = true,
    movementcheck = true, speedcheck = true, teleportback = true,
}

local OldNameKick
OldNameKick = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args   = {...}

    -- Block kick
    if (method == "Kick" or method == "kick") and (self == player or self == Players) then
        warn("[AntiKick] Blocked kick:", args[1])
        return nil
    end

    -- Block anti-teleport remotes khi đang farm
    if getgenv().IsFarm and (method == "FireServer" or method == "InvokeServer") then
        if self and self:IsA("RemoteEvent") or (self and pcall(function() return self:IsA("RemoteFunction") end)) then
            local remoteName = self.Name:lower():gsub("_", ""):gsub("-", "")
            if BLOCKED_REMOTES[remoteName] then
                warn("[AntiTP] Blocked remote:", self.Name)
                return nil
            end
        end
    end

    return OldNameKick(self, ...)
end)

-- ══════════════════════════════════════════
-- 1b. BYPASS TELEPORT (ANTI-CHEAT GETGC HOOK)
-- ══════════════════════════════════════════
if getgc and hookfunction then
    local hookedCount = 0
    for _, v in pairs(getgc(true)) do
        if type(v) == "function" then
            local ok, info = pcall(getinfo, v)
            if ok and info and info.source then
                if info.source:find("AntiCheat") or info.source:find("ControlClient") or info.source:find("Idle") or info.source:find("Sanity") or info.source:find("Movement") then
                    if info.name and (info.name:lower():find("kick") or info.name:lower():find("ban") or info.name:lower():find("teleport") or info.name:lower():find("position") or info.name:lower():find("sanity") or info.name:lower():find("speed") or info.name:lower():find("check")) then
                        hookfunction(v, function(...) return nil end)
                        hookedCount = hookedCount + 1
                    end
                end
            end
            pcall(function()
                local upvalues = getupvalues(v)
                for key, val in pairs(upvalues) do
                    if type(key) == "string" then
                        if key:lower() == "isteleporting" then
                            setupvalue(v, key, false)
                        elseif key:lower() == "maxspeed" or key:lower() == "speedlimit" then
                            setupvalue(v, key, 99999)
                        end
                    end
                end
            end)
        end
    end
    warn("[BYPASS] Hooked " .. tostring(hookedCount) .. " AC functions")
end

-- Physics fixer: PlatformStand khi đang tween
task.spawn(function()
    while task.wait(0.1) do
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum  = char and char:FindFirstChild("Humanoid")
        if hum and root and getgenv().IsTeleporting then
            hum.PlatformStand = true
            hum:ChangeState(Enum.HumanoidStateType.Physics)
            root.Velocity = Vector3.new(0, 0, 0)
        elseif hum and not getgenv().IsTeleporting then
            if hum.PlatformStand then
                hum.PlatformStand = false
                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
        end
    end
end)

-- ══════════════════════════════════════════
-- 2. MOB DATABASE: QUÉT & SORT THEO LEVEL
-- ══════════════════════════════════════════
local MobDatabase = {}

local function buildMobDatabase()
    table.clear(MobDatabase)

    -- npcType → recommendedLevel từ QuestConfig
    local npcLevelMap = {}
    for _, questData in pairs(questcheck.RepeatableQuests) do
        local reqLevel = tonumber(questData.recommendedLevel) or 0
        if questData.requirements then
            for _, req in ipairs(questData.requirements) do
                if req.npcType then
                    if not npcLevelMap[req.npcType] or reqLevel > npcLevelMap[req.npcType] then
                        npcLevelMap[req.npcType] = reqLevel
                    end
                end
            end
        end
    end

    -- Quét workspace.NPCs
    local seenTypes = {}
    local npcFolder = workspace:FindFirstChild("NPCs")
    if npcFolder then
        for _, npc in ipairs(npcFolder:GetChildren()) do
            if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
                local npcName = npc.Name
                if not seenTypes[npcName] then
                    seenTypes[npcName] = true

                    local level = 0
                    for npcType, lvl in pairs(npcLevelMap) do
                        if string.find(npcName, npcType) then
                            level = lvl
                            break
                        end
                    end

                    local island = "Unknown"
                    pcall(function()
                        local zoneId, _ = checkmap.GetZoneAt(npc.HumanoidRootPart.Position)
                        if zoneId then island = zoneId end
                    end)

                    table.insert(MobDatabase, {
                        name   = npcName,
                        level  = level,
                        island = island,
                    })
                end
            end
        end
    end

    table.sort(MobDatabase, function(a, b)
        if a.level == b.level then return a.name < b.name end
        return a.level < b.level
    end)
end

-- Log toàn bộ quest mapping khi load
task.spawn(function()
    print("╔══════════════════════════════════════════╗")
    print("║     QUEST → MOB MAPPING (Debug Log)     ║")
    print("╠══════════════════════════════════════════╣")
    for npcName, data in pairs(questcheck.RepeatableQuests) do
        local req = data.requirements and data.requirements[1]
        local mobType = req and req.npcType or "???"
        local amount  = req and req.amount or "?"
        local lvl     = data.recommendedLevel or "?"
        print(string.format("║ [Quest] %-16s → Lv.%-4s → Kill %-12s x%s", npcName, tostring(lvl), mobType, tostring(amount)))
    end
    print("╚══════════════════════════════════════════╝")
end)

-- ══════════════════════════════════════════
-- 3. QUEST SYSTEM
-- ══════════════════════════════════════════
local function getTargetQuest()
    local level        = player.Data.Level.Value
    local bestNPC      = nil
    local maxLevelFound = -1
    local choosenpc    = nil

    for npcName, data in pairs(questcheck.RepeatableQuests) do
        local req = tonumber(data.recommendedLevel) or 0
        if level >= req and req > maxLevelFound then
            maxLevelFound = req
            bestNPC       = npcName
            if data.requirements and data.requirements[1] then
                choosenpc = data.requirements[1].npcType
            end
        end
    end

    return bestNPC, maxLevelFound, choosenpc
end

-- ══════════════════════════════════════════
-- 4. ISLAND LEARNING & TELEPORT
-- ══════════════════════════════════════════
local autoLevelRanges = {}
local hasLearned = false

local function autoLearnIslandLevels()
    if hasLearned then return end
    for _, questData in pairs(questcheck.RepeatableQuests) do
        local reqLevel = tonumber(questData.recommendedLevel) or 0
        if questData.requirements then
            for _, req in ipairs(questData.requirements) do
                if req.npcType then
                    local npcFolder = workspace:FindFirstChild("NPCs")
                    if npcFolder then
                        for _, obj in ipairs(npcFolder:GetChildren()) do
                            if string.find(obj.Name, req.npcType) and obj:FindFirstChild("HumanoidRootPart") then
                                local zoneId, _ = checkmap.GetZoneAt(obj.HumanoidRootPart.Position)
                                if zoneId then
                                    if not autoLevelRanges[zoneId] then
                                        autoLevelRanges[zoneId] = { MinLevel = reqLevel, MaxLevel = reqLevel, PortalKey = zoneId }
                                    else
                                        autoLevelRanges[zoneId].MinLevel = math.min(autoLevelRanges[zoneId].MinLevel, reqLevel)
                                        autoLevelRanges[zoneId].MaxLevel = math.max(autoLevelRanges[zoneId].MaxLevel, reqLevel)
                                    end
                                end
                                break
                            end
                        end
                    end
                end
            end
        end
    end
    hasLearned = true
end

local function getPortalForLevel(lvl)
    for zoneId, rangeData in pairs(autoLevelRanges) do
        if lvl >= rangeData.MinLevel and lvl <= rangeData.MaxLevel then
            return rangeData.PortalKey
        end
    end
    return "StarterIsland"
end

local function teleportToIsland(currentLevel)
    local targetPortal = getPortalForLevel(currentLevel)
    local portalArg = targetPortal:gsub("Island", ""):gsub(" ", "")

    local success, _ = pcall(function()
        RepStorage:WaitForChild("Remotes"):WaitForChild("TeleportToPortal"):FireServer(portalArg)
    end)

    if success then
        task.wait(2)
        hasLearned = false
        autoLearnIslandLevels()
        buildMobDatabase()
    end
end

-- ══════════════════════════════════════════
-- 5. FIND MOB & INCREMENTAL STEP-TWEEN (BYPASS)
-- ══════════════════════════════════════════
local STEP_SIZE   = 50       -- studs per hop
local STEP_TIME   = 0.08     -- tween time per hop
local STEP_DELAY  = 0.03     -- wait giữa các hop
local CLOSE_RANGE = 15       -- nếu gần hơn thì tween thẳng (ko bị detect)

local function findMob(targetName)
    local npcFolder = workspace:FindFirstChild("NPCs")
    if not npcFolder then return nil end

    local closest = nil
    local closestDist = math.huge
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local playerPos = char.HumanoidRootPart.Position

    for _, npc in ipairs(npcFolder:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
            local humanoid = npc:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local match = false
                if targetName then
                    match = (npc.Name == targetName)
                else
                    match = true
                end

                if match then
                    local dist = (npc.HumanoidRootPart.Position - playerPos).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        closest = npc
                    end
                end
            end
        end
    end

    return closest, closestDist
end

-- Tween nhỏ 1 bước (dùng nội bộ)
local function microTween(root, targetCF)
    local tw = TweenService:Create(
        root,
        TweenInfo.new(STEP_TIME, Enum.EasingStyle.Linear),
        { CFrame = targetCF }
    )
    tw:Play()
    tw.Completed:Wait()
end

-- Incremental step-tween: di chuyển từng bước nhỏ thay vì teleport thẳng
local function tweenToMob(mob)
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    if not mob or not mob:FindFirstChild("HumanoidRootPart") then return end

    local root = char.HumanoidRootPart
    local hum  = char:FindFirstChildOfClass("Humanoid")
    local targetPos = mob.HumanoidRootPart.Position + Vector3.new(0, 0, 5)
    local totalDist = (targetPos - root.Position).Magnitude

    getgenv().IsTeleporting = true

    -- Nếu rất gần → tween thẳng (an toàn, ko bị detect)
    if totalDist <= CLOSE_RANGE then
        microTween(root, CFrame.new(targetPos))
        getgenv().IsTeleporting = false
        return
    end

    -- Tính số bước cần đi
    local steps = math.ceil(totalDist / STEP_SIZE)
    local startPos = root.Position
    local direction = (targetPos - startPos).Unit

    for i = 1, steps do
        if not getgenv().IsFarm then break end
        if not mob or not mob.Parent then break end -- mob đã chết/biến mất

        -- Cập nhật target nếu mob di chuyển
        if mob:FindFirstChild("HumanoidRootPart") then
            targetPos = mob.HumanoidRootPart.Position + Vector3.new(0, 0, 5)
        end

        local nextPos
        if i == steps then
            -- Bước cuối: đến đích
            nextPos = targetPos
        else
            -- Bước trung gian
            local progress = i / steps
            nextPos = startPos:Lerp(targetPos, progress)
        end

        -- Spoof velocity để trông tự nhiên
        local moveDir = (nextPos - root.Position)
        if moveDir.Magnitude > 0 then
            root.Velocity = moveDir.Unit * 50 -- giả lập di chuyển
        end

        -- Micro-tween bước này
        microTween(root, CFrame.new(nextPos))

        -- Nghỉ giữa các bước
        task.wait(STEP_DELAY)
    end

    -- Đảm bảo velocity = 0 khi xong
    root.Velocity = Vector3.new(0, 0, 0)
    getgenv().IsTeleporting = false
end

-- ══════════════════════════════════════════
-- 6. WEAPON / ATTACK SYSTEM
-- ══════════════════════════════════════════
local function equipWeapon()
    local char = player.Character
    if not char then return nil end
    local backpack = player:FindFirstChild("Backpack")
    if not backpack then return nil end

    local mode = getgenv().WeaponMode

    local function findTool(searchIn)
        for _, item in ipairs(searchIn:GetChildren()) do
            if item:IsA("Tool") then
                if mode == "Melee" then
                    local n = item.Name:lower()
                    if n:find("sword") or n:find("blade") or n:find("katana") or n:find("cutlass") or n:find("melee") then
                        return item
                    end
                elseif mode == "Fruit" then
                    local n = item.Name:lower()
                    if n:find("fruit") or n:find("devil") or n:find("power") or n:find("ability") then
                        return item
                    end
                end
            end
        end
        return nil
    end

    local equipped = findTool(char)
    if equipped then return equipped end

    local tool = findTool(backpack)
    if tool then
        tool.Parent = char
        return tool
    end

    -- Fallback: equip tool đầu tiên
    for _, item in ipairs(backpack:GetChildren()) do
        if item:IsA("Tool") then
            item.Parent = char
            return item
        end
    end

    return nil
end

local function autoAttack(mob)
    if not mob or not mob:FindFirstChild("HumanoidRootPart") then return end

    local tool = equipWeapon()
    if tool then
        pcall(function() tool:Activate() end)
    end

    pcall(function()
        RepStorage:WaitForChild("CombatSystem"):WaitForChild("Remotes"):WaitForChild("RequestHit"):FireServer()
    end)

    local skillId = getgenv().SelectedSkill
    if skillId and skillId > 0 then
        pcall(function()
            RepStorage:WaitForChild("AbilitySystem"):WaitForChild("Remotes"):WaitForChild("RequestAbility"):FireServer(skillId)
        end)
    end
end

-- ══════════════════════════════════════════
-- 7. NovaLib UI
-- ══════════════════════════════════════════
local Nova = loadstring(game:HttpGet("https://raw.githubusercontent.com/jachvn112-droid/sailor-piece-script/main/NovaLib.luau"))()

local GUI = Nova:Create({
    Name = "⚓ Sailor Piece Hub v3",
    Theme = Nova.Themes.Ocean,
    Size = UDim2.fromOffset(640, 440),
})

-- ── Status label (cập nhật liên tục) ──
local statusText = "Sẵn sàng. Bật Auto Farm để bắt đầu."
local function setStatus(text)
    statusText = text
end

-- ─────────────────────────────────────────
-- TAB 1: 🏠 Main — Farm Controls
-- ─────────────────────────────────────────
local MainTab = GUI:Tab({ Name = "🏠 Main" })

MainTab:Section("⚔️ Auto Farm")

MainTab:Toggle({
    Name = "Auto Farm Quest",
    Default = false,
    Callback = function(state)
        getgenv().IsFarm = state
        if state then
            setStatus("🟢 Auto Farm đang chạy...")
        else
            setStatus("⏸️ Auto Farm đã tắt.")
        end
    end,
})

MainTab:Toggle({
    Name = "⬛ Auto Haki",
    Default = false,
    Callback = function(state)
        pcall(function()
            RepStorage:WaitForChild("RemoteEvents"):WaitForChild("HakiRemote"):FireServer("Toggle")
        end)
    end,
})

MainTab:Toggle({
    Name = "👁️ Obs Haki",
    Default = false,
    Callback = function(state)
        pcall(function()
            RepStorage:WaitForChild("RemoteEvents"):WaitForChild("ObservationHakiRemote"):FireServer("Toggle")
        end)
    end,
})

MainTab:Toggle({
    Name = "🚀 Make Game Smoother",
    Default = false,
    Callback = function(state)
        pcall(function()
            local settingsRemote = RepStorage:WaitForChild("RemoteEvents"):WaitForChild("SettingsToggle")
            local toggles = {
                {"MuteMusic", state},
                {"MuteSFX", state},
                {"DisableVFX", state},
                {"DisableCutscene", state},
                {"DisableOtherVFX", state},
                {"RemoveTexture", state},
                {"RemoveShadows", state},
            }
            for _, t in ipairs(toggles) do
                settingsRemote:FireServer(t[1], t[2])
            end
            local settings = UserSettings():GetService("UserGameSettings")
            settings.SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel1
            settings.GraphicsQualityLevel = 1
            sethiddenproperty(settings, "GraphicsOptimizationMode", 1)
        end)
    end,
})

MainTab:Section("🎯 Target Selection")

MainTab:Dropdown({
    Name = "⚔️ Weapon Mode",
    Items = {"Melee", "Fruit"},
    Callback = function(val)
        getgenv().WeaponMode = val
    end,
})

local skillOptions = {"None", "[Z] Skill 1", "[X] Skill 2", "[C] Skill 3", "[V] Skill 4", "[F] Skill 5"}
local skillMap = {
    ["None"] = 0,
    ["[Z] Skill 1"] = 1,
    ["[X] Skill 2"] = 2,
    ["[C] Skill 3"] = 3,
    ["[V] Skill 4"] = 4,
    ["[F] Skill 5"] = 5,
}

MainTab:Dropdown({
    Name = "🔥 Spam Skill",
    Items = skillOptions,
    Callback = function(val)
        getgenv().SelectedSkill = skillMap[val] or 0
    end,
})

-- Mob dropdown (auto-populated)
buildMobDatabase()
local mobNames = {"Auto (theo Level)"}
for _, mob in ipairs(MobDatabase) do
    table.insert(mobNames, string.format("[Lv.%d] %s", mob.level, mob.name))
end

MainTab:Dropdown({
    Name = "👾 Chọn Quái",
    Items = mobNames,
    Callback = function(val)
        if val == "Auto (theo Level)" then
            getgenv().SelectedMob = nil
        else
            local mobName = val:match("%] (.+)$")
            getgenv().SelectedMob = mobName
        end
    end,
})

MainTab:Slider({
    Name = "⏱️ Attack Cooldown (ms)",
    Min = 100,
    Max = 1000,
    Default = 300,
    Callback = function(val)
        getgenv().AttackCooldown = val / 1000
    end,
})

-- ─────────────────────────────────────────
-- TAB 2: 🌊 Teleport
-- ─────────────────────────────────────────
local TeleportTab = GUI:Tab({ Name = "🌊 Teleport" })

TeleportTab:Section("🏝️ Island Teleport")

-- Dynamic island list từ TravelConfig
local islandList = {}
pcall(function()
    if checkmap.Islands then
        for islandName, _ in pairs(checkmap.Islands) do
            table.insert(islandList, islandName)
        end
    elseif checkmap.Zones then
        for zoneName, _ in pairs(checkmap.Zones) do
            table.insert(islandList, zoneName)
        end
    end
end)

-- Fallback nếu không đọc được từ config
if #islandList == 0 then
    islandList = {"StarterIsland", "Island1", "Island2", "Island3", "Island4", "Island5"}
end

table.sort(islandList)

for _, islandName in ipairs(islandList) do
    TeleportTab:Button({
        Name = "🏝️ " .. islandName,
        Callback = function()
            pcall(function()
                local portalArg = islandName:gsub("Island", ""):gsub(" ", "")
                RepStorage:WaitForChild("Remotes"):WaitForChild("TeleportToPortal"):FireServer(portalArg)
            end)
            setStatus("🚀 Teleporting to: " .. islandName)
        end,
    })
end

TeleportTab:Section("🔄 Mob List")

TeleportTab:Button({
    Name = "🔄 Refresh Mob List",
    Callback = function()
        buildMobDatabase()
        local count = #MobDatabase
        setStatus(string.format("✅ Refreshed! Found %d mob types.", count))
        for _, mob in ipairs(MobDatabase) do
            print(string.format("  [Lv.%d] %s @ %s", mob.level, mob.name, mob.island))
        end
    end,
})

-- ─────────────────────────────────────────
-- TAB 3: 📊 Info
-- ─────────────────────────────────────────
local InfoTab = GUI:Tab({ Name = "📊 Info" })

InfoTab:Section("📋 Quest → Mob Map")

-- Show quest mapping
for npcName, data in pairs(questcheck.RepeatableQuests) do
    local req = data.requirements and data.requirements[1]
    local mobType = req and req.npcType or "???"
    local amount  = req and req.amount or "?"
    local lvl     = data.recommendedLevel or "?"

    InfoTab:Button({
        Name = string.format("Lv.%s | %s → Kill %s x%s", tostring(lvl), npcName, mobType, tostring(amount)),
        Callback = function()
            -- Bấm để chọn quest này
            getgenv().SelectedMob = mobType
            setStatus("🎯 Manual target: " .. mobType)
        end,
    })
end

InfoTab:Section("📊 Player Stats")

InfoTab:Button({
    Name = "📊 Show Current Stats",
    Callback = function()
        local lvl = "?"
        pcall(function() lvl = player.Data.Level.Value end)
        local bestNPC, bestLvl, bestMob = getTargetQuest()
        print("══════════════════════════════════")
        print("📊 Player Level: " .. tostring(lvl))
        print("🎯 Best Quest NPC: " .. tostring(bestNPC))
        print("🎯 Quest Level: " .. tostring(bestLvl))
        print("👾 Target Mob: " .. tostring(bestMob))
        print("⚔️ Weapon: " .. getgenv().WeaponMode)
        print("🔥 Skill: " .. tostring(getgenv().SelectedSkill))
        print("══════════════════════════════════")
        setStatus(string.format("Lv.%s | Quest: %s → %s", tostring(lvl), tostring(bestNPC), tostring(bestMob)))
    end,
})

-- ─────────────────────────────────────────
-- TAB 4: ⚙️ Settings
-- ─────────────────────────────────────────
local SettingsTab = GUI:Tab({ Name = "⚙️ Settings" })

SettingsTab:Section("🔧 Config")

SettingsTab:Keybind({
    Name = "Toggle Farm Hotkey",
    Key = Enum.KeyCode.F2,
    OnPress = function()
        getgenv().IsFarm = not getgenv().IsFarm
        if getgenv().IsFarm then
            setStatus("🟢 Auto Farm ON (F2)")
        else
            setStatus("⏸️ Auto Farm OFF (F2)")
        end
    end,
})

SettingsTab:Toggle({
    Name = "Anti-AFK",
    Default = true,
    Callback = function(state)
        if state then
            -- Anti-AFK: giữ connection
            task.spawn(function()
                while getgenv()._antiAFK do
                    task.wait(60)
                    pcall(function()
                        local vu = game:GetService("VirtualUser")
                        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                        task.wait(1)
                        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                    end)
                end
            end)
            getgenv()._antiAFK = true
        else
            getgenv()._antiAFK = false
        end
    end,
})

SettingsTab:Section("📝 Debug")

SettingsTab:Button({
    Name = "🗺️ Print All Quest Data",
    Callback = function()
        print("\n═══ FULL QUEST CONFIG DUMP ═══")
        for npcName, data in pairs(questcheck.RepeatableQuests) do
            print(string.format("\n[%s] Level: %s", npcName, tostring(data.recommendedLevel)))
            if data.requirements then
                for i, req in ipairs(data.requirements) do
                    print(string.format("  Requirement %d: Kill '%s' x%s", i, tostring(req.npcType), tostring(req.amount)))
                end
            end
        end
        print("═══ END DUMP ═══\n")
    end,
})

SettingsTab:Button({
    Name = "👾 Print All Mobs in Map",
    Callback = function()
        local npcFolder = workspace:FindFirstChild("NPCs")
        if not npcFolder then
            print("❌ workspace.NPCs not found!")
            return
        end
        print("\n═══ ALL MOBS IN workspace.NPCs ═══")
        local seen = {}
        for _, npc in ipairs(npcFolder:GetChildren()) do
            if npc:IsA("Model") and not seen[npc.Name] then
                seen[npc.Name] = true
                local hum = npc:FindFirstChildOfClass("Humanoid")
                local hp  = hum and string.format("HP: %d/%d", hum.Health, hum.MaxHealth) or "no Humanoid"
                print(string.format("  %s — %s", npc.Name, hp))
            end
        end
        print("═══ END MOBS ═══\n")
    end,
})

-- ══════════════════════════════════════════
-- 8. MAIN FARM LOOP
-- ══════════════════════════════════════════
task.spawn(function()
    autoLearnIslandLevels()

    while true do
        task.wait(0.1)

        if not getgenv().IsFarm then
            task.wait(0.5)
            continue
        end

        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then
            setStatus("⏳ Đang đợi nhân vật...")
            task.wait(1)
            continue
        end

        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then
            setStatus("💀 Nhân vật đã chết, đợi respawn...")
            task.wait(2)
            continue
        end

        -- Xác định mob target
        local targetMobName = getgenv().SelectedMob
        local targetNPC, _, choosenpc

        if not targetMobName then
            targetNPC, _, choosenpc = getTargetQuest()
            targetMobName = choosenpc
        end

        if not targetMobName then
            setStatus("❓ Không tìm thấy quái phù hợp level.")
            task.wait(1)
            continue
        end

        -- Nhận quest nếu auto mode
        if targetNPC then
            pcall(function()
                RepStorage.RemoteEvents.QuestAccept:FireServer(targetNPC)
            end)
        end

        -- Tìm mob gần nhất
        local mob, dist = findMob(targetMobName)

        if mob then
            local mobHumanoid = mob:FindFirstChildOfClass("Humanoid")
            if mobHumanoid and mobHumanoid.Health > 0 then
                setStatus(string.format(
                    "⚔️ Farm: %s (HP: %d/%d) | Dist: %d | %s",
                    mob.Name,
                    mobHumanoid.Health,
                    mobHumanoid.MaxHealth,
                    math.floor(dist),
                    getgenv().WeaponMode
                ))

                -- Tween đến mob
                tweenToMob(mob)
                task.wait(0.2)

                -- Attack loop
                while getgenv().IsFarm and mob and mob.Parent and mob:FindFirstChild("HumanoidRootPart") do
                    local h = mob:FindFirstChildOfClass("Humanoid")
                    if not h or h.Health <= 0 then break end

                    tweenToMob(mob)
                    autoAttack(mob)

                    setStatus(string.format(
                        "⚔️ Đang đánh: %s | ❤️ %d/%d | 🗡️ %s",
                        mob.Name, h.Health, h.MaxHealth, getgenv().WeaponMode
                    ))

                    task.wait(getgenv().AttackCooldown)
                end

                setStatus("✅ Đã hạ: " .. (mob and mob.Name or "mob"))
                task.wait(0.3)
            end
        else
            -- Không tìm thấy mob → chuyển đảo
            setStatus("🔍 Không thấy " .. targetMobName .. " → Đang chuyển đảo...")
            local currentLevel = player.Data.Level.Value
            teleportToIsland(currentLevel)
            task.wait(1)
        end
    end
end)

-- ══════════════════════════════════════════
-- 9. STATUS UPDATER (in trạng thái lên console)
-- ══════════════════════════════════════════
task.spawn(function()
    local lastStatus = ""
    while task.wait(2) do
        if statusText ~= lastStatus then
            lastStatus = statusText
            print("[Status] " .. statusText)
        end
    end
end)

-- ══════════════════════════════════════════
-- NOTIFICATION
-- ══════════════════════════════════════════
GUI:Notify({
    Title = "✦ Sailor Piece Hub v3",
    Text = "Loaded! F2 = Toggle Farm | NovaLib UI",
    Duration = 5,
})

print("✅ Sailor Piece Hub v3 loaded! (NovaLib UI | F2 toggle)")