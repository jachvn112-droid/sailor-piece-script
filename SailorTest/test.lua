-- ⚙️ Cấu hình
getgenv().moduledecompile = true
getgenv().localscript = true
getgenv().containmobquai = false

local HttpService = game:GetService("HttpService")
local SERVER = "http://localhost:3000"
local count = 0
local failed = 0
local skipped = 0

local SKIP_NAMES = {
    ["Animate"] = true,
    ["ChatScript"] = true,
    ["BubbleChat"] = true,
    ["PlayerModule"] = true,
    ["RbxCharacterSounds"] = true,
    ["PlayerScriptsLoader"] = true,
    ["ChatMain"] = true,
    ["ChatServiceRunner"] = true,
}

local function getPath(obj)
    local parts = {}
    local cur = obj
    while cur and cur ~= game do
        table.insert(parts, 1, cur.Name)
        cur = cur.Parent
    end
    return table.concat(parts, "/")
end

local function isInsideMob(obj)
    local cur = obj.Parent
    while cur and cur ~= game and cur ~= workspace do
        if cur:IsA("Model") and cur:FindFirstChildOfClass("Humanoid") then
            return true
        end
        cur = cur.Parent
    end
    return false
end

local function alreadyExists(fullPath)
    local ok, res = pcall(function()
        return request({
            Url = SERVER .. "/check",
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode({ path = fullPath })
        })
    end)
    return ok and res and res.Body == "YES"
end

local function saveScript(scriptObj, folder)
    local gamePath = getPath(scriptObj)
    local fullPath = folder .. "/" .. gamePath

    -- Check file đã tồn tại trước (không tốn bộ nhớ)
    if alreadyExists(fullPath) then
        skipped = skipped + 1
        return
    end

    -- Chỉ lấy bytecode khi cần
    local ok, bytecode = pcall(getscriptbytecode, scriptObj)
    if not ok or not bytecode or bytecode == "" then return end

    local encoded = crypt.base64.encode(bytecode)
    bytecode = nil

    local ok2 = pcall(function()
        request({
            Url = SERVER .. "/save",
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode({ path = fullPath, bytecode = encoded })
        })
    end)
    encoded = nil

    if ok2 then
        count = count + 1
        print("[OK] [" .. folder .. "] " .. gamePath)
    else
        failed = failed + 1
        warn("[SKIP] " .. gamePath)
    end
end

local scripts = {}
for _, obj in ipairs(game:GetDescendants()) do
    if SKIP_NAMES[obj.Name] then continue end

    if obj:IsA("ModuleScript") and getgenv().moduledecompile then
        table.insert(scripts, {obj, "ModuleScripts"})
    end
    if obj:IsA("LocalScript") and getgenv().localscript then
        table.insert(scripts, {obj, "LocalScripts"})
    end
    if getgenv().containmobquai and (obj:IsA("ModuleScript") or obj:IsA("LocalScript") or obj:IsA("Script")) then
        if isInsideMob(obj) then
            table.insert(scripts, {obj, "MobScripts"})
        end
    end
end

print("📋 Found " .. #scripts .. " scripts (after filtering). Starting...")

for i, data in ipairs(scripts) do
    pcall(saveScript, data[1], data[2])
    if i % 20 == 0 then
        print("⏳ " .. i .. "/" .. #scripts .. " | ✅" .. count .. " ⏭️" .. skipped .. " ❌" .. failed)
        task.wait(1)
    else
        task.wait(0.15)
    end
end

print("✅ Done! " .. count .. " saved, " .. skipped .. " already existed, " .. failed .. " failed")
