PLUGIN.RadZones = PLUGIN.RadZones or {}
PLUGIN.Rate = 1

function PLUGIN:Initialize()

	timer.Create("RadTick", self.Rate, 0, RadTick)
end

local function RadTick()
	print("radTick")
	for radPos, radData in pairs(self.RadZones) do
		for _, ply in pairs(player.GetAll()) do
			local radDistance = ply:GetPos():Distance(radPos)
			if radDistance <= radData.radius then
				ply:giveRads(radData.maxRads * (radDistance / radData.radius)) 
			end
		end
	end
end

function DEBUG_createRadZone(inputOrigin, inputRadius, inputMaxRads, inputHalfLife)
	self.RadZones[inputOrigin] = {
		radius = inputRadius,
		maxRads = inputMaxRads,
		halfLife = inputHalfLife
	}

	local radZone = self.RadZones[inputOrigin]

	if halfLife then
		timer.Simple(halfLife*2, function()
			radZone = nil
		end)
	end
end

