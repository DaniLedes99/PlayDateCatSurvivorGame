import "tinydog"
import "bigdog"
import "spider"

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
    local enemyType = math.random()
    if enemyType < 0.33 then
        -- Crear una instancia de BigDog y agregarla a la vista
        local bigDog = BigDog(430, spawnPosition, 1)
        bigDog:add()
    elseif enemyType < 0.66 then
        -- Crear una instancia de TinyDog y agregarla a la vista
        local tinyDog = TinyDog(430, spawnPosition, 1)
        tinyDog:add()
    else
        -- Crear una instancia de Spider con la posición de inicio aleatoria
        local spider = Spider(430, spawnPosition, 2, 50, 0.05)
        spider:add()
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
