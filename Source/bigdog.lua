local pd <const> = playdate
local gfx <const> = pd.graphics

class('BigDog').extends(Enemy)

function BigDog:init(x, y, moveSpeed)
    
    Enemy.init(self, x, y, moveSpeed)

    -- Cargar las imágenes para la animación del BigDog
    self.images = {
        gfx.image.new("images/bigdog1"),
        gfx.image.new("images/bigdog2"),
        gfx.image.new("images/bigdog3")
    }

    -- Inicializar el índice de la imagen y establecer la primera imagen
    self.currentImageIndex = 1
    self:setImage(self.images[self.currentImageIndex])

    -- Inicializar el temporizador de animación
    self.animationDelay = 200
    self:startAnimationTimer()
end

function BigDog:update()
    -- Mover el BigDog
    self:moveBy(-self.moveSpeed, 0)
    
    -- Reiniciar el juego si el BigDog sale de pantalla
    if self.x < 0 then
        resetGame()
    end
end

function BigDog:startAnimationTimer()
    -- Función para actualizar la animación
    local function animate()
        -- Actualizar la imagen del BigDog para la animación
        self.currentImageIndex = (self.currentImageIndex % #self.images) + 1
        self:setImage(self.images[self.currentImageIndex])
        
        -- Reconfigurar el temporizador de animación
        self.animationTimer = pd.timer.performAfterDelay(self.animationDelay, animate)
    end
    
    -- Iniciar el temporizador de animación
    self.animationTimer = pd.timer.performAfterDelay(self.animationDelay, animate)
end
