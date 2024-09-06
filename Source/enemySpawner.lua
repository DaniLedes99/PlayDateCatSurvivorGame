import "tinydog"
import "bigdog"

local pd <const> = playdate
local gfx <const> = pd.graphics

local spawnTimer

function startSpawner()
    math.randomseed(pd.getSecondsSinceEpoch())
    createTimer()
    printTable(pd.timer.allTimers())
end

function createTimer()
    local spawnTime = math.random(500, 1000)
    spawnTimer = pd.timer.performAfterDelay(spawnTime, function ()
        createTimer()
        spawnEnemy()
    end)
end

function spawnEnemy()
    local spawnPosition = math.random(10, 230)
    
    -- Decidir aleatoriamente qué tipo de enemigo spawn
    if math.random() < 0.5 then
        BigDog(430, spawnPosition, 1)
    else
        local tinyDog = TinyDog(430, spawnPosition, 1)
    end
end

function stopSpawner()
    if spawnTimer then
        spawnTimer:remove()
    end
end

function clearEnemies()
    local allSprites = gfx.sprite.getAllSprites()
    for index, sprite in ipairs(allSprites) do
        if sprite:isa(BigDog) or sprite:isa(TinyDog) then
            sprite:remove()
        end
    end
end
