local NovaLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jachvn112-droid/sailor-piece-script/refs/heads/main/NovaLib.luau"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

local Window = NovaLib:Create({
    Name = "Auto Farm Sailor Piece",
    Theme = NovaLib.Themes.Midnight
})

-- ═══════════════════════════════════════
-- TAB 1: AUTO FARM
-- ═══════════════════════════════════════
local Tab = Window:Tab({ Name = "Auto Farm" })

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
        print("Selected mob: " .. selected)
    end
})

-- ═══════════════════════════════════════
-- TAB 2: BACKPACK / TOOL MANAGER
-- ═══════════════════════════════════════
local BackpackTab = Window:Tab({ Name = "Backpack" })

local autoEquipEnabled = false
local autoEquipToolName = nil
local toolButtons = {} -- lưu các button đã tạo

BackpackTab:Section("⚔️ Tool Manager")

-- Toggle Auto Equip
BackpackTab:Toggle({
    Name = "Auto Equip Tool",
    Default = false,
    Callback = function(state)
        autoEquipEnabled = state
        if state and autoEquipToolName then
            -- Equip ngay tool đã chọn
            local backpack = Player.Backpack
            local tool = backpack:FindFirstChild(autoEquipToolName)
            if tool then
                Player.Character:FindFirstChildOfClass("Humanoid"):EquipTool(tool)
            end
        end
    end
})

BackpackTab:Section("🎒 Items in Backpack")

-- Nút Refresh để scan lại backpack
BackpackTab:Button({
    Name = "🔄 Refresh Backpack",
    Callback = function()
        -- Không thể xoá UI cũ trong NovaLib => thông báo tool hiện có
        local backpack = Player.Backpack
        local character = Player.Character
        local toolList = {}

        -- Lấy tool trong Backpack
        for _, item in pairs(backpack:GetChildren()) do
            if item:IsA("Tool") then
                table.insert(toolList, item.Name)
            end
        end

        -- Lấy tool đang equipped (trong Character)
        if character then
            for _, item in pairs(character:GetChildren()) do
                if item:IsA("Tool") then
                    table.insert(toolList, item.Name .. " [Equipped]")
                end
            end
        end

        if #toolList == 0 then
            Window:Notify({
                Title = "Backpack",
                Content = "Không tìm thấy tool nào!",
                Duration = 3
            })
        else
            local msg = table.concat(toolList, "\n")
            Window:Notify({
                Title = "Backpack Items",
                Content = msg,
                Duration = 5
            })
        end
    end
})

-- Hàm tạo button cho mỗi tool
local function createToolButton(toolName)
    if toolButtons[toolName] then return end -- đã có button rồi

    local btnObj = BackpackTab:Button({
        Name = "🗡️ " .. toolName,
        Callback = function()
            local backpack = Player.Backpack
            local character = Player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if not humanoid then return end

            -- Check tool trong backpack
            local tool = backpack:FindFirstChild(toolName)
            if tool then
                humanoid:EquipTool(tool)
                autoEquipToolName = toolName
                Window:Notify({
                    Title = "Equipped",
                    Content = "Đã equip: " .. toolName,
                    Duration = 2
                })
            else
                -- Có thể đang equipped => unequip
                local equipped = character:FindFirstChild(toolName)
                if equipped and equipped:IsA("Tool") then
                    humanoid:UnequipTools()
                    Window:Notify({
                        Title = "Unequipped",
                        Content = "Đã unequip: " .. toolName,
                        Duration = 2
                    })
                end
            end
        end
    })

    toolButtons[toolName] = btnObj
end

-- Scan Backpack lần đầu và tạo button
local function scanBackpack()
    local backpack = Player.Backpack
    local character = Player.Character

    -- Scan tool trong Backpack
    for _, item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") then
            createToolButton(item.Name)
        end
    end

    -- Scan tool đang equipped trong Character
    if character then
        for _, item in pairs(character:GetChildren()) do
            if item:IsA("Tool") then
                createToolButton(item.Name)
            end
        end
    end
end

-- Scan ban đầu
scanBackpack()

-- Tự động detect tool mới được thêm vào Backpack
Player.Backpack.ChildAdded:Connect(function(child)
    if child:IsA("Tool") then
        createToolButton(child.Name)

        -- Auto equip nếu đang bật và đúng tool
        if autoEquipEnabled and autoEquipToolName and child.Name == autoEquipToolName then
            task.wait(0.1)
            local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:EquipTool(child)
            end
        end
    end
end)

-- Detect khi Character respawn => scan lại + auto re-equip
Player.CharacterAdded:Connect(function(char)
    task.wait(1) -- đợi load xong
    scanBackpack()

    -- Auto re-equip sau khi respawn
    if autoEquipEnabled and autoEquipToolName then
        task.wait(0.5)
        local tool = Player.Backpack:FindFirstChild(autoEquipToolName)
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if tool and humanoid then
            humanoid:EquipTool(tool)
        end
    end
end)

-- Loop auto equip: đảm bảo tool luôn được equip
task.spawn(function()
    while task.wait(1) do
        if autoEquipEnabled and autoEquipToolName then
            local character = Player.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                local alreadyEquipped = character:FindFirstChild(autoEquipToolName)
                if humanoid and not alreadyEquipped then
                    local tool = Player.Backpack:FindFirstChild(autoEquipToolName)
                    if tool then
                        humanoid:EquipTool(tool)
                    end
                end
            end
        end
    end
end)
