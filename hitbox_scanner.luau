-- ═══════════════════════════════════════════════════
-- HITBOX SCANNER - Tìm mọi thứ liên quan đến hitbox
-- Chạy trong game, check output (F9) để xem kết quả
-- ═══════════════════════════════════════════════════

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer

print("\n══════════════════════════════════════")
print("🔍 HITBOX SCANNER - Sailor Piece")
print("══════════════════════════════════════\n")

-- 1. Scan CombatSystem trong ReplicatedStorage
print("━━━ [1] ReplicatedStorage.CombatSystem ━━━")
local function scanDeep(obj, indent)
    indent = indent or ""
    for _, child in pairs(obj:GetChildren()) do
        local info = indent .. child.ClassName .. " → " .. child:GetFullName()
        if child:IsA("ModuleScript") then
            print("📦 " .. info)
        elseif child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
            print("🔴 " .. info)
        elseif child:IsA("ValueBase") then
            print("📊 " .. info .. " = " .. tostring(child.Value))
        else
            print("   " .. info)
        end
        scanDeep(child, indent .. "  ")
    end
end

local cs = RS:FindFirstChild("CombatSystem")
if cs then
    scanDeep(cs)
else
    print("❌ Không tìm thấy CombatSystem")
end

-- 2. Scan character parts (tìm hitbox part)
print("\n━━━ [2] Character Parts ━━━")
local char = Player.Character
if char then
    for _, part in pairs(char:GetDescendants()) do
        local tag = ""
        if part:IsA("BasePart") then
            tag = string.format(
                "Part: %s | Size: %s | CanCollide: %s | Transparency: %s",
                part.Name,
                tostring(part.Size),
                tostring(part.CanCollide),
                tostring(part.Transparency)
            )
            -- Highlight các part lớn hoặc tên giống hitbox
            local nameLower = string.lower(part.Name)
            if nameLower:find("hit") or nameLower:find("box") or nameLower:find("attack") or nameLower:find("range") or nameLower:find("damage") then
                print("🎯 HITBOX? → " .. tag)
            else
                print("   " .. tag)
            end
        elseif part:IsA("ModuleScript") or part:IsA("LocalScript") or part:IsA("Script") then
            print("📜 Script: " .. part:GetFullName())
        end
    end
end

-- 3. Scan NPC con Thief đầu tiên
print("\n━━━ [3] NPC Parts (Thief) ━━━")
local npcs = workspace:FindFirstChild("NPCs")
if npcs then
    for _, npc in pairs(npcs:GetChildren()) do
        if npc.Name:find("Thief") and not npc.Name:find("Boss") then
            print("📌 NPC: " .. npc:GetFullName())
            for _, part in pairs(npc:GetDescendants()) do
                if part:IsA("BasePart") then
                    local nameLower = string.lower(part.Name)
                    local tag = string.format(
                        "%s | Size: %s | CanCollide: %s | Trans: %s",
                        part.Name, tostring(part.Size),
                        tostring(part.CanCollide), tostring(part.Transparency)
                    )
                    if nameLower:find("hit") or nameLower:find("box") or nameLower:find("attack") or nameLower:find("range") or nameLower:find("damage") then
                        print("🎯 HITBOX? → " .. tag)
                    else
                        print("   " .. tag)
                    end
                end
            end
            break -- Chỉ cần 1 con
        end
    end
else
    print("❌ Không tìm thấy workspace.NPCs")
end

-- 4. Scan tất cả RemoteEvents/Functions liên quan combat
print("\n━━━ [4] All Combat-Related Remotes ━━━")
for _, obj in pairs(RS:GetDescendants()) do
    if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
        local nameLower = string.lower(obj.Name)
        if nameLower:find("hit") or nameLower:find("combat") or nameLower:find("attack")
            or nameLower:find("damage") or nameLower:find("swing") or nameLower:find("slash")
            or nameLower:find("punch") or nameLower:find("skill") then
            print("🔴 " .. obj.ClassName .. " → " .. obj:GetFullName())
        end
    end
end

-- 5. Scan tool hiện tại (nếu đang cầm)
print("\n━━━ [5] Equipped Tool Parts ━━━")
if char then
    local tool = char:FindFirstChildOfClass("Tool")
    if tool then
        print("🗡️ Tool: " .. tool.Name)
        for _, part in pairs(tool:GetDescendants()) do
            if part:IsA("BasePart") then
                print(string.format(
                    "   %s | Size: %s | CanCollide: %s | Trans: %s",
                    part.Name, tostring(part.Size),
                    tostring(part.CanCollide), tostring(part.Transparency)
                ))
            elseif part:IsA("ModuleScript") or part:IsA("LocalScript") then
                print("   📜 " .. part.ClassName .. ": " .. part.Name)
            end
        end
    else
        print("❌ Không có tool đang equip")
    end
end

-- 6. Tìm ModuleScript chứa từ hitbox trong ReplicatedStorage + StarterPlayer
print("\n━━━ [6] ModuleScripts có chứa 'hit/box/range' trong tên ━━━")
local function searchModules(parent)
    for _, obj in pairs(parent:GetDescendants()) do
        if obj:IsA("ModuleScript") then
            local nameLower = string.lower(obj.Name)
            if nameLower:find("hit") or nameLower:find("box") or nameLower:find("combat")
                or nameLower:find("range") or nameLower:find("damage") or nameLower:find("attack") then
                print("📦 " .. obj:GetFullName())
            end
        end
    end
end
searchModules(RS)
pcall(function() searchModules(game:GetService("StarterPlayer")) end)
pcall(function() searchModules(Player.PlayerGui) end)

print("\n══════════════════════════════════════")
print("✅ SCAN HOÀN TẤT - Check output ở trên!")
print("══════════════════════════════════════")
