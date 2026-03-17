-- AutoFarm Sailor Piece
-- Game: Sailor Piece (Roblox)
-- Author: jachvn112-droid
-- Version: 1.0

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- ================================
-- SETTINGS (chỉnh tại đây)
-- ================================
local Settings = {
    AutoFarm = true,          -- Bật/tắt auto farm mob
    AutoCollectFruit = true,  -- Bật/tắt tự động nhặt trái cây
    AutoQuest = true,         -- Bật/tắt tự nhận quest
    WalkSpeed = 50,           -- Tốc độ di chuyển (mặc định 16)
    JumpPower = 80,           -- Lực nhảy
    FarmRadius = 50,          -- Bán kính farm (studs)
    AttackDelay = 0.1,        -- Thời gian delay giữa các đòn tấn công (giây)
}

-- ================================
-- UTILITY FUNCTIONS
-- ================================

local function getClosestEnemy(radius)
    local closest = nil
    local minDist = radius or Settings.FarmRadius

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj ~= Character then
            local humanoid = obj:FindFirstChildOfClass("Humanoid")
            local rootPart = obj:FindFirstChild("HumanoidRootPart")
            if humanoid and humanoid.Health > 0 and rootPart then
                local dist = (HumanoidRootPart.Position - rootPart.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    closest = obj
                end
            end
        end
    end

    return closest
end

local function teleportTo(position)
    if HumanoidRootPart then
        HumanoidRootPart.CFrame = CFrame.new(position + Vector3.new(0, 3, 0))
    end
end

local function attackEnemy(enemy)
    if not enemy then return end
    local rootPart = enemy:FindFirstChild("HumanoidRootPart")
    if rootPart then
        teleportTo(rootPart.Position)
        -- Fire remote events for attacks (adjust RemoteEvent names based on game)
        local args = {enemy}
        pcall(function()
            game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                :FindFirstChild("Attack"):FireServer(unpack(args))
        end)
    end
end

local function collectFruits()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("Part") then
            local nameLower = obj.Name:lower()
            if nameLower:find("fruit") or nameLower:find("drop") or nameLower:find("item") then
                local part = obj:IsA("Part") and obj or obj:FindFirstChildOfClass("Part")
                if part then
                    local dist = (HumanoidRootPart.Position - part.Position).Magnitude
                    if dist < Settings.FarmRadius then
                        teleportTo(part.Position)
                        task.wait(0.2)
                    end
                end
            end
        end
    end
end

-- ================================
-- APPLY SETTINGS
-- ================================

local function applyStats()
    if Humanoid then
        Humanoid.WalkSpeed = Settings.WalkSpeed
        Humanoid.JumpPower = Settings.JumpPower
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
    Humanoid = char:WaitForChild("Humanoid")
    task.wait(1)
    applyStats()
end)

applyStats()

-- ================================
-- MAIN LOOP
-- ================================

local farmConnection
farmConnection = RunService.Heartbeat:Connect(function()
    if not Character or not HumanoidRootPart then return end
    if Humanoid.Health <= 0 then return end

    -- Auto Farm Enemies
    if Settings.AutoFarm then
        local enemy = getClosestEnemy(Settings.FarmRadius)
        if enemy then
            attackEnemy(enemy)
            task.wait(Settings.AttackDelay)
        end
    end

    -- Auto Collect Fruits/Items
    if Settings.AutoCollectFruit then
        collectFruits()
    end
end)

-- ================================
-- GUI TOGGLE (đơn giản)
-- ================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoFarmGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 160)
frame.Position = UDim2.new(0, 10, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.TextColor3 = Color3.fromRGB(255, 200, 0)
title.Text = "⚓ AutoFarm Sailor Piece"
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

local corner2 = Instance.new("UICorner")
corner2.CornerRadius = UDim.new(0, 10)
corner2.Parent = title

local function createToggle(name, yPos, settingKey)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = Settings[settingKey] and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(180, 0, 0)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = name .. ": " .. (Settings[settingKey] and "ON" or "OFF")
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = frame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        Settings[settingKey] = not Settings[settingKey]
        btn.BackgroundColor3 = Settings[settingKey] and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(180, 0, 0)
        btn.Text = name .. ": " .. (Settings[settingKey] and "ON" or "OFF")
    end)
end

createToggle("Auto Farm", 38, "AutoFarm")
createToggle("Auto Collect", 75, "AutoCollectFruit")
createToggle("Auto Quest", 112, "AutoQuest")

print("✅ AutoFarm Sailor Piece loaded!")
print("📌 GUI toggle ở góc trái màn hình")
