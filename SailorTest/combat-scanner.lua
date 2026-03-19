--[[
    ╔══════════════════════════════════════════════╗
    ║  COMBAT SYSTEM SCANNER - Sailor Piece        ║
    ║  Scans for damage values, remotes, upvalues  ║
    ║  Run this in executor to analyze combat       ║
    ╚══════════════════════════════════════════════╝
]]

local RepStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local results = {}

local function log(section, msg)
    table.insert(results, "[" .. section .. "] " .. msg)
    print("[" .. section .. "] " .. msg)
end

log("START", "=== COMBAT SYSTEM SCANNER ===")
log("START", "Player: " .. player.Name .. " | Level: " .. tostring(player:GetAttribute("Level") or "?"))

-- ═══════════════════════════════════════
-- 1. SCAN ALL REMOTES IN COMBATSYSTEM
-- ═══════════════════════════════════════
log("REMOTES", "--- Scanning CombatSystem remotes ---")
pcall(function()
    local cs = RepStorage:FindFirstChild("CombatSystem")
    if cs then
        local function scanFolder(folder, path)
            for _, child in ipairs(folder:GetChildren()) do
                local childPath = path .. "/" .. child.Name
                if child:IsA("RemoteEvent") then
                    log("REMOTES", "RemoteEvent: " .. childPath)
                elseif child:IsA("RemoteFunction") then
                    log("REMOTES", "RemoteFunction: " .. childPath)
                elseif child:IsA("Folder") or child:IsA("Configuration") then
                    scanFolder(child, childPath)
                end
            end
        end
        scanFolder(cs, "CombatSystem")
    else
        log("REMOTES", "CombatSystem folder NOT FOUND")
    end
end)

-- ═══════════════════════════════════════
-- 2. SCAN ABILITYSYSTEM REMOTES
-- ═══════════════════════════════════════
log("REMOTES", "--- Scanning AbilitySystem remotes ---")
pcall(function()
    local ab = RepStorage:FindFirstChild("AbilitySystem")
    if ab then
        local function scanFolder(folder, path)
            for _, child in ipairs(folder:GetChildren()) do
                local childPath = path .. "/" .. child.Name
                if child:IsA("RemoteEvent") then
                    log("REMOTES", "RemoteEvent: " .. childPath)
                elseif child:IsA("RemoteFunction") then
                    log("REMOTES", "RemoteFunction: " .. childPath)
                elseif child:IsA("Folder") or child:IsA("Configuration") then
                    scanFolder(child, childPath)
                end
            end
        end
        scanFolder(ab, "AbilitySystem")
    else
        log("REMOTES", "AbilitySystem folder NOT FOUND")
    end
end)

-- ═══════════════════════════════════════
-- 3. SCAN ALL REMOTES IN REPLICATEDSTORAGE
-- ═══════════════════════════════════════
log("REMOTES", "--- All RemoteEvents in ReplicatedStorage ---")
pcall(function()
    local function deepScan(folder, path)
        for _, child in ipairs(folder:GetChildren()) do
            local childPath = path .. "/" .. child.Name
            if child:IsA("RemoteEvent") then
                log("ALL_REMOTES", "RE: " .. childPath)
            elseif child:IsA("RemoteFunction") then
                log("ALL_REMOTES", "RF: " .. childPath)
            end
            if #child:GetChildren() > 0 then
                deepScan(child, childPath)
            end
        end
    end
    deepScan(RepStorage, "ReplicatedStorage")
end)

-- ═══════════════════════════════════════
-- 4. SCAN PLAYER ATTRIBUTES (stats, damage, etc.)
-- ═══════════════════════════════════════
log("ATTRIBUTES", "--- Player Attributes ---")
pcall(function()
    local attrs = player:GetAttributes()
    for name, value in pairs(attrs) do
        log("ATTRIBUTES", string.format("Player.%s = %s (%s)", name, tostring(value), typeof(value)))
    end
end)

pcall(function()
    local char = player.Character
    if char then
        local attrs = char:GetAttributes()
        for name, value in pairs(attrs) do
            log("ATTRIBUTES", string.format("Character.%s = %s (%s)", name, tostring(value), typeof(value)))
        end
        -- Check Humanoid attributes
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            log("ATTRIBUTES", "Humanoid.Health = " .. tostring(hum.Health))
            log("ATTRIBUTES", "Humanoid.MaxHealth = " .. tostring(hum.MaxHealth))
            log("ATTRIBUTES", "Humanoid.WalkSpeed = " .. tostring(hum.WalkSpeed))
            local humAttrs = hum:GetAttributes()
            for name, value in pairs(humAttrs) do
                log("ATTRIBUTES", string.format("Humanoid.%s = %s (%s)", name, tostring(value), typeof(value)))
            end
        end
    end
end)

-- ═══════════════════════════════════════
-- 5. SCAN LEADERSTATS / STATS VALUES
-- ═══════════════════════════════════════
log("STATS", "--- Player Value Objects ---")
pcall(function()
    local function scanValues(parent, path)
        for _, child in ipairs(parent:GetChildren()) do
            if child:IsA("ValueBase") then
                log("STATS", string.format("%s/%s = %s (%s)", path, child.Name, tostring(child.Value), child.ClassName))
            elseif child:IsA("Folder") or child:IsA("Configuration") then
                scanValues(child, path .. "/" .. child.Name)
            end
        end
    end
    scanValues(player, "Player")
    if player.Character then
        scanValues(player.Character, "Character")
    end
end)

-- ═══════════════════════════════════════
-- 6. SCAN MODULESCRIPTS FOR DAMAGE KEYWORDS
-- ═══════════════════════════════════════
log("MODULES", "--- Scanning ModuleScripts for damage-related code ---")
pcall(function()
    local keywords = {"damage", "Damage", "DMG", "dmg", "attack", "Attack", "hitDamage", "baseDamage", "critDamage", "DamageMultiplier", "AttackPower", "Strength"}
    local scanned = 0
    local found = 0
    
    local function scanModules(parent, path)
        for _, child in ipairs(parent:GetChildren()) do
            if child:IsA("ModuleScript") then
                scanned = scanned + 1
                local ok, source = pcall(function()
                    return decompile(child)
                end)
                if ok and source then
                    for _, kw in ipairs(keywords) do
                        if string.find(source, kw) then
                            found = found + 1
                            -- Get a snippet around the keyword
                            local idx = string.find(source, kw)
                            local start = math.max(1, idx - 40)
                            local finish = math.min(#source, idx + 60)
                            local snippet = string.sub(source, start, finish):gsub("\n", " "):gsub("\r", "")
                            log("MODULES", string.format("FOUND '%s' in %s/%s: ...%s...", kw, path, child.Name, snippet))
                            break -- only log first match per module
                        end
                    end
                end
            end
            if #child:GetChildren() > 0 then
                pcall(function()
                    scanModules(child, path .. "/" .. child.Name)
                end)
            end
        end
    end
    
    -- Scan key locations
    scanModules(RepStorage, "ReplicatedStorage")
    pcall(function() scanModules(game:GetService("StarterPlayer"), "StarterPlayer") end)
    
    log("MODULES", string.format("Scanned %d modules, found damage keywords in %d", scanned, found))
end)

-- ═══════════════════════════════════════
-- 7. HOOK + UPVALUE SCAN ON LOCALSCRIPTS
-- ═══════════════════════════════════════
log("UPVALUES", "--- Scanning LocalScript upvalues/constants ---")
pcall(function()
    if not getgc then
        log("UPVALUES", "getgc() not available - executor doesn't support it")
        return
    end
    
    local gc = getgc(true)
    local combatFunctions = {}
    
    for _, v in ipairs(gc) do
        if typeof(v) == "function" then
            pcall(function()
                local info = getinfo(v)
                local src = info and info.source or ""
                -- Look for combat-related scripts
                if string.find(src:lower(), "combat") or string.find(src:lower(), "damage") 
                   or string.find(src:lower(), "attack") or string.find(src:lower(), "hit")
                   or string.find(src:lower(), "weapon") then
                    table.insert(combatFunctions, {func = v, source = src, name = info.name or "anonymous"})
                end
            end)
        end
    end
    
    log("UPVALUES", "Found " .. #combatFunctions .. " combat-related functions in GC")
    
    for i, entry in ipairs(combatFunctions) do
        if i > 20 then break end -- limit output
        log("UPVALUES", string.format("  [%d] %s from %s", i, entry.name, entry.source))
        
        -- Scan upvalues
        if getupvalues then
            pcall(function()
                local ups = getupvalues(entry.func)
                for idx, val in pairs(ups) do
                    if typeof(val) == "number" then
                        log("UPVALUES", string.format("    upvalue[%d] = %s (number)", idx, tostring(val)))
                    elseif typeof(val) == "table" then
                        log("UPVALUES", string.format("    upvalue[%d] = table (%d items)", idx, #val))
                        -- Peek inside tables for damage values
                        for k, v2 in pairs(val) do
                            if typeof(k) == "string" and (string.find(k:lower(), "dam") or string.find(k:lower(), "attack") or string.find(k:lower(), "hit") or string.find(k:lower(), "power") or string.find(k:lower(), "strength") or string.find(k:lower(), "crit")) then
                                log("UPVALUES", string.format("      .%s = %s", tostring(k), tostring(v2)))
                            end
                        end
                    end
                end
            end)
        end
        
        -- Scan constants
        if getconstants then
            pcall(function()
                local consts = getconstants(entry.func)
                for idx, val in pairs(consts) do
                    if typeof(val) == "string" and (string.find(val:lower(), "dam") or string.find(val:lower(), "hit") or string.find(val:lower(), "attack") or string.find(val:lower(), "power")) then
                        log("UPVALUES", string.format("    constant[%d] = \"%s\"", idx, val))
                    end
                end
            end)
        end
    end
end)

-- ═══════════════════════════════════════
-- 8. CHECK REQUEST HIT ARGUMENTS VIA HOOK
-- ═══════════════════════════════════════
log("HOOK", "--- Hooking RequestHit to capture args ---")
pcall(function()
    if not hookfunction and not hookmetamethod then
        log("HOOK", "hookfunction not available")
        return
    end
    
    local requestHit = RepStorage:FindFirstChild("CombatSystem")
        and RepStorage.CombatSystem:FindFirstChild("Remotes") 
        and RepStorage.CombatSystem.Remotes:FindFirstChild("RequestHit")
    
    if requestHit then
        log("HOOK", "RequestHit found: " .. requestHit.ClassName)
        
        -- Spy on namecall to capture what args the game sends
        if hookmetamethod then
            local oldNamecall
            oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local method = getnamecallmethod()
                if method == "FireServer" and self == requestHit then
                    local args = {...}
                    local argStr = ""
                    for i, arg in ipairs(args) do
                        argStr = argStr .. string.format("[%d]=%s(%s) ", i, tostring(arg), typeof(arg))
                    end
                    log("HOOK", "RequestHit called with: " .. (argStr ~= "" and argStr or "(no args)"))
                end
                return oldNamecall(self, ...)
            end)
            log("HOOK", "✅ Hooked __namecall on RequestHit - attack a mob manually to see args!")
        end
    else
        log("HOOK", "RequestHit remote NOT FOUND at expected path")
    end
end)

-- ═══════════════════════════════════════
-- 9. SCAN TOOLS (WEAPONS) IN PLAYER
-- ═══════════════════════════════════════
log("WEAPONS", "--- Scanning equipped tools ---")
pcall(function()
    local char = player.Character
    if char then
        for _, tool in ipairs(char:GetChildren()) do
            if tool:IsA("Tool") then
                log("WEAPONS", "Equipped: " .. tool.Name)
                local attrs = tool:GetAttributes()
                for k, v in pairs(attrs) do
                    log("WEAPONS", string.format("  %s.%s = %s (%s)", tool.Name, k, tostring(v), typeof(v)))
                end
                -- Check for value objects inside tool
                for _, child in ipairs(tool:GetDescendants()) do
                    if child:IsA("ValueBase") then
                        log("WEAPONS", string.format("  %s/%s = %s (%s)", tool.Name, child.Name, tostring(child.Value), child.ClassName))
                    end
                end
            end
        end
    end
    -- Also check backpack
    local bp = player:FindFirstChild("Backpack")
    if bp then
        for _, tool in ipairs(bp:GetChildren()) do
            if tool:IsA("Tool") then
                log("WEAPONS", "Backpack: " .. tool.Name)
                local attrs = tool:GetAttributes()
                for k, v in pairs(attrs) do
                    log("WEAPONS", string.format("  %s.%s = %s (%s)", tool.Name, k, tostring(v), typeof(v)))
                end
            end
        end
    end
end)

-- ═══════════════════════════════════════
-- 10. SUMMARY
-- ═══════════════════════════════════════
log("DONE", "=== SCAN COMPLETE ===")
log("DONE", "Total findings: " .. #results)
log("DONE", "")
log("DONE", "NEXT STEPS:")
log("DONE", "1. Attack a mob MANUALLY (click) and check console for hooked RequestHit args")
log("DONE", "2. Look at MODULES section for damage calculation scripts")  
log("DONE", "3. Look at UPVALUES for numeric values that could be damage")
log("DONE", "4. Look at ATTRIBUTES for AttackPower/Strength/Damage stats")

-- Save results to a string for easy copy
local fullLog = table.concat(results, "\n")
if setclipboard then
    setclipboard(fullLog)
    print("\n📋 Full results copied to clipboard!")
end
