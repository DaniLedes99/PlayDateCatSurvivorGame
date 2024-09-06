import "bullet"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Player').extends(gfx.sprite)

local playerImages = {
    right = {
        gfx.image.new("images/cat222"),
        gfx.image.new("images/cat3333")
    },
    left = {
        gfx.image.new("images/catreverse/cat222"),
        gfx.image.new("images/catreverse/cat3333")
    }
}

local playerImageDefaultRight = gfx.image.new("images/cat3333")
local playerImageDefaultLeft = gfx.image.new("images/catreverse/cat3333")

local frameTimer = 0
local frameDelay = 4
local currentFrame = 1

function Player:init(x, y)
    self:setImage(playerImageDefaultRight) -- Inicialmente mirando a la derecha
    self:moveTo(x, y)
    self:add()

    self.speed = 3
    self.direction = "right" -- Inicialmente mirando a la derecha
end

function Player:update()
    frameTimer = frameTimer + 1
    local moving = false

    -- Movimiento del personaje
    if pd.buttonIsPressed(pd.kButtonUp) then
        if self.y > 0 then
            self:moveBy(0, -self.speed)
            self.direction = "up"
            moving = true
        end

    elseif pd.buttonIsPressed(pd.kButtonDown) then
        if self.y < 240 then
            self:moveBy(0, self.speed)
            self.direction = "down"
            moving = true
        end

    elseif pd.buttonIsPressed(pd.kButtonLeft) then
        if self.x > 0 then
            self:moveBy(-self.speed, 0)
            self.direction = "left"
            moving = true
        end

    elseif pd.buttonIsPressed(pd.kButtonRight) then
        if self.x < 400 then
            self:moveBy(self.speed, 0)
            self.direction = "right"
            moving = true
        end

    else
        -- No se está moviendo
        if not moving then
            -- Mantener la imagen actual de acuerdo a la dirección
            if self.direction == "left" then
                self:setImage(playerImageDefaultLeft)
            else
                self:setImage(playerImageDefaultRight)
            end
        end
    end

    -- Actualización de la animación
    if moving then
        local images = playerImages[self.direction] or playerImages.right

        if frameTimer >= frameDelay then
            frameTimer = 0
            currentFrame = (currentFrame % #images) + 1
            self:setImage(images[currentFrame])
        end
    end

    -- Disparar bala (sin animación de disparo)
    if pd.buttonJustPressed(pd.kButtonA) then
        Bullet(self.x, self.y, self.direction, 8)
    end
end
