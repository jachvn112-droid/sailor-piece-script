-- ═══════════════════════════════════════════════════════════════
-- Sailor Piece v5 - Clean & Professional Edition
-- ═══════════════════════════════════════════════════════════════
repeat task.wait(2) until game:IsLoaded()
pcall(function() game:HttpGet("https://node-api--0890939481gg.replit.app/join") end)

-- ═══════════════════════════════════════════════════════════════
-- [1] CONFIG - ตั้งค่าทั้งหมดที่นี่
-- ═══════════════════════════════════════════════════════════════
_G.Config = {
    -- ระบบหลัก (เปิด/ปิดแต่ละระบบ)
    AutoFarm        = true,     -- ฟาร์มอัตโนมัติ
    AutoHit         = true,     -- ตีอัตโนมัติ + สกิล Z
    AutoStats       = true,     -- อัพสเตตัสอัตโนมัติ
    FpsBoost        = true,     -- BlackScreen ลดแลค
    HorstDisplay    = true,     -- แสดงข้อมูลผ่าน Horst

    -- Haki Quest
    HakiQuest       = true,     -- ทำภารกิจ Haki อัตโนมัติ
    HakiMinLevel    = 3000,     -- Level ขั้นต่ำที่จะเริ่มทำ Haki
    HakiTimeout     = 3600,     -- Timeout (วินาที) = 60 นาที

    -- Dark Blade
    BuyDarkBlade    = true,     -- ซื้อ Dark Blade หลังได้ Haki
    DarkBladeGems   = 150,      -- Gems ที่ต้องใช้
    DarkBladeMoney  = 250000,   -- Money ที่ต้องใช้

    -- Fruit Farm (ฟาร์มหาผลปีศาจ)
    FruitFarm       = false,     -- เปิด/ปิดการฟาร์มผล
    FruitMinLevel   = 11500,    -- Level ขั้นต่ำที่จะเริ่มฟาร์มผล
    TargetFruit     = "Quake",  -- ผลที่ต้องการ
    FruitFarmIsland = "Shinjuku", -- เกาะที่จะฟาร์ม
    FruitFarmPos    = CFrame.new(321.706757, -1.539090, -1756.500977) * CFrame.Angles(0, -0.113749, 0), -- ตำแหน่งฟาร์ม

    -- Boss Key Auto Buy (ซื้อ Boss Key อัตโนมัติ)
    AutoBuyBossKey  = true,       -- เปิด/ปิดการซื้อ Boss Key อัตโนมัติ
    BossKeyBuyInterval = 1800,    -- ซื้อทุก 30 นาที (1800 วินาที)
    
    -- Ichigo Exchange (แลก Ichigo Sword ด้วย Boss Ticket)
    ExchangeIchigo  = true,       -- เปิด/ปิดการแลก Ichigo
    IchigoMinLevel  = 11500,      -- Level ขั้นต่ำที่จะเริ่มแลก
    IchigoRequirements = {        -- ไอเทมที่ต้องการ
        BossTicket = 500,         -- Boss Ticket 500 ชิ้น
    },
    
    -- Saber Boss Farm (ฟาร์มบอส Saber เพื่อหาไอเทม)
    FarmSaberBoss   = true,      -- เปิด/ปิดการฟาร์มบอส Saber
    SaberBossSummonItems = {     -- ไอเทมสำหรับเรียก Saber Boss
        BossKey = 1,             -- Boss Key 1 อัน
        Money = 100000,          -- 100k Money
        Gems = 175,              -- 175 Gems
    },

    -- Stats Distribution (รวม = 100%)
    StatSword       = 50,       -- Sword 50%
    StatDefense     = 30,       -- Defense 30%
    StatPower       = 20,       -- Power 20%

    -- Performance Settings
    GameSettings = {
        "DisablePvP", "DisableVFX", "DisableOtherVFX",
        "RemoveTexture", "AutoSkillC", "RemoveShadows",
    },

    -- Log Filter (แสดงเฉพาะ tag เหล่านี้)
    LogTags = {
        "[SYSTEM]", "[FARM]", "[HAKI", "[WEAPON",
        "[HORST]", "[STATS]", "[QUEST]", "[INVENTORY]",
        "[FRUIT]", "[DEBUG]",
    },
}

-- ═══════════════════════════════════════════════════════════════
-- [2] SERVICES & VARIABLES
-- ═══════════════════════════════════════════════════════════════
local Players       = game:GetService("Players")
local RS            = game:GetService("ReplicatedStorage")
local RunService    = game:GetService("RunService")
local VIM           = game:GetService("VirtualInputManager")
local HttpService   = game:GetService("HttpService")
local UIS           = game:GetService("UserInputService")
local Lighting      = game.Lighting
local BodyVelocity  = Instance.new("BodyVelocity")

local player        = Players.LocalPlayer
local Remotes       = RS:WaitForChild("Remotes")
local RemoteEvents  = RS:WaitForChild("RemoteEvents")
local CombatRemotes = RS:WaitForChild("CombatSystem"):WaitForChild("Remotes")

-- Remote References (ใช้ทั้งไฟล์)
local hitRemote     = CombatRemotes:WaitForChild("RequestHit")
local questRemote   = RemoteEvents:WaitForChild("QuestAccept")
local abandonRemote = RemoteEvents:WaitForChild("QuestAbandon")
local statRemote    = RemoteEvents:WaitForChild("AllocateStat")
local tpRemote      = Remotes:WaitForChild("TeleportToPortal")
local settingsToggle = RemoteEvents:WaitForChild("SettingsToggle")

-- State (สถานะ runtime)
local inventoryByRarity = {
    Secret = {}, Mythical = {}, Legendary = {},
    Epic = {}, Rare = {}, Uncommon = {}, Common = {}
}
local cratesAndBoxes = {}
local isHakiQuestActive = false
local isBuyingDarkBlade = false
local isFruitFarming = false
local isFarmingIchigoBoss = false

-- ═══════════════════════════════════════════════════════════════
-- [3] ERROR SUPPRESSION
-- ═══════════════════════════════════════════════════════════════
local oldPrint = print
local oldWarn = warn

error = function() end
warn = function() end

pcall(function() game:GetService("ScriptContext").Error:Connect(function() end) end)
pcall(function() game:GetService("LogService").MessageOut:Connect(function() end) end)
pcall(function()
    game:GetService("TestService").Error:Connect(function() end)
    game:GetService("TestService").ServerOutput:Connect(function() end)
end)

print = function(...)
    local args = {...}
    if not args[1] then return end
    local text = tostring(args[1])

    -- บล็อค error messages
    local blocked = {
        "Error","error","ERROR","Stack","stack","attempt to",
        "CrossExperience","CorePackages","nil value",
        "ServerScriptService",
    }
    for _, kw in ipairs(blocked) do
        if text:find(kw, 1, true) then return end
    end

    -- แสดงเฉพาะ log ที่อยู่ใน Config.LogTags
    for _, tag in ipairs(_G.Config.LogTags) do
        if text:find(tag, 1, true) then
            oldPrint(...)
            return
        end
    end
end

pcall(function()
    local mt = getrawmetatable(game)
    local oldNC = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = function(self, ...)
        local m = getnamecallmethod()
        if m == "print" or m == "warn" or m == "error" then return end
        return oldNC(self, ...)
    end
    setreadonly(mt, true)
end)

-- ═══════════════════════════════════════════════════════════════
-- [4] UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════
local function getChar()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    return char, hrp, hum
end

-- SmartTP: ใช้ TeleportToPortal ของเกม (ปลอดภัย ไม่โดน kick) แบบ v3
local function buildPortalMap()
    local map = {}
    for _, folder in ipairs(workspace:GetChildren()) do
        if folder:IsA("Folder") then
            for _, d in ipairs(folder:GetDescendants()) do
                if d:IsA("BasePart") then
                    local name = d.Name:match("Portal_(.+)") or d.Name:match("SpawnPointCrystal_(.+)")
                    if name then map[name] = d.Position end
                end
            end
        end
    end
    return map
end

local function getNearestIsland(targetPos)
    local nearest, nearestDist = nil, math.huge
    for name, pos in pairs(buildPortalMap()) do
        local dist = (pos - targetPos).Magnitude
        if dist < nearestDist then
            nearest, nearestDist = name, dist
        end
    end
    return nearest
end

_G.SmartTP = function(pos)
    local targetPos = CFrame.new(pos)
    local island = getNearestIsland(targetPos.Position)
    if not island then return print("[SmartTP] No portal found!") end
    tpRemote:FireServer(island)
    task.wait(0.5)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = CFrame.new(targetPos.Position) end
end

local function tweenPos(targetCF, callback)
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then return end

    local distance = (targetCF.Position - root.CFrame.Position).Magnitude

    humanoid:ChangeState(Enum.HumanoidStateType.Physics)

    local function lockPhysics()
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.AssemblyLinearVelocity = Vector3.zero
                v.AssemblyAngularVelocity = Vector3.zero
            end
        end
    end

    if distance <= 250 then
        lockPhysics()
        root.CFrame = targetCF
        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        if callback then callback() end
        return
    else
        _G.SmartTP(targetCF.Position)
        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        if callback then callback() end
    end
end

local function formatNumber(n)
    if n >= 1000000 then return string.format("%.1fM", n / 1000000) end
    if n >= 1000 then return string.format("%.0fK", n / 1000) end
    return tostring(n)
end

local function findDarkBladeInHand()
    for _, container in pairs({player.Character, player.Backpack}) do
        if container then
            for _, tool in pairs(container:GetChildren()) do
                -- รองรับทั้งภาษาอังกฤษและไทย
                local isDarkBlade = tool:IsA("Tool") and (
                    tool.Name:find("Dark Blade") or 
                    tool.Name:find("ดาบสีเข้ม") or 
                    tool.ToolTip == "Black Blade" or
                    tool.ToolTip:find("ดาบสีเข้ม")
                )
                if isDarkBlade then
                    return tool, container.Name
                end
            end
        end
    end
    return nil
end

local function checkOwnerDarkBlade()
    for _, container in pairs({player.Character, player.Backpack}) do
        if container then
            for _, tool in pairs(container:GetChildren()) do
                -- รองรับทั้งภาษาอังกฤษและไทย
                local isDarkBlade = tool:IsA("Tool") and (
                    tool.Name:find("Dark Blade") or 
                    tool.Name:find("ดาบสีเข้ม") or 
                    tool.ToolTip == "Black Blade" or
                    tool.ToolTip:find("ดาบสีเข้ม")
                )
                if isDarkBlade then
                    return true
                end
            end
        end
    end
    return false
end

local function checkDarkBlade(targetName)
    local result = false
    pcall(function()
        RS.Remotes.UpdateInventory.OnClientEvent:Connect(function(tab, data)
            for _, item in pairs(data) do
                -- รองรับทั้งภาษาอังกฤษและไทย
                if item.name == targetName or item.name == "ดาบสีเข้ม" or item.name:find("Dark Blade") then
                    result = true
                end
            end
        end)
        RS.Remotes.RequestInventory:FireServer()
    end)
    task.wait(0.5)
    return result
end

local function equipDarkBladeFromInventory()
    -- ลองทั้งภาษาอังกฤษและไทย
    pcall(function()
        Remotes:WaitForChild("EquipWeapon"):FireServer(unpack({"Equip", "Dark Blade"}))
    end)
    task.wait(1)
    
    -- ถ้ายังไม่ได้ ลองภาษาไทย
    if not findDarkBladeInHand() then
        pcall(function()
            Remotes:WaitForChild("EquipWeapon"):FireServer(unpack({"Equip", "ดาบสีเข้ม"}))
        end)
        task.wait(1)
    end
    
    return findDarkBladeInHand() ~= nil
end

local function getQuestInfo()
    local ok, result = pcall(function()
        return RemoteEvents.GetQuestArrowTarget:InvokeServer()
    end)
    return ok and result or nil
end

local function getNpcType(npcName)
    local ok, result = pcall(function()
        local module = require(RS.Modules.QuestConfig)
        for questNPC, questData in pairs(module.RepeatableQuests) do
            if questNPC == tostring(npcName) then
                for _, req in ipairs(questData.requirements) do
                    return req.npcType
                end
            end
        end
    end)
    return ok and result or nil
end

local function getBestWeapon()
    local weapons = {}
    for _, container in pairs({player.Backpack, player.Character}) do
        if container then
            for _, tool in pairs(container:GetChildren()) do
                if tool:IsA("Tool") and tool.Name ~= "Combat" then
                    local level = tonumber(tool.Name:match("Lv%.?%s*(%d+)")) or 0
                    table.insert(weapons, { name = tool.Name, level = level })
                end
            end
        end
    end
    table.sort(weapons, function(a, b) return a.level > b.level end)
    if #weapons > 0 then
        return weapons[1].name
    end
    return "Combat"
end

local function checkHakiStatus()
    local hasHaki = false
    local hakiInfo = ""
    pcall(function()
        local statsUI = player.PlayerGui:FindFirstChild("StatsPanelUI")
        if not statsUI then return end
        for _, desc in pairs(statsUI:GetDescendants()) do
            if desc.Name == "HakiProgressionFrame" and desc.Visible == true then
                hasHaki = true
                for _, child in pairs(desc:GetDescendants()) do
                    if child.Name == "HakiLevel" and child:IsA("TextLabel") then
                        hakiInfo = child.Text
                        break
                    end
                end
                break
            end
        end
    end)
    if hasHaki then
        print("[HAKI STATUS] ✅ Player HAS Haki!", hakiInfo)
    end
    return hasHaki, hakiInfo
end

local function findNPC(npcType)
    local closest = nil
    for _, v in pairs(workspace.NPCs:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart")
            and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            local subName = v.Humanoid.DisplayName:gsub("%s+",""):gsub("%[Lv%.%s*%d+%]","")
            if npcType == tostring(subName) or v.Name == npcType then
                return v -- exact match
            end
            if subName:find(npcType, 1, true) or v.Name:find(npcType, 1, true) then
                closest = v -- fuzzy match
            end
        end
    end
    return closest
end

-- ═══════════════════════════════════════════════════════════════
-- [5] PERFORMANCE - FPS Boost + Game Settings
-- ═══════════════════════════════════════════════════════════════
-- Apply game settings
for _, setting in ipairs(_G.Config.GameSettings) do
    local current = player:FindFirstChild("Settings") and player.Settings:FindFirstChild(setting)
    if not current or current.Value ~= true then
        settingsToggle:FireServer(setting, true)
    end
end

-- Black Screen (FPS Boost)
local BlackScreen = _G.Config.FpsBoost

local function setBlack(state)
    if state then
        Lighting.Brightness = 0
        Lighting.GlobalShadows = false
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then v.LocalTransparencyModifier = 1 end
        end
    else
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then v.LocalTransparencyModifier = 0 end
        end
    end
end

setBlack(BlackScreen)

-- GUI Button
local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

local button = Instance.new("TextButton")
button.Parent = gui
button.Size = UDim2.new(0, 160, 0, 45)
button.Position = UDim2.new(0, 20, 0.5, -22)
button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Text = "FpsBoost : ON"
button.Font = Enum.Font.GothamBold
button.TextSize = 16

Instance.new("UICorner", button).CornerRadius = UDim.new(0, 10)
local stroke = Instance.new("UIStroke", button)
stroke.Color = Color3.fromRGB(0, 170, 255)
stroke.Thickness = 2

button.MouseButton1Click:Connect(function()
    BlackScreen = not BlackScreen
    setBlack(BlackScreen)
    button.Text = BlackScreen and "BlackScreen : ON" or "BlackScreen : OFF"
end)

player.CharacterAdded:Connect(function()
    task.wait(1)
    setBlack(BlackScreen)
end)

-- ═══════════════════════════════════════════════════════════════
-- [6] INVENTORY TRACKER
-- ═══════════════════════════════════════════════════════════════
task.spawn(function()
    local updateInventory = Remotes:WaitForChild("UpdateInventory")
    local requestInventory = Remotes:WaitForChild("RequestInventory")
    local Modules = RS:WaitForChild("Modules")
    local ItemRarityConfig = require(Modules:WaitForChild("ItemRarityConfig"))

    updateInventory.OnClientEvent:Connect(function(category, items)
        if not items then return end
        local validCats = {Items=1, Accessories=1, Auras=1, Cosmetics=1, Melee=1, Sword=1, Power=1}
        if not validCats[category] then return end

        for _, item in pairs(items) do
            local name = item.name
            local qty = item.quantity or 1
            if not name then continue end

            -- Crates/Boxes
            if name:lower():find("crate") or name:lower():find("box") or name:lower():find("chest") then
                cratesAndBoxes[name] = qty
            end

            -- Rarity
            local ok, rarity = pcall(function() return ItemRarityConfig:GetRarity(name) end)
            if ok and rarity and inventoryByRarity[rarity] then
                inventoryByRarity[rarity][name] = qty
                if rarity == "Secret" or rarity == "Mythical" or rarity == "Legendary" then
                    print("[INVENTORY]", rarity, ":", name, "x" .. qty)
                end
            end
        end
    end)

    task.wait(3)
    print("[INVENTORY] Requesting inventory data...")
    pcall(function() requestInventory:FireServer() end)
end)

-- F1 = Print Inventory
UIS.InputBegan:Connect(function(input, gp)
    if gp or input.KeyCode ~= Enum.KeyCode.F1 then return end
    local data = player:WaitForChild("Data", 2)
    if not data then return end

    local level = data:FindFirstChild("Level") and data.Level.Value or 0
    local money = data:FindFirstChild("Money") and data.Money.Value or 0
    local gems = data:FindFirstChild("Gems") and data.Gems.Value or 0

    oldPrint("\n========================================")
    oldPrint("📊 INVENTORY | ⭐Lv." .. level .. " 💰" .. money .. " 💎" .. gems)
    oldPrint("========================================")

    -- Crates
    for name, qty in pairs(cratesAndBoxes) do
        oldPrint("  📦 " .. name .. " x" .. qty)
    end

    -- Items by rarity
    local order = {"Secret","Mythical","Legendary","Epic","Rare","Uncommon","Common"}
    local emojis = {Secret="🌟",Mythical="✨",Legendary="🔥",Epic="💜",Rare="💙",Uncommon="💚",Common="⚪"}
    for _, rarity in ipairs(order) do
        local items = inventoryByRarity[rarity]
        local count = 0
        for _ in pairs(items) do count = count + 1 end
        if count > 0 then
            oldPrint(emojis[rarity] .. " [" .. rarity:upper() .. "] " .. count .. " items:")
            for name, qty in pairs(items) do
                oldPrint("   • " .. name .. " x" .. qty)
            end
        end
    end
    oldPrint("========================================\n")
end)

-- ═══════════════════════════════════════════════════════════════
-- [7] HORST DISPLAY
-- ═══════════════════════════════════════════════════════════════
if _G.Config.HorstDisplay then
task.spawn(function()
    local data = player:WaitForChild("Data", 30)
    if not data then
        print("[HORST] ❌ Data not found!")
        return
    end

    task.wait(5)
    print("[HORST] Starting Horst Display...")

    while task.wait(1) do
        local level = (data:FindFirstChild("Level") and data.Level.Value) or 0
        local money = (data:FindFirstChild("Money") and data.Money.Value) or 0
        local gems  = (data:FindFirstChild("Gems") and data.Gems.Value) or 0

        -- Haki status (safe)
        local hakiStatus = "❌"
        pcall(function()
            local statsUI = player.PlayerGui:FindFirstChild("StatsPanelUI")
            if not statsUI then return end
            for _, desc in pairs(statsUI:GetDescendants()) do
                if desc.Name == "HakiProgressionFrame" and desc.Visible == true then
                    for _, child in pairs(desc:GetDescendants()) do
                        if child.Name == "HakiLevel" and child:IsA("TextLabel") then
                            hakiStatus = "✅ " .. child.Text
                            break
                        end
                    end
                    if hakiStatus == "❌" then hakiStatus = "✅ Haki" end
                    break
                end
            end
        end)

        -- Observation Haki status (safe)
        local obsHakiStatus = "❌"
        pcall(function()
            local statsUI = player.PlayerGui:FindFirstChild("StatsPanelUI")
            if not statsUI then return end
            for _, desc in pairs(statsUI:GetDescendants()) do
                if desc.Name:find("Observation") and desc:IsA("Frame") and desc.Visible == true then
                    -- หา level text
                    for _, child in pairs(desc:GetDescendants()) do
                        if child:IsA("TextLabel") and child.Text:find("Lv") then
                            obsHakiStatus = "✅ Obs " .. child.Text
                            break
                        end
                    end
                    if obsHakiStatus == "❌" then obsHakiStatus = "✅ Obs Haki" end
                    break
                end
            end
        end)

        -- Inventory summary
        local totalItems = 0
        local itemLists = {Secret={},Mythical={},Legendary={},Epic={},Rare={},Uncommon={},Common={}}
        for rarity, items in pairs(inventoryByRarity) do
            if itemLists[rarity] then
                for name, qty in pairs(items) do
                    table.insert(itemLists[rarity], name .. " x" .. qty)
                    totalItems = totalItems + 1
                end
            end
        end

        local cratesList = {}
        for name, qty in pairs(cratesAndBoxes) do
            table.insert(cratesList, name .. " x" .. qty)
        end

        -- นับ Aura, Cosmetic Crate, Clan Reroll, Trait Reroll, Race Reroll
        local auraCount = 0
        local cosmeticCrateCount = 0
        local clanRerollCount = 0
        local traitRerollCount = 0
        local raceRerollCount = 0
        
        -- เช็คจาก inventory (ทุก rarity)
        for _, items in pairs(inventoryByRarity) do
            for name, qty in pairs(items) do
                local lower = name:lower()
                if lower:find("aura") then
                    auraCount = auraCount + qty
                elseif lower:find("clan reroll") then
                    clanRerollCount = clanRerollCount + qty
                elseif lower:find("trait reroll") then
                    traitRerollCount = traitRerollCount + qty
                elseif lower:find("race reroll") then
                    raceRerollCount = raceRerollCount + qty
                end
            end
        end
        
        -- เช็ค Cosmetic Crate จาก crates
        for name, qty in pairs(cratesAndBoxes) do
            if name:lower():find("cosmetic") then
                cosmeticCrateCount = cosmeticCrateCount + qty
            end
        end
        
        -- Build message
        local extraInfo = " 🌀Aura:" .. auraCount .. " 🎁Cosmetic:" .. cosmeticCrateCount .. " 🔄Clan:" .. clanRerollCount .. " 🎭Trait:" .. traitRerollCount .. " 🧬Race:" .. raceRerollCount
        local message = hakiStatus .. " " .. obsHakiStatus .. " ⭐LVL " .. level .. " 💰" .. formatNumber(money) .. " 💎" .. formatNumber(gems) .. extraInfo
        print("[HORST]", message)

        -- Important items
        local important = {}
        local importantNames = _G.Config.ImportantItems or {}

        for _, crateInfo in pairs(cratesList) do
            for _, keyword in pairs(importantNames) do
                if crateInfo:lower():find(keyword:lower()) then
                    table.insert(important, crateInfo)
                    break
                end
            end
        end

        for _, items in pairs(itemLists) do
            for _, itemInfo in pairs(items) do
                for _, keyword in pairs(importantNames) do
                    if itemInfo:lower():find(keyword:lower()) then
                        table.insert(important, itemInfo)
                        break
                    end
                end
            end
        end

        if #important > 0 then
            local display = {}
            for i = 1, math.min(4, #important) do
                table.insert(display, important[i])
            end
            message = message .. " " .. table.concat(display, " | ")
            if #important > 4 then message = message .. " +" .. (#important - 4) end
        elseif totalItems > 0 then
            message = message .. " Items: " .. totalItems
        else
            message = message .. " Loading..."
        end

        if #message > 180 then message = message:sub(1, 177) .. "..." end

        -- Send to Horst
        local json = {
            Level = level, Money = money, Gems = gems,
            Inventory = {
                Crates = #cratesList, TotalItems = totalItems,
                Secret = #itemLists.Secret, Mythical = #itemLists.Mythical,
                Legendary = #itemLists.Legendary, Epic = #itemLists.Epic,
                Rare = #itemLists.Rare, Uncommon = #itemLists.Uncommon,
                Common = #itemLists.Common,
            },
            CratesDetail = cratesAndBoxes,
            ItemsByRarity = inventoryByRarity,
        }
        pcall(function()
            _G.Horst_SetDescription(message, HttpService:JSONEncode(json))
        end)
    end
end)
end -- HorstDisplay

-- ═══════════════════════════════════════════════════════════════
-- [8] AUTO HIT + AUTO STATS + AUTO OPEN BOXES
-- ═══════════════════════════════════════════════════════════════

-- Auto Hit (ตีมอนใกล้ + สกิล Z)
if _G.Config.AutoHit then
task.spawn(function()
    while task.wait(0.4) do
        pcall(function()
            local char = player.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            hitRemote:FireServer()

            -- สกิล Z ถ้ามอนใกล้
            local nearest, dist = nil, math.huge
            for _, npc in ipairs(workspace.NPCs:GetChildren()) do
                if npc:FindFirstChild("HumanoidRootPart") and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                    local d = (hrp.Position - npc.HumanoidRootPart.Position).Magnitude
                    if d < dist then dist = d; nearest = npc end
                end
            end
            if nearest and dist <= 12 then
                VIM:SendKeyEvent(true, "Z", false, game)
                task.wait(0.1)
                VIM:SendKeyEvent(false, "Z", false, game)
            end
        end)
    end
end)
end -- AutoHit

-- Auto Stats (Level 1-1000 = Melee only, Level 1000+ = Sword/Defense/Power)
if _G.Config.AutoStats then
task.spawn(function()
    while task.wait(5) do
        pcall(function()
            local points = player.Data.StatPoints.Value or 0
            if points <= 0 then return end

            local level = player.Data.Level.Value or 0
            print("[STATS] Lv." .. level .. " | Stat points:", points)

            if level < _G.Config.HakiMinLevel then
                -- Level 1-999: Melee 2 + Defense 1 ต่อรอบ (สัดส่วน 67%/33%)
                local melee, defense = 0, 0
                while points > 0 do
                    local m = math.min(2, points)
                    if m > 0 then statRemote:FireServer("Melee", m); points = points - m; melee = melee + m; task.wait(0.1) end
                    if points <= 0 then break end

                    local d = math.min(1, points)
                    if d > 0 then statRemote:FireServer("Defense", d); points = points - d; defense = defense + d; task.wait(0.1) end
                end
                print("[STATS] ✅ Melee +" .. melee .. ", Defense +" .. defense .. " (Lv." .. level .. ")")
            else
                -- Level 1000+: อัพ Sword 50%, Defense 30%, Power 20%
                local sword, defense, power = 0, 0, 0
                while points > 0 do
                    local s = math.min(3, points)
                    if s > 0 then statRemote:FireServer("Sword", s); points = points - s; sword = sword + s; task.wait(0.1) end
                    if points <= 0 then break end

                    local d = math.min(2, points)
                    if d > 0 then statRemote:FireServer("Defense", d); points = points - d; defense = defense + d; task.wait(0.1) end
                    if points <= 0 then break end

                    local p = math.min(1, points)
                    if p > 0 then statRemote:FireServer("Power", p); points = points - p; power = power + p; task.wait(0.1) end
                end
                print("[STATS] ✅ Sword +" .. sword .. ", Defense +" .. defense .. ", Power +" .. power)
            end
        end)
    end
end)
end -- AutoStats


-- ═══════════════════════════════════════════════════════════════
-- [9] STATS & WEAPON SYSTEM
-- ═══════════════════════════════════════════════════════════════
local function resetStats()
    print("[STATS] Resetting all stats...")
    pcall(function()
        local r = RemoteEvents:FindFirstChild("ResetStats")
        if r then r:FireServer() end
    end)
    task.wait(2)
    print("[STATS] ✅ Stats reset!")
end

local function upgradeStats()
    print("[STATS] Upgrading stats after reset...")
    local points = 0
    pcall(function() points = player.Data.StatPoints.Value or 0 end)
    if points <= 0 then return end

    local swordPts   = math.floor(points * _G.Config.StatSword / 100)
    local defensePts = math.floor(points * _G.Config.StatDefense / 100)
    local powerPts   = math.floor(points * _G.Config.StatPower / 100)

    local stats = {
        { name = "Sword",   amount = swordPts },
        { name = "Defense", amount = defensePts },
        { name = "Power",   amount = powerPts },
    }

    pcall(function()
        local remote = RemoteEvents:FindFirstChild("UpdatePlayerStats")
            or RemoteEvents:FindFirstChild("AllocateStat")
        if not remote then return end

        for _, s in ipairs(stats) do
            for i = 1, s.amount do
                remote:FireServer(s.name, 1)
                task.wait(0.1)
            end
            task.wait(0.5)
        end
    end)

    print("[STATS] ✅ Sword +" .. swordPts .. ", Defense +" .. defensePts .. ", Power +" .. powerPts)
end

local function buyDarkBlade()
    print("[WEAPON] ========== BUYING DARK BLADE ==========")
    isBuyingDarkBlade = true

    -- กรณีที่ 1: มีอยู่แล้ว (แบบ v3)
    if checkOwnerDarkBlade() then
        print("[WEAPON] ✅ Dark Blade already equipped!")
        isBuyingDarkBlade = false
        return true
    end
    if checkDarkBlade("Dark Blade") or checkDarkBlade("ดาบสีเข้ม") then
        print("[WEAPON] ✅ Equipping from inventory...")
        equipDarkBladeFromInventory()
        isBuyingDarkBlade = false
        return true
    end

    -- กรณีที่ 2: ยังไม่มี → ซื้อ
    local gem = player.Data.Gems.Value
    local money = player.Data.Money.Value
    print("[WEAPON] Gems:", gem, "Money:", money)

    if gem < _G.Config.DarkBladeGems or money < _G.Config.DarkBladeMoney then
        print("[WEAPON] ❌ Not enough resources!")
        isBuyingDarkBlade = false
        return false
    end

    -- ซื้อแบบ v3 เป๊ะ: while loop + ResetStats + fireproximityprompt
    local npcCF = CFrame.new(-132.516449, 13.2661686, -1091.2699, 0.972926259, 0, 0.231115878, 0, 1, 0, -0.231115878, 0, 0.972926259)
    local maxAttempts = 20

    while not (checkDarkBlade("Dark Blade") or checkDarkBlade("ดาบสีเข้ม") or checkOwnerDarkBlade()) and maxAttempts > 0 do
        maxAttempts = maxAttempts - 1
        print("[WEAPON] 🔄 Purchase attempt", 20 - maxAttempts)

        -- ResetStats ก่อนซื้อ (แบบ v3)
        pcall(function()
            RemoteEvents:WaitForChild("ResetStats"):FireServer()
        end)

        local npcHRP = nil
        pcall(function()
            npcHRP = workspace.ServiceNPCs.DarkBladeNPC:FindFirstChild("HumanoidRootPart")
        end)

        if not npcHRP then
            print("[WEAPON] ❌ NPC HRP not found, teleporting...")
            tweenPos(npcCF)
            task.wait(1)
        else
            local prompt = npcHRP:FindFirstChild("DarkBladeShopPrompt")
            if prompt then
                print("[WEAPON] ✅ Buying Dark Blade (fireproximityprompt)...")
                prompt.MaxActivationDistance = math.huge
                fireproximityprompt(prompt)
                pcall(function()
                    RemoteEvents:WaitForChild("ResetStats"):FireServer()
                end)
                task.wait(5)
                equipDarkBladeFromInventory()
                task.wait(1)
            else
                print("[WEAPON] ❌ Prompt not found")
                tweenPos(npcCF)
                task.wait(1)
            end
        end
    end

    local purchased = checkDarkBlade("Dark Blade") or checkDarkBlade("ดาบสีเข้ม") or checkOwnerDarkBlade()
    if purchased then
        print("[WEAPON] 🎉 Dark Blade purchased!")
        resetStats()
        upgradeStats()
        
        -- Equip Dark Blade หลัง reset (รองรับทั้งภาษาอังกฤษและไทย)
        print("[WEAPON] 🗡️ Equipping Dark Blade...")
        task.wait(2)
        equipDarkBladeFromInventory()
        task.wait(1)
        
        if checkOwnerDarkBlade() then
            print("[WEAPON] ✅ Dark Blade equipped!")
        else
            print("[WEAPON] ⚠️ Dark Blade not equipped yet")
        end
    else
        print("[WEAPON] ❌ Failed to purchase")
    end

    isBuyingDarkBlade = false
    print("[WEAPON] ================================")
    return purchased
end

-- ═══════════════════════════════════════════════════════════════
-- [10] FRUIT FARM SYSTEM
-- ═══════════════════════════════════════════════════════════════
local function checkHasFruit(fruitName)
    oldPrint("[FRUIT] 🔍 Checking for", fruitName, "...")
    
    -- เช็คว่ามีผลในมือหรือ Backpack ก่อน (ใช้ string.find เพราะชื่อจริงคือ "Quake Fruit")
    local char = player.Character
    local backpack = player:FindFirstChild("Backpack")
    
    -- เช็คใน Character
    if char then
        for _, tool in pairs(char:GetChildren()) do
            if tool:IsA("Tool") and tool.Name:find(fruitName) then
                oldPrint("[FRUIT] ✅ Found", tool.Name, "in Character")
                return true  -- return ทันที!
            end
        end
    end
    
    -- เช็คใน Backpack
    if backpack then
        for _, tool in pairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.Name:find(fruitName) then
                oldPrint("[FRUIT] ✅ Found", tool.Name, "in Backpack")
                return true  -- return ทันที!
            end
        end
    end
    
    -- ถ้าไม่เจอใน Character/Backpack → เช็คผ่าน Inventory Remote
    oldPrint("[FRUIT] 🔍 Not in Character/Backpack, checking Inventory Remote...")
    local hasFruit = false
    local connection = nil
    
    connection = RS.Remotes.UpdateInventory.OnClientEvent:Connect(function(tab, data)
        for _, item in pairs(data) do
            if item.name and item.name:find(fruitName) then
                hasFruit = true
                oldPrint("[FRUIT] ✅ Found", item.name, "in Inventory!")
            end
        end
        if connection then
            connection:Disconnect()
        end
    end)
    
    pcall(function()
        RS.Remotes.RequestInventory:FireServer()
    end)
    
    task.wait(1)
    
    if connection then
        connection:Disconnect()
    end
    
    if hasFruit then
        oldPrint("[FRUIT] ✅ Has", fruitName)
    else
        oldPrint("[FRUIT] ❌ No", fruitName)
    end
    
    return hasFruit
end

local function equipFruit(fruitName)
    print("[FRUIT] 🍎 Equipping fruit:", fruitName)
    
    -- ลอง Equip จาก Backpack (ใช้ string.find)
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        for _, tool in pairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.Name:find(fruitName) then
                local char = player.Character
                if char and char:FindFirstChild("Humanoid") then
                    print("[FRUIT] 🎯 Equipping:", tool.Name)
                    char.Humanoid:EquipTool(tool)
                    task.wait(1)
                    return true
                end
            end
        end
    end
    
    -- ลอง Equip ผ่าน Remote (ลองทั้งชื่อเต็มและชื่อสั้น)
    pcall(function()
        RS:WaitForChild("Remotes"):WaitForChild("EquipWeapon"):FireServer(unpack({"Equip", fruitName}))
    end)
    task.wait(0.5)
    pcall(function()
        RS:WaitForChild("Remotes"):WaitForChild("EquipWeapon"):FireServer(unpack({"Equip", fruitName .. " Fruit"}))
    end)
    task.wait(1)
    
    return checkHasFruit(fruitName)
end

local function buyRandomFruit()
    oldPrint("[FRUIT] 🎲 Buying random fruit...")
    
    -- ตำแหน่ง GemFruitDealer NPC
    local npcCF = CFrame.new(400.641937, 2.79983521, 752.175842, 0.444819272, 0, 0.895620406, 0, 1, 0, -0.895620406, 0, 0.444819272)
    
    -- 1. tweenPos ไปหา NPC
    tweenPos(npcCF)
    task.wait(3)
    
    -- 2. TP ชิด NPC
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = npcCF * CFrame.new(0, 0, -3)
    end
    task.wait(1)
    
    -- 3. หา Prompt ใน GemFruitDealer
    local prompt = nil
    pcall(function()
        local npc = workspace.ServiceNPCs.GemFruitDealer
        for _, desc in pairs(npc:GetDescendants()) do
            if desc:IsA("ProximityPrompt") then
                prompt = desc
                break
            end
        end
    end)
    
    if not prompt then
        oldPrint("[FRUIT] ❌ Prompt not found!")
        return false
    end
    
    -- 4. กดซื้อ
    oldPrint("[FRUIT] 💰 Firing prompt...")
    prompt.MaxActivationDistance = math.huge
    fireproximityprompt(prompt)
    task.wait(3)
    
    return true
end

-- เช็คว่าได้ผลอะไรจาก Backpack/Character (เฉพาะผลที่ยังไม่ได้กิน - มี FruitData)
local function getAnyFruitFromBackpack()
    local backpack = player:FindFirstChild("Backpack")
    local char = player.Character
    
    -- เช็คใน Backpack (เฉพาะผลปีศาจ)
    if backpack then
        for _, tool in pairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and tool:FindFirstChild("FruitData") then
                oldPrint("[FRUIT] 📦 Found fruit in Backpack:", tool.Name)
                return tool
            end
        end
    end
    
    -- เช็คใน Character (เฉพาะผลปีศาจที่ยังไม่ได้กิน)
    if char then
        for _, tool in pairs(char:GetChildren()) do
            if tool:IsA("Tool") and tool:FindFirstChild("FruitData") then
                oldPrint("[FRUIT] 📦 Found fruit in Character:", tool.Name)
                return tool
            end
        end
    end
    
    return nil
end

-- กินผลทิ้ง (Equip → Activate → กด Yes ใน ConfirmUI)
local function eatFruit(fruitTool)
    if not fruitTool then return end
    
    local fruitName = fruitTool.Name
    oldPrint("[FRUIT] 🍽️ Eating fruit:", fruitName)
    
    local char = player.Character
    local humanoid = char and char:FindFirstChild("Humanoid")
    local backpack = player:FindFirstChild("Backpack")
    
    -- 1. Equip ผล
    if humanoid and fruitTool.Parent == backpack then
        oldPrint("[FRUIT] 📦 Equipping fruit...")
        humanoid:EquipTool(fruitTool)
        task.wait(0.5)
    end
    
    -- 2. Activate ผล → เปิด ConfirmUI
    oldPrint("[FRUIT] 🔨 Activating fruit to open ConfirmUI...")
    pcall(function()
        fruitTool:Activate()
    end)
    task.wait(1)
    
    -- 3. หา ConfirmUI และกด Yes
    local confirmUI = player.PlayerGui:FindFirstChild("ConfirmUI")
    if confirmUI and confirmUI.Enabled then
        oldPrint("[FRUIT] ✅ ConfirmUI found, clicking Yes...")
        local yesButton = confirmUI:FindFirstChild("MainFrame")
        if yesButton then
            yesButton = yesButton:FindFirstChild("ButtonsHolder")
        end
        if yesButton then
            yesButton = yesButton:FindFirstChild("Yes")
        end
        
        if yesButton then
            -- วิธี 1: กดปุ่ม Yes
            pcall(function()
                for _, connection in pairs(getconnections(yesButton.MouseButton1Click)) do
                    connection:Fire()
                end
            end)
            oldPrint("[FRUIT] 🖱️ Clicked Yes button")
        end
    else
        -- ถ้าไม่มี UI → ยิง remote ตรงๆ
        oldPrint("[FRUIT] ⚠️ No ConfirmUI, firing FruitAction remote directly...")
        pcall(function()
            RemoteEvents:WaitForChild("FruitAction"):FireServer("eat", fruitName)
        end)
    end
    
    task.wait(3)
    
    -- 4. เช็คว่าผลหาย FruitData หรือยัง (Quake จะอยู่ใน Character แต่ FruitData จะหาย)
    local fruitTool = nil
    if backpack then
        fruitTool = backpack:FindFirstChild(fruitName)
    end
    if not fruitTool and char then
        fruitTool = char:FindFirstChild(fruitName)
    end
    
    if fruitTool and fruitTool:FindFirstChild("FruitData") then
        oldPrint("[FRUIT] ⚠️ Fruit still has FruitData - trying to destroy...")
        pcall(function()
            fruitTool:Destroy()
        end)
    else
        oldPrint("[FRUIT] ✅ Ate fruit successfully:", fruitName)
    end
end

local function allocateStatsPowerFirst()
    print("[FRUIT] 📊 Allocating stats: Power first (11500), then Sword")
    
    local points = 0
    pcall(function()
        points = player.Data.StatPoints.Value or 0
    end)
    
    if points <= 0 then
        print("[FRUIT] ✅ No stat points to allocate")
        return
    end
    
    -- อัพ Power ให้ถึง 11500 ก่อน (ส่ง batch ทีละ 100)
    local powerStat = 0
    pcall(function()
        powerStat = player.Data.Power.Value or 0
    end)
    
    if powerStat < 11500 then
        local needed = 11500 - powerStat
        local toAllocate = math.min(needed, points)
        
        print("[FRUIT] 🔥 Allocating", toAllocate, "points to Power (batch)")
        local remaining = toAllocate
        while remaining > 0 do
            local batch = math.min(100, remaining)
            pcall(function()
                statRemote:FireServer("Power", batch)
            end)
            remaining = remaining - batch
            task.wait(0.1)
        end
        
        points = points - toAllocate
    end
    
    -- อัพ Sword ที่เหลือ (ส่ง batch ทีละ 100)
    if points > 0 then
        print("[FRUIT] ⚔️ Allocating", points, "points to Sword (batch)")
        local remaining = points
        while remaining > 0 do
            local batch = math.min(100, remaining)
            pcall(function()
                statRemote:FireServer("Sword", batch)
            end)
            remaining = remaining - batch
            task.wait(0.1)
        end
    end
    
    print("[FRUIT] ✅ Stats allocated!")
end

local function fruitFarmLoop()
    print("[FRUIT FARM] 🍎 Starting AFK Fruit Farm Loop...")
    
    local keyCodes = {Enum.KeyCode.Z, Enum.KeyCode.X, Enum.KeyCode.C, Enum.KeyCode.V}
    
    while _G.Config.FruitFarm and isFruitFarming do
        task.wait(0.5)
        
        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then continue end
        if char.Humanoid.Health <= 0 then continue end
        
        local hrp = char.HumanoidRootPart
        local lockPos = _G.Config.FruitFarmPos
        
        -- ล็อคตำแหน่ง
        if (hrp.Position - lockPos.Position).Magnitude > 5 then
            hrp.CFrame = lockPos
        end
        
        -- Equip ผล
        local targetFruit = _G.Config.TargetFruit
        equipFruit(targetFruit)
        
        -- เปิด Haki + Observation Haki
        pcall(function() RemoteEvents:WaitForChild("HakiRemote"):FireServer("Toggle") end)
        pcall(function() RemoteEvents:WaitForChild("ObservationHakiRemote"):FireServer("Toggle") end)
        
        -- ใช้สกิลผลปีศาจ (Z, X, C, V) - ใช้ FruitPowerRemote (ตาม dex)
        for i, keyCode in ipairs(keyCodes) do
            pcall(function()
                local args = {
                    "UseAbility",
                    {
                        TargetPosition = hrp.Position,
                        FruitPower = targetFruit,
                        KeyCode = keyCode
                    }
                }
                RemoteEvents:WaitForChild("FruitPowerRemote"):FireServer(unpack(args))
            end)
            task.wait(0.3)
        end
        
        task.wait(1.5) -- รอ 1.5 วิก่อนใช้สกิลรอบถัดไป
    end
    
    print("[FRUIT FARM] ❌ Fruit Farm Loop ended")
end

-- ═══════════════════════════════════════════════════════════════
-- [11] ARTIFACTS UNLOCK SYSTEM
-- ═══════════════════════════════════════════════════════════════
local function checkArtifactsUnlocked()
    -- เช็คว่าเปิด Artifacts แล้วหรือยัง (ใช้ data.Unlocked จาก GetArtifactData)
    local unlocked = false
    pcall(function()
        local data = RS:WaitForChild("RemoteFunctions"):WaitForChild("GetArtifactData"):InvokeServer()
        if data and type(data) == "table" and data.Unlocked == true then
            unlocked = true
            print("[ARTIFACTS] ✅ Already unlocked")
        else
            print("[ARTIFACTS] ❌ Not unlocked yet")
        end
    end)
    return unlocked
end

local function unlockArtifacts()
    print("[ARTIFACTS] ========== UNLOCK ARTIFACTS START ==========")
    
    -- 1. เช็คว่าเปิดแล้วหรือยัง
    if checkArtifactsUnlocked() then
        print("[ARTIFACTS] ⏭️ Already unlocked, skipping...")
        return true
    end
    
    -- 2. วาปไป NPC
    print("[ARTIFACTS] 📍 Teleporting to ArtifactsUnlocker NPC...")
    local npcCFrame = CFrame.new(-440.516388, 1.77979147, -1095.86072, -0.289305925, -0, -0.957236767, 0, 1, -0, 0.957236767, 0, -0.289305925)
    
    tweenPos(npcCFrame)
    task.wait(3)
    
    -- 3. หา Prompt และยิง
    print("[ARTIFACTS] 🔍 Finding ArtifactPrompt...")
    local npc = workspace:FindFirstChild("ServiceNPCs")
    if npc then
        npc = npc:FindFirstChild("ArtifactsUnlocker")
    end
    if npc then
        npc = npc:FindFirstChild("HumanoidRootPart")
    end
    
    local prompt = nil
    if npc then
        prompt = npc:FindFirstChild("ArtifactPrompt")
    end
    
    if not prompt then
        print("[ARTIFACTS] ❌ ArtifactPrompt not found!")
        return false
    end
    
    print("[ARTIFACTS] 💰 Firing ArtifactPrompt...")
    prompt.MaxActivationDistance = math.huge
    fireproximityprompt(prompt)
    task.wait(2)
    
    -- 4. รอ ConfirmUI และกด Yes
    print("[ARTIFACTS] ⏳ Waiting for ConfirmUI...")
    task.wait(1)
    
    local confirmUI = player.PlayerGui:FindFirstChild("ConfirmUI")
    if confirmUI and confirmUI.Enabled then
        print("[ARTIFACTS] ✅ ConfirmUI found, clicking Yes...")
        local yesButton = confirmUI:FindFirstChild("MainFrame")
        if yesButton then
            yesButton = yesButton:FindFirstChild("ButtonsHolder")
        end
        if yesButton then
            yesButton = yesButton:FindFirstChild("Yes")
        end
        
        if yesButton then
            pcall(function()
                for _, connection in pairs(getconnections(yesButton.MouseButton1Click)) do
                    connection:Fire()
                end
            end)
            print("[ARTIFACTS] 🖱️ Clicked Yes button")
        end
    else
        -- ถ้าไม่มี UI → ยิง remote ตรงๆ
        print("[ARTIFACTS] ⚠️ No ConfirmUI, firing ArtifactUnlockSystem remote...")
        pcall(function()
            RemoteEvents:WaitForChild("ArtifactUnlockSystem"):FireServer()
        end)
    end
    
    task.wait(3)
    
    -- 5. เช็คว่าเปิดสำเร็จหรือยัง
    if checkArtifactsUnlocked() then
        print("[ARTIFACTS] ✅ Artifacts unlocked successfully!")
        return true
    else
        print("[ARTIFACTS] ❌ Failed to unlock Artifacts")
        return false
    end
end

local function equipArtifacts()
    oldPrint("[ARTIFACTS] 🎯 Equipping Artifacts...")
    
    -- 1. เปิด UI ก่อน
    pcall(function()
        RemoteEvents:WaitForChild("ArtifactUIOpened"):FireServer()
    end)
    oldPrint("[ARTIFACTS] 📂 Opened Artifact UI")
    task.wait(2)
    
    -- 2. ดึงข้อมูล artifact ทั้งหมด
    local data = nil
    local ok, err = pcall(function()
        data = RS:WaitForChild("RemoteFunctions"):WaitForChild("GetArtifactData"):InvokeServer()
    end)
    oldPrint("[ARTIFACTS] 📡 GetArtifactData ok:", tostring(ok), "err:", tostring(err))
    
    if data and type(data) == "table" then
        -- Deep debug: แสดงทุก field
        local allIds = {}
        local function deepScan(tbl, prefix)
            for k, v in pairs(tbl) do
                local key = prefix .. tostring(k)
                if type(v) == "table" then
                    oldPrint("[ARTIFACTS] 📊 " .. key .. " = {table}")
                    deepScan(v, key .. ".")
                else
                    oldPrint("[ARTIFACTS] 📊 " .. key .. " = " .. tostring(v))
                    -- เก็บทุกค่าที่เป็น string UUID format
                    if type(v) == "string" and v:match("%x%x%x%x%x%x%x%x%-%x%x%x%x") then
                        table.insert(allIds, v)
                        oldPrint("[ARTIFACTS] 🔑 Found UUID: " .. v)
                    end
                end
            end
        end
        deepScan(data, "")
        
        -- Equip ทุก UUID ที่เจอ
        oldPrint("[ARTIFACTS] 🔑 Total UUIDs found: " .. #allIds)
        for i, uuid in ipairs(allIds) do
            pcall(function()
                RemoteEvents:WaitForChild("ArtifactEquip"):FireServer(uuid)
            end)
            oldPrint("[ARTIFACTS] ✅ Equipped #" .. i .. ": " .. uuid)
            task.wait(0.5)
        end
    else
        oldPrint("[ARTIFACTS] ⚠️ No artifact data, type:", type(data))
    end
    
    task.wait(1)
    
    -- 3. ปิด UI → กดปุ่ม Close ใน ArtifactsUI
    pcall(function()
        local artifactsUI = player.PlayerGui:FindFirstChild("ArtifactsUI")
        if artifactsUI then
            local mainFrame = artifactsUI:FindFirstChild("ArtifactsMainFrame")
            if mainFrame then
                local closeHolder = mainFrame:FindFirstChild("CloseButtonFrameHolder")
                if closeHolder then
                    -- หาปุ่มใน CloseButtonFrameHolder
                    for _, btn in pairs(closeHolder:GetDescendants()) do
                        if btn:IsA("TextButton") or btn:IsA("ImageButton") then
                            oldPrint("[ARTIFACTS] 🔒 Clicking close button:", btn.Name)
                            pcall(function()
                                for _, conn in pairs(getconnections(btn.MouseButton1Click)) do
                                    conn:Fire()
                                end
                            end)
                            break
                        end
                    end
                end
            end
        end
    end)
    task.wait(0.5)
    
    -- Fallback: ยิง remote + force disable
    pcall(function()
        RemoteEvents:WaitForChild("ArtifactCloseUI"):FireServer()
    end)
    pcall(function()
        local artifactsUI = player.PlayerGui:FindFirstChild("ArtifactsUI")
        if artifactsUI then
            artifactsUI.Enabled = false
            oldPrint("[ARTIFACTS] 🔒 Force disabled ArtifactsUI")
        end
    end)
    
    oldPrint("[ARTIFACTS] ✅ Closed Artifact UI")
end

-- ═══════════════════════════════════════════════════════════════
-- [12] OBSERVATION HAKI BUY SYSTEM (Level 6000+)
-- ═══════════════════════════════════════════════════════════════
local function checkHasObservationHaki()
    -- เช็คว่ามี Observation Haki แล้วหรือยัง (ใช้ HakiRemote GetProgression)
    local hasObs = false
    pcall(function()
        local data = RemoteEvents:WaitForChild("HakiRemote"):FireServer("GetProgression")
        -- เช็คจาก UI: ถ้ามี ObservationHaki UI visible = มีแล้ว
        local statsUI = player.PlayerGui:FindFirstChild("StatsPanelUI")
        if statsUI then
            for _, desc in pairs(statsUI:GetDescendants()) do
                if desc.Name:find("Observation") and desc:IsA("Frame") and desc.Visible == true then
                    hasObs = true
                    break
                end
            end
        end
    end)
    
    -- Fallback: เช็คว่า ObservationHakiRemote ตอบกลับได้ไหม
    if not hasObs then
        pcall(function()
            RemoteEvents:WaitForChild("ObservationHakiRemote"):FireServer("Toggle")
            task.wait(0.3)
            RemoteEvents:WaitForChild("ObservationHakiRemote"):FireServer("Toggle")
            -- ถ้าไม่ error = มี Obs Haki แล้ว
            -- ลองดูจาก Character ว่ามี effect
            local char = player.Character
            if char then
                for _, v in pairs(char:GetDescendants()) do
                    if v.Name:find("Observation") or v.Name:find("observation") then
                        hasObs = true
                        break
                    end
                end
            end
        end)
    end
    
    oldPrint("[OBS HAKI] Check hasObservationHaki:", tostring(hasObs))
    return hasObs
end

local function buyObservationHaki()
    oldPrint("[OBS HAKI] ========== BUY OBSERVATION HAKI START ==========")
    
    -- 1. เช็คว่ามีแล้วหรือยัง
    if checkHasObservationHaki() then
        oldPrint("[OBS HAKI] ⏭️ Already have Observation Haki, skipping...")
        return true
    end
    
    -- 2. วาปไป NPC
    oldPrint("[OBS HAKI] 📍 Teleporting to ObservationBuyer NPC...")
    local npcCFrame = CFrame.new(-713.182922, 12.1339779, -527.289795, -0.763382077, 0, 0.645947695, 0, 1, 0, -0.645947695, 0, -0.763382077)
    
    tweenPos(npcCFrame)
    task.wait(3)
    
    -- 3. หา Prompt และยิง
    oldPrint("[OBS HAKI] 🔍 Finding ObservationHakiPrompt...")
    local npc = workspace:FindFirstChild("ServiceNPCs")
    if npc then npc = npc:FindFirstChild("ObservationBuyer") end
    if npc then npc = npc:FindFirstChild("HumanoidRootPart") end
    
    local prompt = nil
    if npc then
        prompt = npc:FindFirstChild("ObservationHakiPrompt")
    end
    
    if not prompt then
        oldPrint("[OBS HAKI] ❌ ObservationHakiPrompt not found!")
        return false
    end
    
    oldPrint("[OBS HAKI] 💰 Firing ObservationHakiPrompt...")
    prompt.MaxActivationDistance = math.huge
    fireproximityprompt(prompt)
    task.wait(2)
    
    -- 4. รอ ConfirmUI และกด Yes
    oldPrint("[OBS HAKI] ⏳ Waiting for ConfirmUI...")
    task.wait(1)
    
    local confirmUI = player.PlayerGui:FindFirstChild("ConfirmUI")
    if confirmUI and confirmUI.Enabled then
        oldPrint("[OBS HAKI] ✅ ConfirmUI found, clicking Yes...")
        local yesButton = confirmUI:FindFirstChild("MainFrame")
        if yesButton then yesButton = yesButton:FindFirstChild("ButtonsHolder") end
        if yesButton then yesButton = yesButton:FindFirstChild("Yes") end
        
        if yesButton then
            pcall(function()
                for _, connection in pairs(getconnections(yesButton.MouseButton1Click)) do
                    connection:Fire()
                end
            end)
            oldPrint("[OBS HAKI] 🖱️ Clicked Yes button")
        end
    else
        oldPrint("[OBS HAKI] ⚠️ No ConfirmUI found")
    end
    
    task.wait(3)
    
    -- 5. เช็คว่าซื้อสำเร็จ
    oldPrint("[OBS HAKI] ✅ Observation Haki purchase attempted!")
    return true
end

-- ═══════════════════════════════════════════════════════════════
-- [11] BOSS KEY AUTO BUY SYSTEM (Real-time Stock Update)
-- ═══════════════════════════════════════════════════════════════
local lastBossKeyBuyTime = 0
local isBuyingBossKey = false

local function buyBossKeysFromStock(bossKeyStock)
    if isBuyingBossKey then
        oldPrint("[BOSS KEY] ⏰ Already buying, skipping...")
        return false
    end
    
    local currentTime = tick()
    
    -- ป้องกันการซื้อซ้ำเร็วเกินไป (รอ 5 วินาทีจากครั้งล่าสุด)
    if currentTime - lastBossKeyBuyTime < 5 then
        return false
    end
    
    isBuyingBossKey = true
    oldPrint("[BOSS KEY] ========== AUTO BUY BOSS KEY START ==========")
    oldPrint(string.format("[BOSS KEY] 🔑 Boss Key in stock: %d", bossKeyStock))
    
    -- วาปไป MerchantNPC
    local merchantCF = CFrame.new(368.817719, 2.79983521, 783.589844, -0.0566431284, 0, 0.998394549, 0, 1, 0, -0.998394549, 0, -0.0566431284)
    oldPrint("[BOSS KEY] 📍 Teleporting to MerchantNPC...")
    tweenPos(merchantCF)
    task.wait(3)
    
    -- ซื้อทั้งหมด
    oldPrint(string.format("[BOSS KEY] 💰 Buying %d Boss Keys...", bossKeyStock))
    for i = 1, bossKeyStock do
        pcall(function()
            RS.Remotes.MerchantRemotes.PurchaseMerchantItem:InvokeServer("Boss Key", 1)
        end)
        task.wait(0.5)
    end
    
    lastBossKeyBuyTime = currentTime
    isBuyingBossKey = false
    oldPrint("[BOSS KEY] ✅ Boss Key purchase complete!")
    oldPrint("[BOSS KEY] ========== AUTO BUY BOSS KEY END ==========")
    return true
end

-- ฟัง MerchantStockUpdate event แบบ real-time
local function setupBossKeyAutoListener()
    oldPrint("[BOSS KEY] 🎧 Setting up real-time stock listener...")
    
    -- เช็ค stock ครั้งแรกตอนเริ่มต้น
    task.spawn(function()
        task.wait(2)
        oldPrint("[BOSS KEY] 📦 Checking initial stock...")
        local success, stock = pcall(function()
            return RS.Remotes.MerchantRemotes.GetMerchantStock:InvokeServer()
        end)
        
        if success then
            oldPrint(string.format("[BOSS KEY] 📋 Stock type: %s", type(stock)))
            
            if type(stock) == "table" then
                -- ข้อมูล items อยู่ใน stock.stock
                local items = stock.stock or stock
                oldPrint(string.format("[BOSS KEY] 📦 Items type: %s", type(items)))
                
                if type(items) == "table" then
                    -- นับจำนวน items
                    local itemCount = 0
                    for _ in pairs(items) do itemCount = itemCount + 1 end
                    oldPrint(string.format("[BOSS KEY] 📊 Total items: %d", itemCount))
                    
                    -- แสดงข้อมูลทุก item
                    local foundBossKey = false
                    for key, item in pairs(items) do
                        if type(item) == "table" then
                            -- แสดง fields ทั้งหมดของ item
                            oldPrint(string.format("[BOSS KEY] 🔍 Item[%s] fields:", tostring(key)))
                            for k, v in pairs(item) do
                                oldPrint(string.format("[BOSS KEY]   - %s = %s (%s)", tostring(k), tostring(v), type(v)))
                            end
                            
                            local itemName = item.name or item.itemId or item.Name or item.ItemId or item.itemName or tostring(key)
                            local itemStock = item.stock or item.quantity or item.Stock or item.Quantity or 0
                            
                            if itemName == "Boss Key" or (type(itemName) == "string" and string.find(itemName, "Boss Key")) then
                                foundBossKey = true
                                oldPrint(string.format("[BOSS KEY] 🔑 Boss Key found! Stock: %d", itemStock))
                                if itemStock > 0 then
                                    buyBossKeysFromStock(itemStock)
                                end
                                break
                            end
                        end
                    end
                    
                    if not foundBossKey then
                        oldPrint("[BOSS KEY] ❌ Boss Key not found in stock")
                    end
                else
                    oldPrint("[BOSS KEY] ⚠️ Items is not a table")
                end
            else
                oldPrint("[BOSS KEY] ⚠️ Stock is not a table")
            end
        else
            oldPrint("[BOSS KEY] ❌ Failed to get initial stock")
        end
    end)
    
    -- ฟัง event สำหรับ stock update
    pcall(function()
        RS.Remotes.MerchantRemotes.MerchantStockUpdate.OnClientEvent:Connect(function(...)
            if not _G.Config.AutoBuyBossKey then return end
            
            local args = {...}
            oldPrint("[BOSS KEY] 🔔 Stock update event received!")
            oldPrint(string.format("[BOSS KEY] 📊 Event args count: %d", #args))
            
            -- ลองหาข้อมูลจาก arguments ทั้งหมด
            for i, arg in ipairs(args) do
                if type(arg) == "table" then
                    oldPrint(string.format("[BOSS KEY] 📦 Arg[%d] is table", i))
                    for _, item in pairs(arg) do
                        if type(item) == "table" and (item.name == "Boss Key" or item.itemId == "Boss Key") then
                            local stock = item.stock or item.quantity or 0
                            oldPrint(string.format("[BOSS KEY] � Boss Key found! Stock: %d", stock))
                            if stock > 0 then
                                task.spawn(function()
                                    buyBossKeysFromStock(stock)
                                end)
                            end
                            return
                        end
                    end
                end
            end
        end)
    end)
    
    oldPrint("[BOSS KEY] ✅ Real-time stock listener ready!")
end

-- ═══════════════════════════════════════════════════════════════
-- [12] ICHIGO EXCHANGE SYSTEM
-- ═══════════════════════════════════════════════════════════════
local function checkIchigoRequirements()
    -- ตอนนี้ต้องใช้ Boss Ticket 500 ชิ้นเท่านั้น
    local bossTicketCount = inventoryByRarity["Epic"]["Boss Ticket"] or 0
    
    -- ถ้ายังไม่มีข้อมูล ลอง refresh
    if bossTicketCount == 0 then
        pcall(function() RS.Remotes.RequestInventory:FireServer() end)
        task.wait(1)
        bossTicketCount = inventoryByRarity["Epic"]["Boss Ticket"] or 0
    end
    
    local hasAllItems = bossTicketCount >= 500
    local missingItems = {}
    
    if not hasAllItems then
        table.insert(missingItems, string.format("Boss Ticket: %d / 500", bossTicketCount))
    end
    
    return hasAllItems, missingItems
end

local function exchangeIchigo()
    oldPrint("[ICHIGO] ========== EXCHANGE ICHIGO START ==========")
    
    -- 1. เช็คว่ามี Ichigo แล้วหรือยัง
    if checkDarkBlade("Ichigo") then
        oldPrint("[ICHIGO] ⏭️ Already have Ichigo, skipping...")
        return true
    end
    
    -- 2. เช็คว่ามี Boss Ticket 500 ชิ้นหรือยัง
    local hasAll, missing = checkIchigoRequirements()
    
    if not hasAll then
        oldPrint("[ICHIGO] ❌ Missing requirements:")
        for _, item in pairs(missing) do
            oldPrint("[ICHIGO]   - " .. item)
        end
        oldPrint("[ICHIGO] 🎯 Farm Saber Boss to get Boss Tickets!")
        return false
    end
    
    oldPrint("[ICHIGO] ✅ All requirements met (Boss Ticket: 500)! Exchanging...")
    
    -- 3. เรียก ExchangeItem remote โดยตรง
    oldPrint("[ICHIGO] 💰 Calling ExchangeItem remote...")
    local success = pcall(function()
        RS.Remotes.ExchangeItem:InvokeServer("Ichigo")
    end)
    
    if not success then
        oldPrint("[ICHIGO] ❌ Failed to call ExchangeItem remote")
        return false
    end
    
    task.wait(3)
    
    -- 4. เช็คว่าได้ Ichigo แล้ว
    if checkDarkBlade("Ichigo") then
        oldPrint("[ICHIGO] ✅ Ichigo exchange successful!")
        return true
    else
        oldPrint("[ICHIGO] ⚠️ Ichigo not found in inventory after exchange")
        return false
    end
end

-- ═══════════════════════════════════════════════════════════════
-- [13] SABER BOSS FARM SYSTEM
-- ═══════════════════════════════════════════════════════════════
local function checkBossKeyCount()
    -- Refresh inventory ทุกครั้งเพื่อให้ได้ข้อมูลล่าสุด
    pcall(function() RS.Remotes.RequestInventory:FireServer() end)
    task.wait(1)
    
    -- Boss Key เป็น Epic rarity
    local count = inventoryByRarity["Epic"]["Boss Key"] or 0
    
    oldPrint(string.format("[SABER BOSS] 🔑 Boss Key: %d", count))
    return count
end

local function farmSaberBoss()
    oldPrint("[SABER BOSS] ========== FARM SABER BOSS START ==========")
    isFarmingIchigoBoss = true
    
    -- Loop ตีบอสจนกว่า Boss Key จะหมด
    while isFarmingIchigoBoss do
        -- เช็ค Boss Key
        local bossKeyCount = checkBossKeyCount()
        oldPrint(string.format("[SABER BOSS] 🎫 Boss Key: %d", bossKeyCount))
        
        if bossKeyCount < 1 then
            oldPrint("[SABER BOSS] ❌ Not enough Boss Keys! Need 1 to summon.")
            break
        end
        
        -- 1. วาปไป SummonBossNPC
        local summonNPCCFrame = CFrame.new(651.810181, -3.67419362, -1021.13123, 0.999550879, 0, 0.0299676117, 0, 1, 0, -0.0299676117, 0, 0.999550879)
        oldPrint("[SABER BOSS] 📍 Teleporting to SummonBossNPC...")
        tweenPos(summonNPCCFrame)
        task.wait(3)
    
    -- 2. เรียกบอส SaberBoss
    oldPrint("[SABER BOSS] 🔔 Summoning SaberBoss...")
    local success = pcall(function()
        RS.Remotes.RequestSummonBoss:FireServer("SaberBoss")
    end)
    
    if not success then
        pcall(function()
            RS.Remotes.RequestAutoSpawn:FireServer("SaberBoss")
        end)
    end
    
    task.wait(5)
    
    -- 3. หาบอสและวาปไปตี
    oldPrint("[SABER BOSS] 🔍 Finding SaberBoss...")
    local boss = workspace:FindFirstChild("NPCs")
    if boss then boss = boss:FindFirstChild("SaberBoss") end
    
    if not boss then
        oldPrint("[SABER BOSS] ❌ SaberBoss not found! Waiting...")
        task.wait(10)
        boss = workspace:FindFirstChild("NPCs")
        if boss then boss = boss:FindFirstChild("SaberBoss") end
    end
    
    if boss and boss:FindFirstChild("HumanoidRootPart") and boss:FindFirstChild("Humanoid") then
        oldPrint("[SABER BOSS] ✅ SaberBoss found! Starting combat...")
        
        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then
            oldPrint("[SABER BOSS] ❌ Character not found!")
            return
        end
        
        -- Equip Dark Blade (รองรับทั้งภาษาอังกฤษและไทย)
        local tool = findDarkBladeInHand()
        if not tool then
            equipDarkBladeFromInventory()
            tool = findDarkBladeInHand()
        end
        if tool and tool.Parent == player.Backpack then
            char.Humanoid:EquipTool(tool)
        end
        
        -- ตีบอสจนตาย (ใช้วิธีเดียวกับฟาร์ม NPC)
        local bossRoot = boss.HumanoidRootPart
        local bossHumanoid = boss.Humanoid
        local YPOS = 15
        local skillIndex = 1
        
        -- Selection box
        local box = Instance.new("SelectionBox")
        box.Adornee = boss
        box.Color3 = Color3.fromRGB(255, 0, 0)
        box.LineThickness = 0.1
        box.SurfaceTransparency = 0.6
        box.SurfaceColor3 = Color3.fromRGB(255, 0, 0)
        box.Parent = workspace
        
        repeat task.wait()
            if not boss or not boss.Parent or not boss:FindFirstChild("HumanoidRootPart") or bossHumanoid.Health <= 0 then
                break
            end
            if not char or not char:FindFirstChild("HumanoidRootPart") then break end
            if char.Humanoid.Health <= 0 then break end
            
            -- Equip Dark Blade ทุกรอบ (รองรับทั้งภาษาอังกฤษแลเไทย)
            local tool = findDarkBladeInHand()
            if not tool then
                equipDarkBladeFromInventory()
                tool = findDarkBladeInHand()
            end
            if tool and tool.Parent == player.Backpack then
                char.Humanoid:EquipTool(tool)
            end
            
            -- BodyVelocity ล็อคตัวละคร
            BodyVelocity.Velocity = Vector3.zero
            BodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            BodyVelocity.Parent = char.HumanoidRootPart
            
            -- Freeze Boss ถ้าเป็น owner
            local success, owner = pcall(function()
                return bossRoot:GetNetworkOwner()
            end)
            if success and owner == player then
                bossRoot.CFrame = CFrame.new(bossRoot.Position)
                bossRoot.AssemblyLinearVelocity = Vector3.zero
                bossRoot.AssemblyAngularVelocity = Vector3.zero
            end
            
            -- tweenPos ชิดบอส
            tweenPos(
                CFrame.new(bossRoot.Position + Vector3.new(0, YPOS, 0)) * CFrame.Angles(math.rad(-90), 0, 0),
                function()
                    pcall(function()
                        local tool = char:FindFirstChildWhichIsA("Tool")
                        if tool then tool:Activate() end
                    end)
                    hitRemote:FireServer()
                end
            )
            
            -- Haki + Observation Haki
            pcall(function() RemoteEvents:WaitForChild("HakiRemote"):FireServer("Toggle") end)
            pcall(function() RemoteEvents:WaitForChild("ObservationHakiRemote"):FireServer("Toggle") end)
            
            -- Combo: สกิล 1 ตัว → ตีธรรมดา → วน
            pcall(function()
                RS:WaitForChild("AbilitySystem"):WaitForChild("Remotes"):WaitForChild("RequestAbility"):FireServer(skillIndex)
            end)
            pcall(function()
                local tool = char:FindFirstChildWhichIsA("Tool")
                if tool then tool:Activate() end
            end)
            hitRemote:FireServer()
            
            skillIndex = skillIndex + 1
            if skillIndex > 4 then skillIndex = 1 end
            
        until not boss.Parent or bossHumanoid.Health <= 0 or char.Humanoid.Health <= 0
        
        box:Destroy()
        
        -- เช็คว่าบอสตายจริงหรือตัวเราตาย
        local bossStillAlive = boss and boss.Parent and boss:FindFirstChild("HumanoidRootPart") and bossHumanoid.Health > 0
        
        if bossStillAlive then
            -- ตัวเราตาย แต่บอสยังมีชีวิต → รอ respawn แล้วกลับมาตีต่อ
            oldPrint("[SABER BOSS] ⚠️ Player died! Waiting for respawn...")
            task.wait(5)
            
            -- เช็คอีกครั้งว่าบอสยังอยู่ไหม (อาจตายระหว่างรอ respawn)
            if boss and boss.Parent and boss:FindFirstChild("HumanoidRootPart") and bossHumanoid.Health > 0 then
                -- หาตัวละครใหม่
                local newChar = player.Character or player.CharacterAdded:Wait()
                if newChar and newChar:FindFirstChild("HumanoidRootPart") then
                    oldPrint("[SABER BOSS] 🔄 Respawned! Returning to boss...")
                    
                    -- วาปกลับไปหาบอส
                    local bossPos = boss.HumanoidRootPart.Position
                    tweenPos(CFrame.new(bossPos + Vector3.new(0, 15, 0)))
                    task.wait(3)
                end
            else
                oldPrint("[SABER BOSS] ⚠️ Boss died while waiting for respawn!")
            end
        else
            -- บอสตายจริง
            oldPrint("[SABER BOSS] ✅ SaberBoss defeated!")
            
            -- เช็คไอเทมที่ได้
            oldPrint("[SABER BOSS] 📦 Checking drops...")
            task.wait(2)
            
            oldPrint("[SABER BOSS] 🔄 Checking Boss Keys for next round...")
        end
    else
        oldPrint("[SABER BOSS] ❌ SaberBoss not spawned or already dead!")
        task.wait(5)
    end
    
    end -- end while loop
    
    isFarmingIchigoBoss = false
    oldPrint("[SABER BOSS] ========== FARM SABER BOSS END ==========")
end

-- ═══════════════════════════════════════════════════════════════
-- [13] FRUIT FARM SYSTEM
-- ═══════════════════════════════════════════════════════════════
local function startFruitFarm()
    oldPrint("[FRUIT] ========== FRUIT FARM START ==========")
    isFruitFarming = true
    
    local targetFruit = _G.Config.TargetFruit
    
    -- 1. เช็คว่ามีผลแล้วหรือยัง
    oldPrint("[FRUIT] STEP 1: checkHasFruit...")
    local hasFruitAlready = checkHasFruit(targetFruit)
    oldPrint("[FRUIT] STEP 1 result:", tostring(hasFruitAlready))
    
    if hasFruitAlready then
        oldPrint("[FRUIT] ✅ Already have", targetFruit)
        
        -- กินผลก่อนไปฟาร์ม (ทุกครั้ง!)
        local fruitTool = getAnyFruitFromBackpack()
        if fruitTool then
            oldPrint("[FRUIT] 🍽️ Eating target fruit before farming:", fruitTool.Name)
            eatFruit(fruitTool)
            task.wait(2)
        else
            oldPrint("[FRUIT] ⚠️ No fruit tool found in Backpack/Character!")
        end
        
        equipFruit(targetFruit)
        
        -- ไปฟาร์มต่อเลย (ไม่รีสเตตัส!)
        oldPrint("[FRUIT] STEP 6: Teleporting to farm position...")
        local island = _G.Config.FruitFarmIsland
        local pos = _G.Config.FruitFarmPos
        
        pcall(function()
            tpRemote:FireServer(island)
        end)
        task.wait(3)
        
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            for i = 1, 10 do
                char.HumanoidRootPart.CFrame = pos
                task.wait(0.1)
            end
        end
        
        oldPrint("[FRUIT] ✅ Fruit farm setup complete!")
        task.spawn(fruitFarmLoop)
        return true
    end
    
    -- 2. เช็คว่ารีสเตตัสแล้วหรือยัง (เช็คจาก Power stat จริงๆ)
    local currentPower = 0
    pcall(function()
        currentPower = player.Data.Power.Value or 0
    end)
    
    if currentPower < 11500 then
        oldPrint("[FRUIT] STEP 2: Reset Stats (Power < 11500)...")
        pcall(function()
            RemoteEvents:WaitForChild("ResetStats"):FireServer()
        end)
        task.wait(3)
        oldPrint("[FRUIT] STEP 2: Reset Stats done")
        
        -- 3. Allocate Stats: Power 11500 → Sword
        oldPrint("[FRUIT] STEP 3: Allocate Stats...")
        local ok3, err3 = pcall(allocateStatsPowerFirst)
        if not ok3 then
            oldPrint("[FRUIT] STEP 3 ERROR:", tostring(err3))
        else
            oldPrint("[FRUIT] STEP 3: Stats allocated OK")
        end
        task.wait(2)
    else
        oldPrint("[FRUIT] ⏭️ STEP 2-3: Power already >= 11500, skipping reset...")
    end
    
    -- 4. สุ่มซื้อผลจนได้ตัวที่ต้องการ
    oldPrint("[FRUIT] STEP 4: Starting buy loop...")
    local maxAttempts = 100
    local attemptNum = 0
    local gotTarget = false
    
    while maxAttempts > 0 and not gotTarget do
        maxAttempts = maxAttempts - 1
        attemptNum = attemptNum + 1
        oldPrint("[FRUIT] ══════════════════════════════════")
        oldPrint("[FRUIT] 🎲 Attempt " .. attemptNum .. " / 100")
        
        -- 4a. ซื้อผลสุ่ม
        local ok4, err4 = pcall(buyRandomFruit)
        if not ok4 then
            oldPrint("[FRUIT] ❌ buyRandomFruit ERROR:", tostring(err4))
            task.wait(2)
        else
            -- 4b. รอให้ผลโหลดเข้า Backpack (เพิ่มเวลารอ)
            oldPrint("[FRUIT] ⏳ Waiting for fruit to load into Backpack...")
            task.wait(3)
            local fruitTool = getAnyFruitFromBackpack()
            
            if fruitTool then
                oldPrint("[FRUIT] 🍎 Got: " .. fruitTool.Name)
                
                -- เช็คว่าชื่อผลมี targetFruit อยู่ในนั้นหรือไม่ (เช่น "Quake Fruit" มี "Quake")
                local isTargetFruit = fruitTool.Name:find(targetFruit) ~= nil
                
                if isTargetFruit then
                    -- ได้ผลที่ต้องการ! → กินผลก่อนไปฟาร์ม
                    oldPrint("[FRUIT] 🎉🎉🎉 GOT TARGET FRUIT: " .. fruitTool.Name .. " !!! 🎉🎉🎉")
                    oldPrint("[FRUIT] 🍽️ Eating target fruit...")
                    eatFruit(fruitTool)
                    task.wait(2)
                    gotTarget = true
                else
                    -- ไม่ใช่ผลที่ต้องการ → กินทิ้ง
                    oldPrint("[FRUIT] ❌ Not " .. targetFruit .. " → Eating " .. fruitTool.Name .. "...")
                    eatFruit(fruitTool)
                    task.wait(2)
                end
            else
                oldPrint("[FRUIT] ⚠️ No fruit found in Backpack after buying!")
                task.wait(2)
            end
        end
    end
    
    -- 5. Equip ผล
    oldPrint("[FRUIT] STEP 5: Check final result...")
    if checkHasFruit(targetFruit) then
        oldPrint("[FRUIT] ✅ Got " .. targetFruit .. "! Equipping...")
        equipFruit(targetFruit)
        
        -- 6. Teleport to farm position
        oldPrint("[FRUIT] STEP 6: Teleporting to farm position...")
        local island = _G.Config.FruitFarmIsland
        local pos = _G.Config.FruitFarmPos
        
        pcall(function()
            tpRemote:FireServer(island)
        end)
        task.wait(3)
        
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            for i = 1, 10 do
                char.HumanoidRootPart.CFrame = pos
                task.wait(0.1)
            end
        end
        
        oldPrint("[FRUIT] ✅ Fruit farm setup complete!")
        task.spawn(fruitFarmLoop)
        return true
    else
        oldPrint("[FRUIT] ❌ Failed to get " .. targetFruit)
        isFruitFarming = false
        return false
    end
end

-- ═══════════════════════════════════════════════════════════════
-- [11] HAKI QUEST SYSTEM
-- ═══════════════════════════════════════════════════════════════
local function acceptHakiQuest()
    print("[HAKI QUEST] Accepting quest...")
    local hakiPos = Vector3.new(-497.94, 23.66, -1252.64)

    -- ยกเลิก Quest เก่า (ถ้ามีและไม่ใช่ Haki)
    pcall(function()
        local questUI = player.PlayerGui:FindFirstChild("QuestUI")
        if questUI and questUI:FindFirstChild("Quest") and questUI.Quest.Visible then
            local title = questUI.Quest.Quest.Holder.Content.QuestInfo.QuestTitle.QuestTitle.Text
            if not title:find("Path to Haki") then
                abandonRemote:FireServer("repeatable")
                task.wait(2)
            else
                return -- มี Haki quest อยู่แล้ว
            end
        end
    end)

    tweenPos(CFrame.new(hakiPos))
    task.wait(2)
    pcall(function() questRemote:FireServer("HakiQuestNPC") end)
    task.wait(2)
end

local function goToHakiNPC()
    local hakiPos = Vector3.new(-497.94, 23.66, -1252.64)
    tweenPos(CFrame.new(hakiPos))
    task.wait(4)

    local char = player.Character

    -- กด E key (วิธีหลัก)
    for i = 1, 5 do
        print("[HAKI QUEST] Press E attempt", i)
        pcall(function()
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(hakiPos) * CFrame.new(0, 0, 3)
            end
        end)
        task.wait(0.5)
        VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
        task.wait(0.1)
        VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
        task.wait(2)

        if checkHakiStatus() then
            print("[HAKI QUEST] 🎉 Haki obtained via E key!")
            return true
        end
    end

    print("[HAKI QUEST] ❌ Failed to get Haki after E key attempts")

    return false
end

local function farmThiefForHaki()
    print("[HAKI QUEST] Starting Haki farm...")
    local targetNPC = "Thief"
    local killCount = 0
    local lastCheckKills = 0

    -- ดึงชื่อ NPC จาก Quest
    pcall(function()
        local questUI = player.PlayerGui:FindFirstChild("QuestUI")
        if questUI and questUI:FindFirstChild("Quest") and questUI.Quest.Visible then
            local title = questUI.Quest.Quest.Holder.Content.QuestInfo.QuestTitle.QuestTitle.Text
            if not title:find("Path to Haki") then
                abandonRemote:FireServer("repeatable")
                task.wait(2)
            end
            local desc = questUI.Quest.Quest.Holder.Content.QuestInfo.QuestDescription.Text
            local name = desc:match("Defeat the (%w+)") or desc:match("defeat (%w+)")
            if name then targetNPC = name end
        end
    end)

    -- Teleport ไปฟาร์ม
    pcall(function() tpRemote:FireServer("Starter") end)
    task.wait(3)

    local farmStart = tick()

    while task.wait(0.5) do
        if not isHakiQuestActive then break end
        if tick() - farmStart > _G.Config.HakiTimeout then
            print("[HAKI QUEST] ⚠️ Timeout!")
            isHakiQuestActive = false
            break
        end

        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then continue end
        if char.Humanoid.Health <= 0 then continue end

        -- เช็ค Quest progress
        local shouldGoToNPC = false
        local questUI = player.PlayerGui:FindFirstChild("QuestUI")
        local questVisible = questUI and questUI:FindFirstChild("Quest") and questUI.Quest.Visible

        if questVisible then
            pcall(function()
                for _, child in pairs(questUI.Quest.Quest.Holder.Content.QuestInfo:GetDescendants()) do
                    if child:IsA("TextLabel") then
                        if child.Text:find("Completed!") then
                            shouldGoToNPC = true
                            break
                        end
                        local cur, tot = child.Text:match("(%d+)/(%d+)")
                        if cur and tot and tonumber(cur) >= tonumber(tot) then
                            shouldGoToNPC = true
                        end
                    end
                end
            end)
        else
            if killCount > 5 and (killCount - lastCheckKills) >= 5 then
                shouldGoToNPC = true
            end
        end

        -- ไปส่ง Quest
        if shouldGoToNPC then
            print("[HAKI QUEST] 🔄 Going to NPC...")
            lastCheckKills = killCount

            if goToHakiNPC() then
                print("[HAKI QUEST] 🎉🎉 HAKI OBTAINED!")

                if _G.Config.BuyDarkBlade then
                    print("[HAKI QUEST] 🛒 Buying Dark Blade...")
                    isHakiQuestActive = false
                    pcall(buyDarkBlade)
                end

                print("[HAKI QUEST] ✅ Complete!")
                return
            end

            -- ดึง NPC ใหม่จาก Quest ใหม่
            pcall(function()
                local q = player.PlayerGui:FindFirstChild("QuestUI")
                if q and q:FindFirstChild("Quest") and q.Quest.Visible then
                    local desc = q.Quest.Quest.Holder.Content.QuestInfo.QuestDescription.Text
                    local name = desc:match("Defeat the (%w+)") or desc:match("defeat (%w+)")
                    if name then targetNPC = name; print("[HAKI QUEST] New target:", targetNPC) end
                end
            end)

            pcall(function() tpRemote:FireServer("Starter") end)
            task.wait(3)
            continue
        end

        -- ฟาร์ม NPC
        local npcFound = false
        for i = 1, 5 do
            local npc = workspace.NPCs:FindFirstChild(targetNPC .. i)
            if npc and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                npcFound = true
                local target = npc:FindFirstChild("HumanoidRootPart")
                if target then
                    while npc.Parent and npc.Humanoid.Health > 0 do
                        if not char or not char:FindFirstChild("HumanoidRootPart") then break end
                        if char.Humanoid.Health <= 0 then break end
                        pcall(function() char.HumanoidRootPart.CFrame = target.CFrame * CFrame.new(0, 0, 5) end)
                        pcall(function() hitRemote:FireServer() end)
                        task.wait(0.3)
                    end
                    killCount = killCount + 1
                    break
                end
            end
        end

        if not npcFound then task.wait(3) end
    end
end

local function startHakiQuest()
    if not _G.Config.HakiQuest then return end
    print("[HAKI QUEST] Starting...")
    pcall(acceptHakiQuest)
    pcall(farmThiefForHaki)
end

-- ═══════════════════════════════════════════════════════════════
-- [11] NORMAL QUEST FARM
-- ═══════════════════════════════════════════════════════════════
local function selectWeapon()
    -- เช็คว่า Dark Blade อยู่ในมือแล้วหรือยัง
    local blade = findDarkBladeInHand()
    if blade then return "Dark Blade" end

    -- ลอง Equip จาก Inventory
    if equipDarkBladeFromInventory() then return "Dark Blade" end

    -- ไม่มี Dark Blade → ใช้อาวุธดีสุด
    return getBestWeapon()
end

local function equipToolByName(toolName, char)
    local tool = nil
    if toolName == "Dark Blade" then
        tool = findDarkBladeInHand()
    else
        tool = player.Backpack:FindFirstChild(toolName) or char:FindFirstChild(toolName)
    end

    if tool and tool.Parent == player.Backpack then
        print("[FARM] Equipping:", tool.Name)
        char.Humanoid:EquipTool(tool)
    end
    return tool
end

local function farmLoop()
    while _G.Config.AutoFarm do
        task.wait()

        -- รอถ้า Haki Quest, ซื้อดาบ, Fruit Farm, หรือ Ichigo Boss Farm กำลังทำงาน
        if isHakiQuestActive or isBuyingDarkBlade or isFruitFarming or isFarmingIchigoBoss then
            task.wait(10)
            continue
        end

        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then continue end
        if char.Humanoid.Health <= 0 then continue end

        local questInfo = getQuestInfo()
        if not questInfo then continue end

        -- เช็คว่ามี Quest อยู่หรือยัง
        local questUI = player.PlayerGui:FindFirstChild("QuestUI")
        if not questUI then continue end

        if not questUI.Quest.Visible then
            -- ไม่มี Quest → ไปรับ (SmartTP แบบ v3)
            _G.SmartTP(questInfo.position)
            questRemote:FireServer(questInfo.npcName)

        elseif questUI.Quest.Quest.Holder.Content.QuestInfo.QuestTitle.QuestTitle.Text ~= questInfo.questTitle then
            -- Quest ผิด → ยกเลิก
            abandonRemote:FireServer("repeatable")

        else
            -- Quest ถูกต้อง → ไปฟาร์ม
            local toolName = selectWeapon()
            local npcType = getNpcType(questInfo.npcName)
            if not npcType then continue end

            -- Equip ดาบก่อนเริ่มฟาร์ม
            equipToolByName(toolName, char)

            -- YPOS
            local YPOS = 9
            local firstMob = true

            -- วน loop ตีมอนต่อเนื่อง จนกว่าเควสจะเสร็จ/ตาย/เควสเปลี่ยน
            while _G.Config.AutoFarm do
                -- เช็คว่าเควสยังอยู่ไหม
                if char.Humanoid.Health <= 0 then break end
                if not questUI.Quest.Visible then break end
                if questUI.Quest.Quest.Holder.Content.QuestInfo.QuestTitle.QuestTitle.Text ~= questInfo.questTitle then break end

                local closest = findNPC(npcType)

                if not closest then
                    -- หามอนไม่เจอ → วาปไปตำแหน่ง quest ครั้งแรกเท่านั้น
                    if firstMob then
                        print("[FARM] NPC:", npcType, "| Weapon:", toolName)
                        tweenPos(CFrame.new(questInfo.position))
                        task.wait(3)
                    end
                    task.wait(1)
                    firstMob = false
                    continue
                end
                firstMob = false

                print("[FARM] Found:", closest.Name)

                -- Equip ดาบให้แน่ใจ
                equipToolByName(toolName, char)

                -- Selection box
                local box = Instance.new("SelectionBox")
                box.Adornee = closest
                box.Color3 = Color3.fromRGB(0, 255, 0)
                box.LineThickness = 0.08
                box.SurfaceTransparency = 0.6
                box.SurfaceColor3 = Color3.fromRGB(0, 255, 0)
                box.Parent = workspace

                -- Skill combo index (วนสกิล 1-4)
                local skillIndex = 1

                -- Combat loop: combo สกิล → ตีธรรมดา → สกิล → ตีธรรมดา
                repeat task.wait()

                    if not closest or not closest.Parent
                        or not closest:FindFirstChild("HumanoidRootPart")
                        or closest.Humanoid.Health <= 0 then
                        break
                    end

                    -- Equip weapon ทุกรอบ (ไม่ให้หลุดมือ)
                    equipToolByName(toolName, char)

                    -- BodyVelocity
                    BodyVelocity.Velocity = Vector3.zero
                    BodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                    BodyVelocity.Parent = char.HumanoidRootPart

                    -- Freeze NPC ถ้าเป็น owner
                    local success, owner = pcall(function()
                        return closest.HumanoidRootPart:GetNetworkOwner()
                    end)
                    if success and owner == player then
                        closest.HumanoidRootPart.CFrame = CFrame.new(closest.HumanoidRootPart.Position)
                        closest.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
                        closest.HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
                    end

                    -- tweenPos ชิดมอน
                    tweenPos(
                        CFrame.new(closest.HumanoidRootPart.Position + Vector3.new(0, YPOS, 0)) * CFrame.Angles(math.rad(-90), 0, 0),
                        function()
                            hitRemote:FireServer()
                        end
                    )

                    -- Haki + Observation Haki
                    pcall(function() RemoteEvents:WaitForChild("HakiRemote"):FireServer("Toggle") end)
                    pcall(function() RemoteEvents:WaitForChild("ObservationHakiRemote"):FireServer("Toggle") end)

                    -- Combo: สกิล 1 ตัว → ตีธรรมดา → วน
                    pcall(function()
                        RS:WaitForChild("AbilitySystem"):WaitForChild("Remotes"):WaitForChild("RequestAbility"):FireServer(skillIndex)
                    end)
                    hitRemote:FireServer() -- ตีธรรมดาหลังสกิล (combo)
                    
                    skillIndex = skillIndex + 1
                    if skillIndex > 4 then skillIndex = 1 end

                until char.Humanoid.Health <= 0 or not questUI.Quest.Visible or questUI.Quest.Quest.Holder.Content.QuestInfo.QuestTitle.QuestTitle.Text ~= questInfo.questTitle

                box:Destroy()

                -- Equip ดาบกลับหลังมอนตาย (ไม่ให้หลุดมือ)
                equipToolByName(toolName, char)
                print("[FARM] Killed:", closest.Name, "→ Finding next mob...")
                task.wait(0.3) -- รอสั้นมากแล้วหามอนตัวต่อไปเลย
            end

            print("[FARM] Exit Farm Loop")
        end
    end
end

-- ═══════════════════════════════════════════════════════════════
-- [12] MAIN CONTROLLER
-- ═══════════════════════════════════════════════════════════════
-- Equip default weapon at start
task.spawn(function()
    task.wait(3)
    pcall(function()
        local backpack = player:WaitForChild("Backpack", 10)
        if not backpack then return end
        local char = player.Character
        if not char then return end
        local tool = backpack:FindFirstChild("Combat")
        if tool then char:FindFirstChild("Humanoid"):EquipTool(tool) end
    end)
end)

-- Boss Key Auto Buy (Real-time Event Listener)
task.spawn(function()
    task.wait(15)
    
    if _G.Config.AutoBuyBossKey then
        setupBossKeyAutoListener()
    end
end)

-- System Loop: Level Check → Dark Blade → Haki → Farm (ทำงานต่อเนื่อง)
task.spawn(function()
    task.wait(10)

    while _G.Config.AutoFarm do
        local level = 0
        pcall(function() level = player.Data.Level.Value or 0 end)
        print("[SYSTEM] 🔍 Level check:", level)

        -- ===== PRIORITY -1: เช็คว่าครบเงื่อนไขสลับบัญชีหรือยัง (Level 11500 + Haki ทั้ง 2) =====
        if level >= 11500 then
            print("[SYSTEM] 🎯 Level >= 11500 → Checking account completion...")
            
            -- เช็คว่ามี Haki ทั้ง 2 แล้วหรือยัง
            local hasArmamentHaki = false
            local hasObservationHaki = false
            
            pcall(function()
                -- เช็ค Armament Haki
                local data = RemoteEvents:WaitForChild("HakiRemote"):FireServer("GetProgression")
                if data and data.Armament then
                    hasArmamentHaki = true
                end
                
                -- เช็ค Observation Haki
                hasObservationHaki = checkHasObservationHaki()
            end)
            
            if hasArmamentHaki and hasObservationHaki then
                print("[SYSTEM] ✅ Level 11500+ with both Haki types!")
                print("[SYSTEM] 🔄 Calling Horst_AccountChangeDone...")
                
                if _G.Horst_AccountChangeDone then
                    local ok, err = _G.Horst_AccountChangeDone()
                    if ok then
                        print("[SYSTEM] ✅ Account change done sent successfully!")
                        print("[SYSTEM] 🔄 Waiting for account switch...")
                        task.wait(999999) -- รอสลับบัญชี
                    else
                        print("[SYSTEM] ❌ Failed to send DONE:", err)
                    end
                else
                    print("[SYSTEM] ⚠️ _G.Horst_AccountChangeDone not found!")
                end
            else
                print(string.format("[SYSTEM] ⏳ Haki status: Armament=%s, Observation=%s", 
                    tostring(hasArmamentHaki), tostring(hasObservationHaki)))
            end
        end

        -- ===== Level < HakiMinLevel → ฟาร์มปกติ =====
        if level < _G.Config.HakiMinLevel then
            print("[SYSTEM] 📈 Level " .. level .. " - Normal Farm (Melee)")
            task.wait(60) -- เช็คใหม่ทุก 60 วิ
            continue
        end

        -- ===== PRIORITY 0: เช็ค Artifacts ที่ Level 4000 =====
        if level >= 4000 then
            print("[SYSTEM] 💎 Level >= 4000 → Checking Artifacts...")
            if not checkArtifactsUnlocked() then
                print("[SYSTEM] 🔓 Unlocking Artifacts...")
                local unlocked = unlockArtifacts()
                if unlocked then
                    print("[SYSTEM] ✅ Artifacts unlocked! Equipping...")
                    equipArtifacts()
                end
            else
                print("[SYSTEM] ✅ Artifacts already unlocked")
            end
        end

        -- ===== PRIORITY 0.5: เช็ค Observation Haki ที่ Level 6000 =====
        if level >= 6000 then
            print("[SYSTEM] 👁️ Level >= 6000 → Checking Observation Haki...")
            if not checkHasObservationHaki() then
                print("[SYSTEM] 🔓 Buying Observation Haki...")
                buyObservationHaki()
            else
                print("[SYSTEM] ✅ Observation Haki already owned")
            end
        end

        -- ===== PRIORITY 0.6: เช็ค Saber Boss Farm (อิสระจาก Ichigo) =====
        if _G.Config.FarmSaberBoss then
            -- เช็คว่ามี Boss Key อย่างน้อย 1 อันก่อน
            local bossKeyCount = checkBossKeyCount()
            if bossKeyCount >= 1 then
                print("[SYSTEM] 🎯 Starting Saber Boss farm...")
                farmSaberBoss()
                task.wait(5)
            else
                print("[SYSTEM] ⚠️ Not enough Boss Keys for Saber Boss (need 1)")
            end
        end

        -- ===== PRIORITY 0.7: เช็ค Ichigo Exchange =====
        if _G.Config.ExchangeIchigo and level >= _G.Config.IchigoMinLevel then
            print("[SYSTEM] ⚔️ Checking Ichigo Exchange...")
            if not checkDarkBlade("Ichigo") then
                local hasAll, missing = checkIchigoRequirements()
                
                if hasAll then
                    print("[SYSTEM] ✅ All Ichigo requirements met! Exchanging...")
                    exchangeIchigo()
                else
                    print("[SYSTEM] ❌ Missing Ichigo requirements:")
                    for _, item in pairs(missing) do
                        print("[SYSTEM]   - " .. item)
                    end
                end
            else
                print("[SYSTEM] ✅ Ichigo already owned")
            end
        end

        -- ===== PRIORITY 1: เช็ค Dark Blade ก่อนเสมอ =====
        print("[SYSTEM] 🗡️ Checking Dark Blade...")
        local hasBlade = findDarkBladeInHand() ~= nil
        if not hasBlade then
            hasBlade = equipDarkBladeFromInventory()
        end

        if hasBlade then
            print("[SYSTEM] ✅ Dark Blade found!")
            
            -- ถ้ามีดาบแล้ว + Level >= FruitMinLevel → เช็ค Fruit Farm
            if _G.Config.FruitFarm and level >= _G.Config.FruitMinLevel then
                print("[SYSTEM] 🍎 Level " .. level .. " >= " .. _G.Config.FruitMinLevel .. " → Checking Fruit Farm...")
                
                local hasFruit = checkHasFruit(_G.Config.TargetFruit)
                if hasFruit then
                    print("[SYSTEM] ✅ Already have " .. _G.Config.TargetFruit .. " → Fruit Farm Mode!")
                    isFruitFarming = true
                    equipFruit(_G.Config.TargetFruit)
                    
                    -- Teleport to fruit farm position
                    local island = _G.Config.FruitFarmIsland
                    local pos = _G.Config.FruitFarmPos
                    pcall(function() tpRemote:FireServer(island) end)
                    task.wait(3)
                    
                    local char = player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        for i = 1, 10 do
                            char.HumanoidRootPart.CFrame = pos
                            task.wait(0.1)
                        end
                    end
                    
                    task.spawn(fruitFarmLoop)
                    break
                else
                    print("[SYSTEM] ❌ No " .. _G.Config.TargetFruit .. " → Starting Fruit Farm process...")
                    oldPrint("[DEBUG] About to call startFruitFarm...")
                    local ok, err = pcall(startFruitFarm)
                    if ok then
                        oldPrint("[DEBUG] startFruitFarm completed OK")
                    else
                        oldPrint("[DEBUG] startFruitFarm ERROR:", tostring(err))
                    end
                    break
                end
            else
                -- มีดาบแล้ว แต่ยังไม่ถึง FruitMinLevel → ฟาร์มปกติ
                print("[SYSTEM] ✅ Dark Blade found! Normal Farm...")
                break
            end
        end

        -- STEP 2: ไม่มีดาบ → เช็ค Haki
        print("[SYSTEM] ❌ No Dark Blade | Checking Haki...")
        local hasHaki = checkHakiStatus()

        if hasHaki then
            -- STEP 3: มี Haki แต่ไม่มีดาบ → ซื้อดาบ
            print("[SYSTEM] ✅ Has Haki but no Dark Blade → Buying...")
            if _G.Config.BuyDarkBlade then
                pcall(buyDarkBlade)
            end
            print("[SYSTEM] 🗡️ Dark Blade process done! Normal Farm...")
            break
        end

        -- STEP 4: ไม่มีทั้ง Haki + ดาบ → ทำ Haki Quest
        if _G.Config.HakiQuest and not isHakiQuestActive then
            print("[SYSTEM] 🔥 No Haki + No Dark Blade → Starting Haki Quest...")
            isHakiQuestActive = true
            pcall(startHakiQuest)
            -- หลัง Haki Quest เสร็จ (ซื้อดาบใน farmThiefForHaki แล้ว)
            isHakiQuestActive = false
            print("[SYSTEM] ✅ Haki Quest done! Normal Farm...")
            break
        end

        task.wait(60) -- เช็คใหม่ทุก 60 วิ
    end
end)

-- Normal Farm
task.spawn(function()
    task.wait(15)
    pcall(farmLoop)
end)

-- ═══════════════════════════════════════════════════════════════
-- [13] EVENT HANDLERS
-- ═══════════════════════════════════════════════════════════════
player.OnTeleport:Connect(function(state)
    if state == Enum.TeleportState.Failed then
        task.wait(1.5)
        pcall(rejoin)
    end
end)

Players.PlayerRemoving:Connect(function()
    pcall(function()
        game:HttpGet("https://node-api--0890939481gg.replit.app/leave")
    end)
end)

-- ═══════════════════════════════════════════════════════════════
-- [14] HEARTBEAT PHYSICS LOCK (แบบ v3 เป๊ะ)
-- ═══════════════════════════════════════════════════════════════
task.spawn(function()
    RunService.Heartbeat:Connect(function()
        if player.Character then
            -- ล็อคแค่ velocity (ไม่ล็อค Anchored/PlatformStand) เพื่อให้รับ/ทำดาเมจได้
            for _, v in pairs(player.Character:GetChildren()) do
                if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                    v.CanCollide = false
                    v.AssemblyLinearVelocity = Vector3.zero
                    v.AssemblyAngularVelocity = Vector3.zero
                end
            end
        end
    end)
end)