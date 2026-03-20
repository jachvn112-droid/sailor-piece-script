--[[
    ╔══════════════════════════════════════════╗
    ║         🌟 NovaLib UI Library 🌟         ║
    ║   Premium Roblox UI Library v1.0         ║
    ║   Author: jachvn112-droid                ║
    ╚══════════════════════════════════════════╝
    
    Features: Tabs, Buttons, Toggles, Sliders, 
    Dropdowns, Textboxes, Keybinds, Notifications,
    Color Picker, Prompts + Smooth Animations
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- ═══════════════════════════════════════
-- THEME SYSTEM
-- ═══════════════════════════════════════
local Themes = {
    Midnight = {
        Primary = Color3.fromRGB(15, 15, 25),
        Secondary = Color3.fromRGB(22, 22, 38),
        Accent = Color3.fromRGB(120, 80, 255),
        AccentGlow = Color3.fromRGB(150, 110, 255),
        Text = Color3.fromRGB(230, 230, 245),
        SubText = Color3.fromRGB(140, 140, 170),
        Border = Color3.fromRGB(45, 45, 70),
        Success = Color3.fromRGB(80, 220, 130),
        Error = Color3.fromRGB(255, 80, 90),
        Warning = Color3.fromRGB(255, 180, 50),
    },
    Ocean = {
        Primary = Color3.fromRGB(10, 18, 30),
        Secondary = Color3.fromRGB(15, 28, 48),
        Accent = Color3.fromRGB(0, 180, 255),
        AccentGlow = Color3.fromRGB(50, 200, 255),
        Text = Color3.fromRGB(220, 235, 250),
        SubText = Color3.fromRGB(120, 150, 180),
        Border = Color3.fromRGB(30, 50, 80),
        Success = Color3.fromRGB(0, 230, 150),
        Error = Color3.fromRGB(255, 70, 100),
        Warning = Color3.fromRGB(255, 200, 60),
    },
    Sakura = {
        Primary = Color3.fromRGB(25, 12, 18),
        Secondary = Color3.fromRGB(40, 18, 28),
        Accent = Color3.fromRGB(255, 100, 150),
        AccentGlow = Color3.fromRGB(255, 140, 180),
        Text = Color3.fromRGB(250, 230, 240),
        SubText = Color3.fromRGB(180, 140, 160),
        Border = Color3.fromRGB(70, 35, 50),
        Success = Color3.fromRGB(100, 230, 160),
        Error = Color3.fromRGB(255, 80, 80),
        Warning = Color3.fromRGB(255, 190, 80),
    },
    Emerald = {
        Primary = Color3.fromRGB(10, 20, 15),
        Secondary = Color3.fromRGB(15, 32, 22),
        Accent = Color3.fromRGB(0, 220, 130),
        AccentGlow = Color3.fromRGB(50, 240, 160),
        Text = Color3.fromRGB(220, 250, 235),
        SubText = Color3.fromRGB(120, 170, 140),
        Border = Color3.fromRGB(25, 60, 40),
        Success = Color3.fromRGB(0, 255, 150),
        Error = Color3.fromRGB(255, 90, 90),
        Warning = Color3.fromRGB(255, 200, 60),
    },
}

-- ═══════════════════════════════════════
-- ANIMATION HELPERS
-- ═══════════════════════════════════════
local function tween(obj, props, duration, style, dir)
    local info = TweenInfo.new(duration or 0.3, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out)
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

local function ripple(button, theme)
    local circle = Instance.new("Frame")
    circle.Name = "Ripple"
    circle.BackgroundColor3 = theme.AccentGlow
    circle.BackgroundTransparency = 0.7
    circle.BorderSizePixel = 0
    circle.Size = UDim2.new(0, 0, 0, 0)
    circle.Position = UDim2.new(0.5, 0, 0.5, 0)
    circle.AnchorPoint = Vector2.new(0.5, 0.5)
    circle.ZIndex = button.ZIndex + 1
    circle.Parent = button
    local cr = Instance.new("UICorner")
    cr.CornerRadius = UDim.new(1, 0)
    cr.Parent = circle
    local sz = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2
    tween(circle, {Size = UDim2.new(0, sz, 0, sz), BackgroundTransparency = 1}, 0.5)
    task.delay(0.5, function() circle:Destroy() end)
end

local function addCorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = parent
    return c
end

local function addStroke(parent, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thickness or 1
    s.Transparency = 0.5
    s.Parent = parent
    return s
end

local function addPadding(parent, t, b, l, r)
    local p = Instance.new("UIPadding")
    p.PaddingTop = UDim.new(0, t or 6)
    p.PaddingBottom = UDim.new(0, b or 6)
    p.PaddingLeft = UDim.new(0, l or 8)
    p.PaddingRight = UDim.new(0, r or 8)
    p.Parent = parent
    return p
end

-- ═══════════════════════════════════════
-- NOVA LIBRARY
-- ═══════════════════════════════════════
local Nova = {}
Nova.Themes = Themes

function Nova:Create(config)
    local name = config.Name or "Nova Hub"
    local theme = config.Theme or Themes.Midnight
    local size = config.Size or UDim2.fromOffset(620, 420)
    -- Logo Asset ID: upload hình nova_hub_logo.png lên Roblox và thay ID ở đây
    local logoAssetId = config.LogoId or "rbxassetid://119611823018418"
    local skipSplash = config.SkipSplash or false

    -- Main ScreenGui
    local gui = Instance.new("ScreenGui")
    gui.Name = "NovaLib_" .. name
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.IgnoreGuiInset = true
    gui.Parent = Player.PlayerGui

    -- ════════════════════════════════════════════
    -- SPLASH SCREEN - CINEMATIC INTRO
    -- ════════════════════════════════════════════
    if not skipSplash then
        local splashOverlay = Instance.new("Frame")
        splashOverlay.Name = "SplashOverlay"
        splashOverlay.Size = UDim2.new(1, 0, 1, 0)
        splashOverlay.BackgroundColor3 = Color3.fromRGB(5, 5, 12)
        splashOverlay.BorderSizePixel = 0
        splashOverlay.ZIndex = 200
        splashOverlay.Parent = gui

        -- Particle container for star particles
        local particleHolder = Instance.new("Frame")
        particleHolder.Size = UDim2.new(1, 0, 1, 0)
        particleHolder.BackgroundTransparency = 1
        particleHolder.ZIndex = 201
        particleHolder.Parent = splashOverlay

        -- Spawn floating star particles
        task.spawn(function()
            for i = 1, 30 do
                task.wait(0.05)
                local particle = Instance.new("Frame")
                particle.Size = UDim2.fromOffset(math.random(2, 5), math.random(2, 5))
                particle.Position = UDim2.new(math.random() * 0.9 + 0.05, 0, math.random() * 0.9 + 0.05, 0)
                particle.BackgroundColor3 = theme.AccentGlow
                particle.BackgroundTransparency = math.random(5, 9) / 10
                particle.BorderSizePixel = 0
                particle.ZIndex = 201
                particle.Parent = particleHolder
                addCorner(particle, 10)

                -- Float animation
                task.spawn(function()
                    while particle.Parent do
                        local dur = math.random(20, 40) / 10
                        tween(particle, {
                            Position = UDim2.new(math.random() * 0.9 + 0.05, 0, math.random() * 0.9 + 0.05, 0),
                            BackgroundTransparency = math.random(4, 9) / 10,
                        }, dur, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                        task.wait(dur)
                    end
                end)
            end
        end)

        -- ── STAGE 1: "NOVA HUB" text fade in ──
        local splashText = Instance.new("TextLabel")
        splashText.Size = UDim2.new(0, 400, 0, 60)
        splashText.Position = UDim2.new(0.5, 0, 0.42, 0)
        splashText.AnchorPoint = Vector2.new(0.5, 0.5)
        splashText.BackgroundTransparency = 1
        splashText.Text = "NOVA HUB"
        splashText.TextColor3 = theme.AccentGlow
        splashText.TextSize = 0
        splashText.TextTransparency = 1
        splashText.Font = Enum.Font.GothamBlack
        splashText.ZIndex = 210
        splashText.Parent = splashOverlay

        -- Text glow shadow
        local textGlow = Instance.new("TextLabel")
        textGlow.Size = UDim2.new(0, 400, 0, 60)
        textGlow.Position = UDim2.new(0.5, 0, 0.42, 0)
        textGlow.AnchorPoint = Vector2.new(0.5, 0.5)
        textGlow.BackgroundTransparency = 1
        textGlow.Text = "NOVA HUB"
        textGlow.TextColor3 = theme.Accent
        textGlow.TextSize = 0
        textGlow.TextTransparency = 1
        textGlow.Font = Enum.Font.GothamBlack
        textGlow.ZIndex = 209
        textGlow.Parent = splashOverlay

        -- Animate text appearing with scale
        task.wait(0.3)
        tween(splashText, {TextSize = 48, TextTransparency = 0}, 0.8, Enum.EasingStyle.Back)
        tween(textGlow, {TextSize = 52, TextTransparency = 0.6}, 0.8, Enum.EasingStyle.Back)
        task.wait(1.0)

        -- Subtitle
        local subtitle = Instance.new("TextLabel")
        subtitle.Size = UDim2.new(0, 300, 0, 20)
        subtitle.Position = UDim2.new(0.5, 0, 0.49, 0)
        subtitle.AnchorPoint = Vector2.new(0.5, 0.5)
        subtitle.BackgroundTransparency = 1
        subtitle.Text = "✦  P R E M I U M   S C R I P T   H U B  ✦"
        subtitle.TextColor3 = theme.SubText
        subtitle.TextSize = 11
        subtitle.TextTransparency = 1
        subtitle.Font = Enum.Font.GothamMedium
        subtitle.ZIndex = 210
        subtitle.Parent = splashOverlay
        tween(subtitle, {TextTransparency = 0}, 0.5)
        task.wait(0.6)

        -- ── STAGE 2: Horizontal line appears and expands ──
        local hLine = Instance.new("Frame")
        hLine.Size = UDim2.new(0, 0, 0, 2)
        hLine.Position = UDim2.new(0.5, 0, 0.55, 0)
        hLine.AnchorPoint = Vector2.new(0.5, 0.5)
        hLine.BackgroundColor3 = theme.Accent
        hLine.BorderSizePixel = 0
        hLine.ZIndex = 210
        hLine.Parent = splashOverlay

        -- Line glow gradient
        local lineGlow = Instance.new("UIGradient")
        lineGlow.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.9),
            NumberSequenceKeypoint.new(0.3, 0),
            NumberSequenceKeypoint.new(0.7, 0),
            NumberSequenceKeypoint.new(1, 0.9),
        })
        lineGlow.Parent = hLine

        -- Expand horizontally
        tween(hLine, {Size = UDim2.new(0, 500, 0, 2)}, 0.6, Enum.EasingStyle.Quint)
        task.wait(0.7)

        -- ── STAGE 3: Rectangle expands vertically ──
        tween(hLine, {Size = UDim2.new(0, 500, 0, 300)}, 0.7, Enum.EasingStyle.Back)
        tween(hLine, {BackgroundTransparency = 0.92}, 0.7)
        addCorner(hLine, 14)
        addStroke(hLine, theme.Accent, 1.5)
        task.wait(0.5)

        -- ── STAGE 4: Logo appears inside the rectangle ──
        local logoContainer = Instance.new("Frame")
        logoContainer.Size = UDim2.new(0, 120, 0, 120)
        logoContainer.Position = UDim2.new(0.5, 0, 0.35, 0)
        logoContainer.AnchorPoint = Vector2.new(0.5, 0.5)
        logoContainer.BackgroundTransparency = 1
        logoContainer.ZIndex = 212
        logoContainer.Parent = hLine

        local logo = Instance.new("ImageLabel")
        logo.Size = UDim2.new(1, 0, 1, 0)
        logo.BackgroundTransparency = 1
        logo.Image = logoAssetId
        logo.ImageTransparency = 1
        logo.ZIndex = 212
        logo.ScaleType = Enum.ScaleType.Fit
        logo.Parent = logoContainer

        -- Logo glow circle
        local glowCircle = Instance.new("Frame")
        glowCircle.Size = UDim2.new(0, 0, 0, 0)
        glowCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
        glowCircle.AnchorPoint = Vector2.new(0.5, 0.5)
        glowCircle.BackgroundColor3 = theme.AccentGlow
        glowCircle.BackgroundTransparency = 0.85
        glowCircle.ZIndex = 211
        glowCircle.Parent = logoContainer
        addCorner(glowCircle, 999)

        -- Animate logo appearing with glow burst
        tween(glowCircle, {Size = UDim2.new(0, 180, 0, 180), BackgroundTransparency = 1}, 0.8, Enum.EasingStyle.Quint)
        tween(logo, {ImageTransparency = 0}, 0.6)

        -- Star burst: draw star-shaped lines from center
        for angle = 0, 330, 30 do
            local ray = Instance.new("Frame")
            ray.Size = UDim2.new(0, 0, 0, 1)
            ray.Position = UDim2.new(0.5, 0, 0.35, 0)
            ray.AnchorPoint = Vector2.new(0, 0.5)
            ray.BackgroundColor3 = theme.AccentGlow
            ray.BackgroundTransparency = 0.5
            ray.Rotation = angle
            ray.ZIndex = 211
            ray.Parent = hLine
            
            tween(ray, {Size = UDim2.new(0, math.random(40, 100), 0, 1), BackgroundTransparency = 1}, 0.8, Enum.EasingStyle.Quint)
            task.delay(0.8, function() ray:Destroy() end)
        end

        -- "NOVA HUB" text inside rectangle
        local innerTitle = Instance.new("TextLabel")
        innerTitle.Size = UDim2.new(1, 0, 0, 30)
        innerTitle.Position = UDim2.new(0.5, 0, 0.62, 0)
        innerTitle.AnchorPoint = Vector2.new(0.5, 0.5)
        innerTitle.BackgroundTransparency = 1
        innerTitle.Text = "✦ " .. name .. " ✦"
        innerTitle.TextColor3 = theme.Text
        innerTitle.TextSize = 22
        innerTitle.TextTransparency = 1
        innerTitle.Font = Enum.Font.GothamBold
        innerTitle.ZIndex = 212
        innerTitle.Parent = hLine
        tween(innerTitle, {TextTransparency = 0}, 0.5)

        -- Loading bar
        local loadBarBg = Instance.new("Frame")
        loadBarBg.Size = UDim2.new(0.6, 0, 0, 4)
        loadBarBg.Position = UDim2.new(0.5, 0, 0.75, 0)
        loadBarBg.AnchorPoint = Vector2.new(0.5, 0.5)
        loadBarBg.BackgroundColor3 = theme.Border
        loadBarBg.BorderSizePixel = 0
        loadBarBg.ZIndex = 212
        loadBarBg.Parent = hLine
        addCorner(loadBarBg, 2)

        local loadBarFill = Instance.new("Frame")
        loadBarFill.Size = UDim2.new(0, 0, 1, 0)
        loadBarFill.BackgroundColor3 = theme.Accent
        loadBarFill.BorderSizePixel = 0
        loadBarFill.ZIndex = 213
        loadBarFill.Parent = loadBarBg
        addCorner(loadBarFill, 2)

        -- Loading text
        local loadText = Instance.new("TextLabel")
        loadText.Size = UDim2.new(0.6, 0, 0, 16)
        loadText.Position = UDim2.new(0.5, 0, 0.80, 0)
        loadText.AnchorPoint = Vector2.new(0.5, 0.5)
        loadText.BackgroundTransparency = 1
        loadText.Text = "Initializing..."
        loadText.TextColor3 = theme.SubText
        loadText.TextSize = 10
        loadText.Font = Enum.Font.Gotham
        loadText.ZIndex = 212
        loadText.Parent = hLine

        -- Animate loading bar
        tween(loadBarFill, {Size = UDim2.new(0.3, 0, 1, 0)}, 0.4)
        task.wait(0.3)
        loadText.Text = "Loading modules..."
        tween(loadBarFill, {Size = UDim2.new(0.6, 0, 1, 0)}, 0.4)
        task.wait(0.3)
        loadText.Text = "Preparing interface..."
        tween(loadBarFill, {Size = UDim2.new(0.85, 0, 1, 0)}, 0.3)
        task.wait(0.3)
        loadText.Text = "Ready!"
        tween(loadBarFill, {Size = UDim2.new(1, 0, 1, 0)}, 0.3)
        tween(loadText, {TextColor3 = theme.Accent}, 0.2)
        task.wait(0.5)

        -- ── STAGE 5: Splash out, main UI in ──
        -- Everything fades/shrinks
        tween(splashText, {TextTransparency = 1, TextSize = 60}, 0.4)
        tween(textGlow, {TextTransparency = 1}, 0.3)
        tween(subtitle, {TextTransparency = 1}, 0.3)
        tween(hLine, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        tween(logo, {ImageTransparency = 1}, 0.3)
        tween(innerTitle, {TextTransparency = 1}, 0.3)

        -- Fade particles
        for _, child in pairs(particleHolder:GetChildren()) do
            tween(child, {BackgroundTransparency = 1}, 0.3)
        end

        task.wait(0.4)
        tween(splashOverlay, {BackgroundTransparency = 1}, 0.5)
        task.wait(0.5)
        splashOverlay:Destroy()
    end

    -- ════════════════════════════════════════════
    -- MAIN UI (appears after splash)
    -- ════════════════════════════════════════════

    -- Shadow
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://6014261993"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.5
    shadow.Size = UDim2.new(1, 50, 1, 50)
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(49, 49, 450, 450)

    -- Main Frame  
    local main = Instance.new("Frame")
    main.Name = "MainFrame"
    main.Size = size
    main.Position = UDim2.new(0.5, 0, 0.5, 0)
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = theme.Primary
    main.BorderSizePixel = 0
    main.ClipsDescendants = true
    main.Parent = gui
    addCorner(main, 12)
    addStroke(main, theme.Border, 1)
    shadow.Parent = main

    -- Open animation (after splash or without splash)
    main.Size = UDim2.fromOffset(0, 0)
    main.BackgroundTransparency = 1

    -- Step 1: Horizontal line expand
    tween(main, {Size = UDim2.new(0, size.X.Offset, 0, 3), BackgroundTransparency = 0}, 0.35, Enum.EasingStyle.Quint)
    task.wait(0.35)
    -- Step 2: Vertical expand
    tween(main, {Size = size}, 0.45, Enum.EasingStyle.Back)
    task.wait(0.5)

    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = theme.Secondary
    titleBar.BorderSizePixel = 0
    titleBar.Parent = main
    addCorner(titleBar, 12)

    -- Bottom cover for title bar corners
    local titleCover = Instance.new("Frame")
    titleCover.Size = UDim2.new(1, 0, 0, 14)
    titleCover.Position = UDim2.new(0, 0, 1, -14)
    titleCover.BackgroundColor3 = theme.Secondary
    titleCover.BorderSizePixel = 0
    titleCover.Parent = titleBar

    -- Accent line
    local accentLine = Instance.new("Frame")
    accentLine.Size = UDim2.new(1, 0, 0, 2)
    accentLine.Position = UDim2.new(0, 0, 1, 0)
    accentLine.BackgroundColor3 = theme.Accent
    accentLine.BorderSizePixel = 0
    accentLine.Parent = titleBar

    -- Glow effect on accent line
    local glowGrad = Instance.new("UIGradient")
    glowGrad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.8),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(1, 0.8),
    })
    glowGrad.Parent = accentLine

    -- Animate glow
    task.spawn(function()
        while gui.Parent do
            tween(glowGrad, {Offset = Vector2.new(1, 0)}, 2, Enum.EasingStyle.Linear)
            task.wait(2)
            glowGrad.Offset = Vector2.new(-1, 0)
        end
    end)

    -- Title Text
    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(0.6, 0, 1, 0)
    titleText.Position = UDim2.new(0, 14, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = "✦ " .. name
    titleText.TextColor3 = theme.Text
    titleText.TextSize = 16
    titleText.Font = Enum.Font.GothamBold
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = titleBar

    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -36, 0.5, 0)
    closeBtn.AnchorPoint = Vector2.new(0, 0.5)
    closeBtn.BackgroundColor3 = theme.Error
    closeBtn.BackgroundTransparency = 0.8
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = theme.Error
    closeBtn.TextSize = 14
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = titleBar
    addCorner(closeBtn, 6)

    closeBtn.MouseEnter:Connect(function()
        tween(closeBtn, {BackgroundTransparency = 0.3}, 0.2)
    end)
    closeBtn.MouseLeave:Connect(function()
        tween(closeBtn, {BackgroundTransparency = 0.8}, 0.2)
    end)

    local isOpen = true
    closeBtn.MouseButton1Click:Connect(function()
        isOpen = false
        tween(main, {Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1}, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.wait(0.4)
        gui:Destroy()
    end)

    -- Minimize Button (yellow with "-" text)
    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0, 30, 0, 30)
    minBtn.Position = UDim2.new(1, -70, 0.5, 0)
    minBtn.AnchorPoint = Vector2.new(0, 0.5)
    minBtn.BackgroundColor3 = theme.Warning
    minBtn.BackgroundTransparency = 0.8
    minBtn.Text = "-"
    minBtn.TextColor3 = theme.Warning
    minBtn.TextSize = 20
    minBtn.Font = Enum.Font.GothamBold
    minBtn.BorderSizePixel = 0
    minBtn.Parent = titleBar
    addCorner(minBtn, 6)

    minBtn.MouseEnter:Connect(function()
        tween(minBtn, {BackgroundTransparency = 0.3}, 0.2)
    end)
    minBtn.MouseLeave:Connect(function()
        tween(minBtn, {BackgroundTransparency = 0.8}, 0.2)
    end)

    -- ═══════════════════════════════════════
    -- FLOATING MINI LOGO (shown when minimized)
    -- ═══════════════════════════════════════
    local miniLogo = Instance.new("ImageButton")
    miniLogo.Name = "NovaMinLogo"
    miniLogo.Size = UDim2.fromOffset(50, 50)
    miniLogo.Position = UDim2.new(0, 20, 0.5, 0)
    miniLogo.AnchorPoint = Vector2.new(0, 0.5)
    miniLogo.BackgroundColor3 = theme.Primary
    miniLogo.BackgroundTransparency = 0.2
    miniLogo.Image = logoAssetId
    miniLogo.ScaleType = Enum.ScaleType.Fit
    miniLogo.BorderSizePixel = 0
    miniLogo.Visible = false
    miniLogo.ZIndex = 100
    miniLogo.Parent = gui
    addCorner(miniLogo, 12)
    addStroke(miniLogo, theme.Accent, 2)

    -- Glow pulse animation on mini logo
    local miniGlow = Instance.new("UIStroke")
    miniGlow.Color = theme.AccentGlow
    miniGlow.Thickness = 1.5
    miniGlow.Transparency = 0.6
    miniGlow.Parent = miniLogo

    -- Hover effects on mini logo
    miniLogo.MouseEnter:Connect(function()
        tween(miniLogo, {Size = UDim2.fromOffset(56, 56), BackgroundTransparency = 0}, 0.2)
        tween(miniGlow, {Transparency = 0.2}, 0.2)
    end)
    miniLogo.MouseLeave:Connect(function()
        tween(miniLogo, {Size = UDim2.fromOffset(50, 50), BackgroundTransparency = 0.2}, 0.2)
        tween(miniGlow, {Transparency = 0.6}, 0.2)
    end)

    -- Mini logo drag
    local miniDragging, miniDragInput, miniDragStart, miniStartPos
    miniLogo.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            miniDragging = true
            miniDragStart = input.Position
            miniStartPos = miniLogo.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then miniDragging = false end
            end)
        end
    end)
    miniLogo.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            miniDragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == miniDragInput and miniDragging then
            local delta = input.Position - miniDragStart
            miniLogo.Position = UDim2.new(
                miniStartPos.X.Scale, miniStartPos.X.Offset + delta.X,
                miniStartPos.Y.Scale, miniStartPos.Y.Offset + delta.Y
            )
        end
    end)

    -- ═══════════════════════════════════════
    -- MINIMIZE / RESTORE LOGIC
    -- ═══════════════════════════════════════
    local minimized = false

    -- Click "-" button → hide window, show mini logo
    minBtn.MouseButton1Click:Connect(function()
        minimized = true
        tween(main, {Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.wait(0.3)
        main.Visible = false
        miniLogo.Visible = true
        miniLogo.Size = UDim2.fromOffset(0, 0)
        tween(miniLogo, {Size = UDim2.fromOffset(50, 50)}, 0.3, Enum.EasingStyle.Back)
    end)

    -- Click mini logo → hide logo, restore window
    miniLogo.MouseButton1Click:Connect(function()
        if miniDragging then return end
        minimized = false
        tween(miniLogo, {Size = UDim2.fromOffset(0, 0)}, 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.wait(0.2)
        miniLogo.Visible = false
        main.Visible = true
        main.BackgroundTransparency = 0
        tween(main, {Size = UDim2.new(0, size.X.Offset, 0, 3)}, 0.2, Enum.EasingStyle.Quint)
        task.wait(0.2)
        tween(main, {Size = size}, 0.35, Enum.EasingStyle.Back)
    end)

    -- Drag functionality
    local dragging, dragInput, dragStart, startPos
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            tween(main, {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}, 0.08)
        end
    end)

    -- Tab Bar (left side)
    local tabBar = Instance.new("ScrollingFrame")
    tabBar.Name = "TabBar"
    tabBar.Size = UDim2.new(0, 150, 1, -44)
    tabBar.Position = UDim2.new(0, 0, 0, 42)
    tabBar.BackgroundColor3 = theme.Secondary
    tabBar.BackgroundTransparency = 0.3
    tabBar.BorderSizePixel = 0
    tabBar.ScrollBarThickness = 2
    tabBar.ScrollBarImageColor3 = theme.Accent
    tabBar.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabBar.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tabBar.Parent = main

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 4)
    tabLayout.Parent = tabBar
    addPadding(tabBar, 8, 8, 8, 8)

    -- Content area
    local contentArea = Instance.new("Frame")
    contentArea.Name = "ContentArea"
    contentArea.Size = UDim2.new(1, -154, 1, -46)
    contentArea.Position = UDim2.new(0, 152, 0, 44)
    contentArea.BackgroundTransparency = 1
    contentArea.BorderSizePixel = 0
    contentArea.Parent = main

    -- Tab management
    local tabs = {}
    local activeTab = nil
    local Window = {GUI = gui, Main = main, Theme = theme}

    -- ═══════════════════════════════════════
    -- TAB
    -- ═══════════════════════════════════════
    function Window:Tab(config)
        local tabName = config.Name or "Tab"
        local tabIcon = config.Icon or ""

        -- Tab button
        local tabBtn = Instance.new("TextButton")
        tabBtn.Size = UDim2.new(1, 0, 0, 36)
        tabBtn.BackgroundColor3 = theme.Accent
        tabBtn.BackgroundTransparency = 1
        tabBtn.BorderSizePixel = 0
        tabBtn.Text = ""
        tabBtn.Parent = tabBar
        addCorner(tabBtn, 8)

        local tabLabel = Instance.new("TextLabel")
        tabLabel.Size = UDim2.new(1, -12, 1, 0)
        tabLabel.Position = UDim2.new(0, tabIcon ~= "" and 30 or 12, 0, 0)
        tabLabel.BackgroundTransparency = 1
        tabLabel.Text = tabName
        tabLabel.TextColor3 = theme.SubText
        tabLabel.TextSize = 13
        tabLabel.Font = Enum.Font.GothamMedium
        tabLabel.TextXAlignment = Enum.TextXAlignment.Left
        tabLabel.Parent = tabBtn

        if tabIcon ~= "" then
            local icon = Instance.new("ImageLabel")
            icon.Size = UDim2.new(0, 18, 0, 18)
            icon.Position = UDim2.new(0, 8, 0.5, 0)
            icon.AnchorPoint = Vector2.new(0, 0.5)
            icon.BackgroundTransparency = 1
            icon.Image = tabIcon
            icon.ImageColor3 = theme.SubText
            icon.Parent = tabBtn
        end

        -- Tab content scroll
        local scroll = Instance.new("ScrollingFrame")
        scroll.Name = tabName .. "_Content"
        scroll.Size = UDim2.new(1, 0, 1, 0)
        scroll.BackgroundTransparency = 1
        scroll.BorderSizePixel = 0
        scroll.ScrollBarThickness = 3
        scroll.ScrollBarImageColor3 = theme.Accent
        scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
        scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
        scroll.Visible = false
        scroll.Parent = contentArea

        local contentLayout = Instance.new("UIListLayout")
        contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        contentLayout.Padding = UDim.new(0, 6)
        contentLayout.Parent = scroll
        addPadding(scroll, 6, 6, 8, 8)

        local tabObj = {Scroll = scroll, Name = tabName, Button = tabBtn}

        local function activate()
            for _, t in pairs(tabs) do
                t.Scroll.Visible = false
                tween(t.Button, {BackgroundTransparency = 1}, 0.2)
                for _, child in pairs(t.Button:GetChildren()) do
                    if child:IsA("TextLabel") then
                        tween(child, {TextColor3 = theme.SubText}, 0.2)
                    end
                end
            end
            scroll.Visible = true
            tween(tabBtn, {BackgroundTransparency = 0.8}, 0.2)
            tween(tabLabel, {TextColor3 = theme.Text}, 0.2)
            activeTab = tabObj
        end

        tabBtn.MouseButton1Click:Connect(function()
            ripple(tabBtn, theme)
            activate()
        end)

        tabBtn.MouseEnter:Connect(function()
            if activeTab ~= tabObj then
                tween(tabBtn, {BackgroundTransparency = 0.9}, 0.15)
            end
        end)
        tabBtn.MouseLeave:Connect(function()
            if activeTab ~= tabObj then
                tween(tabBtn, {BackgroundTransparency = 1}, 0.15)
            end
        end)

        table.insert(tabs, tabObj)
        if #tabs == 1 then activate() end

        -- ═══════════════════════════════════════
        -- SECTION
        -- ═══════════════════════════════════════
        local Tab = {}

        function Tab:Section(sName)
            local sec = Instance.new("TextLabel")
            sec.Size = UDim2.new(1, 0, 0, 24)
            sec.BackgroundTransparency = 1
            sec.Text = "  " .. (sName or "Section")
            sec.TextColor3 = theme.Accent
            sec.TextSize = 12
            sec.Font = Enum.Font.GothamBold
            sec.TextXAlignment = Enum.TextXAlignment.Left
            sec.Parent = scroll
        end

        -- ═══════════════════════════════════════
        -- BUTTON
        -- ═══════════════════════════════════════
        function Tab:Button(config)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 36)
            btn.BackgroundColor3 = theme.Secondary
            btn.BorderSizePixel = 0
            btn.Text = ""
            btn.Parent = scroll
            addCorner(btn, 8)
            addStroke(btn, theme.Border, 1)

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -16, 1, 0)
            label.Position = UDim2.new(0, 12, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = config.Name or "Button"
            label.TextColor3 = theme.Text
            label.TextSize = 13
            label.Font = Enum.Font.GothamMedium
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = btn

            btn.MouseEnter:Connect(function()
                tween(btn, {BackgroundColor3 = theme.Accent}, 0.2)
            end)
            btn.MouseLeave:Connect(function()
                tween(btn, {BackgroundColor3 = theme.Secondary}, 0.2)
            end)
            btn.MouseButton1Click:Connect(function()
                ripple(btn, theme)
                if config.Callback then config.Callback() end
            end)

            return {
                SetName = function(_, newText)
                    label.Text = newText
                end,
            }
        end

        -- ═══════════════════════════════════════
        -- TOGGLE
        -- ═══════════════════════════════════════
        function Tab:Toggle(config)
            local state = config.Default or false

            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, 0, 0, 36)
            frame.BackgroundColor3 = theme.Secondary
            frame.BorderSizePixel = 0
            frame.Parent = scroll
            addCorner(frame, 8)
            addStroke(frame, theme.Border, 1)

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -60, 1, 0)
            label.Position = UDim2.new(0, 12, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = config.Name or "Toggle"
            label.TextColor3 = theme.Text
            label.TextSize = 13
            label.Font = Enum.Font.GothamMedium
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = frame

            local toggleBg = Instance.new("Frame")
            toggleBg.Size = UDim2.new(0, 40, 0, 20)
            toggleBg.Position = UDim2.new(1, -50, 0.5, 0)
            toggleBg.AnchorPoint = Vector2.new(0, 0.5)
            toggleBg.BackgroundColor3 = state and theme.Accent or theme.Border
            toggleBg.BorderSizePixel = 0
            toggleBg.Parent = frame
            addCorner(toggleBg, 10)

            local knob = Instance.new("Frame")
            knob.Size = UDim2.new(0, 16, 0, 16)
            knob.Position = state and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
            knob.AnchorPoint = Vector2.new(0, 0.5)
            knob.BackgroundColor3 = theme.Text
            knob.BorderSizePixel = 0
            knob.Parent = toggleBg
            addCorner(knob, 8)

            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.BackgroundTransparency = 1
            btn.Text = ""
            btn.Parent = frame

            btn.MouseButton1Click:Connect(function()
                state = not state
                tween(toggleBg, {BackgroundColor3 = state and theme.Accent or theme.Border}, 0.25)
                tween(knob, {Position = state and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)}, 0.25, Enum.EasingStyle.Back)
                if config.Callback then config.Callback(state) end
            end)

            return {
                Set = function(_, v) 
                    state = v
                    tween(toggleBg, {BackgroundColor3 = state and theme.Accent or theme.Border}, 0.2)
                    tween(knob, {Position = state and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)}, 0.2)
                end,
                Get = function() return state end,
            }
        end

        -- ═══════════════════════════════════════
        -- SLIDER
        -- ═══════════════════════════════════════
        function Tab:Slider(config)
            local min = config.Min or 0
            local max = config.Max or 100
            local val = config.Default or min

            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, 0, 0, 50)
            frame.BackgroundColor3 = theme.Secondary
            frame.BorderSizePixel = 0
            frame.Parent = scroll
            addCorner(frame, 8)
            addStroke(frame, theme.Border, 1)

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.6, 0, 0, 20)
            label.Position = UDim2.new(0, 12, 0, 4)
            label.BackgroundTransparency = 1
            label.Text = config.Name or "Slider"
            label.TextColor3 = theme.Text
            label.TextSize = 13
            label.Font = Enum.Font.GothamMedium
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = frame

            local valLabel = Instance.new("TextLabel")
            valLabel.Size = UDim2.new(0.3, 0, 0, 20)
            valLabel.Position = UDim2.new(0.7, 0, 0, 4)
            valLabel.BackgroundTransparency = 1
            valLabel.Text = tostring(val)
            valLabel.TextColor3 = theme.Accent
            valLabel.TextSize = 13
            valLabel.Font = Enum.Font.GothamBold
            valLabel.TextXAlignment = Enum.TextXAlignment.Right
            valLabel.Parent = frame

            local track = Instance.new("Frame")
            track.Size = UDim2.new(1, -24, 0, 6)
            track.Position = UDim2.new(0, 12, 0, 34)
            track.BackgroundColor3 = theme.Border
            track.BorderSizePixel = 0
            track.Parent = frame
            addCorner(track, 3)

            local fill = Instance.new("Frame")
            fill.Size = UDim2.new((val - min) / (max - min), 0, 1, 0)
            fill.BackgroundColor3 = theme.Accent
            fill.BorderSizePixel = 0
            fill.Parent = track
            addCorner(fill, 3)

            local sliderBtn = Instance.new("TextButton")
            sliderBtn.Size = UDim2.new(1, 0, 1, 10)
            sliderBtn.Position = UDim2.new(0, 0, 0, -5)
            sliderBtn.BackgroundTransparency = 1
            sliderBtn.Text = ""
            sliderBtn.Parent = track

            local sliding = false
            sliderBtn.MouseButton1Down:Connect(function() sliding = true end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = false end
            end)
            RunService.RenderStepped:Connect(function()
                if sliding then
                    local mx = Mouse.X
                    local left = track.AbsolutePosition.X
                    local width = track.AbsoluteSize.X
                    local pct = math.clamp((mx - left) / width, 0, 1)
                    val = math.floor(min + pct * (max - min))
                    fill.Size = UDim2.new(pct, 0, 1, 0)
                    valLabel.Text = tostring(val)
                    if config.Callback then config.Callback(val) end
                end
            end)
        end

        -- ═══════════════════════════════════════
        -- DROPDOWN
        -- ═══════════════════════════════════════
        function Tab:Dropdown(config)
            local items = config.Items or {}
            local isOpen = false

            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, 0, 0, 36)
            frame.BackgroundColor3 = theme.Secondary
            frame.BorderSizePixel = 0
            frame.ClipsDescendants = true
            frame.Parent = scroll
            addCorner(frame, 8)
            addStroke(frame, theme.Border, 1)

            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 36)
            btn.BackgroundTransparency = 1
            btn.Text = ""
            btn.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -36, 1, 0)
            label.Position = UDim2.new(0, 12, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = config.Name or "Select..."
            label.TextColor3 = theme.Text
            label.TextSize = 13
            label.Font = Enum.Font.GothamMedium
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = btn

            local arrow = Instance.new("TextLabel")
            arrow.Size = UDim2.new(0, 20, 0, 36)
            arrow.Position = UDim2.new(1, -28, 0, 0)
            arrow.BackgroundTransparency = 1
            arrow.Text = "▼"
            arrow.TextColor3 = theme.SubText
            arrow.TextSize = 10
            arrow.Font = Enum.Font.GothamBold
            arrow.Parent = btn

            local itemContainer = Instance.new("Frame")
            itemContainer.Size = UDim2.new(1, -8, 0, #items * 30)
            itemContainer.Position = UDim2.new(0, 4, 0, 40)
            itemContainer.BackgroundTransparency = 1
            itemContainer.Parent = frame

            local itemLayout = Instance.new("UIListLayout")
            itemLayout.SortOrder = Enum.SortOrder.LayoutOrder
            itemLayout.Padding = UDim.new(0, 2)
            itemLayout.Parent = itemContainer

            for _, item in pairs(items) do
                local itemBtn = Instance.new("TextButton")
                itemBtn.Size = UDim2.new(1, 0, 0, 28)
                itemBtn.BackgroundColor3 = theme.Primary
                itemBtn.BackgroundTransparency = 0.3
                itemBtn.Text = tostring(item)
                itemBtn.TextColor3 = theme.SubText
                itemBtn.TextSize = 12
                itemBtn.Font = Enum.Font.Gotham
                itemBtn.BorderSizePixel = 0
                itemBtn.Parent = itemContainer
                addCorner(itemBtn, 6)

                itemBtn.MouseEnter:Connect(function()
                    tween(itemBtn, {BackgroundTransparency = 0, TextColor3 = theme.Accent}, 0.15)
                end)
                itemBtn.MouseLeave:Connect(function()
                    tween(itemBtn, {BackgroundTransparency = 0.3, TextColor3 = theme.SubText}, 0.15)
                end)
                itemBtn.MouseButton1Click:Connect(function()
                    label.Text = tostring(item)
                    isOpen = false
                    tween(frame, {Size = UDim2.new(1, 0, 0, 36)}, 0.25, Enum.EasingStyle.Back)
                    arrow.Text = "▼"
                    if config.Callback then config.Callback(item) end
                end)
            end

            btn.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                local targetH = isOpen and (36 + 4 + #items * 30) or 36
                tween(frame, {Size = UDim2.new(1, 0, 0, targetH)}, 0.3, Enum.EasingStyle.Back)
                arrow.Text = isOpen and "▲" or "▼"
            end)

            return {
                SetItems = function(_, newItems)
                    items = newItems
                    -- Clear old items
                    for _, child in ipairs(itemContainer:GetChildren()) do
                        if child:IsA("TextButton") then child:Destroy() end
                    end
                    itemContainer.Size = UDim2.new(1, -8, 0, #items * 30)
                    -- Rebuild items
                    for _, item in pairs(items) do
                        local itemBtn = Instance.new("TextButton")
                        itemBtn.Size = UDim2.new(1, 0, 0, 28)
                        itemBtn.BackgroundColor3 = theme.Primary
                        itemBtn.BackgroundTransparency = 0.3
                        itemBtn.Text = tostring(item)
                        itemBtn.TextColor3 = theme.SubText
                        itemBtn.TextSize = 12
                        itemBtn.Font = Enum.Font.Gotham
                        itemBtn.BorderSizePixel = 0
                        itemBtn.Parent = itemContainer
                        addCorner(itemBtn, 6)

                        itemBtn.MouseEnter:Connect(function()
                            tween(itemBtn, {BackgroundTransparency = 0, TextColor3 = theme.Accent}, 0.15)
                        end)
                        itemBtn.MouseLeave:Connect(function()
                            tween(itemBtn, {BackgroundTransparency = 0.3, TextColor3 = theme.SubText}, 0.15)
                        end)
                        itemBtn.MouseButton1Click:Connect(function()
                            label.Text = tostring(item)
                            isOpen = false
                            tween(frame, {Size = UDim2.new(1, 0, 0, 36)}, 0.25, Enum.EasingStyle.Back)
                            arrow.Text = "▼"
                            if config.Callback then config.Callback(item) end
                        end)
                    end
                    -- Collapse dropdown after refresh
                    if isOpen then
                        isOpen = false
                        tween(frame, {Size = UDim2.new(1, 0, 0, 36)}, 0.25)
                        arrow.Text = "▼"
                    end
                end,
            }
        end

        -- ═══════════════════════════════════════
        -- TEXTBOX
        -- ═══════════════════════════════════════
        function Tab:Textbox(config)
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, 0, 0, 36)
            frame.BackgroundColor3 = theme.Secondary
            frame.BorderSizePixel = 0
            frame.Parent = scroll
            addCorner(frame, 8)
            addStroke(frame, theme.Border, 1)

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.4, 0, 1, 0)
            label.Position = UDim2.new(0, 12, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = config.Name or "Input"
            label.TextColor3 = theme.Text
            label.TextSize = 13
            label.Font = Enum.Font.GothamMedium
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = frame

            local input = Instance.new("TextBox")
            input.Size = UDim2.new(0.55, -12, 0, 26)
            input.Position = UDim2.new(0.45, 0, 0.5, 0)
            input.AnchorPoint = Vector2.new(0, 0.5)
            input.BackgroundColor3 = theme.Primary
            input.BorderSizePixel = 0
            input.Text = config.Default or ""
            input.PlaceholderText = config.Placeholder or "Type..."
            input.TextColor3 = theme.Text
            input.PlaceholderColor3 = theme.SubText
            input.TextSize = 12
            input.Font = Enum.Font.Gotham
            input.ClearTextOnFocus = false
            input.Parent = frame
            addCorner(input, 6)

            input.Focused:Connect(function()
                tween(frame, {BackgroundColor3 = theme.Accent}, 0.2)
                tween(frame, {BackgroundTransparency = 0.85}, 0.2)
            end)
            input.FocusLost:Connect(function(enter)
                tween(frame, {BackgroundColor3 = theme.Secondary, BackgroundTransparency = 0}, 0.2)
                if enter and config.Callback then config.Callback(input.Text) end
            end)
        end

        -- ═══════════════════════════════════════
        -- KEYBIND
        -- ═══════════════════════════════════════
        function Tab:Keybind(config)
            local currentKey = config.Key or Enum.KeyCode.Unknown
            local listening = false

            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, 0, 0, 36)
            frame.BackgroundColor3 = theme.Secondary
            frame.BorderSizePixel = 0
            frame.Parent = scroll
            addCorner(frame, 8)
            addStroke(frame, theme.Border, 1)

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.6, 0, 1, 0)
            label.Position = UDim2.new(0, 12, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = config.Name or "Keybind"
            label.TextColor3 = theme.Text
            label.TextSize = 13
            label.Font = Enum.Font.GothamMedium
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = frame

            local keyBtn = Instance.new("TextButton")
            keyBtn.Size = UDim2.new(0, 70, 0, 26)
            keyBtn.Position = UDim2.new(1, -80, 0.5, 0)
            keyBtn.AnchorPoint = Vector2.new(0, 0.5)
            keyBtn.BackgroundColor3 = theme.Primary
            keyBtn.BorderSizePixel = 0
            keyBtn.Text = currentKey.Name or "None"
            keyBtn.TextColor3 = theme.Accent
            keyBtn.TextSize = 11
            keyBtn.Font = Enum.Font.GothamBold
            keyBtn.Parent = frame
            addCorner(keyBtn, 6)

            keyBtn.MouseButton1Click:Connect(function()
                listening = true
                keyBtn.Text = "..."
                tween(keyBtn, {BackgroundColor3 = theme.Accent}, 0.2)
                tween(keyBtn, {TextColor3 = theme.Primary}, 0.2)
            end)

            UserInputService.InputBegan:Connect(function(input, gpe)
                if listening and input.UserInputType == Enum.UserInputType.Keyboard then
                    currentKey = input.KeyCode
                    keyBtn.Text = currentKey.Name
                    listening = false
                    tween(keyBtn, {BackgroundColor3 = theme.Primary, TextColor3 = theme.Accent}, 0.2)
                    if config.Callback then config.Callback(currentKey) end
                end
                if not listening and input.KeyCode == currentKey and not gpe then
                    if config.OnPress then config.OnPress() end
                end
            end)
        end

        return Tab
    end

    -- ═══════════════════════════════════════
    -- NOTIFICATION
    -- ═══════════════════════════════════════
    function Window:Notify(config)
        local notif = Instance.new("Frame")
        notif.Size = UDim2.new(0, 280, 0, 70)
        notif.Position = UDim2.new(1, 300, 1, -80)
        notif.AnchorPoint = Vector2.new(1, 1)
        notif.BackgroundColor3 = theme.Secondary
        notif.BorderSizePixel = 0
        notif.Parent = gui
        addCorner(notif, 10)
        addStroke(notif, theme.Accent, 1)

        local accent = Instance.new("Frame")
        accent.Size = UDim2.new(0, 4, 0.7, 0)
        accent.Position = UDim2.new(0, 8, 0.15, 0)
        accent.BackgroundColor3 = theme.Accent
        accent.BorderSizePixel = 0
        accent.Parent = notif
        addCorner(accent, 2)

        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -30, 0, 22)
        title.Position = UDim2.new(0, 20, 0, 8)
        title.BackgroundTransparency = 1
        title.Text = config.Title or "Notification"
        title.TextColor3 = theme.Accent
        title.TextSize = 14
        title.Font = Enum.Font.GothamBold
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Parent = notif

        local msg = Instance.new("TextLabel")
        msg.Size = UDim2.new(1, -30, 0, 30)
        msg.Position = UDim2.new(0, 20, 0, 30)
        msg.BackgroundTransparency = 1
        msg.Text = config.Text or ""
        msg.TextColor3 = theme.SubText
        msg.TextSize = 12
        msg.Font = Enum.Font.Gotham
        msg.TextXAlignment = Enum.TextXAlignment.Left
        msg.TextWrapped = true
        msg.Parent = notif

        -- Slide in
        tween(notif, {Position = UDim2.new(1, -20, 1, -80)}, 0.4, Enum.EasingStyle.Back)
        task.delay(config.Duration or 3, function()
            tween(notif, {Position = UDim2.new(1, 300, 1, -80)}, 0.3)
            task.wait(0.3)
            notif:Destroy()
        end)
    end

    -- ═══════════════════════════════════════
    -- PROMPT
    -- ═══════════════════════════════════════
    function Window:Prompt(config)
        local overlay = Instance.new("Frame")
        overlay.Size = UDim2.new(1, 0, 1, 0)
        overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        overlay.BackgroundTransparency = 1
        overlay.BorderSizePixel = 0
        overlay.ZIndex = 100
        overlay.Parent = gui
        tween(overlay, {BackgroundTransparency = 0.5}, 0.3)

        local box = Instance.new("Frame")
        box.Size = UDim2.new(0, 300, 0, 140)
        box.Position = UDim2.new(0.5, 0, 0.5, 0)
        box.AnchorPoint = Vector2.new(0.5, 0.5)
        box.BackgroundColor3 = theme.Secondary
        box.BorderSizePixel = 0
        box.ZIndex = 101
        box.Parent = overlay
        addCorner(box, 12)
        addStroke(box, theme.Accent, 1)

        box.Size = UDim2.new(0, 0, 0, 0)
        tween(box, {Size = UDim2.new(0, 300, 0, 140)}, 0.35, Enum.EasingStyle.Back)

        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 30)
        title.Position = UDim2.new(0, 0, 0, 12)
        title.BackgroundTransparency = 1
        title.Text = config.Title or "Confirm"
        title.TextColor3 = theme.Accent
        title.TextSize = 16
        title.Font = Enum.Font.GothamBold
        title.ZIndex = 102
        title.Parent = box

        local msg = Instance.new("TextLabel")
        msg.Size = UDim2.new(1, -20, 0, 40)
        msg.Position = UDim2.new(0, 10, 0, 42)
        msg.BackgroundTransparency = 1
        msg.Text = config.Text or ""
        msg.TextColor3 = theme.Text
        msg.TextSize = 13
        msg.Font = Enum.Font.Gotham
        msg.TextWrapped = true
        msg.ZIndex = 102
        msg.Parent = box

        local yesBtn = Instance.new("TextButton")
        yesBtn.Size = UDim2.new(0.42, 0, 0, 32)
        yesBtn.Position = UDim2.new(0.06, 0, 1, -42)
        yesBtn.BackgroundColor3 = theme.Accent
        yesBtn.Text = "Confirm"
        yesBtn.TextColor3 = theme.Primary
        yesBtn.TextSize = 13
        yesBtn.Font = Enum.Font.GothamBold
        yesBtn.BorderSizePixel = 0
        yesBtn.ZIndex = 102
        yesBtn.Parent = box
        addCorner(yesBtn, 8)

        local noBtn = Instance.new("TextButton")
        noBtn.Size = UDim2.new(0.42, 0, 0, 32)
        noBtn.Position = UDim2.new(0.52, 0, 1, -42)
        noBtn.BackgroundColor3 = theme.Border
        noBtn.Text = "Cancel"
        noBtn.TextColor3 = theme.SubText
        noBtn.TextSize = 13
        noBtn.Font = Enum.Font.GothamBold
        noBtn.BorderSizePixel = 0
        noBtn.ZIndex = 102
        noBtn.Parent = box
        addCorner(noBtn, 8)

        local function close()
            tween(box, {Size = UDim2.new(0, 0, 0, 0)}, 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In)
            tween(overlay, {BackgroundTransparency = 1}, 0.25)
            task.wait(0.25)
            overlay:Destroy()
        end

        yesBtn.MouseButton1Click:Connect(function()
            if config.OnConfirm then config.OnConfirm() end
            close()
        end)
        noBtn.MouseButton1Click:Connect(function()
            if config.OnCancel then config.OnCancel() end
            close()
        end)
    end

    return Window
end

print("✦ NovaLib UI Library loaded successfully!")
return Nova
