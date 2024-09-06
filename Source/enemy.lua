local pd <const> = playdate
local gfx <const> = pd.graphics

class('Enemy').extends(gfx.sprite)

function Enemy:init(x, y, moveSpeed)
    -- Configurar la posición y añadir el sprite
    self:moveTo(x, y)
    self:add()

    -- Configurar el rectángulo de colisión
    self:setCollideRect(0, 0, self:getSize())

    -- Configurar la velocidad de movimiento
    self.moveSpeed = moveSpeed
end

function Enemy:update()
    -- Método abstracto que debe ser implementado por las clases derivadas
    assert(false, "update() must be implemented by subclasses")
end

function Enemy:collisionResponse()
    return "overlap"
end
