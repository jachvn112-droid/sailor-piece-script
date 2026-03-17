--[[
    ╔══════════════════════════════════════════════╗
    ║     SAILOR PIECE - TELEPORT BYPASS v4        ║
    ║   Chạy script này TRƯỚC khi chạy autofarm   ║
    ╚══════════════════════════════════════════════╝
    
    v4: Dùng TeleportToPortal của game để scan tất cả đảo
    Thay vì bypass render distance, ta teleport qua từng đảo
    → game tự load NPCs → scan + cache mob/level/island
    → autofarm dùng data này để biết mob ở đâu
    
    Bypass gồm:
    1) Hook __namecall: chặn mọi remote anti-teleport
    2) Hook getgc: vô hiệu hóa hàm anti-cheat trong memory
    3) Noclip: xuyên tường khi farm
    4) Anti-void: không rơi xuống void
    5) Anti-idle: không bị kick AFK
    6) Fake velocity: giả lập di chuyển tự nhiên
    7) ★ ISLAND SCANNER: Teleport all islands → cache NPCs + mob data
]]

-- ═══════════════ SERVICES ═══════════════
local Players        = game:GetService("Players")
local RunService     = game:GetService("RunService")
local RepStorage     = game:GetService("ReplicatedStorage")
local player         = Players.LocalPlayer

-- ═══════════════ FLAGS ═══════════════
getgenv().BypassLoaded  = true
getgenv().NoclipEnabled = true
getgenv().AntiVoid      = true
getgenv().AntiIdle      = true

warn("═══════════════════════════════════════")
warn("  [BYPASS] Sailor Piece Teleport Bypass v4")
warn("  ★ Island Scanner Mode")
warn("═══════════════════════════════════════")

-- ════════════════════════════════════
-- 1. HOOK __NAMECALL: Chặn kick + anti-teleport remotes
-- ════════════════════════════════════
local BLOCKED_NAMES = {
    "sanity", "checksanity", "positioncheck", "antiteleport",
    "validateposition", "checkpos", "anticheat", "positionvalidate",
    "sanitycheck", "movementcheck", "speedcheck", "teleportback",
    "checkposition", "poscheck", "verifyposition", "servercheck",
    "validate", "verification", "exploit",
}

local blockedLookup = {}
for _, name in ipairs(BLOCKED_NAMES) do
    blockedLookup[name] = true
end

local OldNamecall
OldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args   = {...}

    -- Block kick
    if (method == "Kick" or method == "kick") then
        if self == player or self == Players then
            warn("[AntiKick] Blocked kick:", args[1])
            return nil
        end
    end

    -- Block anti-TP remotes
    if method == "FireServer" or method == "InvokeServer" then
        local ok, isRemote = pcall(function()
            return self:IsA("RemoteEvent") or self:IsA("RemoteFunction")
        end)
        if ok and isRemote then
            local remoteName = self.Name:lower():gsub("_", ""):gsub("-", "")
            if blockedLookup[remoteName] then
                warn("[AntiTP] Blocked remote:", self.Name)
                return nil
            end
        end
    end

    return OldNamecall(self, ...)
end)
warn("[BYPASS] ✅ Hook __namecall active")

-- ════════════════════════════════════
-- 2. HOOK GETGC: Vô hiệu hóa anti-cheat functions
-- ════════════════════════════════════
if getgc and hookfunction then
    local hookedCount = 0
    for _, v in pairs(getgc(true)) do
        if type(v) == "function" then
            local ok, info = pcall(getinfo, v)
            if ok and info and info.source then
                local src = info.source:lower()
                if src:find("anticheat") or src:find("controlclient") or src:find("sanity")
                    or src:find("idle") or src:find("movement") or src:find("speed") then
                    local fname = info.name and info.name:lower() or ""
                    if fname:find("kick") or fname:find("ban") or fname:find("teleport")
                        or fname:find("position") or fname:find("sanity") or fname:find("speed")
                        or fname:find("check") then
                        pcall(function()
                            hookfunction(v, function(...) return nil end)
                            hookedCount = hookedCount + 1
                        end)
                    end
                end
            end
            -- Patch upvalues
            pcall(function()
                local upvals = getupvalues(v)
                for key, val in pairs(upvals) do
                    if type(key) == "string" then
                        local k = key:lower()
                        if k == "isteleporting" then
                            setupvalue(v, key, false)
                        elseif k == "maxspeed" or k == "speedlimit" then
                            setupvalue(v, key, 99999)
                        end
                    end
                end
            end)
        end
    end
    warn("[BYPASS] ✅ Hooked " .. tostring(hookedCount) .. " AC functions")
end

-- ════════════════════════════════════
-- 3. NOCLIP (xuyên tường khi farm)
-- ════════════════════════════════════
task.spawn(function()
    RunService.Stepped:Connect(function()
        if not getgenv().NoclipEnabled then return end
        local char = player.Character
        if not char then return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)
end)
warn("[BYPASS] ✅ Noclip active")

-- ════════════════════════════════════
-- 4. ANTI-VOID
-- ════════════════════════════════════
task.spawn(function()
    local lastSafe = CFrame.new(0, 100, 0)
    while task.wait(0.5) do
        if not getgenv().AntiVoid then continue end
        local char = player.Character
        if not char then continue end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end
        
        if hrp.Position.Y > -50 then
            lastSafe = hrp.CFrame
        else
            hrp.CFrame = lastSafe
            warn("[AntiVoid] Rescued from void")
        end
    end
end)
warn("[BYPASS] ✅ Anti-void active")

-- ════════════════════════════════════
-- 5. ANTI-IDLE
-- ════════════════════════════════════
task.spawn(function()
    while task.wait(120) do
        if not getgenv().AntiIdle then continue end
        pcall(function()
            local vu = game:GetService("VirtualUser")
            vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            task.wait(0.5)
            vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
    end
end)
warn("[BYPASS] ✅ Anti-idle active")

-- ════════════════════════════════════
-- 6. FAKE VELOCITY (giả lập di chuyển tự nhiên)
-- ════════════════════════════════════
task.spawn(function()
    while task.wait(0.3) do
        local char = player.Character
        if not char then continue end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end
        
        if hrp.Velocity.Magnitude > 200 then
            hrp.Velocity = hrp.Velocity.Unit * 50
        end
    end
end)
warn("[BYPASS] ✅ Fake velocity active")

-- ════════════════════════════════════
-- 7. ★ ISLAND SCANNER — Cốt lõi v4
-- ════════════════════════════════════
-- Dùng TeleportToPortal của game để teleport tới từng đảo
-- Game tự load NPCs khi ta ở đảo đó (streaming enabled)
-- Ta scan workspace.NPCs → cache tất cả mob + island

-- Global cache: autofarm sẽ đọc từ đây
getgenv().IslandMobCache = getgenv().IslandMobCache or {}
-- Format: IslandMobCache[mobName] = { island = "portalArg", position = Vector3 }

getgenv().IslandScanDone = false

-- Danh sách đảo (lấy từ workspace hoặc hardcode)
local function getAllIslands()
    local islands = {}
    
    -- Cách 1: Đọc từ TravelConfig
    local ok, travelConfig = pcall(function()
        return require(RepStorage:WaitForChild("TravelConfig", 5))
    end)
    
    if ok and travelConfig then
        -- Thử đọc .Islands hoặc .Zones
        local data = travelConfig.Islands or travelConfig.Zones
        if data then
            for name, _ in pairs(data) do
                -- Chuyển tên đảo thành portal arg (bỏ "Island", bỏ space)
                local portalArg = name:gsub("Island", ""):gsub(" ", "")
                table.insert(islands, { name = name, portal = portalArg })
            end
        end
    end
    
    -- Cách 2: Scan workspace tìm folder đảo
    if #islands == 0 then
        for _, child in ipairs(workspace:GetChildren()) do
            if child:IsA("Folder") or child:IsA("Model") then
                if child.Name:find("Island") or child.Name:find("island") then
                    local portalArg = child.Name:gsub("Island", ""):gsub(" ", "")
                    table.insert(islands, { name = child.Name, portal = portalArg })
                end
            end
        end
    end
    
    -- Cách 3: Fallback hardcode (từ teleportisland.lua)
    if #islands == 0 then
        local hardcoded = {
            "Starter", "Jungle", "Desert", "Snow", "Boss",
            "ShibuyaStation", "Sailor", "HuecoMundo", "Dungeon",
            "Shinjuku", "Slime", "Academy", "SoulSociety", "Judgement"
        }
        for _, name in ipairs(hardcoded) do
            table.insert(islands, { name = name .. "Island", portal = name })
        end
    end
    
    return islands
end

-- Scan NPCs tại đảo hiện tại
local function scanCurrentIslandNPCs(islandName)
    local npcFolder = workspace:FindFirstChild("NPCs")
    if not npcFolder then return 0 end
    
    local found = 0
    for _, npc in ipairs(npcFolder:GetChildren()) do
        if npc:IsA("Model") then
            local hrp = npc:FindFirstChild("HumanoidRootPart")
            local hum = npc:FindFirstChildOfClass("Humanoid")
            if hrp and hum then
                -- Cache mob info
                if not getgenv().IslandMobCache[npc.Name] then
                    getgenv().IslandMobCache[npc.Name] = {
                        island = islandName,
                        position = hrp.Position,
                        maxHealth = hum.MaxHealth,
                    }
                    found = found + 1
                end
            end
        end
    end
    
    -- Cũng scan các folder khác nếu có
    local extraFolders = {"ServiceNPCs", "StorageNPC", "Mobs", "Enemies"}
    for _, folderName in ipairs(extraFolders) do
        local folder = workspace:FindFirstChild(folderName)
        if folder then
            for _, npc in ipairs(folder:GetChildren()) do
                if npc:IsA("Model") then
                    local hrp = npc:FindFirstChild("HumanoidRootPart")
                    local hum = npc:FindFirstChildOfClass("Humanoid")
                    if hrp and hum and not getgenv().IslandMobCache[npc.Name] then
                        getgenv().IslandMobCache[npc.Name] = {
                            island = islandName,
                            position = hrp.Position,
                            maxHealth = hum.MaxHealth,
                        }
                        found = found + 1
                    end
                end
            end
        end
    end
    
    return found
end

-- API cho autofarm: teleport tới đảo có mob cần tìm
getgenv().TeleportToMobIsland = function(mobName)
    local cached = getgenv().IslandMobCache[mobName]
    if not cached then
        warn("[Scanner] Mob '" .. mobName .. "' chưa được cache. Đang scan lại...")
        -- Scan lại tất cả đảo
        getgenv().ScanAllIslands()
        cached = getgenv().IslandMobCache[mobName]
    end
    
    if cached then
        local portalArg = cached.island:gsub("Island", ""):gsub(" ", "")
        pcall(function()
            RepStorage:WaitForChild("Remotes"):WaitForChild("TeleportToPortal"):FireServer(portalArg)
        end)
        warn("[Scanner] Teleported to " .. cached.island .. " for mob: " .. mobName)
        task.wait(3) -- Đợi load map
        return true
    else
        warn("[Scanner] ❌ Không tìm thấy đảo cho mob: " .. mobName)
        return false
    end
end

-- API: Lấy portal arg cho mob (autofarm dùng trong teleportToIsland)
getgenv().GetIslandForMob = function(mobName)
    local cached = getgenv().IslandMobCache[mobName]
    if cached then
        return cached.island
    end
    return nil
end

-- Scan toàn bộ đảo
getgenv().ScanAllIslands = function()
    local islands = getAllIslands()
    local totalMobs = 0
    
    -- Ghi nhớ vị trí ban đầu
    local startIsland = nil
    pcall(function()
        local checkmap = require(RepStorage.TravelConfig)
        local currentZone = checkmap.GetZoneAt(player.Character.HumanoidRootPart.Position)
        startIsland = currentZone
    end)
    
    warn("[Scanner] ═══ BẮT ĐẦU SCAN " .. #islands .. " ĐẢO ═══")
    
    for i, island in ipairs(islands) do
        warn(string.format("[Scanner] [%d/%d] Đang scan: %s (portal: %s)", 
            i, #islands, island.name, island.portal))
        
        -- Teleport tới đảo
        local ok = pcall(function()
            RepStorage:WaitForChild("Remotes"):WaitForChild("TeleportToPortal"):FireServer(island.portal)
        end)
        
        if ok then
            -- Đợi game load NPCs (streaming cần thời gian)
            task.wait(4)
            
            -- Đợi thêm nếu NPCs folder chưa có
            local waitCount = 0
            while not workspace:FindFirstChild("NPCs") and waitCount < 5 do
                task.wait(1)
                waitCount = waitCount + 1
            end
            
            -- Scan NPCs
            local found = scanCurrentIslandNPCs(island.name)
            totalMobs = totalMobs + found
            warn(string.format("[Scanner]   → Tìm thấy %d mob mới tại %s", found, island.name))
        else
            warn("[Scanner]   ⚠️ Teleport thất bại: " .. island.name)
        end
        
        -- Nghỉ giữa các đảo để tránh spam
        task.wait(1)
    end
    
    -- Quay về đảo ban đầu
    if startIsland then
        local portalBack = startIsland:gsub("Island", ""):gsub(" ", "")
        pcall(function()
            RepStorage:WaitForChild("Remotes"):WaitForChild("TeleportToPortal"):FireServer(portalBack)
        end)
        task.wait(3)
    end
    
    getgenv().IslandScanDone = true
    
    -- Print kết quả
    warn("[Scanner] ═══ SCAN HOÀN TẤT ═══")
    warn(string.format("[Scanner] Tổng: %d loại mob trên %d đảo", totalMobs, #islands))
    warn("[Scanner] ─── Chi tiết cache: ───")
    for mobName, data in pairs(getgenv().IslandMobCache) do
        warn(string.format("  %s → %s (HP: %d)", mobName, data.island, data.maxHealth or 0))
    end
    warn("[Scanner] ════════════════════════")
end

-- ════════════════════════════════════
-- 8. AUTO START SCAN
-- ════════════════════════════════════
task.spawn(function()
    -- Đợi player load xong
    if not player.Character then
        player.CharacterAdded:Wait()
    end
    task.wait(3) -- Đợi game load ổn định
    
    -- Scan đảo hiện tại trước (nhanh)
    local charPos = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if charPos then
        local currentIsland = "Unknown"
        pcall(function()
            local checkmap = require(RepStorage.TravelConfig)
            currentIsland = checkmap.GetZoneAt(charPos.Position) or "Unknown"
        end)
        local quickFound = scanCurrentIslandNPCs(currentIsland)
        warn("[Scanner] Quick scan tại " .. currentIsland .. ": " .. quickFound .. " mobs")
    end
    
    -- Full scan tất cả đảo
    warn("[Scanner] Bắt đầu full scan tất cả đảo trong 5 giây...")
    task.wait(5)
    getgenv().ScanAllIslands()
end)

-- ════════════════════════════════════
-- 9. RE-SCAN ON RESPAWN
-- ════════════════════════════════════
player.CharacterAdded:Connect(function(char)
    task.wait(3)
    local currentIsland = "Unknown"
    pcall(function()
        local checkmap = require(RepStorage.TravelConfig)
        local hrp = char:WaitForChild("HumanoidRootPart", 5)
        if hrp then
            currentIsland = checkmap.GetZoneAt(hrp.Position) or "Unknown"
        end
    end)
    scanCurrentIslandNPCs(currentIsland)
    warn("[Scanner] Re-scanned after respawn at " .. currentIsland)
end)

warn("[BYPASS] ═══════════════════════════════════")
warn("[BYPASS] ✅ Sailor Piece Bypass v4 LOADED!")
warn("[BYPASS] API cho autofarm:")
warn("[BYPASS]   getgenv().TeleportToMobIsland(mobName)")
warn("[BYPASS]   getgenv().GetIslandForMob(mobName)")
warn("[BYPASS]   getgenv().IslandMobCache")
warn("[BYPASS]   getgenv().ScanAllIslands()")
warn("[BYPASS] ═══════════════════════════════════")
