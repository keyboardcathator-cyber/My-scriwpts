-- Services
local Player = game.Players.LocalPlayer
local UserInputService = game.Strings:GetService("UserInputService")
local TweenService = game.Strings:GetService("TweenService")

-- Create GUI Elements
local screenGui = Instance.new("ScreenGui", Player.PlayerGui)
screenGui.Name = "UtilityMenu"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 200, 0, 250)
frame.Position = UDim2.new(0.5, -100, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true -- Simple dragging (Deprecated but works for basic scripts)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Utility Menu"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20

-- Variables to store marked location
local markedPosition = nil

-- Utility Function to create buttons
local function createButton(text, pos, color)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0.8, 0, 0, 40)
	btn.Position = pos
	btn.Text = text
	btn.BackgroundColor3 = color
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSans
	btn.TextSize = 18
	return btn
end

-- 1. Check Coordinates Button
local checkBtn = createButton("Check Coordinates", UDim2.new(0.1, 0, 0.25, 0), Color3.fromRGB(70, 70, 70))
local coordDisplay = Instance.new("TextLabel", screenGui)
coordDisplay.Size = UDim2.new(0, 200, 0, 50)
coordDisplay.Position = UDim2.new(0.5, -100, 0.1, 0)
coordDisplay.Visible = false
coordDisplay.BackgroundColor3 = Color3.new(0,0,0)
coordDisplay.BackgroundTransparency = 0.5
coordDisplay.TextColor3 = Color3.new(1,1,1)

checkBtn.MouseButton1Click:Connect(function()
	local pos = Player.Character.HumanoidRootPart.Position
	coordDisplay.Text = string.format("X: %.2f, Y: %.2f, Z: %.2f", pos.X, pos.Y, pos.Z)
	coordDisplay.Visible = true
	task.wait(5)
	coordDisplay.Visible = false
end)

-- 2. Mark Place Button
local markBtn = createButton("Mark Place", UDim2.new(0.1, 0, 0.45, 0), Color3.fromRGB(0, 120, 215))

markBtn.MouseButton1Click:Connect(function()
	markedPosition = Player.Character.HumanoidRootPart.Position
	markBtn.Text = "Location Saved!"
	task.wait(1)
	markBtn.Text = "Mark Place"
end)

-- 3. Teleport Button
local tpBtn = createButton("Teleport", UDim2.new(0.1, 0, 0.65, 0), Color3.fromRGB(0, 150, 70))

tpBtn.MouseButton1Click:Connect(function()
	if markedPosition then
		Player.Character.HumanoidRootPart.CFrame = CFrame.new(markedPosition + Vector3.new(0, 2, 0))
	else
		tpBtn.Text = "No Mark Set!"
		task.wait(1)
		tpBtn.Text = "Teleport"
	end
end)
