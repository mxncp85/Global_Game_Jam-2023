Client.OnStart = function()

    -- Defines a function to drop
    -- the player above the map.
    dropPlayer = function()
        Player.Position = Number3(Map.Width * 0.5, Map.Height + 10, Map.Depth * 0.5) * Map.Scale
        Player.Rotation = { 0, 0, 0 }
        Player.Velocity = { 0, 0, 0 }
    end

	Player.RightArm.IgnoreAnimations = true
	Player.RightHand.IgnoreAnimations = true
	Player.LeftArm.IgnoreAnimations = true
	Player.LeftHand.IgnoreAnimations = true
	Player.RightArm.Rotation.Y = 0
	Player.RightArm.Rotation.X = 0
	Player.RightArm.LocalRotation.Z = math.pi / -2
	Player.LeftArm.Rotation.Y = 0
	Player.LeftArm.Rotation.X = 0
	Player.LeftArm.LocalRotation.Z = math.pi / 2

    World:AddChild(Player)

    -- Call dropPlayer function:
    dropPlayer()
	Player:EquipRightHand(Items.k40s.mug)
end

Client.Action2 = function()
    timerAnimHandEnd = Timer(0.1, false, function()
    end)
      Player.RightArm.LocalRotation.Z = 0
      Player.RightArm.dt = 0.0
      local animTime = 0.2
  
      Player.RightArm.Tick = function(o, dt)
          o.dt = o.dt + dt
          local pct = o.dt / animTime
          if pct >= 1.0 then
              pct = 1.0
          end
  
          pct = math.sin(pct * math.pi)
          o.LocalRotation.Y = math.pi * -0.5 * pct
      end
      timerAnimHandEnd = Timer(0.1, false, function()
          Player.RightArm.LocalRotation.Z = math.pi / -2
      end)
  end
  
  Client.Action3 = function()
    timerAnimLeftHandEnd = Timer(0.1, false, function()
    end)
      Player.LeftArm.LocalRotation.Z = 3 * math.pi / 2
      Player.LeftHand.LocalRotation.X = math.pi
      Player.LeftArm.LocalRotation.X = math.pi / 6
      Player.LeftArm.dt = 0.0
      local animTime = 0.2
  
      Player.LeftArm.Tick = function(o, dt)
          o.dt = o.dt + dt
          local pct = o.dt / animTime
          if pct >= 1.0 then
              pct = 1.0
          end
  
          pct = pct ^ 4
          o.LocalRotation.X = math.pi / 6
          o.LocalRotation.Z = ((3 * math.pi)/2) - (math.pi / 2.5) * 2.5 * -pct
      end
  
  -- Position de fin du bras du player (a voir)
      timerAnimLeftHandEnd = Timer(0.1, false, function()
          Player.LeftArm.LocalRotation.Z = math.pi / 2.5
          Player.LeftArm.LocalRotation.Y = 0
          Player.LeftHand.LocalRotation.X = math.pi
      end)
  end