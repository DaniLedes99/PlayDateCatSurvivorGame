local pd <const> = playdate
local gfx <const> = pd.graphics

class('Bullet').extends(gfx.sprite)

function Bullet:init(x, y, direction, speed)
    local bulletSize = 4
    local bulletImage = gfx.image.new(bulletSize * 2, bulletSize * 2)
    gfx.pushContext(bulletImage)
        gfx.drawCircleAtPoint(bulletSize, bulletSize, bulletSize)
    gfx.popContext()
    self:setImage(bulletImage)

    self:setCollideRect(0, 0, self:getSize())
    self.speed = speed
    self.direction = direction or "right"  -- Por defecto, la bala se mueve hacia la derecha
    self:moveTo(x, y)
    self:add()
end

function Bullet:update()
    if self.direction == "left" then
        self.x = self.x - self.speed
    elseif self.direction == "right" then
        self.x = self.x + self.speed
    elseif self.direction == "up" then
        self.y = self.y - self.speed
    elseif self.direction == "down" then
        self.y = self.y + self.speed
    end


    local actualX, actualY, collisions, length = self:moveWithCollisions(self.x, self.y)
    if length > 0 then
        for index, collision in ipairs(collisions) do
            local collidedObject = collision['other']
            if collidedObject:isa(TinyDog) or collidedObject:isa(BigDog) then
                collidedObject:remove()
                self:remove()  -- Elimina la bala al colisionar
                incrementScore()  -- Asegúrate de que esta función esté definida
                setShakeAmount(5) -- Asegúrate de que esta función esté definida
            end
        end
    elseif self.x < 0 or self.x > 400 or self.y < 0 or self.y > 240 then
        self:remove()
    end
end

