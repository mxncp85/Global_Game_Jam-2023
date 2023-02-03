Client.OnStart = function()

    -- dropPlayer = function()

	Player.RightArm.IgnoreAnimations = true
	Player.RightHand.IgnoreAnimations = true
	Player.LeftArm.IgnoreAnimations = true
	Player.LeftHand.IgnoreAnimations = true

    --World:AddChild(Player)

end

Client.Action2 = function()
    Player:SwingLeft()
  end
  
Client.Action3 = function()
    Player:SwingRight()
end