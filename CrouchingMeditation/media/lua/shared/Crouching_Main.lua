-- Crouching Meditation Mod untuk Project Zomboid 42.13
-- Script utama untuk reduce stats saat jongkok

local FATIGUE_REDUCTION = 0.03  -- 3% fatigue per 5 detik
local PANIC_REDUCTION = 0.02    -- 2% panic per 5 detik
local TIMER = 0
local INTERVAL = 150  -- 5 detik (150 ticks @ 30 ticks/sec)

local function OnTick()
    local player = getPlayer()
    if not player or player:isDead() then return end
    
    TIMER = TIMER + 1
    
    if player:isCrouching() then
        if TIMER >= INTERVAL then
            local bodyDamage = player:getBodyDamage()
            
            -- Reduce Fatigue
            local fatigue = bodyDamage:getTiredness()
            if fatigue > 0 then
                local reduction = fatigue * FATIGUE_REDUCTION
                bodyDamage:setTiredness(math.max(0, fatigue - reduction))
            end
            
            -- Reduce Panic
            local panic = bodyDamage:getPanic()
            if panic > 0 then
                local reduction = panic * PANIC_REDUCTION
                bodyDamage:setPanic(math.max(0, panic - reduction))
            end
            
            TIMER = 0
        end
    else
        TIMER = 0
    end
end

Events.OnTick.Add(OnTick)