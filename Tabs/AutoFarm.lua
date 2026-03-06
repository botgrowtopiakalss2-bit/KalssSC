-- ================================================
--   Tabs/AutoFarm.lua - KalssSC
-- ================================================

local K = getgenv().KalssUI
local FarmFrame = K.makeTabFrame("AutoFarm")

K.sectionHeader(FarmFrame, "Auto Farm", 14)
K.makeToggle(FarmFrame, "Auto Farm",    30,  false, function(s) print("[AutoFarm] "    .. (s and "ON" or "OFF")) end)
K.makeToggle(FarmFrame, "Auto Collect", 70,  false, function(s) print("[AutoCollect] " .. (s and "ON" or "OFF")) end)
K.makeToggle(FarmFrame, "Auto Respawn", 110, false, function(s) print("[AutoRespawn] " .. (s and "ON" or "OFF")) end)

K.sectionHeader(FarmFrame, "Options", 154)
K.makeToggle(FarmFrame, "Anti AFK",    170, true,  function(s) print("[AntiAFK] "    .. (s and "ON" or "OFF")) end)
K.makeToggle(FarmFrame, "Speed Boost", 210, false, function(s) print("[SpeedBoost] " .. (s and "ON" or "OFF")) end)

print("[KalssSC] AutoFarm tab loaded!")
