import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "player"
import "enemy"
import "enemySpawner"
import "scoreDisplay"
import "screenShake"
import "enemySpawner"


local pd <const> = playdate
local gfx <const> = pd.graphics

local screenShakeSprite = ScreenShake()

function Game()
    resetScore()
    clearEnemies()
    stopSpawner()
    startSpawner()
    setShakeAmount(10)
end

function setShakeAmount(amount)
    screenShakeSprite:setShakeAmount(amount)
end

createScoreDisplay()
Player(30, 120)
startSpawner()


function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
end