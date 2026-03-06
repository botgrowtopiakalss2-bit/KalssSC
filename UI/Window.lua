-- ================================================
--   UI/Window.lua - KalssSC
--   Main window, titlebar, sidebar, content area
-- ================================================

local Players     = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService  = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

-- CONFIG
local CONFIG = {
    Title        = "KalssSC",
    Version      = "v1.0",
    RainbowSpeed = 2,
}

local RAINBOW = {
    Color3.fromRGB(255, 80,  80),
    Color3.fromRGB(255, 160, 60),
    Color3.fromRGB(255, 230, 60),
    Color3.fromRGB(80,  220, 100),
    Color3.fromRGB(60,  180, 255),
    Color3.fromRGB(160, 80,  255),
    Color3.fromRGB(255, 80,  180),
}

-- Simpan ke global supaya file lain bisa akses
_G.KalssUI.CONFIG  = CONFIG
_G.KalssUI.RAINBOW = RAINBOW

-- ================================================
-- UTILITY (disimpan global untuk dipakai semua file)
-- ================================================
local function lerp(a, b, t) return a + (b - a) * t end

local function lerpColor(c1, c2, t)
    return Color3.new(lerp(c1.R, c2.R, t), lerp(c1.G, c2.G, t), lerp(c1.B, c2.B, t))
end

local function getRainbowColor(offset)
    offset = offset or 0
    local t = (tick() * CONFIG.RainbowSpeed + offset) % #RAINBOW
    local i = math.floor(t) + 1
    local nx = (i % #RAINBOW) + 1
    return lerpColor(RAINBOW[i], RAINBOW[nx], t - math.floor(t))
end

local function tween(obj, props, duration)
    TweenService:Create(obj, TweenInfo.new(duration or 0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), props):Play()
end

local function makeCorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = parent
    return c
end

_G.KalssUI.tween      = tween
_G.KalssUI.makeCorner = makeCorner
_G.KalssUI.getRainbowColor = getRainbowColor

-- ================================================
-- DESTROY EXISTING
-- ================================================
if PlayerGui:FindFirstChild("KalssGUI") then
    PlayerGui:FindFirstChild("KalssGUI"):Destroy()
end

-- ================================================
-- SCREENGUI
-- ================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KalssGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = PlayerGui
_G.KalssUI.ScreenGui = ScreenGui

-- ================================================
-- WINDOW
-- ================================================
local Window = Instance.new("Frame")
Window.Name = "Window"
Window.Size = UDim2.new(0, 460, 0, 340)
Window.Position = UDim2.new(0.5, -230, 0.5, -170)
Window.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Window.BorderSizePixel = 0
Window.ClipsDescendants = true
Window.Active = true
Window.Draggable = true
Window.Parent = ScreenGui
makeCorner(Window, 14)
_G.KalssUI.Window = Window

-- Rainbow border
local BorderFrame = Instance.new("Frame")
BorderFrame.Size = UDim2.new(1, 4, 1, 4)
BorderFrame.Position = UDim2.new(0, -2, 0, -2)
BorderFrame.BackgroundColor3 = RAINBOW[1]
BorderFrame.BorderSizePixel = 0
BorderFrame.ZIndex = 0
BorderFrame.Parent = Window
makeCorner(BorderFrame, 16)
_G.KalssUI.BorderFrame = BorderFrame

-- Inner bg
local InnerBG = Instance.new("Frame")
InnerBG.Size = UDim2.new(1, 0, 1, 0)
InnerBG.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
InnerBG.BorderSizePixel = 0
InnerBG.ZIndex = 1
InnerBG.Parent = Window
makeCorner(InnerBG, 14)

-- ================================================
-- TITLE BAR
-- ================================================
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 44)
TitleBar.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 2
TitleBar.Parent = Window

local TitleLine = Instance.new("Frame")
TitleLine.Size = UDim2.new(1, 0, 0, 2)
TitleLine.Position = UDim2.new(0, 0, 1, -2)
TitleLine.BackgroundColor3 = RAINBOW[1]
TitleLine.BorderSizePixel = 0
TitleLine.ZIndex = 3
TitleLine.Parent = TitleBar
_G.KalssUI.TitleLine = TitleLine

local TitleDot = Instance.new("Frame")
TitleDot.Size = UDim2.new(0, 8, 0, 8)
TitleDot.Position = UDim2.new(0, 14, 0.5, -4)
TitleDot.BackgroundColor3 = RAINBOW[1]
TitleDot.BorderSizePixel = 0
TitleDot.ZIndex = 3
TitleDot.Parent = TitleBar
makeCorner(TitleDot, 4)
_G.KalssUI.TitleDot = TitleDot

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 200, 1, 0)
TitleLabel.Position = UDim2.new(0, 28, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = CONFIG.Title
TitleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
TitleLabel.TextSize = 15
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 3
TitleLabel.Parent = TitleBar

local VersionBadge = Instance.new("TextLabel")
VersionBadge.Size = UDim2.new(0, 40, 0, 18)
VersionBadge.Position = UDim2.new(0, 110, 0.5, -9)
VersionBadge.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
VersionBadge.Text = CONFIG.Version
VersionBadge.TextColor3 = Color3.fromRGB(140, 140, 160)
VersionBadge.TextSize = 10
VersionBadge.Font = Enum.Font.GothamBold
VersionBadge.ZIndex = 3
VersionBadge.Parent = TitleBar
makeCorner(VersionBadge, 4)

-- Minimize button
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 28, 0, 28)
MinBtn.Position = UDim2.new(1, -68, 0.5, -14)
MinBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.fromRGB(160, 160, 180)
MinBtn.TextSize = 12
MinBtn.Font = Enum.Font.GothamBold
MinBtn.BorderSizePixel = 0
MinBtn.ZIndex = 3
MinBtn.Parent = TitleBar
makeCorner(MinBtn, 6)

-- Close button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -34, 0.5, -14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(160, 160, 180)
CloseBtn.TextSize = 11
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.ZIndex = 3
CloseBtn.Parent = TitleBar
makeCorner(CloseBtn, 6)

-- Button hover
for _, btn in ipairs({CloseBtn, MinBtn}) do
    btn.MouseEnter:Connect(function() tween(btn, {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}, 0.15) end)
    btn.MouseLeave:Connect(function() tween(btn, {BackgroundColor3 = Color3.fromRGB(28, 28, 34)}, 0.15) end)
end

-- Minimize logic
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    tween(Window, {Size = minimized and UDim2.new(0, 460, 0, 44) or UDim2.new(0, 460, 0, 340)}, 0.3)
end)

-- Close logic
CloseBtn.MouseButton1Click:Connect(function()
    tween(Window, {Size = UDim2.new(0, 460, 0, 0)}, 0.25)
    wait(0.3)
    ScreenGui:Destroy()
end)

-- ================================================
-- SIDEBAR
-- ================================================
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 110, 1, -44)
Sidebar.Position = UDim2.new(0, 0, 0, 44)
Sidebar.BackgroundColor3 = Color3.fromRGB(13, 13, 16)
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 2
Sidebar.Parent = Window
_G.KalssUI.Sidebar = Sidebar

local SidebarLine = Instance.new("Frame")
SidebarLine.Size = UDim2.new(0, 1, 1, 0)
SidebarLine.Position = UDim2.new(1, 0, 0, 0)
SidebarLine.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
SidebarLine.BorderSizePixel = 0
SidebarLine.ZIndex = 3
SidebarLine.Parent = Sidebar

local TabList = Instance.new("UIListLayout")
TabList.FillDirection = Enum.FillDirection.Vertical
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabList.Padding = UDim.new(0, 4)
TabList.Parent = Sidebar

local TabPadding = Instance.new("UIPadding")
TabPadding.PaddingTop = UDim.new(0, 10)
TabPadding.PaddingLeft = UDim.new(0, 8)
TabPadding.PaddingRight = UDim.new(0, 8)
TabPadding.Parent = Sidebar

-- ================================================
-- CONTENT AREA
-- ================================================
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -110, 1, -44)
ContentArea.Position = UDim2.new(0, 110, 0, 44)
ContentArea.BackgroundTransparency = 1
ContentArea.ZIndex = 2
ContentArea.Parent = Window
_G.KalssUI.ContentArea = ContentArea

-- ================================================
-- TAB SYSTEM (global, diisi oleh Components.lua)
-- ================================================
_G.KalssUI.Tabs       = {}
_G.KalssUI.TabButtons = {}
_G.KalssUI.ActiveTab  = nil
_G.KalssUI.RainbowBorder = true

-- ================================================
-- RAINBOW LOOP
-- ================================================
RunService.Heartbeat:Connect(function()
    if not _G.KalssUI.RainbowBorder then return end
    local color = getRainbowColor(0)
    BorderFrame.BackgroundColor3 = color
    TitleLine.BackgroundColor3   = color
    TitleDot.BackgroundColor3    = color
end)
