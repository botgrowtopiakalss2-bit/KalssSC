-- ================================================
--   Tabs/ESP.lua - KalssSC
-- ================================================

local K = getgenv().KalssUI
local EspFrame = K.makeTabFrame("ESP")

K.sectionHeader(EspFrame, "Visuals", 14)
K.makeToggle(EspFrame, "Player ESP", 30,  false, function(s) print("[PlayerESP] " .. (s and "ON" or "OFF")) end)
K.makeToggle(EspFrame, "Name Tags",  70,  false, function(s) print("[NameTags] "  .. (s and "ON" or "OFF")) end)
K.makeToggle(EspFrame, "Health Bar", 110, false, function(s) print("[HealthBar] " .. (s and "ON" or "OFF")) end)

K.sectionHeader(EspFrame, "World", 154)
K.makeToggle(EspFrame, "Item ESP",   170, false, function(s) print("[ItemESP] "   .. (s and "ON" or "OFF")) end)
K.makeToggle(EspFrame, "Fullbright", 210, false, function(s)
    local Lighting = game:GetService("Lighting")
    Lighting.Brightness = s and 5 or 1
    Lighting.ClockTime  = 14
end)

print("[KalssSC] ESP tab loaded!")
