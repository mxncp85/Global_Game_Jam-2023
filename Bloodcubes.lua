Config = {
	Map = "...",
	Items = {
		"aduermael.blood_cube",
		}
}

Client.OnStart = function()
    
    -- cubes for blood
    bloodCubes = {}
    nextBloodCube = 1
    nextDisappearBloodCube = 1
    timeNextDisappearCube = 5
    bloodCubesNumber = 40
    --augment spilled blood cube number to have more blood
    spilledBloodCubesNumber = 10
    for i = 1,bloodCubesNumber do
        local b = Shape(Items.aduermael.blood_cube)
        b.Position = {-1000, -1000, -1000}
        b.Scale = 0.2
        b.Pivot = {0.5, 0.5, 0.5}
        b.CollisionGroupsMask = 4
        b.CollidesWithMask = 1
        table.insert(bloodCubes, b)
        Map:AddChild(b)
    end

    --functions about the blood cubes
    function spillBlood(position, force)
		local bloodCube

		for i = 1,spilledBloodCubesNumber do
			Map:AddChild(bloodCubes[nextBloodCube])
			bloodCube = bloodCubes[nextBloodCube]
			bloodCube.Physics = true
			bloodCube.Position = position
			bloodCube.Velocity = {0, 0, force == nil and 150 or force}
			bloodCube.Velocity:Rotate({math.random() * math.pi * 2, math.random() * math.pi * 2, 0.0})

			nextBloodCube = nextBloodCube + 1
			if nextBloodCube > #bloodCubes then
				nextBloodCube = 1
			end
		end
	end

	function unDisplayBloodCube()
		if timeNextDisappearCube <= 0 then
			bloodCubes[nextDisappearBloodCube]:RemoveFromParent()
			timeNextDisappearCube = 5
		else
			timeNextDisappearCube = timeNextDisappearCube - 1
		end
	end

end

Client.Tick = function(dt)
    
    nextDisappearBloodCube = math.random(1, bloodCubesNumber)
	unDisplayBloodCube()

    --\\\\\\\\\\\--
    --to put when a termite die, so like in the function thet takes it in charge
    spillBlood(monster.Position)
    --///////////--
end