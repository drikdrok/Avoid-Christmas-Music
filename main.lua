math.randomseed(os.time())

require("assets/codebase/core/require")

function love.load()
	game = game:new()
end

function love.update(dt)
	game:update(dt)
end

function love.draw()
	game:draw()
end

function love.keypressed(key)
	if key == "escape" then 
		love.event.quit()
	end
end


function love.mousemoved(x, y, dx, dy)
	game:mousemoved(x, y, dx, dy)
end