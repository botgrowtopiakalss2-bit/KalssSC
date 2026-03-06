-- ================================================
--   MainScript.lua - KalssSC
--   File induk, memanggil semua module
-- ================================================

local BASE = "https://raw.githubusercontent.com/botgrowtopiakalss2-bit/KalssSC/main/"

-- Shared global table untuk komunikasi antar file
_G.KalssUI = {}

local function load(path)
    local ok, err = pcall(function()
        loadstring(game:HttpGet(BASE .. path, true))()
    end)
    if not ok then
        warn("[KalssSC] ❌ Gagal load " .. path .. ": " .. tostring(err))
    else
        print("[KalssSC] ✅ " .. path)
    end
end

-- Urutan load penting! UI dulu, baru Tabs
load("UI/Window.lua")
load("UI/Components.lua")
load("Tabs/Home.lua")
load("Tabs/AutoFarm.lua")
load("Tabs/ESP.lua")
load("Tabs/Settings.lua")

print("[KalssSC] 🎉 Semua file berhasil diload!")StatusLabel.Position = UDim2.new(0, 10, 0, 155)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "✅ Script loaded dari GitHub!"
StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
StatusLabel.TextSize = 13
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = MainFrame

print("[MyGUI] Script berhasil diload!")
