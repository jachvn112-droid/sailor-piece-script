--[[
    ╔══════════════════════════════════════════╗
    ║    NovaLib Example - Sailor Piece Hub    ║
    ╚══════════════════════════════════════════╝
    Copy & paste vào script chính để dùng!
]]

-- Load thư viện
local Nova = loadstring(game:HttpGet("https://raw.githubusercontent.com/jachvn112-droid/sailor-piece-script/main/NovaLib.luau"))()
-- Hoặc nếu dùng local: local Nova = require(path.to.NovaLib)

-- Tạo GUI chính
local GUI = Nova:Create({
    Name = "Sailor Piece Hub",
    Theme = Nova.Themes.Ocean, -- Midnight | Ocean | Sakura | Emerald
    Size = UDim2.fromOffset(620, 420),
})

-- ══════════════════════════════
-- TAB 1: Main
-- ══════════════════════════════
local MainTab = GUI:Tab({ Name = "🏠 Main" })

MainTab:Section("Auto Farm")

MainTab:Toggle({
    Name = "Auto Farm Quest",
    Default = false,
    Callback = function(state)
        print("Auto Farm:", state)
        -- Thêm code auto farm ở đây
    end,
})

MainTab:Toggle({
    Name = "Auto Attack",
    Default = false,
    Callback = function(state)
        print("Auto Attack:", state)
    end,
})

MainTab:Dropdown({
    Name = "Select Quest",
    Items = {"Quest 1", "Quest 2", "Quest 3", "Boss Quest"},
    Callback = function(item)
        print("Selected:", item)
    end,
})

MainTab:Slider({
    Name = "Farm Speed",
    Min = 1,
    Max = 10,
    Default = 5,
    Callback = function(val)
        print("Speed:", val)
    end,
})

-- ══════════════════════════════
-- TAB 2: Combat  
-- ══════════════════════════════
local CombatTab = GUI:Tab({ Name = "⚔️ Combat" })

CombatTab:Section("Skills")

CombatTab:Button({
    Name = "Use Skill 1",
    Callback = function() print("Skill 1!") end,
})

CombatTab:Button({
    Name = "Use Skill 2",
    Callback = function() print("Skill 2!") end,
})

CombatTab:Toggle({
    Name = "Auto Dodge",
    Callback = function(s) print("Dodge:", s) end,
})

CombatTab:Keybind({
    Name = "Toggle Combat",
    Key = Enum.KeyCode.F,
    OnPress = function()
        print("Combat toggled!")
    end,
})

-- ══════════════════════════════
-- TAB 3: Teleport
-- ══════════════════════════════
local TeleportTab = GUI:Tab({ Name = "🌊 Teleport" })

TeleportTab:Section("Islands")

TeleportTab:Button({
    Name = "Island 1",
    Callback = function() print("Teleport Island 1") end,
})

TeleportTab:Button({
    Name = "Island 2",
    Callback = function() print("Teleport Island 2") end,
})

TeleportTab:Button({
    Name = "Island 3",
    Callback = function() print("Teleport Island 3") end,
})

-- ══════════════════════════════
-- TAB 4: Settings
-- ══════════════════════════════
local SettingsTab = GUI:Tab({ Name = "⚙️ Settings" })

SettingsTab:Section("Config")

SettingsTab:Textbox({
    Name = "Webhook URL",
    Placeholder = "Paste webhook...",
    Callback = function(text)
        print("Webhook:", text)
    end,
})

SettingsTab:Slider({
    Name = "Anti-AFK Timer",
    Min = 1,
    Max = 60,
    Default = 10,
    Callback = function(val)
        print("Timer:", val)
    end,
})

SettingsTab:Toggle({
    Name = "Anti-AFK",
    Default = true,
    Callback = function(s) print("Anti-AFK:", s) end,
})

-- Notification khi load xong
GUI:Notify({
    Title = "✦ Welcome!",
    Text = "Sailor Piece Hub loaded!",
    Duration = 4,
})
