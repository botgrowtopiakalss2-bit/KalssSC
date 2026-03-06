-- ================================================
--   Tabs/AutoFarm.lua - KalssSC
--   Tab Auto Farm
-- ================================================

local makeTabFrame  = _G.KalssUI.makeTabFrame
local sectionHeader = _G.KalssUI.sectionHeader
local makeToggle    = _G.KalssUI.makeToggle

local FarmFrame = makeTabFrame("AutoFarm")

sectionHeader(FarmFrame, "Auto Farm", 14)
makeToggle(FarmFrame, "Auto Farm",    30,  false, function(s) print("[AutoFarm] "    .. (s and "ON" or "OFF")) end)
makeToggle(FarmFrame, "Auto Collect", 70,  false, function(s) print("[AutoCollect] " .. (s and "ON" or "OFF")) end)
makeToggle(FarmFrame, "Auto Respawn", 110, false, function(s) print("[AutoRespawn] " .. (s and "ON" or "OFF")) end)

sectionHeader(FarmFrame, "Options", 154)
makeToggle(FarmFrame, "Anti AFK",     170, true,  function(s) print("[AntiAFK] "     .. (s and "ON" or "OFF")) end)
makeToggle(FarmFrame, "Speed Boost",  210, false, function(s) print("[SpeedBoost] "  .. (s and "ON" or "OFF")) end)
