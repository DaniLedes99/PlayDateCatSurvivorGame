import "tinydog"
import "bigdog"
import "spider"

local pd <const> = playdate
local gfx <const> = pd.graphics

local spawnTimer

-- enemySpawner.lua

allEnemies = {}  -- Inicializa la lista de enemigos como una tabla vacía


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
    local enemyType = math.random()
    local newEnemy

    if enemyType < 0.33 then
        newEnemy = BigDog(430, spawnPosition, 1)
    elseif enemyType < 0.66 then
        newEnemy = TinyDog(430, spawnPosition, 1)
    else
        newEnemy = Spider(430, spawnPosition, 2, 30, 0.1)
    end

    table.insert(allEnemies, newEnemy)
end


function stopSpawner()
    if spawnTimer then
        spawnTimer:remove()
    end
end

function clearEnemies()
    -- Asumiendo que `Enemy` es una clase base y todos los enemigos están en una lista
    for _, enemy in pairs(allEnemies) do
        enemy:remove()  -- Asegúrate de que `remove` está llamando a `self:remove()` para eliminar el sprite
    end
    allEnemies = {}  -- Limpia la lista de enemigos
end

function resetGame()
    resetScore()
    clearEnemies()
    stopSpawner()
    startSpawner()
    setShakeAmount(10)
end