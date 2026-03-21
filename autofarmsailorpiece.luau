local NovaLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jachvn112-droid/sailor-piece-script/refs/heads/main/NovaLib.luau"))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

local Window = NovaLib:Create({
    Name = "Auto Farm Sailor Piece",
    Theme = NovaLib.Themes.Midnight
})

local Tab = Window:Tab({ Name = "Auto Farm" })

-- ═══════════════════════════════════════
-- STATE
-- ═══════════════════════════════════════
local selectedMob = nil
local autoFarmEnabled = false
local autoEquipEnabled = false
local selectedWeapon = nil
local tweenSpeed = 100
local farmDistance = 5
local farmMode = "Behind" -- Behind / Above
local autoSkillEnabled = false
local selectedSkillId = nil

-- Forward declaration (defined later)
local stopAboveLock

-- ═══════════════════════════════════════
-- MOB CONFIG: mỗi mob cần Island + QuestNPC + WorkspaceFolder
-- island         = tên gửi qua remote TeleportToPortal
-- quest          = tên QuestNPC gửi qua remote QuestAccept
-- workspaceFolder = tên folder trong workspace chứa parts của đảo đó
-- ═══════════════════════════════════════
local mobConfig = {
    ["Thief"]          = { island = "Starter",  quest = "QuestNPC1", workspaceFolder = "StarterIsland" },
    ["ThiefBoss"]      = { island = "Starter",  quest = "QuestNPC2", workspaceFolder = "StarterIsland" },
    ["Monkey"]         = { island = "Jungle",   quest = "QuestNPC3", workspaceFolder = "JungleIsland" },
    ["MonkeyBoss"]     = { island = "Jungle",   quest = "QuestNPC4", workspaceFolder = "JungleIsland" },
    ["DesertBandit"]   = { island = "Desert",   quest = "QuestNPC5", workspaceFolder = "DesertIsland" },
    ["DesertBoss"]     = { island = "Desert",   quest = "QuestNPC6", workspaceFolder = "DesertIsland" },
    ["FrostRogue"]     = { island = "Snow",     quest = "QuestNPC7", workspaceFolder = "SnowIsland" },
    ["SnowBoss"]       = { island = "Snow",     quest = "QuestNPC8", workspaceFolder = "SnowIsland" },
    ["Sorcerer"]       = { island = "Shibuya",  quest = "QuestNPC9", workspaceFolder = "Shibuya" },
    ["PandaMiniBoss"]  = { island = "Shibuya",  quest = "QuestNPC10", workspaceFolder = "Shibuya" },
    ["Hollow"]         = { island = "HuecoMundo", quest = "QuestNPC11", workspaceFolder = "HuecoMundo" },
    ["StrongSorcerer"] = { island = "Shinjuku", quest = "QuestNPC12", workspaceFolder = "ShinjukuIsland" },
    ["Curse"]          = { island = "Shinjuku", quest = "QuestNPC13", workspaceFolder = "ShinjukuIsland" },
    ["Slime"]          = { island = "Slime",    quest = "QuestNPC14", workspaceFolder = "SlimeIsland" },
    ["AcademyTeacher"] = { island = "Academy",  quest = "QuestNPC15", workspaceFolder = "AcademyIsland" },
    ["Swordsman"]      = { island = "Judgement", quest = "QuestNPC16", workspaceFolder = "JudgementIsland" },
    ["Quincy"]         = { island = "SoulSociety", quest = "QuestNPC17", workspaceFolder = "SoulSocietyIsland" },
    -- Thêm mob mới:
    -- ["MobName"] = { island = "X", quest = "QuestNPCx", workspaceFolder = "XIsland" },
}

-- ═══════════════════════════════════════
-- MOB SETTINGS
-- ═══════════════════════════════════════
Tab:Section("Mob Settings")

-- Display name → Internal name mapping
local mobDisplayToInternal = {
    ["Thief (Lv.10)"]              = "Thief",
    ["Thief Boss (Lv.25)"]         = "ThiefBoss",
    ["Monkey (Lv.250)"]            = "Monkey",
    ["Monkey Boss (Lv.500)"]       = "MonkeyBoss",
    ["Desert Bandit (Lv.750)"]     = "DesertBandit",
    ["Desert Boss (Lv.1000)"]      = "DesertBoss",
    ["Frost Rogue (Lv.1500)"]      = "FrostRogue",
    ["Snow Boss (Lv.2000)"]        = "SnowBoss",
    ["Sorcerer Student (Lv.3000)"] = "Sorcerer",
    ["Panda Boss (Lv.4000)"]       = "PandaMiniBoss",
    ["Hollow (Lv.5000)"]           = "Hollow",
    ["Strong Sorcerer (Lv.6000)"]  = "StrongSorcerer",
    ["Curse (Lv.7000)"]            = "Curse",
    ["Slime (Lv.8000)"]            = "Slime",
    ["Academy Teacher (Lv.9000)"]  = "AcademyTeacher",
    ["Swordsman (Lv.10000)"]       = "Swordsman",
    ["Quincy (Lv.10750)"]          = "Quincy",
}

local mobDisplayList = {
    "Thief (Lv.10)",
    "Thief Boss (Lv.25)",
    "Monkey (Lv.250)",
    "Monkey Boss (Lv.500)",
    "Desert Bandit (Lv.750)",
    "Desert Boss (Lv.1000)",
    "Frost Rogue (Lv.1500)",
    "Snow Boss (Lv.2000)",
    "Sorcerer Student (Lv.3000)",
    "Panda Boss (Lv.4000)",
    "Hollow (Lv.5000)",
    "Strong Sorcerer (Lv.6000)",
    "Curse (Lv.7000)",
    "Slime (Lv.8000)",
    "Academy Teacher (Lv.9000)",
    "Swordsman (Lv.10000)",
    "Quincy (Lv.10750)",
}

Tab:Dropdown({
    Name = "Select Mob",
    Items = mobDisplayList,
    Callback = function(selected)
        selectedMob = mobDisplayToInternal[selected] or selected
        print("Selected mob: " .. selectedMob .. " (" .. selected .. ")")
    end
})

Tab:Toggle({
    Name = "Auto Farm",
    Default = false,
    Callback = function(state)
        autoFarmEnabled = state
        -- Tắt farm → ngay lập tức unfreeze character nếu đang above lock
        if not state then
            pcall(function() stopAboveLock() end)
        end
    end
})

-- ═══════════════════════════════════════
-- FARM SETTINGS
-- ═══════════════════════════════════════
Tab:Section("Farm Settings")

Tab:Dropdown({
    Name = "Farm Position",
    Items = { "Behind", "Above" },
    Callback = function(selected)
        local wasAbove = (farmMode == "Above")
        farmMode = selected
        print("Farm mode: " .. selected)
        -- Đổi từ Above sang Behind → unfreeze ngay
        if wasAbove and selected ~= "Above" then
            pcall(function() stopAboveLock() end)
        end
    end
})

Tab:Slider({
    Name = "Tween Speed",
    Min = 50,
    Max = 500,
    Default = 100,
    Callback = function(value)
        tweenSpeed = value
    end
})

Tab:Slider({
    Name = "Farm Distance",
    Min = 2,
    Max = 30,
    Default = 5,
    Callback = function(value)
        farmDistance = value
    end
})

-- ═══════════════════════════════════════
-- SKILL SETTINGS
-- ═══════════════════════════════════════
Tab:Section("Skill Settings")

local skillDisplayToId = {
    ["F - Skill 1"] = 1,
    ["X - Skill 2"] = 2,
    ["C - Skill 3"] = 3,
    ["V - Skill 4"] = 4,
    ["F - Skill 5"] = 5,
}

local skillDisplayList = {
    "F - Skill 1",
    "X - Skill 2",
    "C - Skill 3",
    "V - Skill 4",
    "F - Skill 5",
}

Tab:Dropdown({
    Name = "Select Skill",
    Items = skillDisplayList,
    Callback = function(selected)
        selectedSkillId = skillDisplayToId[selected]
        print("Selected skill: " .. selected .. " (ID: " .. tostring(selectedSkillId) .. ")")
    end
})

Tab:Toggle({
    Name = "Auto Skill",
    Default = false,
    Callback = function(state)
        autoSkillEnabled = state
    end
})

-- ═══════════════════════════════════════
-- WEAPON SETTINGS
-- ═══════════════════════════════════════
Tab:Section("Weapon Settings")

local function getWeaponList()
    local weapons = {}
    local backpack = Player.Backpack
    local character = Player.Character

    for _, item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") then
            table.insert(weapons, item.Name)
        end
    end

    if character then
        for _, item in pairs(character:GetChildren()) do
            if item:IsA("Tool") then
                if not table.find(weapons, item.Name) then
                    table.insert(weapons, item.Name)
                end
            end
        end
    end

    return weapons
end

local weaponDropdown = Tab:Dropdown({
    Name = "Select Weapon",
    Items = getWeaponList(),
    Callback = function(weapon)
        selectedWeapon = weapon
        print("Selected weapon: " .. weapon)
        local tool = Player.Backpack:FindFirstChild(weapon)
        local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if tool and humanoid then
            humanoid:EquipTool(tool)
        end
    end
})

Tab:Button({
    Name = "🔄 Refresh Weapons",
    Callback = function()
        local newWeapons = getWeaponList()
        weaponDropdown:SetItems(newWeapons)
        print("[Weapons] Refreshed! Found " .. #newWeapons .. " weapons")
    end
})

Tab:Toggle({
    Name = "Auto Equip Weapon",
    Default = false,
    Callback = function(state)
        autoEquipEnabled = state
        if state and selectedWeapon then
            local tool = Player.Backpack:FindFirstChild(selectedWeapon)
            local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
            if tool and humanoid then
                humanoid:EquipTool(tool)
            end
        end
    end
})

-- ═══════════════════════════════════════
-- HELPER FUNCTIONS
-- ═══════════════════════════════════════

-- Check tên NPC có khớp mob đã chọn không (Thief1,Thief2... → Thief, nhưng ThiefBoss ≠ Thief)
local function isMobMatch(npcName, targetMob)
    if not npcName or not targetMob then return false end
    -- Exact match
    if npcName == targetMob then return true end
    -- Pattern: targetMob + số (VD: Thief1, Thief2...)
    -- Nhưng KHÔNG match nếu có chữ khác phía sau (VD: ThiefBoss)
    local pattern = "^" .. targetMob .. "%d+$"
    return string.match(npcName, pattern) ~= nil
end

-- Tìm NPC gần nhất còn sống
local function findClosestNPC()
    local npcsFolder = workspace:FindFirstChild("NPCs")
    if not npcsFolder then return nil end

    local character = Player.Character
    if not character then return nil end

    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end

    local closestNPC = nil
    local closestDist = math.huge

    for _, npc in pairs(npcsFolder:GetChildren()) do
        if npc:IsA("Model") and isMobMatch(npc.Name, selectedMob) then
            local npcHumanoid = npc:FindFirstChildOfClass("Humanoid")
            local npcRoot = npc:FindFirstChild("HumanoidRootPart")
            if npcHumanoid and npcRoot and npcHumanoid.Health > 0 then
                local dist = (root.Position - npcRoot.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closestNPC = npc
                end
            end
        end
    end

    return closestNPC
end

-- Tính vị trí farm dựa theo mode
local function getFarmPosition(npcRoot)
    if farmMode == "Above" then
        -- Ở trên đầu mob, mặt nhìn xuống mob
        local abovePos = npcRoot.Position + Vector3.new(0, farmDistance, 0)
        return CFrame.lookAt(abovePos, npcRoot.Position)
    else
        -- Phía sau mob
        return npcRoot.CFrame * CFrame.new(0, 0, farmDistance)
    end
end

-- Tween đến vị trí
local currentTween = nil
local function tweenTo(targetCFrame)
    local character = Player.Character
    if not character then return end
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    -- Cancel tween cũ
    if currentTween then
        currentTween:Cancel()
    end

    local distance = (root.Position - targetCFrame.Position).Magnitude
    local tweenTime = distance / tweenSpeed

    if tweenTime < 0.05 then tweenTime = 0.05 end

    currentTween = TweenService:Create(root, TweenInfo.new(tweenTime, Enum.EasingStyle.Linear), {
        CFrame = targetCFrame
    })
    currentTween:Play()
end




-- Teleport đến đảo
local function teleportToIsland(islandName)
    pcall(function()
        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TeleportToPortal"):FireServer(islandName)
    end)
end

-- Accept quest
local function acceptQuest(questNPC)
    pcall(function()
        ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("QuestAccept"):FireServer(questNPC)
    end)
end

-- Attack cooldown: tránh spam RequestHit quá nhanh (rate limit)
local lastAttackTime = 0
local attackCooldown = 0.5 -- Chỉ fire mỗi 0.5s (2x/sec thay vì 7-10x)

-- Spam attack (PHẢI truyền target position, không thì server ignore)
local function spamAttack(targetPosition)
    local now = tick()
    if now - lastAttackTime < attackCooldown then return end -- Cooldown chưa hết
    lastAttackTime = now
    pcall(function()
        if targetPosition then
            ReplicatedStorage:WaitForChild("CombatSystem"):WaitForChild("Remotes"):WaitForChild("RequestHit"):FireServer(targetPosition)
        end
    end)
end

-- Check quest UI visible
local function isQuestActive()
    local ok, result = pcall(function()
        local questUI = Player.PlayerGui:FindFirstChild("QuestUI")
        if questUI then
            local quest = questUI:FindFirstChild("Quest")
            if quest then return quest.Visible end
        end
        return false
    end)
    return ok and result
end

-- ═══════════════════════════════════════
-- ISLAND DETECTION: Raycast xuống check đang đứng trên đảo nào
-- ═══════════════════════════════════════
local function isOnIsland(workspaceFolderName)
    local character = Player.Character
    if not character then return false end
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return false end

    local islandFolder = workspace:FindFirstChild(workspaceFolderName)
    if not islandFolder then return false end

    -- Raycast thẳng xuống từ chân player
    local rayOrigin = root.Position
    local rayDirection = Vector3.new(0, -100, 0)
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Whitelist
    rayParams.FilterDescendantsInstances = {islandFolder}

    local result = workspace:Raycast(rayOrigin, rayDirection, rayParams)
    if result and result.Instance then
        return true -- Đang đứng trên part thuộc đảo này
    end

    -- Fallback: check tất cả parts trong island folder
    -- (phòng trường hợp raycast miss do terrain phức tạp)
    for _, part in pairs(islandFolder:GetDescendants()) do
        if part:IsA("BasePart") then
            local dist = (root.Position - part.Position).Magnitude
            if dist < 150 then
                return true
            end
        end
    end

    return false
end

-- ═══════════════════════════════════════
-- MAIN LOOPS
-- Flow: Teleport 1 lần → Quest → Farm Mob
-- Retry nếu lag teleport thất bại
-- ═══════════════════════════════════════
local lastTeleportedIsland = nil -- Track đảo đã tele rồi

-- Loop 1: Teleport + Quest (mỗi 2s)
task.spawn(function()
    while task.wait(2) do
        if autoFarmEnabled and selectedMob then
            local config = mobConfig[selectedMob]
            if config then
                -- Step 1: Check đang ở đảo đúng chưa
                if not isOnIsland(config.workspaceFolder) then
                    -- Chưa ở đảo đúng → teleport + retry tối đa 5 lần
                    for attempt = 1, 5 do
                        print("[Farm] Teleport to " .. config.island .. " (attempt " .. attempt .. "/5)")
                        teleportToIsland(config.island)
                        task.wait(3) -- Đợi teleport load

                        if isOnIsland(config.workspaceFolder) then
                            print("[Farm] Arrived at " .. config.island .. "!")
                            lastTeleportedIsland = config.workspaceFolder
                            break
                        end
                        print("[Farm] Lag? Retrying...")
                    end
                end

                -- Step 2: Đã ở đảo đúng → check quest
                if isOnIsland(config.workspaceFolder) and not isQuestActive() then
                    acceptQuest(config.quest)
                end
            end
        end
    end
end)

-- ═══════════════════════════════════════
-- ABOVE MODE: BodyVelocity lock (KHONG Anchored vi no block combat)
-- ═══════════════════════════════════════
local aboveLockConnection = nil
local aboveTargetNPC = nil
local aboveLockActive = false

-- Them BodyVelocity de giu co dinh ma van cho phep combat
local function addHoldForce(root)
    if root:FindFirstChild("FarmHold") then return end
    local bv = Instance.new("BodyVelocity")
    bv.Name = "FarmHold"
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.P = 100000
    bv.Parent = root
end

local function removeHoldForce(root)
    local bv = root:FindFirstChild("FarmHold")
    if bv then bv:Destroy() end
end

local function startAboveLock()
    if aboveLockActive then return end
    aboveLockActive = true

    local character = Player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if root then
        root.Anchored = false
        addHoldForce(root)
    end

    aboveLockConnection = RunService.Stepped:Connect(function()
        if not autoFarmEnabled or farmMode ~= "Above" then
            return
        end

        local char = Player.Character
        local r = char and char:FindFirstChild("HumanoidRootPart")
        if not r then return end

        -- Luon dam bao KHONG Anchored va co BodyVelocity
        r.Anchored = false
        addHoldForce(r)

        local npc = findClosestNPC()
        if not npc then
            aboveTargetNPC = nil
            return
        end
        local npcRoot = npc:FindFirstChild("HumanoidRootPart")
        if not npcRoot then
            aboveTargetNPC = nil
            return
        end

        aboveTargetNPC = npc

        local abovePos = npcRoot.Position + Vector3.new(0, farmDistance, 0)
        r.CFrame = CFrame.lookAt(abovePos, npcRoot.Position)
    end)
end

stopAboveLock = function()
    if not aboveLockActive then return end
    aboveLockActive = false

    if aboveLockConnection then
        aboveLockConnection:Disconnect()
        aboveLockConnection = nil
    end
    aboveTargetNPC = nil

    local character = Player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if root then
        removeHoldForce(root)
    end
end

-- ═══════════════════════════════════════
-- ATTACK + MOVEMENT LOOPS
-- ═══════════════════════════════════════

-- Above mode: attack loop (fire remote lien tuc tu vi tri co dinh)
task.spawn(function()
    while task.wait(0.1) do
        if autoFarmEnabled and selectedMob and farmMode == "Above" then
            if aboveTargetNPC then
                local npcRoot = aboveTargetNPC:FindFirstChild("HumanoidRootPart")
                if npcRoot then
                    spamAttack(npcRoot.Position)
                end
            end
        end
    end
end)

-- Behind mode: tween + attack loop
task.spawn(function()
    while task.wait(0.1) do
        if autoFarmEnabled and selectedMob and farmMode ~= "Above" then
            local npc = findClosestNPC()
            if npc then
                local npcRoot = npc:FindFirstChild("HumanoidRootPart")
                if npcRoot then
                    local character = Player.Character
                    local root = character and character:FindFirstChild("HumanoidRootPart")
                    if root then
                        local farmPos = getFarmPosition(npcRoot)
                        local dist = (root.Position - farmPos.Position).Magnitude
                        if dist > 3 then
                            tweenTo(farmPos)
                        end
                        spamAttack(npcRoot.Position)
                    end
                end
            end
        end
    end
end)

-- Monitor: tự bật/tắt Above lock + cleanup khi đổi mode
task.spawn(function()
    while task.wait(0.3) do
        if autoFarmEnabled and farmMode == "Above" then
            startAboveLock()
        else
            stopAboveLock()
        end
    end
end)



-- Loop 3: Auto equip weapon (mỗi 1s)
task.spawn(function()
    while task.wait(1) do
        if autoEquipEnabled and selectedWeapon then
            local character = Player.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                local alreadyEquipped = character:FindFirstChild(selectedWeapon)
                if humanoid and not alreadyEquipped then
                    local tool = Player.Backpack:FindFirstChild(selectedWeapon)
                    if tool then
                        humanoid:EquipTool(tool)
                    end
                end
            end
        end
    end
end)

-- Loop 4: Auto Skill spam (mỗi 0.3s)
task.spawn(function()
    while task.wait(0.3) do
        if autoSkillEnabled and selectedSkillId then
            pcall(function()
                ReplicatedStorage:WaitForChild("AbilitySystem"):WaitForChild("Remotes"):WaitForChild("RequestAbility"):FireServer(selectedSkillId)
            end)
        end
    end
end)

-- Re-equip sau respawn
Player.CharacterAdded:Connect(function(char)
    task.wait(1)
    if autoEquipEnabled and selectedWeapon then
        local tool = Player.Backpack:FindFirstChild(selectedWeapon)
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if tool and humanoid then
            humanoid:EquipTool(tool)
        end
    end
end)

-- Cập nhật weapon dropdown khi có tool mới
Player.Backpack.ChildAdded:Connect(function(child)
    if child:IsA("Tool") then
        if weaponDropdown and weaponDropdown.Refresh then
            weaponDropdown:Refresh(getWeaponList())
        end
        if autoEquipEnabled and selectedWeapon and child.Name == selectedWeapon then
            task.wait(0.1)
            local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:EquipTool(child)
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- ║                    BOSSES SECTION                          ║
-- ║  Timed Bosses: multi-select, sort by distance, auto farm   ║
-- ║  2 modes: Tween (smooth) vs Xeno (CFrame + stabilize)     ║
-- ═══════════════════════════════════════════════════════════════

-- Boss config: CFrame spawn locations + Remote teleport names (from xeno.lua)
local timedBossConfig = {
    ["Gojo"]    = { cframe = CFrame.new(1858.32, 12.98, 338.14),    remote = "Shibuya" },
    ["Yuji"]    = { cframe = CFrame.new(1537.92, 9.98, 226.10),     remote = "Shibuya" },
    ["Sukuna"]  = { cframe = CFrame.new(1571.26, 77.22, -34.11),    remote = "Shibuya" },
    ["Jinwoo"]  = { cframe = CFrame.new(248.74, 12.09, 927.54),     remote = "Sailor" },
    ["Alucard"] = { cframe = CFrame.new(248.74, 12.09, 927.54),     remote = "Sailor" },
    ["Aizen"]   = { cframe = CFrame.new(-567.22, -0.42, 1228.49),   remote = "HuecoMundo" },
    ["Yamato"]  = { cframe = CFrame.new(-1422.68, 24.42, -1383.46), remote = "Judgement" },
}

local timedBossList = { "Gojo", "Yuji", "Sukuna", "Jinwoo", "Alucard", "Aizen", "Yamato" }

-- ═══════════════════════════════════════════════════════════════
-- ║           UNIFIED BOSS FARM STATE                           ║
-- ═══════════════════════════════════════════════════════════════
local selectedBosses = {}            -- { "Gojo" = true, "Sukuna" = true }
local bossFarmEnabled = false        -- Master toggle (1 toggle duy nhất)
local bossFarmMode = "Tween"         -- "Tween" hoặc "Xeno"
local bossTweenSpeed = 0.1           -- Tween speed (seconds)
local currentBossTarget = nil        -- Boss model đang bị khóa mục tiêu
local currentBossIsland = nil        -- Đảo mà nhân vật đang đứng (sau teleport)

-- UI Section
Tab:Section("⏱️ Timed Bosses")

Tab:Dropdown({
    Name = "Select Bosses",
    Items = timedBossList,
    MultiSelect = true,
    Callback = function(selectedList)
        -- NovaLib MultiSelect: callback nhận STRING mỗi lần click 1 boss
        if type(selectedList) == "string" then
            if selectedBosses[selectedList] then
                selectedBosses[selectedList] = nil
            else
                selectedBosses[selectedList] = true
            end
        elseif type(selectedList) == "table" then
            selectedBosses = {}
            for _, bossName in ipairs(selectedList) do
                selectedBosses[bossName] = true
            end
        end
        local names = {}
        for name, _ in pairs(selectedBosses) do table.insert(names, name) end
        print("[Bosses] Selected: " .. (#names > 0 and table.concat(names, ", ") or "none"))
    end
})

-- ───────────────────────────────────────
-- TOGGLE 1: Auto Bosses Farming (Tween mode)
-- ───────────────────────────────────────
Tab:Toggle({
    Name = "Auto Bosses Farming",
    Default = false,
    Callback = function(state)
        if state then
            bossFarmEnabled = true
            bossFarmMode = "Tween"
            -- Tắt các farm khác tránh xung đột
            if autoFarmEnabled then
                autoFarmEnabled = false
                pcall(function() stopAboveLock() end)
                print("[Bosses] Disabled Auto Farm to avoid conflict")
            end
        else
            -- Chỉ tắt nếu mode hiện tại đúng là Tween (tránh tắt nhầm khi Xeno đang chạy)
            if bossFarmMode == "Tween" then
                bossFarmEnabled = false
                currentBossTarget = nil
                currentBossIsland = nil
            end
        end
        print("[Bosses] Auto Bosses Farming (Tween) " .. (state and "ON" or "OFF"))
    end
})

Tab:Slider({
    Name = "Boss Tween Speed (s)",
    Min = 1,
    Max = 50,
    Default = 10,
    Callback = function(value)
        bossTweenSpeed = value / 100
    end
})

-- ───────────────────────────────────────
-- TOGGLE 2: Xeno Auto Bosses Farming (CFrame + Stabilize mode)
-- ───────────────────────────────────────
Tab:Toggle({
    Name = "Xeno Auto Bosses Farming",
    Default = false,
    Callback = function(state)
        if state then
            bossFarmEnabled = true
            bossFarmMode = "Xeno"
            -- Tắt các farm khác tránh xung đột
            if autoFarmEnabled then
                autoFarmEnabled = false
                pcall(function() stopAboveLock() end)
                print("[Bosses] Disabled Auto Farm to avoid conflict")
            end
        else
            if bossFarmMode == "Xeno" then
                bossFarmEnabled = false
                currentBossTarget = nil
                currentBossIsland = nil
                -- Cleanup stabilizers khi tắt
                local char = Player.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                if root then
                    local bv = root:FindFirstChild("BossStabBV")
                    local bg = root:FindFirstChild("BossStabBG")
                    if bv then bv:Destroy() end
                    if bg then bg:Destroy() end
                end
            end
        end
        print("[Bosses] Xeno Auto Bosses Farming " .. (state and "ON" or "OFF"))
    end
})

Tab:Slider({
    Name = "Boss Xeno Speed (s)",
    Min = 1,
    Max = 50,
    Default = 10,
    Callback = function(value)
        -- Xeno mode dùng CFrame snap nên speed slider ít ý nghĩa
        -- Giữ lại cho tương thích UI
        bossTweenSpeed = value / 100
    end
})

-- ═══════════════════════════════════════════════════════════════
-- ║        UNIFIED BOSS FARM HELPERS                            ║
-- ═══════════════════════════════════════════════════════════════

--- Check có boss nào được chọn trong dropdown không
local function hasSelectedBosses()
    for _ in pairs(selectedBosses) do return true end
    return false
end

--- Match boss NPC model → config key trong timedBossConfig
--- VD: NPC tên "GojoBoss" hoặc "Gojo1" → trả "Gojo"
local function matchBossToConfig(npcModel)
    for configKey, _ in pairs(timedBossConfig) do
        if npcModel.Name:find("^" .. configKey) then
            return configKey
        end
    end
    return nil
end

--- Lấy island name từ boss model (thông qua config)
local function getBossIslandFromModel(bossModel)
    local configKey = matchBossToConfig(bossModel)
    if configKey and timedBossConfig[configKey] then
        return timedBossConfig[configKey].remote
    end
    return nil
end

--- Check boss còn sống + hợp lệ
--- - Humanoid tồn tại, Health > 0
--- - HumanoidRootPart tồn tại
--- - Y > -500 (không rơi dưới map)
local function isBossAlive(boss)
    if not boss or not boss.Parent then return false end
    local h = boss:FindFirstChildOfClass("Humanoid")
    local r = boss:FindFirstChild("HumanoidRootPart")
    if not h or not r then return false end
    if h.Health <= 0 then return false end
    if r.Position.Y < -500 then return false end
    return true
end

--- Quét toàn bộ boss hợp lệ trên map, filter theo dropdown, sort theo HP
--- Returns: sorted table { {model=Model, hp=number, island=string}, ... }
local function scanAndSortBosses()
    local npcsFolder = workspace:FindFirstChild("NPCs")
    if not npcsFolder then return {} end

    local results = {}

    for _, npc in pairs(npcsFolder:GetChildren()) do
        if npc:IsA("Model") then
            -- Check boss có trong dropdown đã chọn không
            local matched = false
            for bossName, _ in pairs(selectedBosses) do
                if npc.Name:find("^" .. bossName) then
                    matched = true
                    break
                end
            end

            if matched and isBossAlive(npc) then
                local h = npc:FindFirstChildOfClass("Humanoid")
                local island = getBossIslandFromModel(npc)
                table.insert(results, {
                    model = npc,
                    hp = h.Health,
                    island = island or "Unknown"
                })
            end
        end
    end

    -- Sort theo HP tăng dần → ưu tiên boss ít máu nhất
    table.sort(results, function(a, b)
        return a.hp < b.hp
    end)

    return results
end

--- Cleanup Xeno stabilizers (BodyVelocity + BodyGyro)
local function cleanupBossStabilizers()
    local char = Player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        local bv = root:FindFirstChild("BossStabBV")
        local bg = root:FindFirstChild("BossStabBG")
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
    end
end

--- Lấy island cho vị trí chờ khi không có boss nào alive
--- Ưu tiên: đảo có nhiều boss được chọn nhất
local function getBestWaitIsland()
    local islandCount = {}
    for bossName, _ in pairs(selectedBosses) do
        local cfg = timedBossConfig[bossName]
        if cfg then
            local island = cfg.remote
            islandCount[island] = (islandCount[island] or 0) + 1
        end
    end
    -- Tìm đảo có count cao nhất
    local bestIsland, bestCount = nil, 0
    for island, count in pairs(islandCount) do
        if count > bestCount then
            bestCount = count
            bestIsland = island
        end
    end
    return bestIsland
end

-- ═══════════════════════════════════════════════════════════════
-- ║    UNIFIED BOSS FARM MAIN LOOP (State Machine)             ║
-- ║                                                             ║
-- ║  Flow:  IDLE → FIND_TARGET → SMART_TELEPORT →              ║
-- ║         MOVE_AND_ATTACK → (boss chết) → FIND_TARGET        ║
-- ═══════════════════════════════════════════════════════════════
task.spawn(function()
    while task.wait(0.2) do
        -- ┌─────────────────────────────────────────────────┐
        -- │ GUARD: Chỉ chạy khi farm BẬT + có boss chọn    │
        -- └─────────────────────────────────────────────────┘
        if not bossFarmEnabled or not hasSelectedBosses() then
            -- Farm tắt → cleanup và idle
            if currentBossTarget then
                currentBossTarget = nil
                cleanupBossStabilizers()
            end
            continue
        end

        -- ┌─────────────────────────────────────────────────┐
        -- │ STEP 1: Validate current target                 │
        -- │ Nếu target chết/mất → unlock ngay lập tức       │
        -- └─────────────────────────────────────────────────┘
        if currentBossTarget and not isBossAlive(currentBossTarget) then
            print("[BossFarm] ✗ Target '" .. currentBossTarget.Name .. "' died/invalid → scanning next...")
            currentBossTarget = nil
            cleanupBossStabilizers()
            -- Không continue, đi thẳng xuống step 2 để tìm target mới
        end

        -- ┌─────────────────────────────────────────────────┐
        -- │ STEP 2: Find new target (nếu chưa có)           │
        -- │ Quét map → Sort HP → Lock boss ít máu nhất      │
        -- └─────────────────────────────────────────────────┘
        if not currentBossTarget then
            local sorted = scanAndSortBosses()

            if #sorted == 0 then
                -- ☐ Không có boss nào alive → teleport đảo chờ + idle
                cleanupBossStabilizers()
                local waitIsland = getBestWaitIsland()
                if waitIsland and currentBossIsland ~= waitIsland then
                    print("[BossFarm] No bosses alive → teleport to " .. waitIsland .. " and wait")
                    teleportToIsland(waitIsland)
                    currentBossIsland = waitIsland
                    task.wait(3) -- Đợi teleport xong
                else
                    -- Đã ở đúng đảo, đợi boss respawn
                    task.wait(2)
                end
                continue
            end

            -- ★ Lock target: boss có HP thấp nhất
            currentBossTarget = sorted[1].model
            print("[BossFarm] ★ Locked target: " .. currentBossTarget.Name
                .. " | HP: " .. math.floor(sorted[1].hp)
                .. " | Island: " .. sorted[1].island
                .. " | Total alive: " .. #sorted)
        end

        -- ┌─────────────────────────────────────────────────┐
        -- │ STEP 3: Smart Teleport (chỉ khi KHÁC đảo)      │
        -- │ Cùng đảo → SKIP teleport, chỉ tween/cframe     │
        -- │ Khác đảo → Teleport trước, rồi re-validate     │
        -- └─────────────────────────────────────────────────┘
        local targetIsland = getBossIslandFromModel(currentBossTarget)
        if targetIsland then
            -- Check 1: So sánh island name
            local needTeleport = (currentBossIsland ~= targetIsland)

            -- Check 2: Distance fallback — nếu gần boss (<300 studs) thì KHÔNG cần teleport
            -- (trường hợp player đã ở đúng đảo nhưng currentBossIsland chưa set)
            if needTeleport then
                local bossRoot = currentBossTarget:FindFirstChild("HumanoidRootPart")
                local char = Player.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                if bossRoot and root then
                    local dist = (root.Position - bossRoot.Position).Magnitude
                    if dist < 300 then
                        -- Gần boss → đang ở cùng đảo, chỉ cần update island name
                        needTeleport = false
                        currentBossIsland = targetIsland
                        print("[BossFarm] Already near boss (" .. math.floor(dist) .. " studs) → skip teleport")
                    end
                end
            end

            if needTeleport then
                print("[BossFarm] ➜ Teleporting to island: " .. targetIsland)
                cleanupBossStabilizers()
                teleportToIsland(targetIsland)
                currentBossIsland = targetIsland
                task.wait(3) -- Đợi teleport hoàn tất
                continue     -- Re-validate target sau teleport
            end
        end

        -- ┌─────────────────────────────────────────────────┐
        -- │ STEP 4: Move to boss + Attack                   │
        -- │ Tween mode: tween mượt tới vị trí sau boss      │
        -- │ Xeno mode: CFrame snap + BodyVelocity/BodyGyro  │
        -- └─────────────────────────────────────────────────┘
        local bossRoot = currentBossTarget:FindFirstChild("HumanoidRootPart")
        if not bossRoot then
            -- Boss mất HumanoidRootPart → invalid, unlock
            currentBossTarget = nil
            continue
        end

        local character = Player.Character
        local root = character and character:FindFirstChild("HumanoidRootPart")
        if not root then continue end

        if bossFarmMode == "Tween" then
            -- ── TWEEN MODE ──
            -- Tween mượt tới vị trí phía sau boss
            local targetCF = bossRoot.CFrame * CFrame.new(0, 0, farmDistance)
            local dist = (root.Position - targetCF.Position).Magnitude

            if dist > 3 then
                local tweenTime = math.max(bossTweenSpeed, 0.05)
                local tw = TweenService:Create(root, TweenInfo.new(
                    tweenTime, Enum.EasingStyle.Linear
                ), { CFrame = targetCF })
                tw:Play()
            end

        elseif bossFarmMode == "Xeno" then
            -- ── XENO MODE ──
            -- CFrame snap trực tiếp + stabilize bằng BodyVelocity/BodyGyro
            root.Anchored = false
            root.CFrame = bossRoot.CFrame * CFrame.new(0, 0, farmDistance)

            -- Thêm BodyVelocity để giữ ổn định (không bị đẩy văng)
            if not root:FindFirstChild("BossStabBV") then
                local bv = Instance.new("BodyVelocity")
                bv.Name = "BossStabBV"
                bv.Velocity = Vector3.new(0, 0, 0)
                bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bv.P = 100000
                bv.Parent = root
            end

            -- Thêm BodyGyro để hướng mặt vào boss
            if not root:FindFirstChild("BossStabBG") then
                local bg = Instance.new("BodyGyro")
                bg.Name = "BossStabBG"
                bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                bg.P = 100000
                bg.CFrame = root.CFrame
                bg.Parent = root
            end
        end

        -- ── ATTACK ──
        -- spamAttack đã có cooldown 0.5s bên trong, gọi mỗi cycle an toàn
        spamAttack(bossRoot.Position)
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- ║                    SETTINGS TAB                            ║
-- ═══════════════════════════════════════════════════════════════
local SettingsTab = Window:Tab({ Name = "Settings" })

-- ═══════════════════════════════════════
-- WHITE SCREEN (Xóa map giảm lag nặng)
-- ═══════════════════════════════════════
SettingsTab:Section("Performance")

local whiteScreenEnabled = false
local hiddenParts = {}

SettingsTab:Toggle({
    Name = "White Screen (Giảm Lag)",
    Default = false,
    Callback = function(state)
        whiteScreenEnabled = state
        if state then
            -- Ẩn tất cả BasePart trong workspace (trừ NPCs + Character)
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and not obj:IsDescendantOf(workspace:FindFirstChild("NPCs") or workspace) then
                    local char = Player.Character
                    if not (char and obj:IsDescendantOf(char)) then
                        if obj.Transparency < 1 then
                            hiddenParts[obj] = obj.Transparency
                            obj.Transparency = 1
                        end
                    end
                end
            end
            -- Ẩn Terrain
            pcall(function()
                workspace.Terrain:Clear()
            end)
            print("[Settings] White Screen ON - Map hidden")
        else
            -- Khôi phục
            for part, originalTransparency in pairs(hiddenParts) do
                if part and part.Parent then
                    part.Transparency = originalTransparency
                end
            end
            hiddenParts = {}
            print("[Settings] White Screen OFF - Map restored")
        end
    end
})

-- ═══════════════════════════════════════
-- FPS LOCK
-- ═══════════════════════════════════════
SettingsTab:Slider({
    Name = "FPS Lock",
    Min = 15,
    Max = 240,
    Default = 60,
    Callback = function(value)
        pcall(function()
            setfpscap(value)
        end)
        print("[Settings] FPS locked to " .. value)
    end
})

-- ═══════════════════════════════════════
-- NOCLIP (Đi xuyên tường)
-- ═══════════════════════════════════════
SettingsTab:Section("Movement")

local noclipEnabled = false
local noclipConnection = nil

SettingsTab:Toggle({
    Name = "Noclip (Xuyên Tường)",
    Default = false,
    Callback = function(state)
        noclipEnabled = state
        if state then
            noclipConnection = RunService.Stepped:Connect(function()
                if not noclipEnabled then return end
                local character = Player.Character
                if not character then return end
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
            print("[Settings] Noclip ON")
        else
            if noclipConnection then
                noclipConnection:Disconnect()
                noclipConnection = nil
            end
            -- Khôi phục collision
            local character = Player.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.CanCollide = true
                    end
                end
            end
            print("[Settings] Noclip OFF")
        end
    end
})

-- ═══════════════════════════════════════
-- ANTI-DUPLICATE (Chống chạy script 2 lần)
-- ═══════════════════════════════════════
SettingsTab:Section("Safety")

if _G.AutoFarmSailorPieceLoaded then
    print("[Warning] Script đã chạy rồi! Không load lại.")
    -- Không cần return vì script đã load hết
else
    _G.AutoFarmSailorPieceLoaded = true
end

-- ═══════════════════════════════════════
-- AUTO REJOIN (Tự vào lại khi bị kick)
-- ═══════════════════════════════════════
local autoRejoinEnabled = false

SettingsTab:Toggle({
    Name = "Auto Rejoin (Tự Vào Lại)",
    Default = false,
    Callback = function(state)
        autoRejoinEnabled = state
        print("[Settings] Auto Rejoin " .. (state and "ON" or "OFF"))
    end
})

-- Bắt sự kiện bị kick/disconnect
pcall(function()
    local CoreGui = game:GetService("CoreGui")
    local ErrorPrompt = CoreGui:WaitForChild("RobloxPromptGui", 5)
    if ErrorPrompt then
        ErrorPrompt.DescendantAdded:Connect(function()
            if autoRejoinEnabled then
                task.wait(3)
                pcall(function()
                    game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
                end)
            end
        end)
    end
end)

-- ═══════════════════════════════════════
-- SESSION INFO
-- ═══════════════════════════════════════
SettingsTab:Section("Info")

SettingsTab:Button({
    Name = "📋 Copy Game Link",
    Callback = function()
        pcall(function()
            local link = "https://www.roblox.com/games/" .. tostring(game.PlaceId)
            setclipboard(link)
            print("[Info] Link copied: " .. link)
        end)
    end
})

local startTime = os.time()
SettingsTab:Button({
    Name = "⏱ Session Uptime",
    Callback = function()
        local elapsed = os.time() - startTime
        local mins = math.floor(elapsed / 60)
        local secs = elapsed % 60
        print("[Info] Session uptime: " .. mins .. "m " .. secs .. "s")
    end
})

print("[Auto Farm Sailor Piece] Loaded successfully! ✅")
