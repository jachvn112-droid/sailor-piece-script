-- [[ SAILOR PIECE RENDER DISTANCE BYPASS (NIL/CACHE SCANNER) ]]
-- Run this script instead of `bypass.lua`.
-- It searches Roblox's hidden memory (Nil instances) to find NPCs that are cached but not rendered.

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if not getnilinstances then
    warn("Your exploit does not support getnilinstances()!")
    return
end

print("[BYPASS CACHE] Scanning Roblox memory (nil instances) for cached NPCs...")

getgenv().CachedNPCs = getgenv().CachedNPCs or {}
local foundCount = 0

-- 1. Scan currently loaded workspace first (just in case)
local function scanFolder(folderName)
    local folder = workspace:FindFirstChild(folderName)
    if folder then
        for _, npc in ipairs(folder:GetChildren()) do
            if npc:IsA("Model") and npc.PrimaryPart then
                getgenv().CachedNPCs[npc.Name] = npc.PrimaryPart.CFrame
            end
        end
    end
end
scanFolder("NPCs")
scanFolder("ServiceNPCs")
scanFolder("StorageNPC")

-- 2. Scan hidden memory for unloaded/cached NPCs
for _, instance in pairs(getnilinstances()) do
    if instance:IsA("Model") then
        -- Games usually keep the PrimaryPart (HumanoidRootPart) CFrame intact when caching to nil
        local root = instance.PrimaryPart or instance:FindFirstChild("HumanoidRootPart")
        if root then
            -- We assume it's an NPC if it has a Humanoid or if it matches familiar names
            local isNPC = instance:FindFirstChildOfClass("Humanoid") ~= nil or instance.Name:find("QuestNPC") or instance.Name:find("Trainee") or instance.Name:find("NPC")
            
            if isNPC then
                if not getgenv().CachedNPCs[instance.Name] then
                    getgenv().CachedNPCs[instance.Name] = root.CFrame
                    foundCount = foundCount + 1
                    -- print("[BYPASS CACHE] Found cached NPC in Memory: " .. instance.Name)
                end
            end
        end
    end
end

print("[BYPASS CACHE] Scan Complete!")
print("[BYPASS CACHE] Recovered " .. tostring(foundCount) .. " hidden NPCs from memory cache.")

local totalCached = 0
for _, _ in pairs(getgenv().CachedNPCs) do totalCached = totalCached + 1 end
print("[BYPASS CACHE] Total NPCs ready for Auto-Farm: " .. tostring(totalCached))

-- Note: In main.lua, `findNPCCFrame` already uses `getgenv().CachedNPCs`, 
-- so as long as this script runs and finds them, main.lua will instantly know where to fly!
