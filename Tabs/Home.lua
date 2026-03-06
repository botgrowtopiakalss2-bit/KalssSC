-- ================================================
--   Tabs/Home.lua - KalssSC
--   Tab Home: welcome card + live ping & fps
-- ================================================

local RunService  = game:GetService("RunService")
local Players     = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local makeTabFrame = _G.KalssUI.makeTabFrame
local RAINBOW      = _G.KalssUI.RAINBOW
local makeCorner   = _G.KalssUI.makeCorner
local CONFIG       = _G.KalssUI.CONFIG

local HomeFrame = makeTabFrame("Home")

-- ================================================
-- WELCOME CARD
-- ================================================
local WelcomeCard = Instance.new("Frame")
WelcomeCard.Size = UDim2.new(1, -30, 0, 80)
WelcomeCard.Position = UDim2.new(0, 15, 0, 14)
WelcomeCard.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
WelcomeCard.BorderSizePixel = 0
WelcomeCard.ZIndex = 3
WelcomeCard.Parent = HomeFrame
makeCorner(WelcomeCard, 10)

local WelcomeAccent = Instance.new("Frame")
WelcomeAccent.Size = UDim2.new(0, 3, 0.7, 0)
WelcomeAccent.Position = UDim2.new(0, 0, 0.15, 0)
WelcomeAccent.BackgroundColor3 = RAINBOW[5]
WelcomeAccent.BorderSizePixel = 0
WelcomeAccent.ZIndex = 4
WelcomeAccent.Parent = WelcomeCard
makeCorner(WelcomeAccent, 2)

local WelcomeTitle = Instance.new("TextLabel")
WelcomeTitle.Size = UDim2.new(1, -20, 0, 24)
WelcomeTitle.Position = UDim2.new(0, 16, 0, 14)
WelcomeTitle.BackgroundTransparency = 1
WelcomeTitle.Text = "Welcome, " .. LocalPlayer.DisplayName
WelcomeTitle.TextColor3 = Color3.fromRGB(220, 220, 235)
WelcomeTitle.TextSize = 14
WelcomeTitle.Font = Enum.Font.GothamBold
WelcomeTitle.TextXAlignment = Enum.TextXAlignment.Left
WelcomeTitle.ZIndex = 4
WelcomeTitle.Parent = WelcomeCard

local WelcomeSub = Instance.new("TextLabel")
WelcomeSub.Size = UDim2.new(1, -20, 0, 16)
WelcomeSub.Position = UDim2.new(0, 16, 0, 40)
WelcomeSub.BackgroundTransparency = 1
WelcomeSub.Text = "KalssSC " .. CONFIG.Version .. "  •  Script loaded ✓"
WelcomeSub.TextColor3 = Color3.fromRGB(80, 80, 100)
WelcomeSub.TextSize = 10
WelcomeSub.Font = Enum.Font.Gotham
WelcomeSub.TextXAlignment = Enum.TextXAlignment.Left
WelcomeSub.ZIndex = 4
WelcomeSub.Parent = WelcomeCard

-- ================================================
-- STAT CARDS
-- ================================================
local statData = {
    { label = "Ping",   value = "—ms",  color = RAINBOW[4] },
    { label = "FPS",    value = "—fps", color = RAINBOW[2] },
    { label = "Status", value = "ON",   color = RAINBOW[3] },
}

local pingVal, fpsVal

for i, stat in ipairs(statData) do
    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, 88, 0, 54)
    card.Position = UDim2.new(0, 15 + (i-1) * 96, 0, 106)
    card.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
    card.BorderSizePixel = 0
    card.ZIndex = 3
    card.Parent = HomeFrame
    makeCorner(card, 10)

    local val = Instance.new("TextLabel")
    val.Size = UDim2.new(1, 0, 0, 24)
    val.Position = UDim2.new(0, 0, 0, 8)
    val.BackgroundTransparency = 1
    val.Text = stat.value
    val.TextColor3 = stat.color
    val.TextSize = 16
    val.Font = Enum.Font.GothamBold
    val.ZIndex = 4
    val.Parent = card

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 14)
    lbl.Position = UDim2.new(0, 0, 0, 32)
    lbl.BackgroundTransparency = 1
    lbl.Text = stat.label
    lbl.TextColor3 = Color3.fromRGB(70, 70, 90)
    lbl.TextSize = 9
    lbl.Font = Enum.Font.GothamBold
    lbl.ZIndex = 4
    lbl.Parent = card

    if stat.label == "Ping" then pingVal = val end
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
