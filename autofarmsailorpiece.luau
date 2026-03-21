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

-- Spam attack (PHẢI truyền target position, không thì server ignore)
local function spamAttack(targetPosition)
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

-- State
local selectedBosses = {}            -- { "Gojo" = true, "Sukuna" = true, ... }
local bossFarmTweenEnabled = false   -- Toggle 1: Tween approach
local bossFarmXenoEnabled = false    -- Toggle 2: Xeno CFrame approach
local bossTweenSpeed = 0.1
local bossXenoSpeed = 0.1

-- UI Section
Tab:Section("⏱️ Timed Bosses")

Tab:Dropdown({
    Name = "Select Bosses",
    Items = timedBossList,
    MultiSelect = true,
    Callback = function(selectedList)
        -- ★ FIX: NovaLib MultiSelect fires callback per item as STRING (not table)
        -- Mỗi lần user click 1 boss → callback nhận string tên boss đó
        -- Ta toggle on/off trong selectedBosses
        if type(selectedList) == "string" then
            -- Toggle: nếu đã chọn thì bỏ, chưa chọn thì thêm
            if selectedBosses[selectedList] then
                selectedBosses[selectedList] = nil
            else
                selectedBosses[selectedList] = true
            end
        elseif type(selectedList) == "table" then
            -- Fallback nếu lib trả table (phiên bản khác)
            selectedBosses = {}
            for _, bossName in ipairs(selectedList) do
                selectedBosses[bossName] = true
            end
        end
        -- Print danh sách đang chọn
        local names = {}
        for name, _ in pairs(selectedBosses) do table.insert(names, name) end
        print("[Bosses] Selected: " .. (#names > 0 and table.concat(names, ", ") or "none"))
    end
})

-- ───────────────────────────────────────
-- TOGGLE 1: Auto Bosses Farming (Tween)
-- Teleport đảo → Tween mượt tới boss → Attack
-- ───────────────────────────────────────
Tab:Toggle({
    Name = "Auto Bosses Farming",
    Default = false,
    Callback = function(state)
        bossFarmTweenEnabled = state
        if not state then
            lastBossTeleportedIsland = nil -- Reset để bật lại sẽ re-tele đúng đảo
        end
        if state then
            -- Tắt các farm khác tránh xung đột
            if bossFarmXenoEnabled then
                bossFarmXenoEnabled = false
                print("[Bosses] Disabled Xeno Boss Farm to avoid conflict")
            end
            if autoFarmEnabled then
                autoFarmEnabled = false
                pcall(function() stopAboveLock() end)
                print("[Bosses] Disabled Auto Farm to avoid conflict")
            end
            if xenoFarmEnabled then
                xenoFarmEnabled = false
                print("[Bosses] Disabled Xeno Mob Farm to avoid conflict")
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
-- TOGGLE 2: Xeno Auto Bosses Farming (CFrame + Stabilize)
-- TeleportToPortal remote → CFrame trực tiếp + BodyVelocity/BodyGyro
-- ───────────────────────────────────────
Tab:Toggle({
    Name = "Xeno Auto Bosses Farming",
    Default = false,
    Callback = function(state)
        bossFarmXenoEnabled = state
        -- Cleanup stabilize khi tắt + reset island state
        if not state then
            lastXenoBossTeleportedIsland = nil -- Reset để bật lại sẽ re-tele đúng đảo
            local char = Player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                local bv = root:FindFirstChild("BossStabBV")
                local bg = root:FindFirstChild("BossStabBG")
                if bv then bv:Destroy() end
                if bg then bg:Destroy() end
            end
        end
        if state then
            -- Tắt các farm khác tránh xung đột
            if bossFarmTweenEnabled then
                bossFarmTweenEnabled = false
                print("[Bosses] Disabled Tween Boss Farm to avoid conflict")
            end
            if autoFarmEnabled then
                autoFarmEnabled = false
                pcall(function() stopAboveLock() end)
                print("[Bosses] Disabled Auto Farm to avoid conflict")
            end
            if xenoFarmEnabled then
                xenoFarmEnabled = false
                print("[Bosses] Disabled Xeno Mob Farm to avoid conflict")
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
        bossXenoSpeed = value / 100
    end
})

-- ═══════════════════════════════════════════════════════════════
-- ║           BOSS TRACKER (Event-Driven, like xeno.lua)        ║
-- ║  Track boss alive/dead bằng events — KHÔNG CẦN tele đảo    ║
-- ║  để check. Biết boss nào alive ngay từ xa!                  ║
-- ═══════════════════════════════════════════════════════════════

local BossTracker = {
    Active = {},    -- { [bossName] = npcModel } — chỉ boss đang alive
    _connections = {} -- cleanup connections
}

-- Kiểm tra NPC có phải boss trong config không (tên match)
local function isBossNPC(npcName)
    for bossName, _ in pairs(timedBossConfig) do
        if npcName == bossName or npcName:find(bossName) then
            return bossName
        end
    end
    return nil
end

-- Register 1 NPC vào tracker (nếu là boss + alive)
local function registerBossNPC(npc)
    if not npc:IsA("Model") then return end
    local bossName = isBossNPC(npc.Name)
    if not bossName then return end

    local hum = npc:WaitForChild("Humanoid", 3)
    local root = npc:WaitForChild("HumanoidRootPart", 3)
    if not hum or not root then return end

    -- Chỉ track nếu alive
    if hum.Health <= 0 then return end

    BossTracker.Active[bossName] = npc
    print("[BossTracker] ✅ Registered: " .. bossName .. " (HP: " .. hum.Health .. ")")

    -- Khi boss chết → xóa khỏi tracker
    local diedConn
    diedConn = hum.Died:Connect(function()
        BossTracker.Active[bossName] = nil
        print("[BossTracker] ❌ Died: " .. bossName)
        if diedConn then diedConn:Disconnect() end
    end)
    table.insert(BossTracker._connections, diedConn)

    -- Khi boss bị xóa khỏi workspace → xóa khỏi tracker
    local ancestryConn
    ancestryConn = npc.AncestryChanged:Connect(function(_, parent)
        if not parent then
            BossTracker.Active[bossName] = nil
            print("[BossTracker] 🗑 Removed: " .. bossName)
            if ancestryConn then ancestryConn:Disconnect() end
        end
    end)
    table.insert(BossTracker._connections, ancestryConn)
end

-- Init: scan tất cả NPCs hiện có + lắng nghe NPCs mới spawn
local function initBossTracker()
    local npcsFolder = workspace:FindFirstChild("NPCs")
    if not npcsFolder then
        -- Đợi NPCs folder xuất hiện
        npcsFolder = workspace:WaitForChild("NPCs", 30)
        if not npcsFolder then
            warn("[BossTracker] NPCs folder not found!")
            return
        end
    end

    -- Scan NPCs hiện có
    for _, npc in pairs(npcsFolder:GetChildren()) do
        registerBossNPC(npc)
    end

    -- Lắng nghe NPCs mới spawn (boss respawn)
    local addConn = npcsFolder.ChildAdded:Connect(function(npc)
        task.wait(0.5) -- Đợi Humanoid/HumanoidRootPart load (0.5s cho chắc)
        registerBossNPC(npc)
    end)
    table.insert(BossTracker._connections, addConn)

    print("[BossTracker] Initialized! Tracking " .. tostring(#npcsFolder:GetChildren()) .. " NPCs")
end

-- Khởi động tracker ngay
task.spawn(initBossTracker)

-- ═══════════════════════════════════════
-- BOSS HELPERS (shared by both modes)
-- ═══════════════════════════════════════

-- Helper: Lấy danh sách boss đã chọn + ALIVE (từ tracker), sort theo HP thấp nhất
local function getSortedSelectedBosses()
    local bossList = {}
    for bossName, _ in pairs(selectedBosses) do
        local config = timedBossConfig[bossName]
        if config then
            -- ★ CHECK TRACKER: boss đang alive không?
            local npc = BossTracker.Active[bossName]
            local isAlive = false
            local currentHP = math.huge -- dead = HP vô cực (sort xuống cuối)
            if npc then
                local hum = npc:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    isAlive = true
                    currentHP = hum.Health
                end
            end
            table.insert(bossList, {
                name = bossName,
                config = config,
                hp = currentHP,
                alive = isAlive,
                npc = npc
            })
        end
    end

    -- Sort: alive trước, rồi HP thấp nhất trước
    table.sort(bossList, function(a, b)
        if a.alive ~= b.alive then return a.alive end
        return a.hp < b.hp
    end)

    return bossList
end

-- Helper: Tính vị trí farm boss (dùng farmMode + farmDistance hiện tại)
local function bossGetGoal(bossRoot)
    local dist = farmDistance
    if farmMode == "Above" then
        local pos = bossRoot.Position
        return CFrame.new(pos + Vector3.new(0, dist, 0), pos)
    else
        return bossRoot.CFrame * CFrame.new(0, 2, dist)
    end
end

-- Helper: Auto equip weapon (dùng chung cho cả 2 mode)
local function bossAutoEquip(char)
    if autoEquipEnabled and selectedWeapon then
        local alreadyEquipped = char:FindFirstChild(selectedWeapon)
        if not alreadyEquipped then
            local tool = Player.Backpack:FindFirstChild(selectedWeapon)
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if tool and humanoid then
                humanoid:EquipTool(tool)
            end
        end
    end
end

-- ═══════════════════════════════════════════════════════════════
-- ★ LOOP A: TWEEN BOSS FARM (CẢI TIẾN VỚI BOSS TRACKER)
-- ★ Sort theo HP thấp nhất + Target Lock + Đứng yên chờ khi không có boss
-- ★ Flow: Quét boss alive → Khóa target HP thấp nhất → Tele đảo → Tween → Attack đến chết
-- ═══════════════════════════════════════════════════════════════
local lastBossTeleportedIsland = nil
local tweenBossLockedTarget = nil      -- NPC model đang bị khóa (Tween mode)
local tweenBossLockedName = nil        -- Tên boss đang bị khóa

task.spawn(function()
    while task.wait(bossTweenSpeed) do
        if not bossFarmTweenEnabled then
            tweenBossLockedTarget = nil
            tweenBossLockedName = nil
            continue
        end

        local char = Player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then continue end

        -- ★ TARGET LOCK: Nếu đang khóa target → kiểm tra nó còn sống không
        if tweenBossLockedTarget then
            local bh = tweenBossLockedTarget:FindFirstChildOfClass("Humanoid")
            local br = tweenBossLockedTarget:FindFirstChild("HumanoidRootPart")
            if bh and bh.Health > 0 and br and tweenBossLockedTarget.Parent then
                -- Target vẫn sống → tiếp tục đánh nó (KHÔNG sort lại)
                local config = timedBossConfig[tweenBossLockedName]

                -- Tele đảo nếu quá xa
                local distToBoss = (root.Position - br.Position).Magnitude
                if distToBoss > 150 and config and config.remote then
                    if lastBossTeleportedIsland ~= config.remote then
                        teleportToIsland(config.remote)
                        lastBossTeleportedIsland = config.remote
                        task.wait(1)
                    end
                end

                -- Tween tới boss
                local g = bossGetGoal(br)
                tweenTo(g)

                -- Equip + attack
                bossAutoEquip(char)
                spamAttack(br.Position)
                continue -- Không tìm boss mới, tiếp tục tick sau
            else
                -- Target đã chết hoặc bị xóa → mở khóa, tìm boss mới
                print("[Bosses] ✅ " .. (tweenBossLockedName or "?") .. " defeated! Finding next target...")
                tweenBossLockedTarget = nil
                tweenBossLockedName = nil
            end
        end

        -- ★ TÌM BOSS MỚI: Sort theo HP thấp nhất
        local sortedBosses = getSortedSelectedBosses()
        if #sortedBosses == 0 then continue end

        local foundTarget = false
        for _, bossInfo in ipairs(sortedBosses) do
            if not bossFarmTweenEnabled then break end
            if not bossInfo.alive or not bossInfo.npc then continue end

            local bossNPC = bossInfo.npc
            local bossRoot = bossNPC:FindFirstChild("HumanoidRootPart")
            local bossHum = bossNPC:FindFirstChildOfClass("Humanoid")
            if not bossRoot or not bossHum or bossHum.Health <= 0 then continue end

            -- ★ KHÓA TARGET mới (con HP thấp nhất)
            tweenBossLockedTarget = bossNPC
            tweenBossLockedName = bossInfo.name
            print("[Bosses] 🎯 Locked target: " .. bossInfo.name .. " (HP: " .. math.floor(bossHum.Health) .. ")")

            -- Tele đảo nếu cần
            local config = bossInfo.config
            local distToBoss = (root.Position - bossRoot.Position).Magnitude
            if distToBoss > 150 and config.remote then
                if lastBossTeleportedIsland ~= config.remote then
                    teleportToIsland(config.remote)
                    lastBossTeleportedIsland = config.remote
                    task.wait(1)
                end
            end

            -- Tween tới boss + equip + attack
            local goal = bossGetGoal(bossRoot)
            tweenTo(goal)
            bossAutoEquip(char)
            spamAttack(bossRoot.Position)
            foundTarget = true
            break
        end

        -- ★ KHÔNG CÓ BOSS ALIVE → ĐỨNG YÊN TẠI CHỖ, chờ boss spawn
        if not foundTarget then
            -- Không di chuyển, không xoay vòng. Chỉ print 1 lần mỗi 5s
            -- (loop tự kiểm tra lại mỗi bossTweenSpeed tick)
        end
    end
end)

-- ═══════════════════════════════════════
-- ★ LOOP B: XENO BOSS FARM
-- TeleportToPortal remote → CFrame trực tiếp + BodyVelocity/BodyGyro
-- (Giống cách Xeno farm mob)
-- ═══════════════════════════════════════

-- Boss-specific stabilize (tên riêng để không xung đột với mob xeno)
local function bossStabilize(root, goalCFrame)
    local bv = root:FindFirstChild("BossStabBV")
    if not bv then
        bv = Instance.new("BodyVelocity")
        bv.Name = "BossStabBV"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.P = 100000
        bv.Parent = root
    end
    bv.Velocity = Vector3.new(0, 0, 0)

    local bg = root:FindFirstChild("BossStabBG")
    if not bg then
        bg = Instance.new("BodyGyro")
        bg.Name = "BossStabBG"
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.D = 500
        bg.P = 100000
        bg.Parent = root
    end
    bg.CFrame = goalCFrame
end

local function bossDestabilize(root)
    local bv = root:FindFirstChild("BossStabBV")
    local bg = root:FindFirstChild("BossStabBG")
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
end

local lastXenoBossTeleportedIsland = nil
local xenoBossLockedTarget = nil       -- NPC model đang bị khóa (Xeno mode)
local xenoBossLockedName = nil         -- Tên boss đang bị khóa

task.spawn(function()

    while task.wait(bossXenoSpeed) do
        if not bossFarmXenoEnabled then
            xenoBossLockedTarget = nil
            xenoBossLockedName = nil
            bossDestabilize(Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") or nil)
            continue
        end

        local char = Player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then continue end

        -- ★ TARGET LOCK: Nếu đang khóa target → kiểm tra nó còn sống không
        if xenoBossLockedTarget then
            local bh = xenoBossLockedTarget:FindFirstChildOfClass("Humanoid")
            local br = xenoBossLockedTarget:FindFirstChild("HumanoidRootPart")
            if bh and bh.Health > 0 and br and xenoBossLockedTarget.Parent then
                -- Target vẫn sống → tiếp tục đánh (KHÔNG sort lại)
                local config = timedBossConfig[xenoBossLockedName]

                -- Tele đảo nếu quá xa (xeno style: TeleportToPortal)
                local distToBoss = (root.Position - br.Position).Magnitude
                if distToBoss > 150 and config and config.remote then
                    local TpRemoteBoss = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("TeleportToPortal")
                    if TpRemoteBoss and lastXenoBossTeleportedIsland ~= config.remote then
                        pcall(function() TpRemoteBoss:FireServer(config.remote) end)
                        lastXenoBossTeleportedIsland = config.remote
                        task.wait(0.5)
                    end
                end

                -- CFrame trực tiếp + stabilize (xeno style)
                local g = bossGetGoal(br)
                bossStabilize(root, g)
                root.CFrame = g

                -- Equip + attack
                bossAutoEquip(char)
                spamAttack(br.Position)
                continue -- Không tìm boss mới
            else
                -- Target đã chết hoặc bị xóa → mở khóa
                print("[Bosses] ✅ " .. (xenoBossLockedName or "?") .. " defeated! (Xeno) Finding next...")
                xenoBossLockedTarget = nil
                xenoBossLockedName = nil
                bossDestabilize(root)
            end
        end

        -- ★ TÌM BOSS MỚI: Sort theo HP thấp nhất
        local sortedBosses = getSortedSelectedBosses()
        if #sortedBosses == 0 then continue end

        local foundTarget = false
        for _, bossInfo in ipairs(sortedBosses) do
            if not bossFarmXenoEnabled then break end
            if not bossInfo.alive or not bossInfo.npc then continue end

            local bossNPC = bossInfo.npc
            local bossRoot = bossNPC:FindFirstChild("HumanoidRootPart")
            local bossHum = bossNPC:FindFirstChildOfClass("Humanoid")
            if not bossRoot or not bossHum or bossHum.Health <= 0 then continue end

            -- ★ KHÓA TARGET mới
            xenoBossLockedTarget = bossNPC
            xenoBossLockedName = bossInfo.name
            print("[Bosses] 🎯 Xeno locked target: " .. bossInfo.name .. " (HP: " .. math.floor(bossHum.Health) .. ")")

            -- Tele đảo (xeno style)
            local config = bossInfo.config
            local distToBoss = (root.Position - bossRoot.Position).Magnitude
            if distToBoss > 150 and config.remote then
                local TpRemoteBoss = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("TeleportToPortal")
                if TpRemoteBoss then
                    pcall(function() TpRemoteBoss:FireServer(config.remote) end)
                    lastXenoBossTeleportedIsland = config.remote
                    task.wait(0.5)
                end
            end

            -- CFrame + stabilize + equip + attack
            local goal = bossGetGoal(bossRoot)
            bossStabilize(root, goal)
            root.CFrame = goal
            bossAutoEquip(char)
            spamAttack(bossRoot.Position)
            foundTarget = true
            break
        end

        -- ★ KHÔNG CÓ BOSS ALIVE → ĐỨNG YÊN TẠI CHỖ, chờ boss spawn
        if not foundTarget then
            bossDestabilize(root) -- Xóa BodyMovers để không giữ cứng
            -- Không di chuyển, không xoay vòng. Loop tự poll lại mỗi tick.
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- ║          XENO AUTO FARM (Bypass Anticheat Style)           ║
-- ║  Dùng TeleportToPortal remote + CFrame trực tiếp          ║
-- ║  + BodyVelocity/BodyGyro giữ vị trí                       ║
-- ═══════════════════════════════════════════════════════════════

local xenoFarmEnabled = false
local xenoFarmSpeed = 0.1  -- delay giữa mỗi lần CFrame (giống TweenSpeed trong xeno)

-- Remote references (cache 1 lần)
local TpRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TeleportToPortal")

Tab:Section("Xeno Auto Farm (Bypass)")

Tab:Toggle({
    Name = "Xeno Auto Farm",
    Default = false,
    Callback = function(state)
        xenoFarmEnabled = state
        -- Tắt → cleanup stabilize
        if not state then
            local char = Player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                local bv = root:FindFirstChild("XenoStabBV")
                local bg = root:FindFirstChild("XenoStabBG")
                if bv then bv:Destroy() end
                if bg then bg:Destroy() end
            end
        end
        -- Tắt farm cũ khi bật xeno (tránh xung đột)
        if state and autoFarmEnabled then
            autoFarmEnabled = false
            pcall(function() stopAboveLock() end)
            print("[Xeno] Disabled old Auto Farm to avoid conflict")
        end
    end
})

Tab:Slider({
    Name = "Xeno TP Speed (s)",
    Min = 1,    -- 0.01s
    Max = 50,   -- 0.5s
    Default = 10, -- 0.1s
    Callback = function(value)
        xenoFarmSpeed = value / 100
    end
})

-- Stabilize: thêm BodyVelocity + BodyGyro giữ character đứng yên (giống xeno DungeonFarmer)
local function xenoStabilize(root, goalCFrame)
    -- BodyVelocity: triệt tiêu mọi chuyển động
    local bv = root:FindFirstChild("XenoStabBV")
    if not bv then
        bv = Instance.new("BodyVelocity")
        bv.Name = "XenoStabBV"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.P = 100000
        bv.Parent = root
    end
    bv.Velocity = Vector3.new(0, 0, 0)

    -- BodyGyro: giữ hướng nhìn cố định
    local bg = root:FindFirstChild("XenoStabBG")
    if not bg then
        bg = Instance.new("BodyGyro")
        bg.Name = "XenoStabBG"
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.D = 500
        bg.P = 100000
        bg.Parent = root
    end
    bg.CFrame = goalCFrame
end

-- Destabilize: xóa BodyMovers khi chuyển target
local function xenoDestabilize(root)
    local bv = root:FindFirstChild("XenoStabBV")
    local bg = root:FindFirstChild("XenoStabBG")
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
end

-- Tính vị trí farm (giống _getGoal trong xeno)
local function xenoGetGoal(npcRoot)
    local dist = farmDistance
    if farmMode == "Above" then
        local pos = npcRoot.Position
        return CFrame.new(pos + Vector3.new(0, dist, 0), pos)
    else
        -- Behind: đứng sau lưng NPC
        return npcRoot.CFrame * CFrame.new(0, 2, dist)
    end
end

-- XENO FARM: Loop teleport + quest (giống loop cũ nhưng riêng biệt)
task.spawn(function()
    while task.wait(2) do
        if xenoFarmEnabled and selectedMob then
            local config = mobConfig[selectedMob]
            if config then
                -- Check đang ở đảo đúng chưa
                if not isOnIsland(config.workspaceFolder) then
                    for attempt = 1, 5 do
                        print("[Xeno] Teleport to " .. config.island .. " (attempt " .. attempt .. "/5)")
                        pcall(function() TpRemote:FireServer(config.island) end)
                        task.wait(3)
                        if isOnIsland(config.workspaceFolder) then
                            print("[Xeno] Arrived at " .. config.island)
                            break
                        end
                    end
                end
                -- Accept quest
                if isOnIsland(config.workspaceFolder) and not isQuestActive() then
                    acceptQuest(config.quest)
                end
            end
        end
    end
end)

-- XENO FARM: Main farm loop (CFrame trực tiếp + TeleportToPortal bypass)
task.spawn(function()
    while task.wait(xenoFarmSpeed) do
        if not xenoFarmEnabled or not selectedMob then continue end

        local config = mobConfig[selectedMob]
        if not config then continue end

        local char = Player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then continue end

        -- Tìm NPC gần nhất còn sống
        local npc = findClosestNPC()
        if not npc then
            xenoDestabilize(root)
            continue
        end

        local npcRoot = npc:FindFirstChild("HumanoidRootPart")
        local npcHum = npc:FindFirstChildOfClass("Humanoid")
        if not npcRoot or not npcHum or npcHum.Health <= 0 then
            xenoDestabilize(root)
            continue
        end

        -- Tính khoảng cách
        local distance = (root.Position - npcRoot.Position).Magnitude

        -- ★ BYPASS ANTICHEAT: Nếu quá xa (>150 studs) → fire TeleportToPortal TRƯỚC
        -- Server sẽ chấp nhận vị trí mới, không kéo về chỗ cũ
        if distance > 150 and config.island then
            pcall(function() TpRemote:FireServer(config.island) end)
            task.wait(0.3) -- Chờ server xử lý
        end

        -- Tính vị trí goal
        local goal = xenoGetGoal(npcRoot)

        -- Stabilize (giữ đứng yên bằng BodyVelocity + BodyGyro)
        xenoStabilize(root, goal)

        -- ★ TP TRỰC TIẾP bằng CFrame (không dùng Tween)
        root.CFrame = goal

        -- Auto equip weapon
        if autoEquipEnabled and selectedWeapon then
            local alreadyEquipped = char:FindFirstChild(selectedWeapon)
            if not alreadyEquipped then
                local tool = Player.Backpack:FindFirstChild(selectedWeapon)
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if tool and humanoid then
                    humanoid:EquipTool(tool)
                end
            end
        end

        -- Spam attack vào vị trí NPC
        spamAttack(npcRoot.Position)
    end
end)

-- Cleanup stabilize khi character respawn
Player.CharacterAdded:Connect(function()
    task.wait(1)
    -- BodyMovers tự mất khi character mới spawn, không cần cleanup
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
                    if char and obj:IsDescendantOf(char) then continue end
                    if obj.Transparency < 1 then
                        hiddenParts[obj] = obj.Transparency
                        obj.Transparency = 1
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
