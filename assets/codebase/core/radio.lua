radio = class("radio")

local possibleFrequencies = {
	15, 35, 65, 84
}

function radio:initialize()
	self.songs = {
		love.audio.newSource("assets/sfx/christmas1.ogg", "static"),
		love.audio.newSource("assets/sfx/christmas2.ogg", "static"),
		love.audio.newSource("assets/sfx/pop1.ogg", "static"),
		love.audio.newSource("assets/sfx/pop2.ogg", "static")
	}

	self.noise = love.audio.newSource("assets/sfx/noise.wav", "static")
	self.noise:setVolume(0)
	self.noise:setLooping(true)
	self.noise:play()

	self.frequencies = {}


	for i,v in pairs(self.songs) do
		v:setVolume(0)
		v:setLooping(true)
		v:play()

		local n = math.random(1, #possibleFrequencies)
		table.insert(self.frequencies, possibleFrequencies[n])
		table.remove(possibleFrequencies, n)
	end		
end

function radio:update(frequency, dt)
	for i,v in pairs(self.songs) do
		if math.abs(frequency - self.frequencies[i]) < 10 then 
			v:setVolume(1 - math.abs(frequency - self.frequencies[i]) / 10)
			self.noise:setVolume(math.abs(frequency - self.frequencies[i]) / 10)
		else
			v:setVolume(0)
		end

		local n = math.random(-8, 10) * dt
		for i,v in pairs(self.frequencies) do
			self.frequencies[i] = self.frequencies[i] + n
			if self.frequencies[i] > 100 then 
				self.frequencies[i] = 1
			elseif self.frequencies[i] < 0 then 
				self.frequencies[i] = 99
			end
		end	
	end	

end

function radio:draw()
	local str = ""
	for i, v in pairs(self.frequencies) do
		str = str.. math.floor(v).. ", "
	end
	love.graphics.print(str, 0, 15)
end