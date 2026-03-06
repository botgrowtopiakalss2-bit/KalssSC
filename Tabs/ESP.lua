-- ================================================
--   Tabs/ESP.lua - KalssSC
--   Tab ESP / Visuals
-- ================================================

local makeTabFrame  = _G.KalssUI.makeTabFrame
local sectionHeader = _G.KalssUI.sectionHeader
local makeToggle    = _G.KalssUI.makeToggle

local EspFrame = makeTabFrame("ESP")

sectionHeader(EspFrame, "Visuals", 14)
makeToggle(EspFrame, "Player ESP", 30,  false, function(s) print("[PlayerESP] " .. (s and "ON" or "OFF")) end)
makeToggle(EspFrame, "Name Tags",  70,  false, function(s) print("[NameTags] "  .. (s and "ON" or "OFF")) end)
makeToggle(EspFrame, "Health Bar", 110, false, function(s) print("[HealthBar] " .. (s and "ON" or "OFF")) end)

sectionHeader(EspFrame, "World", 154)
makeToggle(EspFrame, "Item ESP",   170, false, function(s) print("[ItemESP] "   .. (s and "ON" or "OFF")) end)
makeToggle(EspFrame, "Fullbright", 210, false, function(s)
    local Lighting = game:GetService("Lighting")
    if s then
        Lighting.Brightness = 5
        Lighting.ClockTime  = 14
    else
        Lighting.Brightness = 1
        Lighting.ClockTime  = 14
    end
end)
