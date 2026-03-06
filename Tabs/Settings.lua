-- ================================================
--   Tabs/Settings.lua - KalssSC
--   Tab Settings
-- ================================================

local makeTabFrame  = _G.KalssUI.makeTabFrame
local sectionHeader = _G.KalssUI.sectionHeader
local makeToggle    = _G.KalssUI.makeToggle
local makeCorner    = _G.KalssUI.makeCorner
local CONFIG        = _G.KalssUI.CONFIG

local SetFrame = makeTabFrame("Settings")

sectionHeader(SetFrame, "Interface", 14)
makeToggle(SetFrame, "Rainbow Border", 30, true, function(s)
    _G.KalssUI.RainbowBorder = s
end)
makeToggle(SetFrame, "Notifications", 70, true, function(s)
    print("[Notif] " .. (s and "ON" or "OFF"))
end)

sectionHeader(SetFrame, "Script", 114)
makeToggle(SetFrame, "Auto Execute", 130, false, function(s)
    print("[AutoExec] " .. (s and "ON" or "OFF"))
end)

-- Info card
local InfoCard = Instance.new("Frame")
InfoCard.Size = UDim2.new(1, -30, 0, 44)
InfoCard.Position = UDim2.new(0, 15, 0, 210)
InfoCard.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
InfoCard.BorderSizePixel = 0
InfoCard.ZIndex = 3
InfoCard.Parent = SetFrame
makeCorner(InfoCard, 8)

local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(1, -20, 1, 0)
InfoText.Position = UDim2.new(0, 10, 0, 0)
InfoText.BackgroundTransparency = 1
InfoText.Text = "KalssSC " .. CONFIG.Version .. "  |  github.com/botgrowtopiakalss2-bit/KalssSC"
InfoText.TextColor3 = Color3.fromRGB(60, 60, 80)
InfoText.TextSize = 9
InfoText.Font = Enum.Font.Gotham
InfoText.TextXAlignment = Enum.TextXAlignment.Left
InfoText.ZIndex = 4
InfoText.Parent = InfoCard
