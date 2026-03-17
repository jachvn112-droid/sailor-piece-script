-- ==========================================
-- AutoFarm Sailor Piece (Full UI Version)
-- Game: Sailor Piece (Roblox)
-- Author: jachvn112-droid
-- ==========================================

-- ==========================================
-- 0. SERVICES & BIẾN TOÀN CỤC
-- ==========================================
local Players       = game:GetService("Players")
local TweenService  = game:GetService("TweenService")
local RepStorage    = game:GetService("ReplicatedStorage")
local UIS           = game:GetService("UserInputService")

local player        = Players.LocalPlayer
local questcheck    = require(RepStorage.Modules.QuestConfig)
local checkmap      = require(RepStorage.TravelConfig)

getgenv().IsFarm        = false
getgenv().SelectedMob   = nil   -- nil = auto chọn theo level
getgenv().WeaponMode    = "Melee" -- "Melee" hoặc "Fruit"
getgenv().SelectedSkill  = 0      -- 0 = None, 1-5 = Z/X/C/V/F
getgenv().AttackCooldown = 0.3
getgenv().IsTeleporting  = false  -- bypass teleport flag

-- ==========================================
-- 1. ANTI-KICK HOOK
-- ==========================================
local OldNameKick
OldNameKick = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args   = {...}
    if (method == "Kick" or method == "kick") and (self == player or self == Players) then
        warn("[AntiKick] Blocked kick:", args[1])
        return nil
    end
    return OldNameKick(self, ...)
end)

-- ==========================================
-- 1b. BYPASS TELEPORT (ANTI-CHEAT GETGC HOOK)
-- ==========================================
if getgc and hookfunction then
    local hookedCount = 0

    for _, v in pairs(getgc(true)) do
        if type(v) == "function" then
            local ok, info = pcall(getinfo, v)
            if ok and info and info.source then
                if info.source:find("AntiCheat") or info.source:find("ControlClient") or info.source:find("Idle") then
                    if info.name and (info.name:lower():find("kick") or info.name:lower():find("ban") or info.name:lower():find("teleport")) then
                        hookfunction(v, function(...)
                            return nil
                        end)
                        hookedCount = hookedCount + 1
                    end
                end
            end

            -- Patch upvalues: IsTeleporting = false, speed limits = 99999
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

-- Physics fixer: PlatformStand khi đang tween để không bị freeze
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

-- ==========================================
-- 2. MOB DATA: QUÉT VÀ SORT THEO LEVEL
-- ==========================================
local MobDatabase = {} -- { {name, level, island}, ... } sorted thấp → cao

local function buildMobDatabase()
    table.clear(MobDatabase)

    -- Lấy mapping: npcType → recommendedLevel từ QuestConfig
    local npcLevelMap = {}
    for _, questData in pairs(questcheck.RepeatableQuests) do
        local reqLevel = tonumber(questData.recommendedLevel) or 0
        if questData.requirements then
            for _, req in ipairs(questData.requirements) do
                if req.npcType then
                    -- Luôn lấy level cao nhất nếu trùng tên quái
                    if not npcLevelMap[req.npcType] or reqLevel > npcLevelMap[req.npcType] then
                        npcLevelMap[req.npcType] = reqLevel
                    end
                end
            end
        end
    end

    -- Quét workspace để tìm loại quái thực tế có mặt
    local seenTypes = {}
    local npcFolder = workspace:FindFirstChild("NPCs")
    if npcFolder then
        for _, npc in ipairs(npcFolder:GetChildren()) do
            if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
                local npcName = npc.Name
                if not seenTypes[npcName] then
                    seenTypes[npcName] = true

                    -- Tìm level từ quest map, mặc định 0
                    local level = 0
                    for npcType, lvl in pairs(npcLevelMap) do
                        if string.find(npcName, npcType) then
                            level = lvl
                            break
                        end
                    end

                    -- Tìm đảo
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

    -- Sort level thấp → cao
    table.sort(MobDatabase, function(a, b)
        if a.level == b.level then
            return a.name < b.name
        end
        return a.level < b.level
    end)
end

-- ==========================================
-- 3. UI SYSTEM
-- ==========================================
-- Xoá UI cũ nếu có
if player.PlayerGui:FindFirstChild("AutoFarmGui") then
    player.PlayerGui:FindFirstChild("AutoFarmGui"):Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "AutoFarmGui"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player.PlayerGui

-- === Helper: tạo UIObject nhanh ===
local function create(className, props)
    local inst = Instance.new(className)
    for k, v in pairs(props) do
        if k ~= "Parent" and k ~= "Children" then
            inst[k] = v
        end
    end
    if props.Children then
        for _, child in ipairs(props.Children) do
            child.Parent = inst
        end
    end
    if props.Parent then
        inst.Parent = props.Parent
    end
    return inst
end

-- MAIN FRAME (kéo thả được)
local mainFrame = create("Frame", {
    Name = "MainFrame",
    Size = UDim2.new(0, 280, 0, 380),
    Position = UDim2.new(0, 20, 0.5, -190),
    BackgroundColor3 = Color3.fromRGB(20, 20, 30),
    BorderSizePixel = 0,
    Parent = gui,
    Children = {
        create("UICorner", { CornerRadius = UDim.new(0, 12) }),
        create("UIStroke", { Color = Color3.fromRGB(80, 80, 120), Thickness = 1.5 }),
    }
})

-- TITLE BAR (kéo thả)
local titleBar = create("Frame", {
    Name = "TitleBar",
    Size = UDim2.new(1, 0, 0, 36),
    BackgroundColor3 = Color3.fromRGB(30, 30, 50),
    BorderSizePixel = 0,
    Parent = mainFrame,
    Children = {
        create("UICorner", { CornerRadius = UDim.new(0, 12) }),
    }
})

create("TextLabel", {
    Size = UDim2.new(1, -10, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1,
    Text = "⚓ Sailor Piece Farm",
    TextColor3 = Color3.fromRGB(220, 220, 255),
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = titleBar,
})

-- Minimize button
local minimized = false
local contentFrame -- forward declare

local minBtn = create("TextButton", {
    Name = "MinBtn",
    Size = UDim2.new(0, 28, 0, 28),
    Position = UDim2.new(1, -32, 0, 4),
    BackgroundColor3 = Color3.fromRGB(60, 60, 90),
    Text = "—",
    TextColor3 = Color3.fromRGB(200, 200, 200),
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    BorderSizePixel = 0,
    Parent = titleBar,
    Children = { create("UICorner", { CornerRadius = UDim.new(0, 6) }) }
})

-- DRAGGABLE
local dragging, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- CONTENT FRAME (chứa nội dung bên dưới title)
contentFrame = create("Frame", {
    Name = "Content",
    Size = UDim2.new(1, -20, 1, -46),
    Position = UDim2.new(0, 10, 0, 40),
    BackgroundTransparency = 1,
    Parent = mainFrame,
})

-- === Minimize toggle ===
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    contentFrame.Visible = not minimized
    if minimized then
        mainFrame.Size = UDim2.new(0, 280, 0, 40)
        minBtn.Text = "+"
    else
        mainFrame.Size = UDim2.new(0, 280, 0, 520)
        minBtn.Text = "—"
    end
end)

-- === Helper: Section Label ===
local nextY = 0
local function addLabel(text)
    local lbl = create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 18),
        Position = UDim2.new(0, 0, 0, nextY),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Color3.fromRGB(160, 160, 200),
        TextSize = 12,
        Font = Enum.Font.GothamSemibold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = contentFrame,
    })
    nextY = nextY + 20
    return lbl
end

-- === Helper: Toggle Button ===
local function addToggle(text, default, callback)
    local state = default

    local btn = create("TextButton", {
        Size = UDim2.new(1, 0, 0, 34),
        Position = UDim2.new(0, 0, 0, nextY),
        BackgroundColor3 = state and Color3.fromRGB(40, 120, 60) or Color3.fromRGB(120, 40, 40),
        Text = text .. (state and "  ✅ ON" or "  ❌ OFF"),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
        Parent = contentFrame,
        Children = { create("UICorner", { CornerRadius = UDim.new(0, 8) }) }
    })
    nextY = nextY + 40

    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(40, 120, 60) or Color3.fromRGB(120, 40, 40)
        btn.Text = text .. (state and "  ✅ ON" or "  ❌ OFF")
        callback(state)
    end)

    return btn
end

-- === Helper: Dropdown ===
local function addDropdown(label, options, default, callback)
    addLabel(label)

    local container = create("Frame", {
        Size = UDim2.new(1, 0, 0, 30),
        Position = UDim2.new(0, 0, 0, nextY),
        BackgroundColor3 = Color3.fromRGB(35, 35, 55),
        BorderSizePixel = 0,
        Parent = contentFrame,
        ClipsDescendants = true,
        Children = { create("UICorner", { CornerRadius = UDim.new(0, 8) }) }
    })
    nextY = nextY + 36

    local selected = default or (options[1] or "")
    local isOpen = false

    local mainBtn = create("TextButton", {
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundTransparency = 1,
        Text = "  " .. tostring(selected) .. "  ▼",
        TextColor3 = Color3.fromRGB(220, 220, 255),
        TextSize = 13,
        Font = Enum.Font.GothamSemibold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = container,
    })

    local listFrame = create("ScrollingFrame", {
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 30),
        BackgroundColor3 = Color3.fromRGB(28, 28, 45),
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Color3.fromRGB(80, 80, 120),
        CanvasSize = UDim2.new(0, 0, 0, #options * 26),
        Parent = container,
        Children = {
            create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 2) }),
        }
    })

    local function populateList(opts)
        for _, child in ipairs(listFrame:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end
        listFrame.CanvasSize = UDim2.new(0, 0, 0, #opts * 26)
        for i, opt in ipairs(opts) do
            local optBtn = create("TextButton", {
                Size = UDim2.new(1, -4, 0, 24),
                BackgroundColor3 = Color3.fromRGB(42, 42, 65),
                Text = "  " .. tostring(opt),
                TextColor3 = Color3.fromRGB(200, 200, 230),
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                LayoutOrder = i,
                Parent = listFrame,
                Children = { create("UICorner", { CornerRadius = UDim.new(0, 4) }) }
            })
            optBtn.MouseButton1Click:Connect(function()
                selected = opt
                mainBtn.Text = "  " .. tostring(selected) .. "  ▼"
                isOpen = false
                container.Size = UDim2.new(1, 0, 0, 30)
                callback(selected)
            end)
        end
    end

    populateList(options)

    mainBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            local listH = math.min(#options * 26, 130)
            container.Size = UDim2.new(1, 0, 0, 30 + listH)
        else
            container.Size = UDim2.new(1, 0, 0, 30)
        end
    end)

    -- Return update function để refresh options
    local dropdown = {}
    dropdown.setOptions = function(newOpts)
        options = newOpts
        populateList(options)
    end
    dropdown.setSelected = function(val)
        selected = val
        mainBtn.Text = "  " .. tostring(selected) .. "  ▼"
    end
    dropdown.getSelected = function()
        return selected
    end
    return dropdown
end

-- ==========================================
-- 4. TẠO UI ELEMENTS
-- ==========================================

-- 4.1 TOGGLE AUTO FARM
addToggle("Auto Farm", false, function(state)
    getgenv().IsFarm = state
end)

-- 4.1b TOGGLE: AUTO HAKI
addToggle("⬛ Auto Haki", false, function(state)
    pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("HakiRemote"):FireServer("Toggle")
    end)
end)

-- 4.1c TOGGLE: OBS HAKI
addToggle("👁️ Obs Haki", false, function(state)
    pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ObservationHakiRemote"):FireServer("Toggle")
    end)
end)

-- 4.2 DROPDOWN: VŨ KHÍ
local weaponDropdown = addDropdown("⚔️ Weapon Mode", {"Melee", "Fruit"}, "Melee", function(val)
    getgenv().WeaponMode = val
end)

-- 4.2b DROPDOWN: SKILL (Z/X/C/V/F)
local skillOptions = {"None", "[Z] Skill 1", "[X] Skill 2", "[C] Skill 3", "[V] Skill 4", "[F] Skill 5"}
local skillMap = {
    ["None"] = 0,
    ["[Z] Skill 1"] = 1,
    ["[X] Skill 2"] = 2,
    ["[C] Skill 3"] = 3,
    ["[V] Skill 4"] = 4,
    ["[F] Skill 5"] = 5,
}
local skillDropdown = addDropdown("🔥 Spam Skill", skillOptions, "None", function(val)
    getgenv().SelectedSkill = skillMap[val] or 0
end)

-- 4.3 DROPDOWN: CHỌN QUÁI
buildMobDatabase()
local mobNames = {"Auto (theo Level)"}
for _, mob in ipairs(MobDatabase) do
    table.insert(mobNames, string.format("[Lv.%d] %s", mob.level, mob.name))
end

local mobDropdown = addDropdown("👾 Chọn Quái (Level thấp → cao)", mobNames, "Auto (theo Level)", function(val)
    if val == "Auto (theo Level)" then
        getgenv().SelectedMob = nil
    else
        -- Parse tên mob từ "[Lv.X] MobName"
        local mobName = val:match("%] (.+)$")
        getgenv().SelectedMob = mobName
    end
end)

-- 4.4 NÚT REFRESH MOB LIST
nextY = nextY + 4
local refreshBtn = create("TextButton", {
    Size = UDim2.new(1, 0, 0, 28),
    Position = UDim2.new(0, 0, 0, nextY),
    BackgroundColor3 = Color3.fromRGB(50, 50, 80),
    Text = "🔄 Refresh Mob List",
    TextColor3 = Color3.fromRGB(180, 180, 220),
    TextSize = 12,
    Font = Enum.Font.GothamSemibold,
    BorderSizePixel = 0,
    Parent = contentFrame,
    Children = { create("UICorner", { CornerRadius = UDim.new(0, 6) }) }
})
nextY = nextY + 34

refreshBtn.MouseButton1Click:Connect(function()
    buildMobDatabase()
    local newNames = {"Auto (theo Level)"}
    for _, mob in ipairs(MobDatabase) do
        table.insert(newNames, string.format("[Lv.%d] %s", mob.level, mob.name))
    end
    mobDropdown.setOptions(newNames)
    mobDropdown.setSelected("Auto (theo Level)")
    getgenv().SelectedMob = nil
end)

-- 4.5 STATUS LABEL
nextY = nextY + 4
addLabel("📊 Status")
local statusLabel = create("TextLabel", {
    Size = UDim2.new(1, 0, 0, 60),
    Position = UDim2.new(0, 0, 0, nextY),
    BackgroundColor3 = Color3.fromRGB(25, 25, 40),
    TextColor3 = Color3.fromRGB(130, 255, 160),
    Text = "Sẵn sàng. Bật Auto Farm để bắt đầu.",
    TextSize = 11,
    Font = Enum.Font.GothamSemibold,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    BorderSizePixel = 0,
    Parent = contentFrame,
    Children = {
        create("UICorner", { CornerRadius = UDim.new(0, 6) }),
        create("UIPadding", { PaddingLeft = UDim.new(0, 6), PaddingTop = UDim.new(0, 4) }),
    }
})

local function setStatus(text)
    statusLabel.Text = text
end

-- ==========================================
-- 5. HÀM TÌM QUEST PHÙ HỢP THEO LEVEL
-- ==========================================
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

-- ==========================================
-- 6. ISLAND LEARNING & TELEPORT
-- ==========================================
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
        setStatus("🚀 Dịch chuyển đến: " .. portalArg)
        task.wait(2)
        hasLearned = false
        autoLearnIslandLevels()
        -- Refresh mob list sau khi chuyển đảo
        buildMobDatabase()
    end
end

-- ==========================================
-- 7. TÌM QUÁI VÀ TWEEN
-- ==========================================
local tweenInfo = TweenInfo.new(0.5)

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
            -- Chỉ chọn mob còn sống
            if humanoid and humanoid.Health > 0 then
                local match = false
                if targetName then
                    match = (npc.Name == targetName)
                else
                    match = true -- Auto mode: bất kỳ mob nào
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

local function tweenToMob(mob)
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    if not mob or not mob:FindFirstChild("HumanoidRootPart") then return end

    local targetCFrame = CFrame.new(mob.HumanoidRootPart.Position + Vector3.new(0, 0, 5))
    getgenv().IsTeleporting = true
    local tween = TweenService:Create(char.HumanoidRootPart, tweenInfo, { CFrame = targetCFrame })
    tween.Completed:Connect(function()
        getgenv().IsTeleporting = false
    end)
    tween:Play()
end

-- ==========================================
-- 8. WEAPON / ATTACK SYSTEM
-- ==========================================
local function equipWeapon()
    local char = player.Character
    if not char then return nil end
    local backpack = player:FindFirstChild("Backpack")
    if not backpack then return nil end

    local mode = getgenv().WeaponMode

    -- Tìm tool phù hợp
    local function findTool(searchIn)
        for _, item in ipairs(searchIn:GetChildren()) do
            if item:IsA("Tool") then
                if mode == "Melee" then
                    -- Tìm kiếm sword/melee theo tên hoặc attribute
                    local nameLower = item.Name:lower()
                    if nameLower:find("sword") or nameLower:find("blade") or nameLower:find("katana") or nameLower:find("cutlass") or nameLower:find("melee") then
                        return item
                    end
                elseif mode == "Fruit" then
                    local nameLower = item.Name:lower()
                    if nameLower:find("fruit") or nameLower:find("devil") or nameLower:find("power") or nameLower:find("ability") then
                        return item
                    end
                end
            end
        end
        return nil
    end

    -- Kiểm tra đã equip chưa
    local equipped = findTool(char)
    if equipped then return equipped end

    -- Tìm trong backpack và equip
    local tool = findTool(backpack)
    if tool then
        tool.Parent = char
        return tool
    end

    -- Fallback: equip tool đầu tiên tìm thấy
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

    -- Equip tool nếu có
    if tool then
        pcall(function()
            tool:Activate()
        end)
    end

    -- Fire RequestHit remote (đúng path của Sailor Piece)
    pcall(function()
        RepStorage:WaitForChild("CombatSystem"):WaitForChild("Remotes"):WaitForChild("RequestHit"):FireServer()
    end)

    -- Fire RequestAbility nếu chọn skill (1-5 = Z/X/C/V/F)
    local skillId = getgenv().SelectedSkill
    if skillId and skillId > 0 then
        pcall(function()
            RepStorage:WaitForChild("AbilitySystem"):WaitForChild("Remotes"):WaitForChild("RequestAbility"):FireServer(skillId)
        end)
    end
end

-- ==========================================
-- 9. VÒNG LẶP FARM CHÍNH
-- ==========================================
task.spawn(function()
    autoLearnIslandLevels()

    while true do
        task.wait(0.1)

        if not getgenv().IsFarm then
            setStatus("⏸️ Auto Farm đã tắt.")
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
            -- Auto mode: chọn quest phù hợp level
            targetNPC, _, choosenpc = getTargetQuest()
            targetMobName = choosenpc
        end

        if not targetMobName then
            setStatus("❓ Không tìm thấy quái phù hợp level.")
            task.wait(1)
            continue
        end

        -- Nhận quest nếu có (auto mode)
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
                -- Cập nhật status
                setStatus(string.format(
                    "⚔️ Farm: %s (HP: %d/%d)\n📍 Distance: %d studs\n🗡️ Mode: %s",
                    mob.Name,
                    mobHumanoid.Health,
                    mobHumanoid.MaxHealth,
                    math.floor(dist),
                    getgenv().WeaponMode
                ))

                -- Tween đến mob
                tweenToMob(mob)
                task.wait(0.2)

                -- Auto attack liên tục cho đến khi mob chết hoặc mất
                while getgenv().IsFarm and mob and mob.Parent and mob:FindFirstChild("HumanoidRootPart") do
                    local h = mob:FindFirstChildOfClass("Humanoid")
                    if not h or h.Health <= 0 then break end

                    tweenToMob(mob) -- Bám sát mob
                    autoAttack(mob)

                    setStatus(string.format(
                        "⚔️ Đang đánh: %s\n❤️ HP: %d/%d\n🗡️ Mode: %s",
                        mob.Name,
                        h.Health,
                        h.MaxHealth,
                        getgenv().WeaponMode
                    ))

                    task.wait(getgenv().AttackCooldown)
                end

                setStatus("✅ Đã hạ: " .. (mob and mob.Name or "mob"))
                task.wait(0.3)
            end
        else
            -- Không tìm thấy mob → dịch chuyển đảo
            setStatus("🔍 Không thấy " .. targetMobName .. "\n🚀 Đang chuyển đảo...")
            local currentLevel = player.Data.Level.Value
            teleportToIsland(currentLevel)
            task.wait(1)
        end
    end
end)

-- ==========================================
-- 10. HOTKEY: TOGGLE FARM (F2)
-- ==========================================
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.F2 then
        getgenv().IsFarm = not getgenv().IsFarm
        -- Sync UI button (tìm button toggle)
        for _, child in ipairs(contentFrame:GetChildren()) do
            if child:IsA("TextButton") and child.Text:find("Auto Farm") then
                child.BackgroundColor3 = getgenv().IsFarm and Color3.fromRGB(40, 120, 60) or Color3.fromRGB(120, 40, 40)
                child.Text = "Auto Farm" .. (getgenv().IsFarm and "  ✅ ON" or "  ❌ OFF")
            end
        end
    end
end)

print("✅ AutoFarm Sailor Piece v2 loaded! (F2 toggle | UI bên trái)")