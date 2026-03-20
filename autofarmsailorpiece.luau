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
    ["Slime (Lv.8000)"]            = "SlimeWarrior",
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
        farmMode = selected
        print("Farm mode: " .. selected)
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
        -- Ở trên đầu mob + lật 180° úp mặt xuống
        local abovePos = npcRoot.CFrame * CFrame.new(0, farmDistance, 0)
        return abovePos * CFrame.Angles(math.rad(180), 0, 0)
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

-- Di chuyển hitbox (cho mode Above)
local function moveHitbox(npc)
    if farmMode == "Above" then
        -- Dời HumanoidRootPart của player xuống dưới để hit mob bên dưới
        local character = Player.Character
        if character then
            local root = character:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = root.CFrame * CFrame.new(0, -farmDistance, 0)
            end
        end
    end
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

-- Spam attack
local function spamAttack()
    pcall(function()
        ReplicatedStorage:WaitForChild("CombatSystem"):WaitForChild("Remotes"):WaitForChild("RequestHit"):FireServer()
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

-- Loop 2: Tìm mob + tween + spam attack (mỗi 0.1s)
task.spawn(function()
    while task.wait(0.1) do
        if autoFarmEnabled and selectedMob then
            local npc = findClosestNPC()
            if npc then
                local npcRoot = npc:FindFirstChild("HumanoidRootPart")
                if npcRoot then
                    local character = Player.Character
                    local root = character and character:FindFirstChild("HumanoidRootPart")
                    if root then
                        local farmPos = getFarmPosition(npcRoot)
                        local dist = (root.Position - farmPos.Position).Magnitude

                        -- Tween đến vị trí farm nếu còn xa
                        if dist > 3 then
                            tweenTo(farmPos)
                        end

                        if farmMode == "Above" then
                            -- Snap xuống vị trí mob → fire hit → snap lại lên
                            local savedCFrame = root.CFrame
                            root.CFrame = npcRoot.CFrame * CFrame.new(0, 0, farmDistance)
                            spamAttack()
                            root.CFrame = savedCFrame
                        else
                            -- Behind: đánh bình thường
                            spamAttack()
                        end
                    end
                end
            end
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
