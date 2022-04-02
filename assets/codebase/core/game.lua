game = class("game")

local radioImage = love.graphics.newImage("assets/gfx/radio.png")	
local knobImage = love.graphics.newImage("assets/gfx/knob.png")

local knobAngle = 0
local tuning = false

local startDragY = 0
local startAngle = 0
local startDirection = 1

function game:initialize()
	self.frequency = 15
	self.time = 0

	self.radio = radio:new()
end

function game:update(dt)

	game:handleKnob()

	self.time = self.time + dt

	self.radio:update(self.frequency, dt)


end

function game:draw()
	love.graphics.draw(radioImage, 100, 100)
	love.graphics.draw(knobImage, 650 + knobImage:getWidth()/2, 500 + knobImage:getHeight()/2, knobAngle, 1, 1, knobImage:getWidth()/2, knobImage:getHeight()/2)

	game:drawSine()

	love.graphics.print(self.frequency)

	game.radio:draw()


end



function game:drawSine()
	local line = {}
	for i = 1, 230, 3 do
		table.insert(line, 210 + i)
		table.insert(line, 315 + math.sin(i + self.time * 3) * (math.sin(self.frequency / 10) * 20))
	end

	love.graphics.setLineWidth(3)
	love.graphics.setColor(24/255, 36/255, 25/255)
	love.graphics.line(line)
	love.graphics.setColor(1,1,1)
end

function game:handleKnob()
	local mouseX, mouseY = love.mouse.getPosition()
	local isDown = love.mouse.isDown(1)

	if isDown then 
		if not tuning and rectCollision(mouseX, mouseY, 1, 1, 650, 500, 115, 155) then -- Slide knob
			tuning = true
			startDragY = mouseY	
			startAngle = knobAngle

			startDirection = 1
			if mouseX > 650 + 115/2 then 
				startDirection = -1
			end
		end
	else
		tuning = false
	end

	if tuning then 
		knobAngle = startAngle + (startDragY - mouseY) / 60 * startDirection
	end
end	


function game:mousemoved(x, y, dx, dy)
	if tuning then 
		self.frequency = self.frequency + dy / 10 * startDirection
	end	
end






function rectCollision(x1, y1, w1, h1, x2, y2, w2, h2)
	return x1 + w1 > x2 and x1 < x2 + w2 and y1 + h1 > y2 and y1 < y2 + h2
end

