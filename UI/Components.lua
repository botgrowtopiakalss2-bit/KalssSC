-- ================================================
--   UI/Components.lua - KalssSC
--   Helper functions: toggle, section header, tab system
-- ================================================

local tween       = _G.KalssUI.tween
local makeCorner  = _G.KalssUI.makeCorner
local RAINBOW     = _G.KalssUI.RAINBOW
local Sidebar     = _G.KalssUI.Sidebar
local ContentArea = _G.KalssUI.ContentArea
local TabButtons  = _G.KalssUI.TabButtons
local Tabs        = _G.KalssUI.Tabs

-- ================================================
-- SECTION HEADER
-- ================================================
local function sectionHeader(parent, text, yPos)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -30, 0, 14)
    lbl.Position = UDim2.new(0, 15, 0, yPos)
    lbl.BackgroundTransparency = 1
    lbl.Text = string.upper(text)
    lbl.TextColor3 = Color3.fromRGB(80, 80, 100)
    lbl.TextSize = 9
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 3
    lbl.Parent = parent
    return lbl
end

-- ================================================
-- TOGGLE
-- ================================================
local function makeToggle(parent, labelText, yPos, defaultOn, onToggle)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -30, 0, 34)
    Container.Position = UDim2.new(0, 15, 0, yPos)
    Container.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    Container.BorderSizePixel = 0
    Container.ZIndex = 3
    Container.Parent = parent
    makeCorner(Container, 8)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = labelText
    Label.TextColor3 = Color3.fromRGB(190, 190, 210)
    Label.TextSize = 12
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 4
    Label.Parent = Container

    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(0, 34, 0, 18)
    Track.Position = UDim2.new(1, -46, 0.5, -9)
    Track.BackgroundColor3 = defaultOn and Color3.fromRGB(60, 180, 100) or Color3.fromRGB(40, 40, 50)
    Track.BorderSizePixel = 0
    Track.ZIndex = 4
    Track.Parent = Container
    makeCorner(Track, 9)

    local Thumb = Instance.new("Frame")
    Thumb.Size = UDim2.new(0, 12, 0, 12)
    Thumb.Position = defaultOn and UDim2.new(0, 19, 0.5, -6) or UDim2.new(0, 3, 0.5, -6)
    Thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Thumb.BorderSizePixel = 0
    Thumb.ZIndex = 5
    Thumb.Parent = Track
    makeCorner(Thumb, 6)

    local isOn = defaultOn
    local ClickArea = Instance.new("TextButton")
    ClickArea.Size = UDim2.new(1, 0, 1, 0)
    ClickArea.BackgroundTransparency = 1
    ClickArea.Text = ""
    ClickArea.ZIndex = 6
    ClickArea.Parent = Container

    ClickArea.MouseButton1Click:Connect(function()
        isOn = not isOn
        tween(Track, {BackgroundColor3 = isOn and Color3.fromRGB(60, 180, 100) or Color3.fromRGB(40, 40, 50)}, 0.2)
        tween(Thumb, {Position = isOn and UDim2.new(0, 19, 0.5, -6) or UDim2.new(0, 3, 0.5, -6)}, 0.2)
        if onToggle then onToggle(isOn) end
    end)

    return Container
end

-- ================================================
-- TAB FRAME FACTORY
-- ================================================
local function makeTabFrame(name)
    local f = Instance.new("Frame")
    f.Name = name
    f.Size = UDim2.new(1, 0, 1, 0)
    f.BackgroundTransparency = 1
    f.Visible = false
    f.ZIndex = 2
    f.Parent = ContentArea
    Tabs[name] = f
    return f
end

-- ================================================
-- ACTIVATE TAB
-- ================================================
local function activateTab(name)
    if _G.KalssUI.ActiveTab == name then return end
    _G.KalssUI.ActiveTab = name

    for tabName, tabUI in pairs(TabButtons) do
        local isActive = (tabName == name)
        tween(tabUI.btn,   {BackgroundColor3 = isActive and Color3.fromRGB(22, 22, 28) or Color3.fromRGB(20, 20, 24)}, 0.2)
        tween(tabUI.bar,   {BackgroundTransparency = isActive and 0 or 1}, 0.2)
        tween(tabUI.icon,  {TextColor3 = isActive and tabUI.color or Color3.fromRGB(90, 90, 110)}, 0.2)
        tween(tabUI.label, {TextColor3 = isActive and Color3.fromRGB(220, 220, 230) or Color3.fromRGB(90, 90, 110)}, 0.2)
    end

    for tabName, frame in pairs(Tabs) do
        frame.Visible = (tabName == name)
    end
end

-- ================================================
-- TAB BUTTON FACTORY
-- FIX: Pakai AbsolutePosition manual, bukan UIListLayout
-- ================================================
local TAB_DATA = {
    { name = "Home",     icon = "⌂", color = RAINBOW[5] },
    { name = "AutoFarm", icon = "⚡", color = RAINBOW[2] },
    { name = "ESP",      icon = "◈",  color = RAINBOW[4] },
    { name = "Settings", icon = "⚙", color = RAINBOW[6] },
}

-- Hapus UIListLayout dan UIPadding lama dari Sidebar supaya tidak konflik
for _, child in ipairs(Sidebar:GetChildren()) do
    if child:IsA("UIListLayout") or child:IsA("UIPadding") then
        child:Destroy()
    end
end

for i, data in ipairs(TAB_DATA) do
    local btn = Instance.new("TextButton")
    btn.Name = data.name .. "Tab"
    btn.Size = UDim2.new(1, -16, 0, 36)
    -- Posisi manual: mulai dari y=10, tiap tab jarak 40px
    btn.Position = UDim2.new(0, 8, 0, 10 + (i - 1) * 40)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
    btn.Text = ""
    btn.BorderSizePixel = 0
    btn.ZIndex = 3
    btn.Parent = Sidebar
    makeCorner(btn, 8)

    local ActiveBar = Instance.new("Frame")
    ActiveBar.Size = UDim2.new(0, 3, 0.6, 0)
    ActiveBar.Position = UDim2.new(0, 0, 0.2, 0)
    ActiveBar.BackgroundColor3 = data.color
    ActiveBar.BorderSizePixel = 0
    ActiveBar.BackgroundTransparency = 1
    ActiveBar.ZIndex = 4
    ActiveBar.Parent = btn
    makeCorner(ActiveBar, 2)

    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.new(0, 22, 1, 0)
    Icon.Position = UDim2.new(0, 8, 0, 0)
    Icon.BackgroundTransparency = 1
    Icon.Text = data.icon
    Icon.TextColor3 = Color3.fromRGB(90, 90, 110)
    Icon.TextSize = 14
    Icon.Font = Enum.Font.GothamBold
    Icon.ZIndex = 4
    Icon.Parent = btn

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -34, 1, 0)
    Label.Position = UDim2.new(0, 32, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = data.name
    Label.TextColor3 = Color3.fromRGB(90, 90, 110)
    Label.TextSize = 11
    Label.Font = Enum.Font.GothamBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 4
    Label.Parent = btn

    TabButtons[data.name] = {btn = btn, bar = ActiveBar, icon = Icon, label = Label, color = data.color}

    btn.MouseButton1Click:Connect(function()
        activateTab(data.name)
    end)
end

-- ================================================
-- SIMPAN KE GLOBAL
-- ================================================
_G.KalssUI.sectionHeader = sectionHeader
_G.KalssUI.makeToggle    = makeToggle
_G.KalssUI.makeTabFrame  = makeTabFrame
_G.KalssUI.activateTab   = activateTab

-- Default tab
activateTab("Home")    Tabs[name] = f
    return f
end

-- ================================================
-- ACTIVATE TAB
-- ================================================
local function activateTab(name)
    if _G.KalssUI.ActiveTab == name then return end
    _G.KalssUI.ActiveTab = name

    for tabName, tabUI in pairs(TabButtons) do
        local isActive = (tabName == name)
        tween(tabUI.btn,   {BackgroundColor3 = isActive and Color3.fromRGB(22, 22, 28) or Color3.fromRGB(20, 20, 24)}, 0.2)
        tween(tabUI.bar,   {BackgroundTransparency = isActive and 0 or 1}, 0.2)
        tween(tabUI.icon,  {TextColor3 = isActive and tabUI.color or Color3.fromRGB(90, 90, 110)}, 0.2)
        tween(tabUI.label, {TextColor3 = isActive and Color3.fromRGB(220, 220, 230) or Color3.fromRGB(90, 90, 110)}, 0.2)
    end

    for tabName, frame in pairs(Tabs) do
        frame.Visible = (tabName == name)
    end
end

-- ================================================
-- TAB BUTTON FACTORY
-- ================================================
local TAB_DATA = {
    { name = "Home",     icon = "⌂", color = RAINBOW[5] },
    { name = "AutoFarm", icon = "⚡", color = RAINBOW[2] },
    { name = "ESP",      icon = "◈",  color = RAINBOW[4] },
    { name = "Settings", icon = "⚙", color = RAINBOW[6] },
}

for _, data in ipairs(TAB_DATA) do
    local btn = Instance.new("TextButton")
    btn.Name = data.name .. "Tab"
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
    btn.Text = ""
    btn.BorderSizePixel = 0
    btn.ZIndex = 3
    btn.Parent = Sidebar
    makeCorner(btn, 8)

    local ActiveBar = Instance.new("Frame")
    ActiveBar.Size = UDim2.new(0, 3, 0.6, 0)
    ActiveBar.Position = UDim2.new(0, 0, 0.2, 0)
    ActiveBar.BackgroundColor3 = data.color
    ActiveBar.BorderSizePixel = 0
    ActiveBar.BackgroundTransparency = 1
    ActiveBar.ZIndex = 4
    ActiveBar.Parent = btn
    makeCorner(ActiveBar, 2)

    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.new(0, 22, 1, 0)
    Icon.Position = UDim2.new(0, 8, 0, 0)
    Icon.BackgroundTransparency = 1
    Icon.Text = data.icon
    Icon.TextColor3 = Color3.fromRGB(90, 90, 110)
    Icon.TextSize = 14
    Icon.Font = Enum.Font.GothamBold
    Icon.ZIndex = 4
    Icon.Parent = btn

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -34, 1, 0)
    Label.Position = UDim2.new(0, 32, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = data.name
    Label.TextColor3 = Color3.fromRGB(90, 90, 110)
    Label.TextSize = 11
    Label.Font = Enum.Font.GothamBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 4
    Label.Parent = btn

    TabButtons[data.name] = {btn = btn, bar = ActiveBar, icon = Icon, label = Label, color = data.color}

    btn.MouseButton1Click:Connect(function()
        activateTab(data.name)
    end)
end

-- ================================================
-- SIMPAN KE GLOBAL
-- ================================================
_G.KalssUI.sectionHeader = sectionHeader
_G.KalssUI.makeToggle    = makeToggle
_G.KalssUI.makeTabFrame  = makeTabFrame
_G.KalssUI.activateTab   = activateTab
