-- [[ SAILOR PIECE ANTI-KICK (MULTI-LAYER) ]]
-- Layer 1: hookmetamethod __namecall
-- Layer 2: hookfunction Player:Kick
-- Layer 3: hookfunction TeleportService (kick-teleport)
-- Layer 4: hookfunction RemoteEvent:FireServer (kick remotes)
-- Layer 5: getgc scan — disable kick/ban functions in memory

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer

local blockedCount = 0

local function logBlock(layer, info)
    blockedCount = blockedCount + 1
    warn(("[ANTI-KICK] Layer %s blocked kick #%d: %s"):format(layer, blockedCount, tostring(info)))
end

------------------------------------------------------------
-- LAYER 1: hookmetamethod __namecall (original)
------------------------------------------------------------
local OldNameKick
OldNameKick = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    -- Block Player:Kick / Players:Kick
    if (method == "Kick" or method == "kick") and (self == LocalPlayer or self == Players) then
        logBlock("1-Namecall", args[1] or "no reason")
        return nil
    end

    -- Block Teleport used as kick (TeleportToPlaceInstance to unknown place)
    if method == "TeleportToPlaceInstance" and self == TeleportService then
        logBlock("1-Namecall", "TeleportToPlaceInstance blocked")
        return nil
    end

    -- Block Disconnect
    if method == "Disconnect" and self == LocalPlayer then
        logBlock("1-Namecall", "Disconnect blocked")
        return nil
    end

    return OldNameKick(self, ...)
end))

print("[ANTI-KICK] Layer 1 (hookmetamethod __namecall) ✓")

------------------------------------------------------------
-- LAYER 2: hookfunction Player:Kick directly
------------------------------------------------------------
if hookfunction then
    local oldKick
    oldKick = hookfunction(LocalPlayer.Kick, newcclosure(function(self, ...)
        if self == LocalPlayer then
            local args = {...}
            logBlock("2-HookKick", args[1] or "no reason")
            return nil
        end
        return oldKick(self, ...)
    end))
    print("[ANTI-KICK] Layer 2 (hookfunction Player:Kick) ✓")
else
    warn("[ANTI-KICK] Layer 2 skipped — hookfunction not available")
end

------------------------------------------------------------
-- LAYER 3: hookfunction TeleportService methods
------------------------------------------------------------
if hookfunction then
    -- Teleport (placeId, player)
    local oldTeleport
    oldTeleport = hookfunction(TeleportService.Teleport, newcclosure(function(self, placeId, player, ...)
        if player == LocalPlayer or (typeof(player) == "Instance" and player:IsA("Player") and player == LocalPlayer) then
            logBlock("3-Teleport", "PlaceId=" .. tostring(placeId))
            return nil
        end
        return oldTeleport(self, placeId, player, ...)
    end))

    -- TeleportToPlaceInstance
    local oldTeleportPlace
    oldTeleportPlace = hookfunction(TeleportService.TeleportToPlaceInstance, newcclosure(function(self, placeId, instanceId, player, ...)
        if player == LocalPlayer then
            logBlock("3-TeleportPlace", "PlaceId=" .. tostring(placeId))
            return nil
        end
        return oldTeleportPlace(self, placeId, instanceId, player, ...)
    end))

    print("[ANTI-KICK] Layer 3 (hookfunction TeleportService) ✓")
end

------------------------------------------------------------
-- LAYER 4: hookfunction RemoteEvent:FireServer (kick remotes)
------------------------------------------------------------
if hookfunction then
    local Instance_new = Instance.new
    local dummyRemote = Instance_new("RemoteEvent")
    local oldFireServer
    oldFireServer = hookfunction(dummyRemote.FireServer, newcclosure(function(self, ...)
        if typeof(self) == "Instance" and self:IsA("RemoteEvent") then
            local remoteName = self.Name:lower()
            if remoteName:find("kick") or remoteName:find("ban") or remoteName:find("punish") or remoteName:find("anticheat") then
                logBlock("4-Remote", self:GetFullName())
                return nil
            end
        end
        return oldFireServer(self, ...)
    end))
    dummyRemote:Destroy()

    print("[ANTI-KICK] Layer 4 (hookfunction RemoteEvent:FireServer) ✓")
end

------------------------------------------------------------
-- LAYER 5: getgc scan — hook kick/ban functions in memory
------------------------------------------------------------
if getgc and hookfunction then
    local scanned = 0
    for _, v in pairs(getgc(true)) do
        if type(v) == "function" then
            local ok, info = pcall(getinfo, v)
            if ok and info and info.source then
                local src = info.source:lower()
                local name = (info.name or ""):lower()

                -- Hook functions from anti-cheat / kick-related scripts
                if (src:find("anticheat") or src:find("anti_cheat") or src:find("security") or src:find("moderation")) then
                    if name:find("kick") or name:find("ban") or name:find("remove") or name:find("disconnect") then
                        pcall(function()
                            hookfunction(v, newcclosure(function(...)
                                logBlock("5-GC", "Func=" .. tostring(info.name) .. " Src=" .. tostring(info.source))
                                return nil
                            end))
                            scanned = scanned + 1
                        end)
                    end
                end
            end
        end
    end
    print(("[ANTI-KICK] Layer 5 (getgc scan) ✓ — hooked %d functions"):format(scanned))
end

------------------------------------------------------------
-- STATUS LOOP — periodic log
------------------------------------------------------------
task.spawn(function()
    while task.wait(30) do
        if blockedCount > 0 then
            print(("[ANTI-KICK] Total kicks blocked so far: %d"):format(blockedCount))
        end
    end
end)

print("[ANTI-KICK] All layers active. You are protected. 🛡️")