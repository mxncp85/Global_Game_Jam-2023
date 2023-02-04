
Client.OnStart = function()

    kMonsterSpawnMinDistance = 50
	kMonsterSpawnMaxDistance = 75
	
	kMonsterSpawnHeight = 15

	kMonsterSpeed = 35

    monstersOn = false
	monsters = {} -- no monsters at start
	killedMonsters = {} -- recycle bin

    --\\\\\\\\\\\\\\--
    --to help understand how the movements works
    function spawnMonster()
		
		local delta = Number3(math.random(kMonsterSpawnMinDistance, kMonsterSpawnMaxDistance), 0, math.random(kMonsterSpawnMinDistance, kMonsterSpawnMaxDistance))
		delta:Rotate(Number3(0, math.random() * math.pi * 2, 0))

		local monster = Shape(Items.olivbleu.termite)
		monster.Scale = 2
		monster.Physics = true
		monster.Pivot = {monster.Width * 0.5, 0, monster.Depth * 0.5}
		monster.Position = Player.Position + delta + Number3(0, kMonsterSpawnHeight, 0)
		monster.Rotation = {0, math.pi, 0}

		World:AddChild(monster)

		table.insert(monsters, monster)
	end
    --//////////////--
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