--[[
    ╔══════════════════════════════════════════╗
    ║  Sailor Piece Hub v4 — Full Edition      ║
    ║  Author: jachvn112-droid                 ║
    ║  UI: NovaLib | Game: Sailor Piece        ║
    ║  Features: Farm, Boss, Dungeon, Skills   ║
    ╚══════════════════════════════════════════╝
]]

-- ══════════════════════════════════════════
-- 0. SERVICES & GLOBALS
-- ══════════════════════════════════════════
local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RepStorage   = game:GetService("ReplicatedStorage")
local UIS          = game:GetService("UserInputService")
local RunService   = game:GetService("RunService")

local player       = Players.LocalPlayer
local questcheck   = require(RepStorage.Modules.QuestConfig)
local checkmap     = require(RepStorage.TravelConfig)

-- ── Farm State ──
getgenv().IsFarm         = false
getgenv().SelectedMob    = nil
getgenv().WeaponMode     = "Melee"
getgenv().AttackCooldown = 0.3
getgenv().IsTeleporting  = false
getgenv().PlankMode      = false
getgenv().FarmHeight     = 25
getgenv().FarmSpeed      = 50
getgenv().MoveMode       = "Tween"  -- "Tween" | "Teleport"

-- ── Skill State ──
getgenv().SelectedSkill  = 0
getgenv().AutoSkills     = { Z = false, X = false, C = false, V = false, F = false }
getgenv().SkillCooldown  = 0.5

-- ── Boss State ──
getgenv().IsBossFight    = false
getgenv().SelectedBoss   = nil
getgenv().IsSummonBoss   = false
getgenv().SummonDifficulty = "Normal"

-- ── Dungeon / Gamemode State ──
getgenv().IsAutoDungeon  = false
getgenv().DungeonType    = "Shadow"
getgenv().IsBossRush     = false

-- ── Quest Chain State ──
getgenv().IsDungeonQuest = false
getgenv().IsHogyokuQuest = false

-- ── Item State ──
getgenv().IsAutoChest    = false
getgenv().IsAutoMerchant = false
getgenv().MerchantItem   = nil

-- ── Misc State ──
getgenv().IsNoclip       = false
getgenv()._antiAFK       = true

-- Status text
local statusText = "Sẵn sàng. Bật Auto Farm để bắt đầu."
local function setStatus(text)
    statusText = text
end

-- ══════════════════════════════════════════
-- 1. ANTI-KICK + ANTI-TP-BACK HOOK
-- ══════════════════════════════════════════
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

    if (method == "Kick" or method == "kick") and (self == player or self == Players) then
        warn("[AntiKick] Blocked kick:", args[1])
        return nil
    end

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

-- Physics fixer
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

local function teleportToIsland(currentLevel, targetMobName)
    if targetMobName and getgenv().TeleportToMobIsland then
        local ok = getgenv().TeleportToMobIsland(targetMobName)
        if ok then
            hasLearned = false
            autoLearnIslandLevels()
            buildMobDatabase()
            return
        end
    end

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
-- 5. FIND MOB & TWEEN (+ Plank + Teleport mode)
-- ══════════════════════════════════════════
local STEP_SIZE   = 50
local STEP_TIME   = 0.08
local STEP_DELAY  = 0.03
local CLOSE_RANGE = 15

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
                    match = (npc.Name == targetName) or string.find(npc.Name, targetName)
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

local function findBoss(bossName)
    -- Check workspace.NPCs and workspace.Bosses
    for _, folder in ipairs({"NPCs", "Bosses", "Boss", "WorldBoss"}) do
        local f = workspace:FindFirstChild(folder)
        if f then
            for _, npc in ipairs(f:GetChildren()) do
                if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
                    local h = npc:FindFirstChildOfClass("Humanoid")
                    if h and h.Health > 0 then
                        if bossName then
                            if npc.Name == bossName or string.find(npc.Name, bossName) then
                                return npc
                            end
                        else
                            return npc
                        end
                    end
                end
            end
        end
    end
    return nil
end

local function microTween(root, targetCF)
    local tw = TweenService:Create(
        root,
        TweenInfo.new(STEP_TIME, Enum.EasingStyle.Linear),
        { CFrame = targetCF }
    )
    tw:Play()
    tw.Completed:Wait()
end

local function tweenToMob(mob)
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    if not mob or not mob:FindFirstChild("HumanoidRootPart") then return end

    local root = char.HumanoidRootPart
    local hum  = char:FindFirstChildOfClass("Humanoid")

    -- Calculate target position
    local offset = Vector3.new(0, 0, 5)
    if getgenv().PlankMode then
        offset = Vector3.new(0, getgenv().FarmHeight, 0)
    end
    local targetPos = mob.HumanoidRootPart.Position + offset

    -- Teleport mode: instant move
    if getgenv().MoveMode == "Teleport" then
        root.CFrame = CFrame.new(targetPos)
        return
    end

    -- Tween mode: step-based
    local totalDist = (targetPos - root.Position).Magnitude
    getgenv().IsTeleporting = true

    if totalDist <= CLOSE_RANGE then
        microTween(root, CFrame.new(targetPos))
        getgenv().IsTeleporting = false
        return
    end

    local steps = math.ceil(totalDist / STEP_SIZE)
    local startPos = root.Position

    for i = 1, steps do
        if not getgenv().IsFarm and not getgenv().IsBossFight and not getgenv().IsAutoDungeon then break end
        if not mob or not mob.Parent then break end

        if mob:FindFirstChild("HumanoidRootPart") then
            targetPos = mob.HumanoidRootPart.Position + offset
        end

        local nextPos
        if i == steps then
            nextPos = targetPos
        else
            local progress = i / steps
            nextPos = startPos:Lerp(targetPos, progress)
        end

        local moveDir = (nextPos - root.Position)
        if moveDir.Magnitude > 0 then
            root.Velocity = moveDir.Unit * getgenv().FarmSpeed
        end

        microTween(root, CFrame.new(nextPos))
        task.wait(STEP_DELAY)
    end

    root.Velocity = Vector3.new(0, 0, 0)
    getgenv().IsTeleporting = false
end

-- ══════════════════════════════════════════
-- 6. WEAPON / ATTACK SYSTEM (+ Skill Spam)
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

    -- Individual skill spam
    local skillMap = { Z = 1, X = 2, C = 3, V = 4, F = 5 }
    for key, slot in pairs(skillMap) do
        if getgenv().AutoSkills[key] then
            pcall(function()
                RepStorage:WaitForChild("AbilitySystem"):WaitForChild("Remotes"):WaitForChild("RequestAbility"):FireServer(slot)
            end)
        end
    end

    -- Legacy single skill
    local skillId = getgenv().SelectedSkill
    if skillId and skillId > 0 and not next(getgenv().AutoSkills) then
        pcall(function()
            RepStorage:WaitForChild("AbilitySystem"):WaitForChild("Remotes"):WaitForChild("RequestAbility"):FireServer(skillId)
        end)
    end
end

-- Skill spam loop (runs independently)
task.spawn(function()
    while true do
        task.wait(getgenv().SkillCooldown)
        if getgenv().IsFarm or getgenv().IsBossFight or getgenv().IsAutoDungeon or getgenv().IsBossRush then
            local char = player.Character
            if char and char:FindFirstChildOfClass("Humanoid") and char:FindFirstChildOfClass("Humanoid").Health > 0 then
                local skillMap = { Z = 1, X = 2, C = 3, V = 4, F = 5 }
                for key, slot in pairs(skillMap) do
                    if getgenv().AutoSkills[key] then
                        pcall(function()
                            RepStorage:WaitForChild("AbilitySystem"):WaitForChild("Remotes"):WaitForChild("RequestAbility"):FireServer(slot)
                        end)
                    end
                end
            end
        end
    end
end)

-- ══════════════════════════════════════════
-- 7. BOSS FIGHT SYSTEM
-- ══════════════════════════════════════════
local BossList = {}

local function buildBossList()
    table.clear(BossList)
    for _, folder in ipairs({"Bosses", "Boss", "WorldBoss", "NPCs"}) do
        local f = workspace:FindFirstChild(folder)
        if f then
            for _, npc in ipairs(f:GetChildren()) do
                if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
                    local h = npc:FindFirstChildOfClass("Humanoid")
                    if h and h.MaxHealth >= 5000 then
                        local seen = false
                        for _, b in ipairs(BossList) do
                            if b == npc.Name then seen = true break end
                        end
                        if not seen then
                            table.insert(BossList, npc.Name)
                        end
                    end
                end
            end
        end
    end
    if #BossList == 0 then
        BossList = {"WorldBoss", "Boss1", "Boss2", "Boss3"}
    end
end

local function doBossFight()
    local bossName = getgenv().SelectedBoss
    local boss = findBoss(bossName)

    if not boss then
        setStatus("🔍 Boss không tìm thấy: " .. tostring(bossName))
        return false
    end

    local h = boss:FindFirstChildOfClass("Humanoid")
    if not h or h.Health <= 0 then return false end

    setStatus(string.format("⚔️ Boss Fight: %s | HP: %d/%d", boss.Name, h.Health, h.MaxHealth))
    tweenToMob(boss)
    autoAttack(boss)
    return true
end

-- ══════════════════════════════════════════
-- 8. SUMMON BOSS SYSTEM
-- ══════════════════════════════════════════
local SummonBossList = {"Boss1", "Boss2", "Boss3"}

local function doSummonBoss()
    -- Try to summon via remote
    pcall(function()
        local remotes = RepStorage:FindFirstChild("RemoteEvents")
        if remotes then
            local summonRemote = remotes:FindFirstChild("SummonBoss") or remotes:FindFirstChild("BossSummon") or remotes:FindFirstChild("SpawnBoss")
            if summonRemote then
                summonRemote:FireServer(getgenv().SelectedBoss or SummonBossList[1], getgenv().SummonDifficulty)
                setStatus("🔮 Summoning boss: " .. tostring(getgenv().SelectedBoss))
            end
        end
    end)

    -- Try crafting-based summon
    pcall(function()
        local remotes = RepStorage:FindFirstChild("RemoteEvents")
        if remotes then
            local craftRemote = remotes:FindFirstChild("Crafting") or remotes:FindFirstChild("Craft")
            if craftRemote then
                craftRemote:FireServer("SummonStone")
            end
        end
    end)

    task.wait(2)

    -- Attack the summoned boss
    local boss = findBoss(getgenv().SelectedBoss)
    if boss then
        local h = boss:FindFirstChildOfClass("Humanoid")
        if h and h.Health > 0 then
            tweenToMob(boss)
            autoAttack(boss)
            return true
        end
    end
    return false
end

-- ══════════════════════════════════════════
-- 9. DUNGEON SYSTEM (Shadow / Rune / Cid)
-- ══════════════════════════════════════════
local DungeonTypes = {"Shadow", "Rune", "Cid"}

local function doAutoDungeon()
    local dtype = getgenv().DungeonType

    -- Try to enter dungeon
    pcall(function()
        local remotes = RepStorage:FindFirstChild("RemoteEvents")
        if remotes then
            local dungeonRemote = remotes:FindFirstChild("Dungeon") or remotes:FindFirstChild("DungeonEnter") or remotes:FindFirstChild("EnterDungeon")
            if dungeonRemote then
                dungeonRemote:FireServer("Enter", dtype)
                setStatus("🏰 Entering dungeon: " .. dtype)
            end
        end
    end)

    task.wait(3)

    -- Farm mobs inside dungeon
    local mob = findMob(nil) -- any mob
    if mob then
        tweenToMob(mob)
        autoAttack(mob)
        return true
    end
    return false
end

-- Boss Rush
local function doBossRush()
    pcall(function()
        local remotes = RepStorage:FindFirstChild("RemoteEvents")
        if remotes then
            local rushRemote = remotes:FindFirstChild("BossRush") or remotes:FindFirstChild("EnterBossRush")
            if rushRemote then
                rushRemote:FireServer("Enter")
                setStatus("⚡ Boss Rush mode!")
            end
        end
    end)

    task.wait(2)
    local boss = findBoss(nil)
    if boss then
        tweenToMob(boss)
        autoAttack(boss)
        return true
    end
    return false
end

-- ══════════════════════════════════════════
-- 10. QUEST CHAINS
-- ══════════════════════════════════════════

-- Dungeon Quest: collect 6 pieces
local function getDungeonQuestProgress()
    local count = 0
    pcall(function()
        local data = player:FindFirstChild("Data")
        if data then
            local dq = data:FindFirstChild("DungeonPieces") or data:FindFirstChild("DungeonQuest")
            if dq then count = dq.Value end
        end
    end)
    return count
end

local DungeonQuestOrder = {"Shadow", "Rune", "Cid", "Shadow", "Rune", "Cid"}

local function doDungeonQuest()
    local progress = getDungeonQuestProgress()
    if progress >= 6 then
        setStatus("✅ Dungeon Quest hoàn thành! (6/6)")
        return false
    end

    local nextDungeon = DungeonQuestOrder[progress + 1] or "Shadow"
    setStatus(string.format("🔮 Dungeon Quest: %d/6 → %s", progress, nextDungeon))

    getgenv().DungeonType = nextDungeon
    return doAutoDungeon()
end

-- Hogyoku Quest: collect 5 fragments
local function getHogyokuProgress()
    local count = 0
    pcall(function()
        local data = player:FindFirstChild("Data")
        if data then
            local hq = data:FindFirstChild("HogyokuFragments") or data:FindFirstChild("Hogyoku")
            if hq then count = hq.Value end
        end
    end)
    return count
end

local HogyokuBosses = {"Boss1", "Boss2", "Boss3", "Boss4", "Boss5"}

local function doHogyokuQuest()
    local progress = getHogyokuProgress()
    if progress >= 5 then
        -- Turn in to NPC
        pcall(function()
            local remotes = RepStorage:FindFirstChild("RemoteEvents")
            if remotes then
                local questR = remotes:FindFirstChild("Quest") or remotes:FindFirstChild("QuestAccept")
                if questR then
                    questR:FireServer("HogyokuComplete")
                end
            end
        end)
        setStatus("✅ Hogyoku Quest hoàn thành! (5/5)")
        return false
    end

    local targetBoss = HogyokuBosses[progress + 1] or "Boss1"
    setStatus(string.format("🔮 Hogyoku: %d/5 → %s", progress, targetBoss))

    local boss = findBoss(targetBoss)
    if boss then
        tweenToMob(boss)
        autoAttack(boss)
        return true
    end
    return false
end

-- ══════════════════════════════════════════
-- 11. AUTO CHEST + MERCHANT
-- ══════════════════════════════════════════
local ChestTypes = {"Wood", "Iron", "Gold", "Diamond", "Legendary"}

task.spawn(function()
    while true do
        task.wait(5)
        if getgenv().IsAutoChest then
            for _, chestType in ipairs(ChestTypes) do
                pcall(function()
                    local remotes = RepStorage:FindFirstChild("RemoteEvents")
                    if remotes then
                        local chestR = remotes:FindFirstChild("Chest") or remotes:FindFirstChild("OpenChest")
                        if chestR then
                            chestR:FireServer("Open", chestType)
                        end
                    end
                end)
            end
            setStatus("📦 Auto Chest: Opened all chests")
        end
    end
end)

-- Merchant auto-buy
task.spawn(function()
    while true do
        task.wait(30) -- check every 30s
        if getgenv().IsAutoMerchant and getgenv().MerchantItem then
            pcall(function()
                local remotes = RepStorage:FindFirstChild("RemoteEvents")
                if remotes then
                    local merchantR = remotes:FindFirstChild("Merchant") or remotes:FindFirstChild("Shop") or remotes:FindFirstChild("Buy")
                    if merchantR then
                        merchantR:FireServer("Buy", getgenv().MerchantItem)
                        setStatus("🛒 Bought: " .. getgenv().MerchantItem)
                    end
                end
            end)
        end
    end
end)

-- ══════════════════════════════════════════
-- 12. NOCLIP
-- ══════════════════════════════════════════
task.spawn(function()
    RunService.Stepped:Connect(function()
        if getgenv().IsNoclip then
            local char = player.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end)
end)

-- ══════════════════════════════════════════
-- 13. NovaLib UI (6 Tabs)
-- ══════════════════════════════════════════
local Nova = loadstring(game:HttpGet("https://raw.githubusercontent.com/jachvn112-droid/sailor-piece-script/main/NovaLib.luau"))()

local GUI = Nova:Create({
    Name = "⚓ Sailor Piece Hub v4",
    Theme = Nova.Themes.Ocean,
    Size = UDim2.fromOffset(660, 460),
})

-- ─── TAB 1: 🏠 Farm ───
local FarmTab = GUI:Tab({ Name = "🏠 Farm" })

FarmTab:Section("⚔️ Auto Farm")

FarmTab:Toggle({
    Name = "Auto Farm Quest",
    Default = false,
    Callback = function(state)
        getgenv().IsFarm = state
        setStatus(state and "🟢 Auto Farm ON" or "⏸️ Auto Farm OFF")
    end,
})

FarmTab:Toggle({
    Name = "🛹 Plank Mode (hover trên mob)",
    Default = false,
    Callback = function(state)
        getgenv().PlankMode = state
    end,
})

FarmTab:Dropdown({
    Name = "🚀 Move Mode",
    Items = {"Tween", "Teleport"},
    Callback = function(val)
        getgenv().MoveMode = val
    end,
})

FarmTab:Slider({
    Name = "📏 Farm Height (Plank)",
    Min = 5, Max = 100, Default = 25,
    Callback = function(val) getgenv().FarmHeight = val end,
})

FarmTab:Slider({
    Name = "💨 Farm Speed",
    Min = 10, Max = 200, Default = 50,
    Callback = function(val) getgenv().FarmSpeed = val end,
})

FarmTab:Slider({
    Name = "⏱️ Attack Cooldown (ms)",
    Min = 100, Max = 1000, Default = 300,
    Callback = function(val) getgenv().AttackCooldown = val / 1000 end,
})

FarmTab:Section("🎯 Target")

buildMobDatabase()
local mobNames = {"Auto (theo Level)"}
for _, mob in ipairs(MobDatabase) do
    table.insert(mobNames, string.format("[Lv.%d] %s", mob.level, mob.name))
end

FarmTab:Dropdown({
    Name = "👾 Chọn Quái",
    Items = mobNames,
    Callback = function(val)
        if val == "Auto (theo Level)" then
            getgenv().SelectedMob = nil
        else
            getgenv().SelectedMob = val:match("%] (.+)$")
        end
    end,
})

-- ─── TAB 2: ⚔️ Boss ───
local BossTab = GUI:Tab({ Name = "⚔️ Boss" })

BossTab:Section("🐉 World Boss Fight")

BossTab:Toggle({
    Name = "Auto Boss Fight",
    Default = false,
    Callback = function(state)
        getgenv().IsBossFight = state
        setStatus(state and "🐉 Boss Fight ON" or "Boss Fight OFF")
    end,
})

buildBossList()
BossTab:Dropdown({
    Name = "🎯 Chọn Boss",
    Items = BossList,
    Callback = function(val)
        getgenv().SelectedBoss = val
    end,
})

BossTab:Section("🔮 Summon Boss")

BossTab:Toggle({
    Name = "Auto Summon Boss",
    Default = false,
    Callback = function(state)
        getgenv().IsSummonBoss = state
        setStatus(state and "🔮 Summon Boss ON" or "Summon OFF")
    end,
})

BossTab:Dropdown({
    Name = "💀 Difficulty",
    Items = {"Easy", "Normal", "Hard", "Nightmare"},
    Callback = function(val)
        getgenv().SummonDifficulty = val
    end,
})

-- ─── TAB 3: 🎮 Gamemodes ───
local ModeTab = GUI:Tab({ Name = "🎮 Modes" })

ModeTab:Section("🏰 Dungeons")

ModeTab:Toggle({
    Name = "Auto Dungeon",
    Default = false,
    Callback = function(state)
        getgenv().IsAutoDungeon = state
        setStatus(state and "🏰 Dungeon ON" or "Dungeon OFF")
    end,
})

ModeTab:Dropdown({
    Name = "🏰 Dungeon Type",
    Items = DungeonTypes,
    Callback = function(val)
        getgenv().DungeonType = val
    end,
})

ModeTab:Section("⚡ Boss Rush")

ModeTab:Toggle({
    Name = "Auto Boss Rush",
    Default = false,
    Callback = function(state)
        getgenv().IsBossRush = state
        setStatus(state and "⚡ Boss Rush ON" or "Boss Rush OFF")
    end,
})

ModeTab:Section("🔮 Quest Chains")

ModeTab:Toggle({
    Name = "Dungeon Quest (6 pieces)",
    Default = false,
    Callback = function(state)
        getgenv().IsDungeonQuest = state
        setStatus(state and "🔮 Dungeon Quest ON" or "DQ OFF")
    end,
})

ModeTab:Toggle({
    Name = "Hogyoku Quest (5 fragments)",
    Default = false,
    Callback = function(state)
        getgenv().IsHogyokuQuest = state
        setStatus(state and "🔮 Hogyoku Quest ON" or "HQ OFF")
    end,
})

-- ─── TAB 4: 🔮 Skills ───
local SkillTab = GUI:Tab({ Name = "🔮 Skills" })

SkillTab:Section("🎯 Individual Skills")

for _, key in ipairs({"Z", "X", "C", "V", "F"}) do
    local slotNum = ({ Z=1, X=2, C=3, V=4, F=5 })[key]
    SkillTab:Toggle({
        Name = string.format("[%s] Skill %d", key, slotNum),
        Default = false,
        Callback = function(state)
            getgenv().AutoSkills[key] = state
        end,
    })
end

SkillTab:Toggle({
    Name = "🔥 ALL Skills ON/OFF",
    Default = false,
    Callback = function(state)
        for _, k in ipairs({"Z","X","C","V","F"}) do
            getgenv().AutoSkills[k] = state
        end
    end,
})

SkillTab:Slider({
    Name = "⏱️ Skill Cooldown (ms)",
    Min = 100, Max = 3000, Default = 500,
    Callback = function(val) getgenv().SkillCooldown = val / 1000 end,
})

SkillTab:Section("⬛ Haki")

SkillTab:Toggle({
    Name = "⬛ Auto Haki",
    Default = false,
    Callback = function(state)
        pcall(function()
            RepStorage:WaitForChild("RemoteEvents"):WaitForChild("HakiRemote"):FireServer("Toggle")
        end)
    end,
})

SkillTab:Toggle({
    Name = "👁️ Obs Haki",
    Default = false,
    Callback = function(state)
        pcall(function()
            RepStorage:WaitForChild("RemoteEvents"):WaitForChild("ObservationHakiRemote"):FireServer("Toggle")
        end)
    end,
})

-- ─── TAB 5: 📦 Items ───
local ItemTab = GUI:Tab({ Name = "📦 Items" })

ItemTab:Section("📦 Auto Chest")

ItemTab:Toggle({
    Name = "Auto Open Chests",
    Default = false,
    Callback = function(state)
        getgenv().IsAutoChest = state
        setStatus(state and "📦 Auto Chest ON" or "Chest OFF")
    end,
})

ItemTab:Section("🛒 Auto Merchant")

ItemTab:Toggle({
    Name = "Auto Buy from Merchant",
    Default = false,
    Callback = function(state)
        getgenv().IsAutoMerchant = state
    end,
})

ItemTab:Dropdown({
    Name = "🛒 Item to Buy",
    Items = {"HealthPotion", "StaminaPotion", "BoostScroll", "SummonStone"},
    Callback = function(val)
        getgenv().MerchantItem = val
    end,
})

-- ─── TAB 6: ⚙️ Settings ───
local SettingsTab = GUI:Tab({ Name = "⚙️ Settings" })

SettingsTab:Section("🔧 Combat")

SettingsTab:Dropdown({
    Name = "⚔️ Weapon Mode",
    Items = {"Melee", "Fruit"},
    Callback = function(val)
        getgenv().WeaponMode = val
    end,
})

SettingsTab:Section("🔧 Utility")

SettingsTab:Toggle({
    Name = "👻 Noclip",
    Default = false,
    Callback = function(state)
        getgenv().IsNoclip = state
        setStatus(state and "👻 Noclip ON" or "Noclip OFF")
    end,
})

SettingsTab:Toggle({
    Name = "🚀 Make Game Smoother",
    Default = false,
    Callback = function(state)
        pcall(function()
            local settingsRemote = RepStorage:WaitForChild("RemoteEvents"):WaitForChild("SettingsToggle")
            local toggles = {
                {"MuteMusic", state}, {"MuteSFX", state},
                {"DisableVFX", state}, {"DisableCutscene", state},
                {"DisableOtherVFX", state}, {"RemoveTexture", state},
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

SettingsTab:Toggle({
    Name = "Anti-AFK",
    Default = true,
    Callback = function(state)
        getgenv()._antiAFK = state
        if state then
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
        end
    end,
})

SettingsTab:Section("⌨️ Keybinds")

SettingsTab:Keybind({
    Name = "[F2] Toggle Farm",
    Key = Enum.KeyCode.F2,
    OnPress = function()
        getgenv().IsFarm = not getgenv().IsFarm
        setStatus(getgenv().IsFarm and "🟢 Farm ON (F2)" or "⏸️ Farm OFF (F2)")
    end,
})

SettingsTab:Keybind({
    Name = "[V] Toggle Farm",
    Key = Enum.KeyCode.V,
    OnPress = function()
        getgenv().IsFarm = not getgenv().IsFarm
        setStatus(getgenv().IsFarm and "🟢 Farm ON (V)" or "⏸️ Farm OFF (V)")
    end,
})

SettingsTab:Keybind({
    Name = "[B] Toggle Boss Fight",
    Key = Enum.KeyCode.B,
    OnPress = function()
        getgenv().IsBossFight = not getgenv().IsBossFight
        setStatus(getgenv().IsBossFight and "🐉 Boss ON (B)" or "Boss OFF (B)")
    end,
})

SettingsTab:Keybind({
    Name = "[N] Toggle Summon Boss",
    Key = Enum.KeyCode.N,
    OnPress = function()
        getgenv().IsSummonBoss = not getgenv().IsSummonBoss
        setStatus(getgenv().IsSummonBoss and "🔮 Summon ON (N)" or "Summon OFF (N)")
    end,
})

SettingsTab:Keybind({
    Name = "[M] Toggle All Skills",
    Key = Enum.KeyCode.M,
    OnPress = function()
        local anyOn = false
        for _, v in pairs(getgenv().AutoSkills) do
            if v then anyOn = true break end
        end
        local newState = not anyOn
        for _, k in ipairs({"Z","X","C","V","F"}) do
            getgenv().AutoSkills[k] = newState
        end
        setStatus(newState and "🔥 All Skills ON (M)" or "Skills OFF (M)")
    end,
})

SettingsTab:Section("📝 Debug")

SettingsTab:Button({
    Name = "🗺️ Print Quest Data",
    Callback = function()
        print("\n═══ QUEST CONFIG DUMP ═══")
        for npcName, data in pairs(questcheck.RepeatableQuests) do
            local req = data.requirements and data.requirements[1]
            local mobType = req and req.npcType or "???"
            local amount  = req and req.amount or "?"
            print(string.format("  [%s] Lv.%s → Kill %s x%s", npcName, tostring(data.recommendedLevel), mobType, tostring(amount)))
        end
        print("═══ END ═══\n")
    end,
})

SettingsTab:Button({
    Name = "👾 Print Mobs in Map",
    Callback = function()
        local npcFolder = workspace:FindFirstChild("NPCs")
        if not npcFolder then print("❌ NPCs not found!") return end
        print("\n═══ MOBS ═══")
        local seen = {}
        for _, npc in ipairs(npcFolder:GetChildren()) do
            if npc:IsA("Model") and not seen[npc.Name] then
                seen[npc.Name] = true
                local hum = npc:FindFirstChildOfClass("Humanoid")
                local hp  = hum and string.format("HP: %d/%d", hum.Health, hum.MaxHealth) or "no Humanoid"
                print(string.format("  %s — %s", npc.Name, hp))
            end
        end
        print("═══ END ═══\n")
    end,
})

SettingsTab:Button({
    Name = "🔄 Refresh Mob/Boss List",
    Callback = function()
        buildMobDatabase()
        buildBossList()
        setStatus(string.format("✅ Found %d mobs, %d bosses", #MobDatabase, #BossList))
    end,
})

-- ══════════════════════════════════════════
-- 14. PRIORITY MAIN LOOP
-- ══════════════════════════════════════════
task.spawn(function()
    autoLearnIslandLevels()

    while true do
        task.wait(0.1)

        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then
            task.wait(1)
            continue
        end

        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then
            setStatus("💀 Đợi respawn...")
            task.wait(2)
            continue
        end

        -- Priority 1: Dungeon Quest
        if getgenv().IsDungeonQuest then
            if doDungeonQuest() then
                task.wait(getgenv().AttackCooldown)
                continue
            end
        end

        -- Priority 2: Hogyoku Quest
        if getgenv().IsHogyokuQuest then
            if doHogyokuQuest() then
                task.wait(getgenv().AttackCooldown)
                continue
            end
        end

        -- Priority 3: Auto Dungeon
        if getgenv().IsAutoDungeon then
            if doAutoDungeon() then
                task.wait(getgenv().AttackCooldown)
                continue
            end
        end

        -- Priority 4: Boss Rush
        if getgenv().IsBossRush then
            if doBossRush() then
                task.wait(getgenv().AttackCooldown)
                continue
            end
        end

        -- Priority 5: Summon Boss
        if getgenv().IsSummonBoss then
            if doSummonBoss() then
                task.wait(getgenv().AttackCooldown)
                continue
            end
        end

        -- Priority 6: Boss Fight
        if getgenv().IsBossFight then
            if doBossFight() then
                task.wait(getgenv().AttackCooldown)
                continue
            end
        end

        -- Priority 7: Auto Farm (default)
        if getgenv().IsFarm then
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

            -- Accept quest
            if targetNPC then
                pcall(function()
                    RepStorage.RemoteEvents.QuestAccept:FireServer(targetNPC)
                end)
            end

            local mob, dist = findMob(targetMobName)

            if mob then
                local mobH = mob:FindFirstChildOfClass("Humanoid")
                if mobH and mobH.Health > 0 then
                    setStatus(string.format("⚔️ %s | HP:%d/%d | %dm", mob.Name, mobH.Health, mobH.MaxHealth, math.floor(dist)))

                    tweenToMob(mob)
                    task.wait(0.2)

                    while getgenv().IsFarm and mob and mob.Parent and mob:FindFirstChild("HumanoidRootPart") do
                        local h = mob:FindFirstChildOfClass("Humanoid")
                        if not h or h.Health <= 0 then break end
                        tweenToMob(mob)
                        autoAttack(mob)
                        setStatus(string.format("⚔️ %s | ❤️%d/%d | 🗡️%s", mob.Name, h.Health, h.MaxHealth, getgenv().WeaponMode))
                        task.wait(getgenv().AttackCooldown)
                    end

                    setStatus("✅ Hạ: " .. (mob and mob.Name or "mob"))
                    task.wait(0.3)
                end
            else
                setStatus("🔍 " .. targetMobName .. " → Chuyển đảo...")
                local currentLevel = player.Data.Level.Value
                teleportToIsland(currentLevel, targetMobName)
                task.wait(1)
            end
        else
            -- Nothing enabled
            task.wait(0.5)
        end
    end
end)

-- ══════════════════════════════════════════
-- 15. STATUS UPDATER + NOTIFICATION
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

GUI:Notify({
    Title = "✦ Sailor Piece Hub v4",
    Text = "Full Edition loaded! F2/V=Farm B=Boss N=Summon M=Skills",
    Duration = 5,
})

print("✅ Sailor Piece Hub v4 loaded! (Full Edition | 6 Tabs | Priority Loop)")