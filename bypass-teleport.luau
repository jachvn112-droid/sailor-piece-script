--[[
    ╔══════════════════════════════════════════════╗
    ║     SAILOR PIECE - TELEPORT BYPASS v3        ║
    ║   Chạy script này TRƯỚC khi chạy autofarm   ║
    ╚══════════════════════════════════════════════╝
    
    Bypass gồm:
    1) Hook __namecall: chặn mọi remote anti-teleport
    2) Hook getgc: vô hiệu hóa hàm anti-cheat trong memory
    3) Noclip: xuyên tường khi farm
    4) Anti-void: không rơi xuống void
    5) Anti-idle: không bị kick AFK
    6) Fake velocity: giả lập di chuyển tự nhiên
    7) Hook position replication
    8) ★ BYPASS RENDER DISTANCE: Force load NPCs ở mọi khoảng cách
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
warn("  [BYPASS] Sailor Piece Teleport Bypass v3")
warn("═══════════════════════════════════════")

-- ════════════════════════════════════
-- 1. HOOK __NAMECALL: Chặn kick + anti-teleport remotes
-- ════════════════════════════════════
local BLOCKED_NAMES = {
    -- Anti-teleport / position check
    "sanity", "checksanity", "positioncheck", "antiteleport",
    "validateposition", "checkpos", "anticheat", "positionvalidate",
    "sanitycheck", "movementcheck", "speedcheck", "teleportback",
    "checkposition", "poscheck", "verifyposition", "servercheck",
    "validate", "verification", "exploit",
}

-- Tạo lookup table nhanh
local blockedLookup = {}
for _, name in ipairs(BLOCKED_NAMES) do
    blockedLookup[name] = true
end

local OldNamecall
OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args   = {...}

    -- Block kick
    if (method == "Kick" or method == "kick") then
        if self == player or self == Players then
            warn("[BYPASS] Chặn kick:", tostring(args[1]))
            return nil
        end
    end

    -- Block anti-teleport remotes
    if method == "FireServer" or method == "InvokeServer" then
        local ok, isRemote = pcall(function()
            return self:IsA("RemoteEvent") or self:IsA("RemoteFunction")
        end)
        if ok and isRemote then
            local remoteName = self.Name:lower():gsub("[_%-%s]", "")
            if blockedLookup[remoteName] then
                warn("[BYPASS] Chặn remote:", self.Name)
                return nil
            end
            -- Chặn thêm nếu tên chứa keyword
            for _, kw in ipairs({"sanity", "position", "speed", "teleport", "cheat", "exploit", "check"}) do
                if remoteName:find(kw) then
                    warn("[BYPASS] Chặn remote (keyword):", self.Name)
                    return nil
                end
            end
        end
    end

    return OldNamecall(self, ...)
end))
warn("[BYPASS] ✅ Hooked __namecall (anti-kick + anti-teleport)")

-- ════════════════════════════════════
-- 2. HOOK __INDEX / __NEWINDEX: Chặn đọc/ghi position check
-- ════════════════════════════════════
-- Hook để chặn game đọc WalkSpeed bất thường
local OldIndex
OldIndex = hookmetamethod(game, "__index", newcclosure(function(self, key)
    -- Nếu game check WalkSpeed, trả về giá trị mặc định
    if checkcaller() == false then
        if typeof(self) == "Instance" and self:IsA("Humanoid") then
            if key == "WalkSpeed" then
                return 16 -- Giá trị mặc định
            elseif key == "JumpPower" or key == "JumpHeight" then
                return 50
            end
        end
    end
    return OldIndex(self, key)
end))
warn("[BYPASS] ✅ Hooked __index (spoof WalkSpeed/JumpPower)")

-- ════════════════════════════════════
-- 3. GC HOOK: Vô hiệu hóa anti-cheat functions trong memory
-- ════════════════════════════════════
if getgc and hookfunction then
    local hookedCount = 0
    local getinfo = debug.getinfo or getinfo
    local getupvalues = debug.getupvalues or getupvalues
    local setupvalue  = debug.setupvalue or setupvalue

    for _, v in pairs(getgc(true)) do
        if type(v) == "function" then
            -- Hook anti-cheat functions
            local ok, info = pcall(getinfo, v)
            if ok and info and info.source then
                local src = info.source:lower()
                local name = info.name and info.name:lower() or ""

                -- Tìm source anti-cheat
                local isACSource = src:find("anticheat") or src:find("controlclient") 
                    or src:find("idle") or src:find("sanity") or src:find("movement")
                    or src:find("exploit") or src:find("detection") or src:find("validate")
                    or src:find("security") or src:find("guard")

                if isACSource then
                    -- Tìm function anti-cheat
                    local isACFunc = name:find("kick") or name:find("ban") or name:find("teleport")
                        or name:find("position") or name:find("sanity") or name:find("speed")
                        or name:find("check") or name:find("detect") or name:find("validate")
                        or name:find("reset") or name:find("flag")

                    if isACFunc then
                        pcall(hookfunction, v, function(...) return nil end)
                        hookedCount = hookedCount + 1
                    end
                end
            end

            -- Sửa upvalues liên quan
            pcall(function()
                local upvalues = getupvalues(v)
                for key, val in pairs(upvalues) do
                    if type(key) == "string" then
                        local k = key:lower()
                        if k == "isteleporting" or k == "teleporting" then
                            setupvalue(v, key, false)
                        elseif k == "maxspeed" or k == "speedlimit" or k == "maxvelocity" then
                            setupvalue(v, key, 99999)
                        elseif k == "maxdistance" or k == "distancelimit" or k == "maxdist" then
                            setupvalue(v, key, 99999)
                        elseif k == "anticheat" or k == "acenabled" or k == "checksenabled" then
                            if type(val) == "boolean" then
                                setupvalue(v, key, false)
                            end
                        end
                    end
                end
            end)
        end
    end
    warn("[BYPASS] ✅ Hooked " .. tostring(hookedCount) .. " anti-cheat functions từ GC")
end

-- ════════════════════════════════════
-- 4. NOCLIP: Xuyên tường khi đang farm
-- ════════════════════════════════════
task.spawn(function()
    local stepped = RunService.Stepped
    stepped:Connect(function()
        if not getgenv().NoclipEnabled then return end
        local char = player.Character
        if not char then return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)
    warn("[BYPASS] ✅ Noclip enabled")
end)

-- ════════════════════════════════════
-- 5. ANTI-VOID: Không rơi xuống void
-- ════════════════════════════════════
task.spawn(function()
    while task.wait(0.5) do
        if not getgenv().AntiVoid then continue end
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root and root.Position.Y < -50 then
            root.CFrame = CFrame.new(root.Position.X, 100, root.Position.Z)
            root.Velocity = Vector3.new(0, 0, 0)
            warn("[BYPASS] Anti-void: cứu nhân vật khỏi void")
        end
    end
end)

-- ════════════════════════════════════
-- 6. ANTI-IDLE: Chống bị kick AFK
-- ════════════════════════════════════
task.spawn(function()
    local vu = game:GetService("VirtualUser")
    while task.wait(60) do
        if not getgenv().AntiIdle then continue end
        pcall(function()
            vu:CaptureController()
            vu:ClickButton2(Vector2.new())
        end)
    end
    warn("[BYPASS] ✅ Anti-idle running")
end)

-- ════════════════════════════════════
-- 7. BLOCK CHARACTER ADDED RESET
-- ════════════════════════════════════
-- Khi respawn, re-apply bypass
player.CharacterAdded:Connect(function(char)
    task.wait(1)
    -- Re-apply noclip
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end)

-- ════════════════════════════════════
-- 8. HOOK REMOTES FOLDER - Tìm và chặn mọi remote nghi ngờ
-- ════════════════════════════════════
task.spawn(function()
    task.wait(2) -- đợi game load
    
    -- Quét tất cả remote trong ReplicatedStorage
    local function scanRemotes(folder, depth)
        depth = depth or 0
        if depth > 5 then return end
        
        for _, child in ipairs(folder:GetChildren()) do
            if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
                local n = child.Name:lower()
                for _, kw in ipairs({"sanity", "position", "speed", "cheat", "exploit", "check", "validate", "detect"}) do
                    if n:find(kw) then
                        warn("[BYPASS] Tìm thấy remote nghi ngờ:", child:GetFullName())
                        -- Log nhưng không xóa, vì __namecall hook đã chặn rồi
                    end
                end
            elseif child:IsA("Folder") then
                scanRemotes(child, depth + 1)
            end
        end
    end
    
    scanRemotes(RepStorage)
    
    -- Scan workspace
    local acFolder = workspace:FindFirstChild("AntiCheat") or workspace:FindFirstChild("Security")
    if acFolder then
        warn("[BYPASS] Tìm thấy folder anti-cheat:", acFolder:GetFullName())
        pcall(function()
            acFolder:Destroy()
        end)
        warn("[BYPASS] ✅ Đã xóa folder anti-cheat")
    end
end)

-- ════════════════════════════════════
-- 9. POSITION SPOOF LOOP - Giả lập di chuyển tự nhiên
-- ════════════════════════════════════
-- Lưu vị trí cuối để server thấy di chuyển smooth
getgenv()._LastSpoofPos = nil

task.spawn(function()
    while task.wait(0.1) do
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            local currentPos = root.Position
            if getgenv()._LastSpoofPos then
                local delta = (currentPos - getgenv()._LastSpoofPos).Magnitude
                -- Nếu di chuyển quá 200 studs trong 0.1s, giả lập velocity
                if delta > 200 then
                    root.Velocity = (currentPos - getgenv()._LastSpoofPos).Unit * 80
                end
            end
            getgenv()._LastSpoofPos = currentPos
        end
    end
end)

-- ════════════════════════════════════
-- 10. HEARTBEAT HOOK - Chặn server rejecting position
-- ════════════════════════════════════
task.spawn(function()
    -- Tìm và disable physics replication check
    pcall(function()
        local physicsService = game:GetService("PhysicsService")
        -- Không có API trực tiếp, nhưng ta đã hook đủ
    end)
    
    -- Hook bất kỳ connection nào liên quan tới position reset
    RunService.Heartbeat:Connect(function()
        local char = player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum and getgenv().IsTeleporting then
            hum.PlatformStand = true
            hum:ChangeState(Enum.HumanoidStateType.Physics)
        end
    end)
end)

-- ════════════════════════════════════
-- 11. ★ BYPASS RENDER DISTANCE / STREAMING
-- ════════════════════════════════════
-- ĐÂY LÀ LÝ DO CHÍNH: Game dùng StreamingEnabled nên
-- NPCs ở xa không được load về client → findMob() trả về nil
-- Fix: dùng ReplicationFocus + sethiddenproperty để force load

local _focusPart = nil

local function setupRenderBypass()
    -- 1) Thử tắt StreamingEnabled (thường bị server-lock nhưng đáng thử)
    pcall(function()
        workspace.StreamingEnabled = false
    end)
    
    -- 2) sethiddenproperty: Tăng bán kính streaming lên tối đa
    if sethiddenproperty then
        pcall(function()
            sethiddenproperty(workspace, "StreamingMinRadius", 10000)
        end)
        pcall(function()
            sethiddenproperty(workspace, "StreamingTargetRadius", 10000)
        end)
        pcall(function()
            sethiddenproperty(workspace, "StreamingPauseMode", 0) -- Disabled
        end)
        warn("[BYPASS] ✅ Set StreamingMinRadius/TargetRadius = 10000")
    else
        warn("[BYPASS] ⚠️ sethiddenproperty không có, thử cách khác...")
    end
    
    -- 3) MaximumSimulationRadius = tối đa
    pcall(function()
        player.MaximumSimulationRadius = math.huge
    end)
    pcall(function()
        player.SimulationRadius = math.huge
    end)
    warn("[BYPASS] ✅ SimulationRadius = math.huge")
    
    -- 4) Tạo focus part cho ReplicationFocus
    _focusPart = Instance.new("Part")
    _focusPart.Name = "__BypassFocus"
    _focusPart.Anchored = true
    _focusPart.CanCollide = false
    _focusPart.Transparency = 1
    _focusPart.Size = Vector3.new(1, 1, 1)
    _focusPart.Parent = workspace
end

-- Hàm set focus tới 1 vị trí bất kỳ để server stream data ở đó
-- Autofarm gọi hàm này trước khi tìm mob
getgenv().SetRenderFocus = function(position)
    if not _focusPart then return end
    
    if typeof(position) == "CFrame" then
        _focusPart.CFrame = position
    elseif typeof(position) == "Vector3" then
        _focusPart.CFrame = CFrame.new(position)
    end
    
    pcall(function()
        player.ReplicationFocus = _focusPart
    end)
end

-- Hàm reset focus về nhân vật (khi đã tìm thấy mob)
getgenv().ResetRenderFocus = function()
    pcall(function()
        player.ReplicationFocus = nil
    end)
end

-- Auto-setup render bypass
setupRenderBypass()

-- Loop liên tục giữ SimulationRadius + cập nhật focus
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            player.MaximumSimulationRadius = math.huge
            player.SimulationRadius = math.huge
        end)
        
        -- Nếu chưa ai set focus, focus vào vị trí nhân vật
        if _focusPart and not player.ReplicationFocus then
            local char = player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                _focusPart.CFrame = root.CFrame
            end
        end
        
        -- Thử set lại streaming radius mỗi giây (đề phòng game reset)
        if sethiddenproperty then
            pcall(function()
                sethiddenproperty(workspace, "StreamingMinRadius", 10000)
                sethiddenproperty(workspace, "StreamingTargetRadius", 10000)
            end)
        end
    end
end)

-- Pre-load NPCs folder bằng cách request streaming
task.spawn(function()
    task.wait(3)
    -- Quét tất cả các đảo trong workspace để force stream
    for _, child in ipairs(workspace:GetChildren()) do
        if child:IsA("Model") or child:IsA("Folder") then
            local n = child.Name:lower()
            if n:find("island") or n:find("spawn") or n:find("map") or n:find("npc") then
                pcall(function()
                    -- Touch từng child để force replication
                    for _, sub in ipairs(child:GetDescendants()) do
                        if sub:IsA("BasePart") then
                            local _ = sub.Position
                        end
                    end
                end)
            end
        end
    end
    
    -- Focus tới NPCs folder nếu có
    local npcsFolder = workspace:FindFirstChild("NPCs") or workspace:FindFirstChild("Npcs")
    if npcsFolder then
        warn("[BYPASS] ✅ NPCs folder tìm thấy: " .. tostring(#npcsFolder:GetChildren()) .. " mobs")
        for _, npc in ipairs(npcsFolder:GetChildren()) do
            -- Force stream mỗi NPC
            pcall(function()
                local root = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChild("Head")
                if root and _focusPart then
                    _focusPart.CFrame = root.CFrame
                    player.ReplicationFocus = _focusPart
                    task.wait(0.05)
                end
            end)
        end
        -- Reset focus
        pcall(function()
            player.ReplicationFocus = nil
        end)
        warn("[BYPASS] ✅ Đã force-stream " .. tostring(#npcsFolder:GetChildren()) .. " NPCs")
    else
        warn("[BYPASS] ⚠️ Không tìm thấy NPCs folder - sẽ thử lại khi autofarm chạy")
    end
end)

warn("[BYPASS] ✅ Render distance bypass LOADED")

-- Re-apply render bypass khi respawn
player.CharacterAdded:Connect(function()
    task.wait(2)
    setupRenderBypass()
end)

-- ════════════════════════════════════
-- SUMMARY
-- ════════════════════════════════════
warn("═══════════════════════════════════════")
warn("  [BYPASS] ✅ TẤT CẢ BYPASS ĐÃ LOADED! (v3)")
warn("  • Anti-kick: ON")
warn("  • Anti-teleport-back: ON") 
warn("  • Anti-cheat GC hook: ON")
warn("  • WalkSpeed spoof: ON")
warn("  • Noclip: ON")
warn("  • Anti-void: ON")
warn("  • Anti-idle: ON")
warn("  • Remote scanner: ON")
warn("  • Position spoof: ON")
warn("  • ★ Render Distance Bypass: ON")
warn("  • ★ ReplicationFocus: ON")
warn("  • ★ StreamingRadius: 10000")
warn("═══════════════════════════════════════")
warn("  → Bây giờ hãy chạy autofarm script!")
warn("═══════════════════════════════════════")
