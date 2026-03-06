-- ================================================
--   Loader.lua
--   Script ini yang kamu paste di Roblox Executor
--   Ganti GITHUB_RAW_URL dengan link Raw GitHub kamu
-- ================================================

local GITHUB_RAW_URL = "https://github.com/botgrowtopiakalss2-bit/KalssSC/blob/main/MainScript.lua"
--                                                    ^^^^^^^^  ^^^^^^^^^^ ^^^^
--                                                    Ganti dengan username, repo, dan branch kamu

-- Load dan jalankan script dari GitHub
local success, result = pcall(function()
    return loadstring(game:HttpGet(GITHUB_RAW_URL, true))()
end)

if success then
    print("[Loader] ✅ Script berhasil diload dari GitHub!")
else
    warn("[Loader] ❌ Gagal load script: " .. tostring(result))
end
