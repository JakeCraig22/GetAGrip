local gameDesign = script.Parent.gameDesign
local Open = game.Workspace.GetAGrip.PoleChallenge.Start.ProximityPrompt
local TeleportPart2 = game.Workspace.GetAGrip.PoleChallenge.myFolder.tp2
local GreenLine = gameDesign.GreenLine
local WhiteLine = gameDesign.WhiteLine
local button = gameDesign.gameButton
local pos = 1
local active = false 
local moving = false
--[[
Script enables gui and starts the moving greenline game once the proximity prompt is enabled
]]


local missed = 0
local score = false
local early = false
local speed = 6
local buttonClicker = 0
local MAX_MISSED_ATTEMPTS = 3
local player = game.Players.LocalPlayer 
local Players = game:GetService("Players")
local SingularGui = player.PlayerGui.PoleChallengeGUIs.Pole1Gui

local hum = player.Character:WaitForChild("Humanoid")
local value = 0
debounce = nil


local function moveGreenLine() -- function to move the greenline
	while active == true do 
		if moving == false then
			if pos == 1 then
				moving = true
				GreenLine:TweenPosition(
					UDim2.new(0, 0, 0, 0), -- Endposition
					"Out", -- Easing Direction
					"Linear", -- Easing Style
					speed, -- Time in seconds
					false, -- Override other tweens
					nil
				)
				task.wait(5)
				pos = pos + 1
				if score == false then
					missed = missed + 1
				end
				moving = false
				score = false
				early = false
				print("Missed: "..missed)
			else
				moving = true
				GreenLine:TweenPosition(
					UDim2.new(0.988, 0, 0, 0), -- Endposition
					"Out", -- Easing Direction
					"Linear", -- Easing Style
					speed, -- Time in seconds
					false, -- Override other tweens
					nil
				)
				task.wait(5) 
				pos = pos - 1
				if score == false then
					missed = missed + 1
				end
				moving = false
				score = false
				early = false
				print("Missed: "..missed)
			end
		end
		if missed >= MAX_MISSED_ATTEMPTS then -- when missed over max attempts, game ends
			print("game over")
			gameDesign:Destroy()
			player.Character.HumanoidRootPart.Anchored = false
			player.Character.WalkSpeed = 16
		end
		task.wait(1)
	end
end

local function checkPosition() -- checks position of the greenline to see if it is within the boundaries of the whiteline
	if GreenLine.Position.X.Scale > .478 and GreenLine.Position.X.Scale < .510 then
		if early == false then
			score = true
			WhiteLine.BackgroundColor3 = Color3.fromRGB(38, 255, 5)
			wait(.5)
			WhiteLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		end
	else
		if score == false then
			score = false
			early = true
			gameDesign.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			task.wait(.5)
			gameDesign.BackgroundColor3= Color3.fromRGB(0, 0, 0)
		end
	end
end


Open.Triggered:Connect(function(player)
	if debounce == nil then
		hum.WalkSpeed = 0
		hum.JumpPower = 0
		player.Character:SetPrimaryPartCFrame(TeleportPart2.CFrame + Vector3.new(0, 0, 0))
		player.Character.HumanoidRootPart.Anchored = true
	end
	SingularGui.Enabled = not SingularGui.Enabled -- enables or disables game
	if active == false then
		active = true
	else
		active = false 
	end
	Open.Enabled = false
	wait(5)
	moveGreenLine()
end)

button.MouseButton1Down:Connect(function() -- speeds up the line as the button is clicked 
	checkPosition()
	if buttonClicker >= 1 then
		speed = speed - .2
	end
	buttonClicker = buttonClicker + 1
end)
