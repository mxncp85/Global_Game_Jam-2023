Config = {
	Items = { 
				"k40s.mug", 
				"k40s.indic_side",
				"k40s.head_fourmis",
				"k40s.body_fourmis",
				"k40s.hands_fourmis",
				"k40s.feet_fourmis",
				"k40s.lefthand_fourmis" }
}

Client.OnStart = function()

    dropPlayer = function()
        Player.Position = Number3(Map.Width * 0.5, Map.Height + 10, Map.Depth * 0.5) * Map.Scale
        Player.Rotation = { 0, 0, 0 }
        Player.Velocity = { 0, 0, 0 }
    end

	Timer(3.0, function()
		Player.RightArm.IsHiddenSelf = true
		Player.RightArm:GetChild(1).IsHiddenSelf = true
		Player.RightHand.IsHiddenSelf = true

		Player.LeftArm.IsHiddenSelf = true
		Player.LeftArm:GetChild(1).IsHiddenSelf = true
		Player.LeftHand.IsHiddenSelf = true

		Player.Head.IsHiddenSelf = true
		Player.Head:GetChild(1).IsHiddenSelf = true

		Player.Body.IsHiddenSelf = true
		Player.Body:GetChild(1).IsHiddenSelf = true

		Player.LeftLeg.IsHiddenSelf = true
		Player.LeftLeg:GetChild(1).IsHiddenSelf = true
		Player.LeftLeg:GetChild(2).IsHiddenSelf = true

		Player.RightLeg.IsHiddenSelf = true
		Player.RightLeg:GetChild(1).IsHiddenSelf = true
		Player.RightLeg:GetChild(2).IsHiddenSelf = true

		equipments = require("equipments")
		equipments.unloadAll(Player)

		local leftLegShape = Shape(Items.k40s.feet_fourmis)
		Player.LeftLeg:AddChild(leftLegShape)
		leftLegShape.LocalPosition = {0, -2, 0}

		local rightLegShape = Shape(Items.k40s.feet_fourmis)
		Player.RightLeg:AddChild(rightLegShape)
		rightLegShape.LocalPosition = {0, -2, 0}

		local bodyShape = Shape(Items.k40s.body_fourmis)
		Player.Body:AddChild(bodyShape)
		bodyShape.LocalPosition = {1, 5, 0}

		Player:EquipHat(Items.k40s.head_fourmis)
		Player:EquipRightHand(Items.k40s.hands_fourmis)
	end)
	Player.RightArm.IgnoreAnimations = true
	Player.RightHand.IgnoreAnimations = true
	Player.LeftArm.IgnoreAnimations = true
	Player.LeftHand.IgnoreAnimations = true
	Player.RightArm.LocalRotation.Y = 0
	Player.RightArm.LocalRotation.X = 0
	Player.RightArm.LocalRotation.Z = math.pi / -2
	Player.LeftArm.LocalRotation.Y = 0
	Player.LeftArm.LocalRotation.X = 0
	Player.LeftArm.LocalRotation.Z = -math.pi / 2

    World:AddChild(Player)
    dropPlayer()
end

Client.Action2 = function()
  timerAnimRightHandEnd = Timer(0.1, false, function()
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
	timerAnimRightHandEnd = Timer(0.1, false, function()
		Player.RightArm.LocalRotation.Z = math.pi / -2
    end)
end

Client.Action3 = function()
    --Empty fction
end
