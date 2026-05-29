-- Crouching Meditation Mod - Project Zomboid 42.13+
-- Script untuk handle crouching stats reduction dengan floating text notifikasi
-- Fatigue: -3% setiap 5 detik | Panic: -2% setiap 5 detik

local FATIGUE_REDUCTION = 0.03     -- 3% per 5 detik
local PANIC_REDUCTION = 0.02       -- 2% per 5 detik
local UPDATE_INTERVAL = 5.0        -- Update setiap 5 detik

-- Table untuk tracking timer per player
local crouchTimers = {}

-- Fungsi untuk mendapatkan player
local function getPlayer(playerIndex)
    return getSpecificPlayer(playerIndex or 0)
end

-- Fungsi untuk cek apakah player sedang jongkok
local function isPlayerCrouching(player)
    if not player then return false end
    return player:isCrouching()
end

-- Fungsi untuk tampilkan floating text
local function showFloatingText(player, text, color)
    if not player then return end
    
    -- Buat floating text di atas kepala player
    local x = player:getX()
    local y = player:getY()
    local z = player:getZ()
    
    -- Tambah offset agar floating text muncul di atas kepala
    local floatingText = FloatingText:new(x, y - 0.5, z, text)
    getCell():addObjectToGrid(floatingText, x, y, z)
end

-- Fungsi utama untuk reduce stats saat jongkok
local function reduceStatsWhileCrouching(playerIndex)
    local player = getPlayer(playerIndex)
    if not player or player:isDead() then 
        crouchTimers[playerIndex] = nil
        return 
    end
    
    -- Initialize timer untuk player ini jika belum ada
    if not crouchTimers[playerIndex] then
        crouchTimers[playerIndex] = 0
    end
    
    -- Cek apakah player sedang jongkok
    if isPlayerCrouching(player) then
        crouchTimers[playerIndex] = crouchTimers[playerIndex] + 1
        
        -- Jika sudah mencapai 5 detik (sesuai UPDATE_INTERVAL)
        if crouchTimers[playerIndex] >= UPDATE_INTERVAL then
            local bodyDamage = player:getBodyDamage()
            
            -- Kurangi Fatigue (kelelahan)
            local fatigue = bodyDamage:getTiredness()
            if fatigue > 0 then
                local fatigueReduction = fatigue * FATIGUE_REDUCTION
                bodyDamage:setTiredness(math.max(0, fatigue - fatigueReduction))
                
                -- Tampilkan floating text untuk fatigue
                showFloatingText(player, "-" .. string.format("%.1f", fatigueReduction) .. " Fatigue", "green")
            end
            
            -- Kurangi Panic
            local panic = bodyDamage:getPanic()
            if panic > 0 then
                local panicReduction = panic * PANIC_REDUCTION
                bodyDamage:setPanic(math.max(0, panic - panicReduction))
                
                -- Tampilkan floating text untuk panic
                showFloatingText(player, "-" .. string.format("%.1f", panicReduction) .. " Panic", "blue")
            end
            
            -- Reset timer
            crouchTimers[playerIndex] = 0
        end
    else
        -- Reset timer jika tidak jongkok
        crouchTimers[playerIndex] = 0
    end
end

-- Event listener untuk setiap update game (dipanggil setiap 1 detik)
local function onGameStart()
    Events.OnTick.Add(function()
        for i = 0, getNumPlayers() - 1 do
            reduceStatsWhileCrouching(i)
        end
    end)
end

-- Register event saat game dimulai
if isClient() then
    Events.OnGameStart.Add(onGameStart)
end

-- Cleanup saat player disconnect
local function onPlayerDeath(playerIndex)
    crouchTimers[playerIndex] = nil
end

if isClient() then
    Events.OnPlayerDeath.Add(onPlayerDeath)
end