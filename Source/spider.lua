local pd <const> = playdate
local gfx <const> = pd.graphics

class('Spider').extends(gfx.sprite)

function Spider:init(x, y, moveSpeed, amplitude, frequency)
    -- Asegúrate de que todos los parámetros están definidos
    assert(amplitude and frequency, "amplitude and frequency must be provided")
    
    -- Cargar la imagen para el Spider
    self.image = gfx.image.new("images/enemy")
    self:setImage(self.image)
    
    -- Configurar la posición y añadir el sprite
    self:moveTo(x, y)
    self:add()

    -- Configurar el rectángulo de colisión
    self:setCollideRect(0, 0, self:getSize())

    -- Configurar velocidad de movimiento y parámetros de la curva
    self.moveSpeed = moveSpeed
    self.amplitude = amplitude  -- Altura máxima de la curva
    self.frequency = frequency  -- Cuánto se repite la curva por unidad de distancia horizontal

    -- Inicializar variables para el movimiento
    self.startX = x
    self.startY = y  -- Asegúrate de que startY esté correctamente inicializado
    self.elapsedTime = 0
end

function Spider:update()
    -- Mover el Spider horizontalmente
    local newX = self.x - self.moveSpeed
    self.elapsedTime = self.elapsedTime + self.moveSpeed

    -- Calcular la nueva posición en Y usando una función senoidal
    local newY = self.startY + (self.amplitude * math.sin(self.elapsedTime * self.frequency))

    -- Aplicar los nuevos valores de X y Y
    self:moveTo(newX, newY)

    -- Reiniciar el juego si el Spider sale de pantalla
    if self.x < 0 then
        resetGame()
    end
end

function Spider:collisionResponse()
    return "overlap"
end
