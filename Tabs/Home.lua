-- ================================================
--   Tabs/Home.lua - KalssSC
-- ================================================

local RunService  = game:GetService("RunService")
local Players     = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local K = getgenv().KalssUI

local HomeFrame = K.makeTabFrame("Home")

-- WELCOME CARD
local WelcomeCard = Instance.new("Frame")
WelcomeCard.Size             = UDim2.new(1, -30, 0, 80)
WelcomeCard.Position         = UDim2.new(0, 15, 0, 14)
WelcomeCard.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
WelcomeCard.BorderSizePixel  = 0
WelcomeCard.ZIndex           = 3
WelcomeCard.Parent           = HomeFrame
K.makeCorner(WelcomeCard, 10)

local Accent = Instance.new("Frame")
Accent.Size             = UDim2.new(0, 3, 0.7, 0)
Accent.Position         = UDim2.new(0, 0, 0.15, 0)
Accent.BackgroundColor3 = K.RAINBOW[5]
Accent.BorderSizePixel  = 0
Accent.ZIndex           = 4
Accent.Parent           = WelcomeCard
K.makeCorner(Accent, 2)

local WTitle = Instance.new("TextLabel")
WTitle.Size                  = UDim2.new(1, -20, 0, 24)
WTitle.Position              = UDim2.new(0, 16, 0, 14)
WTitle.BackgroundTransparency = 1
WTitle.Text                  = "Welcome, " .. LocalPlayer.DisplayName
WTitle.TextColor3            = Color3.fromRGB(220, 220, 235)
WTitle.TextSize              = 14
WTitle.Font                  = Enum.Font.GothamBold
WTitle.TextXAlignment        = Enum.TextXAlignment.Left
WTitle.ZIndex                = 4
WTitle.Parent                = WelcomeCard

local WSub = Instance.new("TextLabel")
WSub.Size                  = UDim2.new(1, -20, 0, 16)
WSub.Position              = UDim2.new(0, 16, 0, 40)
WSub.BackgroundTransparency = 1
WSub.Text                  = "KalssSC " .. K.CONFIG.Version .. "  •  Script loaded ✓"
WSub.TextColor3            = Color3.fromRGB(80, 80, 100)
WSub.TextSize              = 10
WSub.Font                  = Enum.Font.Gotham
WSub.TextXAlignment        = Enum.TextXAlignment.Left
WSub.ZIndex                = 4
WSub.Parent                = WelcomeCard

-- STAT CARDS
local statData = {
    { label = "Ping",   value = "—ms",  color = K.RAINBOW[4] },
    { label = "FPS",    value = "—fps", color = K.RAINBOW[2] },
    { label = "Status", value = "ON",   color = K.RAINBOW[3] },
}

local pingVal, fpsVal

for i, stat in ipairs(statData) do
    local card = Instance.new("Frame")
    card.Size             = UDim2.new(0, 88, 0, 54)
    card.Position         = UDim2.new(0, 15 + (i-1) * 96, 0, 106)
    card.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
    card.BorderSizePixel  = 0
    card.ZIndex           = 3
    card.Parent           = HomeFrame
    K.makeCorner(card, 10)

    local val = Instance.new("TextLabel")
    val.Size                  = UDim2.new(1, 0, 0, 24)
    val.Position              = UDim2.new(0, 0, 0, 8)
    val.BackgroundTransparency = 1
    val.Text                  = stat.value
    val.TextColor3            = stat.color
    val.TextSize              = 16
    val.Font                  = Enum.Font.GothamBold
    val.ZIndex                = 4
    val.Parent                = card

    local lbl = Instance.new("TextLabel")
    lbl.Size                  = UDim2.new(1, 0, 0, 14)
    lbl.Position              = UDim2.new(0, 0, 0, 32)
    lbl.BackgroundTransparency = 1
    lbl.Text                  = stat.label
    lbl.TextColor3            = Color3.fromRGB(70, 70, 90)
    lbl.TextSize              = 9
    lbl.Font                  = Enum.Font.GothamBold
    lbl.ZIndex                = 4
    lbl.Parent                = card

    if stat.label == "Ping" then pingVal = val end
    if stat.label == "FPS"  then fpsVal  = val end
end

local lastTick = tick()
RunService.Heartbeat:Connect(function()
    if pingVal then pingVal.Text = math.floor(LocalPlayer:GetNetworkPing() * 1000) .. "ms" end
    if fpsVal  then
        local dt = tick() - lastTick
        if dt > 0 then fpsVal.Text = math.floor(1 / dt) .. "fps" end
        lastTick = tick()
    end
end)

print("[KalssSC] Home tab loaded!")    if stat.label == "Ping" then pingVal = val end
    if stat.label == "FPS"  then fpsVal  = val end
end

-- Live update
local lastTick = tick()
RunService.Heartbeat:Connect(function()
    if pingVal then
        pingVal.Text = math.floor(LocalPlayer:GetNetworkPing() * 1000) .. "ms"
    end
    if fpsVal then
        local dt = tick() - lastTick
        if dt > 0 then fpsVal.Text = math.floor(1 / dt) .. "fps" end
        lastTick = tick()
    end
end)
