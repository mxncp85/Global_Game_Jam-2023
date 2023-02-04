
Client.OnStart = function()

    kMonsterSpawnMinDistance = 50
	kMonsterSpawnMaxDistance = 75
	
	kMonsterSpawnHeight = 15

	kMonsterSpeed = 35

    monstersOn = false
	monsters = {} -- no monsters at start
	killedMonsters = {} -- recycle bin

    kPlayerHeight = 10.5 -- 2.1 map cubes
	kPlayerHalfWidth = 2.0
	kPlayerHalfDepth = 2.0

    function collides(shape)
		
		local playerMin = Number3(Player.Position.X - kPlayerHalfWidth,
								  Player.Position.Y,
								  Player.Position.Z - kPlayerHalfDepth)

		local playerMax = Number3(Player.Position.X + kPlayerHalfWidth,
								  Player.Position.Y + kPlayerHeight,
								  Player.Position.Z + kPlayerHalfDepth)

		local halfSize = (shape.Width > shape.Depth
						 and shape.Width * 0.5
						 or shape.Depth * 0.5) * shape.LocalScale.X

		local shapeMin = Number3(shape.Position.X - halfSize,
								 shape.Position.Y,
								 shape.Position.Z - halfSize)

		local shapeMax = Number3(shape.Position.X + halfSize,
								 shape.Position.Y + shape.Height * shape.LocalScale.X,
								 shape.Position.Z + halfSize)

		if playerMax.X > shapeMin.X and
		   playerMin.X < shapeMax.X and
		   playerMax.Y > shapeMin.Y and
		   playerMin.Y < shapeMax.Y and
		   playerMax.Z > shapeMin.Z and
		   playerMin.Z < shapeMax.Z then

		   	return true
		end

		return false
	end
end

Client.Tick = function(dt)

    for i, monster in ipairs(monsters) do

        -- monsters always look at player
        -- TODO: fix
        monster.Left = Number3(monster.Position.X, 0, monster.Position.Z) - Number3(Player.Position.X, 0, Player.Position.Z)

        if inControl() and collides(monster) then

            monster.Velocity.X = 0
            monster.Velocity.Z = 0

            takeDamage(monster)

        elseif math.abs(monster.Position.X - Player.Position.X) <= 100 and math.abs(monster.Position.Y - Player.Position.Y) <= 100 and math.abs(monster.Position.Z - Player.Position.Z) <= 100 and monster.IsOnGround then
                local jumpVelocity
                jumpVelocity = -Number3(monster.Left.X, monster.Left.Y, monster.Left.Z)
                jumpVelocity = jumpVelocity * kMonsterSpeed
                monster.Velocity = jumpVelocity
        end
    end
end