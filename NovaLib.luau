-- ╔═══════════════════════════════════════════════════════════╗
-- ║         🌊 OCEAN HUB - Theme Wrapper for Obsidian       ║
-- ║    Loads Obsidian UI Library + Applies Ocean Theme       ║
-- ╚═══════════════════════════════════════════════════════════╝

-- Step 1: Load Obsidian Library (from vfterminall - all-in-one, battle-tested)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/vfterminall/deividcomsono/main/Obsidian"))()

-- Step 2: Load ThemeManager & SaveManager addons (from original Obsidian repo)
local addonRepo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local ThemeManager = loadstring(game:HttpGet(addonRepo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(addonRepo .. "addons/SaveManager.lua"))()

-- Step 3: Apply Ocean Deep Sea Theme
Library.Scheme.BackgroundColor = Color3.fromRGB(10, 14, 28)
Library.Scheme.MainColor = Color3.fromRGB(15, 22, 40)
Library.Scheme.AccentColor = Color3.fromRGB(0, 200, 215)
Library.Scheme.OutlineColor = Color3.fromRGB(25, 40, 65)
Library.Scheme.FontColor = Color3.fromRGB(200, 230, 255)

-- Step 4: Show Loader/Splash Screen
pcall(function()
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local plr = Players.LocalPlayer
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "OceanLoader"
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    
    local ok, hui = pcall(function() return gethui() end)
    if ok and hui then
        screenGui.Parent = hui
    else
        pcall(function() screenGui.Parent = game:GetService("CoreGui") end)
        if not screenGui.Parent then
            screenGui.Parent = plr:WaitForChild("PlayerGui")
        end
    end
    
    -- Background overlay
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(5, 8, 18)
    bg.BackgroundTransparency = 0
    bg.BorderSizePixel = 0
    bg.Parent = screenGui
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0.35, 0)
    title.BackgroundTransparency = 1
    title.Text = "🌊 Ocean Hub"
    title.TextColor3 = Color3.fromRGB(0, 220, 235)
    title.TextSize = 36
    title.Font = Enum.Font.GothamBold
    title.Parent = bg
    
    -- Subtitle
    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, 0, 0, 30)
    sub.Position = UDim2.new(0, 0, 0.35, 55)
    sub.BackgroundTransparency = 1
    sub.Text = "Initializing Sailor Piece..."
    sub.TextColor3 = Color3.fromRGB(120, 160, 200)
    sub.TextSize = 16
    sub.Font = Enum.Font.Gotham
    sub.Parent = bg
    
    -- Progress bar background
    local barBg = Instance.new("Frame")
    barBg.Size = UDim2.new(0.3, 0, 0, 4)
    barBg.Position = UDim2.new(0.35, 0, 0.35, 100)
    barBg.BackgroundColor3 = Color3.fromRGB(25, 40, 65)
    barBg.BorderSizePixel = 0
    barBg.Parent = bg
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 2)
    barCorner.Parent = barBg
    
    -- Progress bar fill
    local barFill = Instance.new("Frame")
    barFill.Size = UDim2.new(0, 0, 1, 0)
    barFill.BackgroundColor3 = Color3.fromRGB(0, 200, 215)
    barFill.BorderSizePixel = 0
    barFill.Parent = barBg
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 2)
    fillCorner.Parent = barFill
    
    -- Animate progress bar
    local tweenInfo = TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local fillTween = TweenService:Create(barFill, tweenInfo, {Size = UDim2.new(1, 0, 1, 0)})
    fillTween:Play()
    
    task.wait(1.5)
    
    -- Fade out
    local fadeInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint)
    local fadeTween = TweenService:Create(bg, fadeInfo, {BackgroundTransparency = 1})
    TweenService:Create(title, fadeInfo, {TextTransparency = 1}):Play()
    TweenService:Create(sub, fadeInfo, {TextTransparency = 1}):Play()
    TweenService:Create(barBg, fadeInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(barFill, fadeInfo, {BackgroundTransparency = 1}):Play()
    fadeTween:Play()
    fadeTween.Completed:Wait()
    
    screenGui:Destroy()
end)

warn("[Ocean Hub] UI Library loaded successfully!")

return {
    Library = Library,
    ThemeManager = ThemeManager,
    SaveManager = SaveManager,
}
