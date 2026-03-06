-- ================================================
--   Loader.lua
--   Paste INI di Delta Executor lalu Execute
-- ================================================

local GITHUB_RAW_URL = "https://raw.githubusercontent.com/botgrowtopiakalss2-bit/KalssSC/main/MainScript.lua"

local success, result = pcall(function()
    return loadstring(game:HttpGet(GITHUB_RAW_URL, true))()
end)

if success then
    print("[KalssSC] ✅ Loaded!")
else
    warn("[KalssSC] ❌ Error: " .. tostring(result))
end
