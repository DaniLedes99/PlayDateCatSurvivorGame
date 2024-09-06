local pd <const> = playdate
local gfx <const> = pd.graphics

class('Spider').extends(Enemy)

function Spider:init(x, y, moveSpeed, amplitude, frequency)
    
    Enemy.init(self, x, y, moveSpeed)


    assert(amplitude and frequency, "amplitude and frequency must be provided")
    
    -- Cargar la imagen para el Spider
    self.image = gfx.image.new("images/enemy")
    self:setImage(self.image)
    
    -- Configurar parámetros específicos
    self.amplitude = amplitude
    self.frequency = frequency
    self.startY = y
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
