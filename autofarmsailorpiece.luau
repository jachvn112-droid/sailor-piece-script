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
local TeleportService = game:GetService("TeleportService")

-- ══════════════════════════════════════════
-- 0.1. ANTI-KICK SYSTEM (DELTA-SAFE)
-- ══════════════════════════════════════════
local player       = Players.LocalPlayer
local _kicksBlocked = 0

local function _logKickBlock(layer, info)
    _kicksBlocked = _kicksBlocked + 1
    warn(("[ANTI-KICK] Layer %s blocked #%d: %s"):format(layer, _kicksBlocked, tostring(info)))
end

local _wrap = typeof(newcclosure) == "function" and newcclosure or function(f) return f end

-- Layer 1: hookmetamethod __namecall
if typeof(hookmetamethod) == "function" and typeof(getnamecallmethod) == "function" then
    pcall(function()
        local OldNameKick
        OldNameKick = hookmetamethod(game, "__namecall", _wrap(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            if (method == "Kick" or method == "kick") and (self == player or self == Players) then
                _logKickBlock("1", args[1] or "no reason")
                return nil
            end
            if method == "TeleportToPlaceInstance" and self == TeleportService then
                _logKickBlock("1", "TeleportToPlaceInstance")
                return nil
            end
            return OldNameKick(self, ...)
        end))
        print("[ANTI-KICK] Layer 1 ✓")
    end)
else
    warn("[ANTI-KICK] Layer 1 skipped (hookmetamethod not available)")
end

-- Layer 2: hookfunction Player:Kick
if typeof(hookfunction) == "function" then
    pcall(function()
        local oldKick
        oldKick = hookfunction(player.Kick, _wrap(function(self, ...)
            if self == player then
                _logKickBlock("2", ({...})[1] or "no reason")
                return nil
            end
            return oldKick(self, ...)
        end))
        print("[ANTI-KICK] Layer 2 ✓")
    end)
else
    warn("[ANTI-KICK] Layer 2 skipped (hookfunction not available)")
end

-- Layer 3: hookfunction TeleportService
if typeof(hookfunction) == "function" then
    pcall(function()
        local oldTP
        oldTP = hookfunction(TeleportService.Teleport, _wrap(function(self, placeId, plr, ...)
            if plr == player then
                _logKickBlock("3", "PlaceId=" .. tostring(placeId))
                return nil
            end
            return oldTP(self, placeId, plr, ...)
        end))
        print("[ANTI-KICK] Layer 3a ✓")
    end)
    pcall(function()
        local oldTPPlace
        oldTPPlace = hookfunction(TeleportService.TeleportToPlaceInstance, _wrap(function(self, placeId, instId, plr, ...)
            if plr == player then
                _logKickBlock("3", "PlaceId=" .. tostring(placeId))
                return nil
            end
            return oldTPPlace(self, placeId, instId, plr, ...)
        end))
        print("[ANTI-KICK] Layer 3b ✓")
    end)
else
    warn("[ANTI-KICK] Layer 3 skipped")
end

-- Layer 4: hookfunction RemoteEvent:FireServer (kick remotes)
if typeof(hookfunction) == "function" then
    pcall(function()
        local dummy = Instance.new("RemoteEvent")
        local oldFire
        oldFire = hookfunction(dummy.FireServer, _wrap(function(self, ...)
            if typeof(self) == "Instance" and self:IsA("RemoteEvent") then
                local n = self.Name:lower()
                if n:find("kick") or n:find("ban") or n:find("punish") or n:find("anticheat") then
                    _logKickBlock("4", self:GetFullName())
                    return nil
                end
            end
            return oldFire(self, ...)
        end))
        dummy:Destroy()
        print("[ANTI-KICK] Layer 4 ✓")
    end)
else
    warn("[ANTI-KICK] Layer 4 skipped")
end

-- Layer 5: getgc scan — hook kick/ban functions in memory
if typeof(getgc) == "function" and typeof(hookfunction) == "function" and typeof(getinfo) == "function" then
    pcall(function()
        for _, v in pairs(getgc(true)) do
            if type(v) == "function" then
                pcall(function()
                    local info = getinfo(v)
                    if info and info.source then
                        local src = info.source:lower()
                        local name = (info.name or ""):lower()
                        if (src:find("anticheat") or src:find("security") or src:find("moderation")) then
                            if name:find("kick") or name:find("ban") or name:find("remove") then
                                hookfunction(v, _wrap(function(...)
                                    _logKickBlock("5", tostring(info.name))
                                    return nil
                                end))
                            end
                        end
                    end
                end)
            end
        end
        print("[ANTI-KICK] Layer 5 ✓")
    end)
else
    warn("[ANTI-KICK] Layer 5 skipped (getgc/getinfo not available)")
end

print("[ANTI-KICK] System initialized 🛡️")
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
getgenv().QuestMode      = false
getgenv()._antiAFK       = true

-- ── Auto Stats State ──
getgenv()._statsStartTime   = os.time()
getgenv()._statsTotalKills  = 0
getgenv()._statsBossKills   = 0
getgenv()._statsEXPGained   = 0
getgenv()._statsBeliGained  = 0
getgenv()._statsStartLevel  = 0
getgenv()._statsStartEXP    = 0
getgenv()._statsStartBeli   = 0
getgenv()._statsInitialized = false

-- ── Teleport State ──
getgenv().SelectedIsland  = nil

-- Status text
local statusText = "Ready. Enable Auto Farm to begin."
local function setStatus(text)
    statusText = text
end

-- ══════════════════════════════════════════
-- 0.5. CONFIG SAVE / LOAD SYSTEM
-- ══════════════════════════════════════════
local CONFIG_FILE = "SailorPieceHub_v4_config.json"
local HttpService = game:GetService("HttpService")
local _autoSaveEnabled = true
local _configDirty = false

-- List of keys to save
local CONFIG_KEYS = {
    -- Farm
    "IsFarm", "SelectedMob", "WeaponMode", "AttackCooldown", "QuestMode",
    "PlankMode", "FarmHeight", "FarmSpeed", "MoveMode",
    -- Skills
    "AutoSkills", "SkillCooldown",
    -- Boss
    "IsBossFight", "SelectedBoss", "IsSummonBoss", "SummonDifficulty",
    -- Dungeon / Gamemode
    "IsAutoDungeon", "DungeonType", "IsBossRush",
    -- Quest Chain
    "IsDungeonQuest", "IsHogyokuQuest",
    -- Items
    "IsAutoChest", "IsAutoMerchant", "MerchantItem",
    -- Misc
    "IsNoclip", "_antiAFK",
    -- Stats
    "_statsTotalKills", "_statsBossKills",
    -- Teleport
    "SelectedIsland",
}

local function saveConfig()
    local ok, err = pcall(function()
        local data = {}
        for _, key in ipairs(CONFIG_KEYS) do
            data[key] = getgenv()[key]
        end
        data._savedAt = os.time()
        local json = HttpService:JSONEncode(data)
        writefile(CONFIG_FILE, json)
    end)
    if ok then
        setStatus("💾 Config saved!")
    else
        warn("[Config] Save failed:", err)
    end
    return ok
end

local function loadConfig()
    local ok, err = pcall(function()
        if not isfile(CONFIG_FILE) then
            setStatus("📂 No config found, using defaults.")
            return
        end
        local json = readfile(CONFIG_FILE)
        local data = HttpService:JSONDecode(json)
        for _, key in ipairs(CONFIG_KEYS) do
            if data[key] ~= nil then
                -- AutoSkills is a table, needs proper merging
                if key == "AutoSkills" and type(data[key]) == "table" then
                    for k, v in pairs(data[key]) do
                        getgenv().AutoSkills[k] = v
                    end
                else
                    getgenv()[key] = data[key]
                end
            end
        end
        local savedTime = data._savedAt
        if savedTime then
            local ago = os.time() - savedTime
            local mins = math.floor(ago / 60)
            setStatus(string.format("✅ Config loaded! (saved %dm ago)", mins))
        else
            setStatus("✅ Config loaded!")
        end
    end)
    if not ok then
        warn("[Config] Load failed:", err)
        setStatus("⚠️ Config load failed, using defaults.")
    end
    return ok
end

local function resetConfig()
    pcall(function()
        if isfile(CONFIG_FILE) then
            delfile(CONFIG_FILE)
        end
    end)
    -- Reset to defaults
    getgenv().IsFarm         = false
    getgenv().SelectedMob    = nil
    getgenv().WeaponMode     = "Melee"
    getgenv().AttackCooldown = 0.3
    getgenv().PlankMode      = false
    getgenv().FarmHeight     = 25
    getgenv().FarmSpeed      = 50
    getgenv().MoveMode       = "Tween"
    getgenv().AutoSkills     = { Z = false, X = false, C = false, V = false, F = false }
    getgenv().SkillCooldown  = 0.5
    getgenv().IsBossFight    = false
    getgenv().SelectedBoss   = nil
    getgenv().IsSummonBoss   = false
    getgenv().SummonDifficulty = "Normal"
    getgenv().IsAutoDungeon  = false
    getgenv().DungeonType    = "Shadow"
    getgenv().IsBossRush     = false
    getgenv().IsDungeonQuest = false
    getgenv().IsHogyokuQuest = false
    getgenv().IsAutoChest    = false
    getgenv().IsAutoMerchant = false
    getgenv().MerchantItem   = nil
    getgenv().IsNoclip       = false
    getgenv()._antiAFK       = true
    setStatus("🔄 Config reset to defaults!")
end

-- Mark config dirty when settings change
local function markConfigDirty()
    _configDirty = true
end

-- Auto-save loop (every 30s if changes detected)
task.spawn(function()
    while true do
        task.wait(30)
        if _autoSaveEnabled and _configDirty then
            _configDirty = false
            saveConfig()
        end
    end
end)

-- Load config on startup
loadConfig()

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
-- 2. MOB DATABASE: SCAN & SORT BY LEVEL
-- ══════════════════════════════════════════
local MobDatabase = {}

local function buildMobDatabase()
    table.clear(MobDatabase)

    -- Step 1: Collect all quest levels and npcType → minLevel mapping
    local npcLevelMap = {}
    local allLevels = {}
    local levelSet = {}
    for _, questData in pairs(questcheck.RepeatableQuests) do
        local reqLevel = tonumber(questData.recommendedLevel) or 0
        if questData.requirements then
            for _, req in ipairs(questData.requirements) do
                if req.npcType then
                    if not npcLevelMap[req.npcType] or reqLevel > npcLevelMap[req.npcType] then
                        npcLevelMap[req.npcType] = reqLevel
                    end
                    if not levelSet[reqLevel] then
                        levelSet[reqLevel] = true
                        table.insert(allLevels, reqLevel)
                    end
                end
            end
        end
    end

    -- Step 2: Sort all levels and build a "next level" lookup for ranges
    table.sort(allLevels)
    local nextLevelMap = {}
    for i, lvl in ipairs(allLevels) do
        if i < #allLevels then
            nextLevelMap[lvl] = allLevels[i + 1]
        else
            nextLevelMap[lvl] = "MAX"
        end
    end

    -- Step 3: Build npcType → {minLevel, maxLevel} range map
    local npcRangeMap = {}
    for npcType, minLvl in pairs(npcLevelMap) do
        local maxLvl = nextLevelMap[minLvl] or "MAX"
        npcRangeMap[npcType] = { min = minLvl, max = maxLvl }
    end

    local seenTypes = {}
    local npcFolder = workspace:FindFirstChild("NPCs")
    if npcFolder then
        for _, npc in ipairs(npcFolder:GetChildren()) do
            if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
                -- Strip trailing digits to group (Thief1, Thief2 → Thief)
                local baseName = npc.Name:match("^(.-)%d*$") or npc.Name
                if baseName == "" then baseName = npc.Name end
                if not seenTypes[baseName] then
                    seenTypes[baseName] = true
                    local minLevel = 0
                    local maxLevel = "MAX"
                    for npcType, range in pairs(npcRangeMap) do
                        if string.find(baseName, npcType) then
                            minLevel = range.min
                            maxLevel = range.max
                            break
                        end
                    end

                    local island = "Unknown"
                    pcall(function()
                        local zoneId, _ = checkmap.GetZoneAt(npc.HumanoidRootPart.Position)
                        if zoneId then island = zoneId end
                    end)

                    table.insert(MobDatabase, {
                        name     = baseName,
                        level    = minLevel,
                        minLevel = minLevel,
                        maxLevel = maxLevel,
                        island   = island,
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
        local hitTarget = mob:FindFirstChild("HumanoidRootPart") or mob
        RepStorage:WaitForChild("CombatSystem"):WaitForChild("Remotes"):WaitForChild("RequestHit"):FireServer(hitTarget)
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
        setStatus("🔍 Boss not found: " .. tostring(bossName))
        return false
    end

    local h = boss:FindFirstChildOfClass("Humanoid")
    if not h or h.Health <= 0 then return false end

    setStatus(string.format("⚔️ Boss Fight: %s | HP: %d/%d", boss.Name, h.Health, h.MaxHealth))
    tweenToMob(boss)
    autoAttack(boss)
    -- Check if boss died after attack
    task.wait(0.1)
    if h.Health <= 0 then
        getgenv()._statsBossKills = getgenv()._statsBossKills + 1
        getgenv()._statsTotalKills = getgenv()._statsTotalKills + 1
    end
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
        setStatus("✅ Dungeon Quest complete! (6/6)")
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
        setStatus("✅ Hogyoku Quest complete! (5/5)")
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

-- Toggle/Dropdown references for config sync
local toggleRefs = {}
local mobDropdown, bossDropdown
local syncTogglesFromConfig  -- forward declaration

local GUI = Nova:Create({
    Name = "⚓ Sailor Piece Hub v4",
    Theme = Nova.Themes.Ocean,
    Size = UDim2.fromOffset(660, 460),
})

-- ─── TAB 1: 🏠 Farm ───
local FarmTab = GUI:Tab({ Name = "🏠 Farm" })

FarmTab:Section("⚔️ Auto Farm")

toggleRefs.IsFarm = FarmTab:Toggle({
    Name = "Auto Farm",
    Default = false,
    Callback = function(state)
        getgenv().IsFarm = state
        setStatus(state and "🟢 Auto Farm ON" or "⏸️ Auto Farm OFF")
        markConfigDirty()
    end,
})

toggleRefs.QuestMode = FarmTab:Toggle({
    Name = "📜 Quest Mode (auto-accept quests)",
    Default = false,
    Callback = function(state)
        getgenv().QuestMode = state
        markConfigDirty()
    end,
})

toggleRefs.PlankMode = FarmTab:Toggle({
    Name = "🛹 Plank Mode (hover above mob)",
    Default = false,
    Callback = function(state)
        getgenv().PlankMode = state
        markConfigDirty()
    end,
})

FarmTab:Dropdown({
    Name = "🚀 Move Mode",
    Items = {"Tween", "Teleport"},
    Callback = function(val)
        getgenv().MoveMode = val
        markConfigDirty()
    end,
})

FarmTab:Slider({
    Name = "📏 Farm Height (Plank)",
    Min = 5, Max = 100, Default = 25,
    Callback = function(val) getgenv().FarmHeight = val; markConfigDirty() end,
})

FarmTab:Slider({
    Name = "💨 Farm Speed",
    Min = 10, Max = 200, Default = 50,
    Callback = function(val) getgenv().FarmSpeed = val; markConfigDirty() end,
})

FarmTab:Slider({
    Name = "⏱️ Attack Cooldown (ms)",
    Min = 100, Max = 1000, Default = 300,
    Callback = function(val) getgenv().AttackCooldown = val / 1000; markConfigDirty() end,
})

FarmTab:Section("🎯 Target")

buildMobDatabase()
local mobNames = {"Auto (by Level)"}
for _, mob in ipairs(MobDatabase) do
    local maxLvlStr = (mob.maxLevel == "MAX") and "+" or ("-" .. tostring(mob.maxLevel))
    table.insert(mobNames, string.format("[Lv.%d%s] %s", mob.minLevel, maxLvlStr, mob.name))
end

mobDropdown = FarmTab:Dropdown({
    Name = "👾 Select Mob",
    Items = mobNames,
    Callback = function(val)
        if val == "Auto (by Level)" then
            getgenv().SelectedMob = nil
        else
            getgenv().SelectedMob = val:match("%] (.+)$")
        end
        markConfigDirty()
    end,
})

-- ─── TAB 2: ⚔️ Boss ───
local BossTab = GUI:Tab({ Name = "⚔️ Boss" })

BossTab:Section("🐉 World Boss Fight")

toggleRefs.IsBossFight = BossTab:Toggle({
    Name = "Auto Boss Fight",
    Default = false,
    Callback = function(state)
        getgenv().IsBossFight = state
        setStatus(state and "🐉 Boss Fight ON" or "Boss Fight OFF")
        markConfigDirty()
    end,
})

buildBossList()
bossDropdown = BossTab:Dropdown({
    Name = "🎯 Select Boss",
    Items = BossList,
    Callback = function(val)
        getgenv().SelectedBoss = val
        markConfigDirty()
    end,
})

BossTab:Section("🔮 Summon Boss")

toggleRefs.IsSummonBoss = BossTab:Toggle({
    Name = "Auto Summon Boss",
    Default = false,
    Callback = function(state)
        getgenv().IsSummonBoss = state
        setStatus(state and "🔮 Summon Boss ON" or "Summon OFF")
        markConfigDirty()
    end,
})

BossTab:Dropdown({
    Name = "💀 Difficulty",
    Items = {"Easy", "Normal", "Hard", "Nightmare"},
    Callback = function(val)
        getgenv().SummonDifficulty = val
        markConfigDirty()
    end,
})

-- ─── TAB 3: 🎮 Gamemodes ───
local ModeTab = GUI:Tab({ Name = "🎮 Modes" })

ModeTab:Section("🏰 Dungeons")

toggleRefs.IsAutoDungeon = ModeTab:Toggle({
    Name = "Auto Dungeon",
    Default = false,
    Callback = function(state)
        getgenv().IsAutoDungeon = state
        setStatus(state and "🏰 Dungeon ON" or "Dungeon OFF")
        markConfigDirty()
    end,
})

ModeTab:Dropdown({
    Name = "🏰 Dungeon Type",
    Items = DungeonTypes,
    Callback = function(val)
        getgenv().DungeonType = val
        markConfigDirty()
    end,
})

ModeTab:Section("⚡ Boss Rush")

toggleRefs.IsBossRush = ModeTab:Toggle({
    Name = "Auto Boss Rush",
    Default = false,
    Callback = function(state)
        getgenv().IsBossRush = state
        setStatus(state and "⚡ Boss Rush ON" or "Boss Rush OFF")
        markConfigDirty()
    end,
})

ModeTab:Section("🔮 Quest Chains")

toggleRefs.IsDungeonQuest = ModeTab:Toggle({
    Name = "Dungeon Quest (6 pieces)",
    Default = false,
    Callback = function(state)
        getgenv().IsDungeonQuest = state
        setStatus(state and "🔮 Dungeon Quest ON" or "DQ OFF")
        markConfigDirty()
    end,
})

toggleRefs.IsHogyokuQuest = ModeTab:Toggle({
    Name = "Hogyoku Quest (5 fragments)",
    Default = false,
    Callback = function(state)
        getgenv().IsHogyokuQuest = state
        setStatus(state and "🔮 Hogyoku Quest ON" or "HQ OFF")
        markConfigDirty()
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
            markConfigDirty()
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
        markConfigDirty()
    end,
})

SkillTab:Slider({
    Name = "⏱️ Skill Cooldown (ms)",
    Min = 100, Max = 3000, Default = 500,
    Callback = function(val) getgenv().SkillCooldown = val / 1000; markConfigDirty() end,
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

toggleRefs.IsAutoChest = ItemTab:Toggle({
    Name = "Auto Open Chests",
    Default = false,
    Callback = function(state)
        getgenv().IsAutoChest = state
        setStatus(state and "📦 Auto Chest ON" or "Chest OFF")
        markConfigDirty()
    end,
})

ItemTab:Section("🛒 Auto Merchant")

toggleRefs.IsAutoMerchant = ItemTab:Toggle({
    Name = "Auto Buy from Merchant",
    Default = false,
    Callback = function(state)
        getgenv().IsAutoMerchant = state
        markConfigDirty()
    end,
})

ItemTab:Dropdown({
    Name = "🛒 Item to Buy",
    Items = {"HealthPotion", "StaminaPotion", "BoostScroll", "SummonStone"},
    Callback = function(val)
        getgenv().MerchantItem = val
        markConfigDirty()
    end,
})

-- ─── TAB 6: 🌍 Teleport ───
local TeleportTab = GUI:Tab({ Name = "🌍 Teleport" })

TeleportTab:Section("🏝️ Island Teleport")

-- Build island list from autoLevelRanges
autoLearnIslandLevels()
local _islandNames = {}
for zoneId, rangeData in pairs(autoLevelRanges) do
    table.insert(_islandNames, string.format("[Lv.%d-%d] %s", rangeData.MinLevel, rangeData.MaxLevel, zoneId))
end
table.sort(_islandNames)
if #_islandNames == 0 then
    _islandNames = {"StarterIsland", "Island2", "Island3"}
end

TeleportTab:Dropdown({
    Name = "🏝️ Select Island",
    Items = _islandNames,
    Callback = function(val)
        -- Extract zone name from "[Lv.X-Y] ZoneName"
        local zoneName = val:match("%] (.+)$") or val
        getgenv().SelectedIsland = zoneName
        markConfigDirty()
    end,
})

TeleportTab:Button({
    Name = "🚀 Teleport Now",
    Callback = function()
        local island = getgenv().SelectedIsland
        if not island then
            setStatus("⚠️ Select an island first!")
            return
        end
        setStatus("🌍 Teleporting to: " .. island)
        pcall(function()
            local portalArg = island:gsub("Island", ""):gsub(" ", "")
            RepStorage:WaitForChild("Remotes"):WaitForChild("TeleportToPortal"):FireServer(portalArg)
        end)
        task.wait(2)
        hasLearned = false
        autoLearnIslandLevels()
        buildMobDatabase()
        setStatus("✅ Teleported to: " .. island)
    end,
})

TeleportTab:Section("🔄 Quick Teleport")

TeleportTab:Button({
    Name = "🏠 Go to Starter Island",
    Callback = function()
        setStatus("🏠 Teleporting to Starter...")
        pcall(function()
            RepStorage:WaitForChild("Remotes"):WaitForChild("TeleportToPortal"):FireServer("Starter")
        end)
        task.wait(2)
        setStatus("✅ Returned to Starter Island")
    end,
})

TeleportTab:Button({
    Name = "📍 TP to Current Quest",
    Callback = function()
        local _, _, choosenpc = getTargetQuest()
        if choosenpc then
            local currentLevel = player.Data.Level.Value
            teleportToIsland(currentLevel, choosenpc)
            setStatus("📍 TP to quest mob: " .. choosenpc)
        else
            setStatus("⚠️ No quest found matching your level")
        end
    end,
})

TeleportTab:Button({
    Name = "🔄 Refresh Island List",
    Callback = function()
        hasLearned = false
        autoLearnIslandLevels()
        local count = 0
        for _ in pairs(autoLevelRanges) do count = count + 1 end
        setStatus(string.format("✅ Found %d islands", count))
    end,
})

-- ─── TAB 7: 📊 Stats ───
local StatsTab = GUI:Tab({ Name = "📊 Stats" })

StatsTab:Section("📊 Farm Statistics")

-- Initialize stats on first load
if not getgenv()._statsInitialized then
    pcall(function()
        getgenv()._statsStartLevel = player.Data.Level.Value
        local expVal = player.Data:FindFirstChild("EXP") or player.Data:FindFirstChild("Exp") or player.Data:FindFirstChild("Experience")
        if expVal then getgenv()._statsStartEXP = expVal.Value end
        local beliVal = player.Data:FindFirstChild("Beli") or player.Data:FindFirstChild("Gold") or player.Data:FindFirstChild("Money") or player.Data:FindFirstChild("Cash")
        if beliVal then getgenv()._statsStartBeli = beliVal.Value end
    end)
    getgenv()._statsStartTime  = os.time()
    getgenv()._statsInitialized = true
end

local function formatUptime(seconds)
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    local s = seconds % 60
    return string.format("%02d:%02d:%02d", h, m, s)
end

local function getStatsText()
    local elapsed = os.time() - getgenv()._statsStartTime
    local kills = getgenv()._statsTotalKills
    local bossK = getgenv()._statsBossKills
    local kpm = elapsed > 0 and math.floor(kills / (elapsed / 60) * 10) / 10 or 0

    local currentEXP = 0
    local currentBeli = 0
    local currentLevel = 0
    pcall(function()
        currentLevel = player.Data.Level.Value
        local expVal = player.Data:FindFirstChild("EXP") or player.Data:FindFirstChild("Exp") or player.Data:FindFirstChild("Experience")
        if expVal then currentEXP = expVal.Value end
        local beliVal = player.Data:FindFirstChild("Beli") or player.Data:FindFirstChild("Gold") or player.Data:FindFirstChild("Money") or player.Data:FindFirstChild("Cash")
        if beliVal then currentBeli = beliVal.Value end
    end)

    local expGained = currentEXP - getgenv()._statsStartEXP
    local beliGained = currentBeli - getgenv()._statsStartBeli
    local levelsGained = currentLevel - getgenv()._statsStartLevel

    return {
        uptime = formatUptime(elapsed),
        kills = kills,
        bossKills = bossK,
        kpm = kpm,
        expGained = expGained,
        beliGained = beliGained,
        levelsGained = levelsGained,
        currentLevel = currentLevel,
    }
end

-- Stats display buttons (click to refresh)
local _statsButtons = {}

_statsButtons.uptime = StatsTab:Button({
    Name = "⏱️ Uptime: 00:00:00",
    Callback = function() end, -- updated by loop
})

_statsButtons.kills = StatsTab:Button({
    Name = "💀 Kills: 0 (0/min)",
    Callback = function() end,
})

_statsButtons.bossKills = StatsTab:Button({
    Name = "🐉 Boss Kills: 0",
    Callback = function() end,
})

StatsTab:Section("📈 Gains")

_statsButtons.exp = StatsTab:Button({
    Name = "✨ EXP Gained: 0",
    Callback = function() end,
})

_statsButtons.beli = StatsTab:Button({
    Name = "💰 Beli Gained: 0",
    Callback = function() end,
})

_statsButtons.levels = StatsTab:Button({
    Name = "📈 Levels Gained: 0 (Lv.?)",
    Callback = function() end,
})

StatsTab:Section("🔧 Controls")

StatsTab:Button({
    Name = "🔄 Reset Stats",
    Callback = function()
        getgenv()._statsStartTime  = os.time()
        getgenv()._statsTotalKills = 0
        getgenv()._statsBossKills  = 0
        pcall(function()
            getgenv()._statsStartLevel = player.Data.Level.Value
            local expVal = player.Data:FindFirstChild("EXP") or player.Data:FindFirstChild("Exp") or player.Data:FindFirstChild("Experience")
            if expVal then getgenv()._statsStartEXP = expVal.Value end
            local beliVal = player.Data:FindFirstChild("Beli") or player.Data:FindFirstChild("Gold") or player.Data:FindFirstChild("Money") or player.Data:FindFirstChild("Cash")
            if beliVal then getgenv()._statsStartBeli = beliVal.Value end
        end)
        setStatus("📊 Stats reset!")
    end,
})

-- Auto-update stats display every 5s
task.spawn(function()
    while true do
        task.wait(5)
        pcall(function()
            local s = getStatsText()
            if _statsButtons.uptime and _statsButtons.uptime.SetName then
                _statsButtons.uptime:SetName("⏱️ Uptime: " .. s.uptime)
            end
            if _statsButtons.kills and _statsButtons.kills.SetName then
                _statsButtons.kills:SetName(string.format("💀 Kills: %d (%.1f/min)", s.kills, s.kpm))
            end
            if _statsButtons.bossKills and _statsButtons.bossKills.SetName then
                _statsButtons.bossKills:SetName("🐉 Boss Kills: " .. s.bossKills)
            end
            if _statsButtons.exp and _statsButtons.exp.SetName then
                _statsButtons.exp:SetName("✨ EXP Gained: " .. tostring(s.expGained))
            end
            if _statsButtons.beli and _statsButtons.beli.SetName then
                _statsButtons.beli:SetName("💰 Beli Gained: " .. tostring(s.beliGained))
            end
            if _statsButtons.levels and _statsButtons.levels.SetName then
                _statsButtons.levels:SetName(string.format("📈 Levels: +%d (Lv.%d)", s.levelsGained, s.currentLevel))
            end
        end)
    end
end)

-- ─── TAB 8: ⚙️ Settings ───
local SettingsTab = GUI:Tab({ Name = "⚙️ Settings" })

SettingsTab:Section("🔧 Combat")

SettingsTab:Dropdown({
    Name = "⚔️ Weapon Mode",
    Items = {"Melee", "Fruit"},
    Callback = function(val)
        getgenv().WeaponMode = val
        markConfigDirty()
    end,
})

SettingsTab:Section("🔧 Utility")

toggleRefs.IsNoclip = SettingsTab:Toggle({
    Name = "👻 Noclip",
    Default = false,
    Callback = function(state)
        getgenv().IsNoclip = state
        setStatus(state and "👻 Noclip ON" or "Noclip OFF")
        markConfigDirty()
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

SettingsTab:Section("💾 Config Save/Load")

SettingsTab:Toggle({
    Name = "💾 Auto Save (every 30s)",
    Default = true,
    Callback = function(state)
        _autoSaveEnabled = state
        setStatus(state and "💾 Auto Save ON" or "Auto Save OFF")
    end,
})

SettingsTab:Button({
    Name = "💾 Save Config Now",
    Callback = function()
        saveConfig()
    end,
})

SettingsTab:Button({
    Name = "📂 Load Config",
    Callback = function()
        loadConfig()
        syncTogglesFromConfig()
    end,
})

SettingsTab:Button({
    Name = "🔄 Reset Config (Default)",
    Callback = function()
        resetConfig()
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
        -- Rebuild dropdown items
        if mobDropdown then
            local freshMobs = {"Auto (by Level)"}
            for _, mob in ipairs(MobDatabase) do
                local maxLvlStr = (mob.maxLevel == "MAX") and "+" or ("-" .. tostring(mob.maxLevel))
                table.insert(freshMobs, string.format("[Lv.%d%s] %s", mob.minLevel, maxLvlStr, mob.name))
            end
            mobDropdown:SetItems(freshMobs)
        end
        if bossDropdown then
            bossDropdown:SetItems(BossList)
        end
        setStatus(string.format("✅ Found %d mobs, %d bosses", #MobDatabase, #BossList))
    end,
})

-- ══════════════════════════════════════════
-- 13b. SYNC TOGGLES FROM SAVED CONFIG
-- ══════════════════════════════════════════
syncTogglesFromConfig = function()
    local mapping = {
        IsFarm = "IsFarm", PlankMode = "PlankMode", QuestMode = "QuestMode",
        IsBossFight = "IsBossFight", IsSummonBoss = "IsSummonBoss",
        IsAutoDungeon = "IsAutoDungeon", IsBossRush = "IsBossRush",
        IsDungeonQuest = "IsDungeonQuest", IsHogyokuQuest = "IsHogyokuQuest",
        IsAutoChest = "IsAutoChest", IsAutoMerchant = "IsAutoMerchant",
        IsNoclip = "IsNoclip",
    }
    for refKey, envKey in pairs(mapping) do
        local ref = toggleRefs[refKey]
        if ref and ref.Set then
            ref:Set(getgenv()[envKey] == true)
        end
    end
end

-- Sync UI to match any config loaded at startup (line 219)
syncTogglesFromConfig()

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
            setStatus("💀 Waiting for respawn...")
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
            local targetNPC

            -- Quest mode: only if no mob selected AND quest mode is ON
            if not targetMobName and getgenv().QuestMode then
                local _npc, _, choosenpc = getTargetQuest()
                targetNPC = _npc
                targetMobName = choosenpc
            end

            if not targetMobName then
                -- No mob selected + no quest mode = farm nearest mob
                local nearestMob = findMob(nil)
                if nearestMob then
                    targetMobName = nearestMob.Name
                else
                    setStatus("❓ No mobs found nearby.")
                    task.wait(1)
                    continue
                end
            end

            -- Accept quest only if quest mode is on
            if targetNPC and getgenv().QuestMode then
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

                    -- Fire RequestHit on first approach to initialize combat
                    pcall(function()
                        local hitTarget = mob:FindFirstChild("HumanoidRootPart") or mob
                        RepStorage:WaitForChild("CombatSystem"):WaitForChild("Remotes"):WaitForChild("RequestHit"):FireServer(hitTarget)
                    end)
                    equipWeapon()

                    while getgenv().IsFarm and mob and mob.Parent and mob:FindFirstChild("HumanoidRootPart") do
                        local h = mob:FindFirstChildOfClass("Humanoid")
                        if not h or h.Health <= 0 then break end
                        tweenToMob(mob)
                        autoAttack(mob)
                        setStatus(string.format("⚔️ %s | ❤️%d/%d | 🗡️%s", mob.Name, h.Health, h.MaxHealth, getgenv().WeaponMode))
                        task.wait(getgenv().AttackCooldown)
                    end

                    -- ── Kill counter hook ──
                    getgenv()._statsTotalKills = getgenv()._statsTotalKills + 1
                    setStatus("✅ Killed: " .. (mob and mob.Name or "mob") .. " | Total: " .. getgenv()._statsTotalKills)
                    task.wait(0.3)
                end
            else
                setStatus("🔍 " .. targetMobName .. " → Switching island...")
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
    Title = "✦ Sailor Piece Hub v4+",
    Text = "Full Edition loaded! 8 Tabs | Stats + Teleport | F2/V=Farm B=Boss N=Summon M=Skills",
    Duration = 5,
})

print("✅ Sailor Piece Hub v4+ loaded! (Full Edition | 8 Tabs | Stats + Teleport | Priority Loop)")