-- Script untuk handle crouching stats reduction
-- Mekanik: Saat player jongkok, stats ngantuk dan panik berkurang secara bertahap

local TIREDNESS_REDUCTION = 0.02  -- Berkurang 2% per detik saat jongkok
local PANIC_REDUCTION = 0.03      -- Berkurang 3% per detik saat jongkok
local UPDATE_INTERVAL = 1.0       -- Update setiap 1 detik

-- Fungsi untuk mendapatkan player
local function getPlayer(playerIndex)
    return getSpecificPlayer(playerIndex or 0)
end

-- Fungsi untuk cek apakah player sedang jongkok
local function isPlayerCrouching(player)
    if not player then return false end
    return player:isCrouching()
end

-- Fungsi utama untuk reduce stats
local function reduceStatsWhileCrouching(playerIndex)
    local player = getPlayer(playerIndex)
    if not player or player:isDead() then return end
    
    -- Cek apakah sedang jongkok
    if isPlayerCrouching(player) then
        local bodyDamage = player:getBodyDamage()
        
        -- Kurangi rasa ngantuk (tiredness)
        local tiredness = bodyDamage:getTiredness()
        if tiredness > 0 then
            bodyDamage:setTiredness(math.max(0, tiredness - TIREDNESS_REDUCTION))
        end
        
        -- Kurangi rasa panik (panic)
        local panic = bodyDamage:getPanic()
        if panic > 0 then
            bodyDamage:setPanic(math.max(0, panic - PANIC_REDUCTION))
        end
    end
end

-- Event listener untuk setiap update game
local function onGameStart()
    Events.OnTick.Add(function()
        for i = 0, getNumPlayers() - 1 do
            reduceStatsWhileCrouching(i)
        end
    end)
end

-- Register event
if isClient() then
    Events.OnGameStart.Add(onGameStart)
end