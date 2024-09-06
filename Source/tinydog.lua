local pd <const> = playdate
local gfx <const> = pd.graphics

class('TinyDog').extends(Enemy)

function TinyDog:init(x, y, moveSpeed)
    Enemy.init(self, x, y, moveSpeed)
   
    -- Cargar las imágenes para la animación del TinyDog
    self.images = {
        gfx.image.new("images/tinydog1"),
        gfx.image.new("images/tinydog2"),
        gfx.image.new("images/tinydog3")
    }
    
    -- Inicializar el índice de la imagen y establecer la primera imagen
    self.currentImageIndex = 1
    self:setImage(self.images[self.currentImageIndex])

    -- Inicializar el temporizador de animación
    self.animationDelay = 200
    self:startAnimationTimer()
end

function TinyDog:update()
    -- Mover el TinyDog
    self:moveBy(-self.moveSpeed, 0)
    
    -- Reiniciar el juego si el TinyDog sale de pantalla
    if self.x < 0 then
        resetGame()
    end
end

function TinyDog:startAnimationTimer()
    -- Función para actualizar la animación
    local function animate()
        -- Actualizar la imagen del TinyDog para la animación
        self.currentImageIndex = (self.currentImageIndex % #self.images) + 1
        self:setImage(self.images[self.currentImageIndex])
        
        -- Reconfigurar el temporizador de animación
        self.animationTimer = pd.timer.performAfterDelay(self.animationDelay, animate)
    end
    
    -- Iniciar el temporizador de animación
    self.animationTimer = pd.timer.performAfterDelay(self.animationDelay, animate)
end
