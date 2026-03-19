local NovaLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jachvn112-droid/sailor-piece-script/refs/heads/main/NovaLib.luau"))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

local Window = NovaLib:Create({
    Name = "Auto Farm Sailor Piece",
    Theme = NovaLib.Themes.Midnight
})

local Tab = Window:Tab({ Name = "Auto Farm" })

-- ═══════════════════════════════════════
-- MOB SETTINGS
-- ═══════════════════════════════════════
Tab:Section("Mob Settings")

local selectedMob = nil
local autoFarmEnabled = false

-- Bảng map mob → quest NPC remote arg
local mobQuestMap = {
    ["Thief"] = "QuestNPC1",
}

Tab:Dropdown({
    Name = "Select Mob",
    Items = {
        "Thief",          -- Lv 0
        "ThiefBoss",      -- Lv 100
        "Monkey",         -- Lv 250
        "MonkeyBoss",     -- Lv 500
        "DesertBandit",   -- Lv 750
        "DesertBoss",     -- Lv 1000
        "FrostRogue",     -- Lv 1500
        "SnowBoss",       -- Lv 2000
        "Sorcerer",       -- Lv 3000
        "PandaMiniBoss",  -- Lv 4000
        "Hollow",         -- Lv 5000
        "StrongSorcerer", -- Lv 6250
        "Curse",          -- Lv 7000
        "SlimeWarrior",   -- Lv 8000
        "AcademyTeacher", -- Lv 9000
        "Swordsman",      -- Lv 10000
        "Quincy"          -- Lv 10750
    },
    Callback = function(selected)
        selectedMob = selected
        print("Selected mob: " .. selected)
    end
})

-- Toggle Auto Farm
Tab:Toggle({
    Name = "Auto Farm",
    Default = false,
    Callback = function(state)
        autoFarmEnabled = state
    end
})

-- Hàm accept quest
local function acceptQuest(questNPC)
    pcall(function()
        ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("QuestAccept"):FireServer(questNPC)
    end)
end

-- Hàm check quest UI có đang hiện không
local function isQuestActive()
    local success, result = pcall(function()
        local questUI = Player.PlayerGui:FindFirstChild("QuestUI")
        if questUI then
            local quest = questUI:FindFirstChild("Quest")
            if quest then
                return quest.Visible
            end
        end
        return false
    end)
    if success then
        return result
    end
    return false
end

-- Auto Farm loop: check quest + auto accept
task.spawn(function()
    while task.wait(0.5) do
        if autoFarmEnabled and selectedMob then
            local questNPC = mobQuestMap[selectedMob]
            if questNPC then
                -- Nếu quest UI không hiện (đã hoàn thành hoặc chưa nhận) → accept lại
                if not isQuestActive() then
                    acceptQuest(questNPC)
                    task.wait(1) -- đợi server xử lý
                end
            end
        end
    end
end)

-- ═══════════════════════════════════════
-- WEAPON SETTINGS
-- ═══════════════════════════════════════
Tab:Section("Weapon Settings")

local autoEquipEnabled = false
local selectedWeapon = nil

-- Scan tất cả tool trong Backpack + Character
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

-- Dropdown chọn weapon từ backpack
local weaponDropdown = Tab:Dropdown({
    Name = "Select Weapon",
    Items = getWeaponList(),
    Callback = function(weapon)
        selectedWeapon = weapon
        print("Selected weapon: " .. weapon)

        -- Equip ngay khi chọn
        local tool = Player.Backpack:FindFirstChild(weapon)
        local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if tool and humanoid then
            humanoid:EquipTool(tool)
        end
    end
})

-- Toggle auto equip
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

-- Auto equip loop
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

-- Auto re-equip sau khi respawn
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

-- Cập nhật dropdown khi có tool mới vào backpack
Player.Backpack.ChildAdded:Connect(function(child)
    if child:IsA("Tool") then
        if weaponDropdown and weaponDropdown.Refresh then
            weaponDropdown:Refresh(getWeaponList())
        end

        -- Auto equip nếu đang bật
        if autoEquipEnabled and selectedWeapon and child.Name == selectedWeapon then
            task.wait(0.1)
            local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:EquipTool(child)
            end
        end
    end
end)
