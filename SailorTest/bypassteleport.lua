-- [[ SAILOR PIECE ANTI-CHEAT BYPASS (GETGC HOOK) ]]
-- Run this BEFORE Auto-Farm. 
-- It searches the entire memory for Anti-Cheat functions and disables them.

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if not getgc or not hookfunction then
    warn("Your exploit does not support getgc or hookfunction!")
    return
end

print("[BYPASS] Scanning memory with getgc()...")

local hookedCount = 0

-- Iterate through all functions in memory
for _, v in pairs(getgc(true)) do
    if type(v) == "function" and not is_synapse_function(v) then
        local info = getinfo(v)
        
        -- Filter for Lua functions (not C functions)
        if info and info.source then
            if info.source:find("AntiCheat") or info.source:find("ControlClient") or info.source:find("Idle") then
                -- Disable functions that might kick or freeze the player
                if info.name and (info.name:lower():find("kick") or info.name:lower():find("ban") or info.name:lower():find("teleport")) then
                    local oldFunc;
                    oldFunc = hookfunction(v, function(...)
                        -- print("[BYPASS] Blocked AC function: " .. tostring(info.name))
                        return nil -- Simply return nothing, disabling the check
                    end)
                    hookedCount = hookedCount + 1
                end
            end
        end
        
        -- Alternatively, if the game uses upvalues for AntiCheat flags (like IsTeleporting or Speed)
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

print("[BYPASS] Finished scanning! Hooked " .. tostring(hookedCount) .. " AC functions.")

-- Fix standard Tween Freezing Issue
-- Many times, the character freezes simply because TweenService fights the physics engine.
-- This loop ensures your Humanoid is in PlatformStand mode while flying, which stops the freezing.
task.spawn(function()
    while task.wait(0.1) do
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum and root and getgenv().IsTeleporting then
            hum.PlatformStand = true
            hum:ChangeState(Enum.HumanoidStateType.Physics)
            
            -- Keep velocity at 0 so gravity doesn't fight the tween
            root.Velocity = Vector3.new(0, 0, 0)
        elseif hum and not getgenv().IsTeleporting then
            if hum.PlatformStand then
                hum.PlatformStand = false
                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
        end
    end
end)

print("[BYPASS] Physics/Tween patches applied.")
