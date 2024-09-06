local pd <const> = playdate
local gfx <const> = pd.graphics

class('Enemy').extends(gfx.sprite)

function Enemy:init(x, y, moveSpeed)
    -- Cargar las imágenes para la animación
    self.images = {
        gfx.image.new("images/bigdog1"),
        gfx.image.new("images/bigdog2"),
        gfx.image.new("images/bigdog3")
    }
    
    -- Inicializar el índice de la imagen y establecer la primera imagen
    self.currentImageIndex = 1
    self:setImage(self.images[self.currentImageIndex])
    
    -- Configurar la posición y añadir el sprite
    self:moveTo(x, y)
    self:add()

    -- Configurar el rectángulo de colisión
    self:setCollideRect(0, 0, self:getSize())

    -- Configurar velocidad de movimiento
    self.moveSpeed = moveSpeed

    -- Inicializar el temporizador de animación
    self.animationDelay = 200
    self:startAnimationTimer()
end

function Enemy:update()
    -- Mover el enemigo
    self:moveBy(-self.moveSpeed, 0)
    
    -- Reiniciar el juego si el enemigo sale de pantalla
    if self.x < 0 then
        resetGame()
    end
end

function Enemy:collisionResponse()
    return "overlap"
end

function Enemy:startAnimationTimer()
    -- Función para actualizar la animación
    local function animate()
        -- Actualizar la imagen del enemigo para la animación
        self.currentImageIndex = (self.currentImageIndex % #self.images) + 1
        self:setImage(self.images[self.currentImageIndex])
        
        -- Reconfigurar el temporizador de animación
        self.animationTimer = pd.timer.performAfterDelay(self.animationDelay, animate)
    end
    
    -- Iniciar el temporizador de animación
    self.animationTimer = pd.timer.performAfterDelay(self.animationDelay, animate)
end
