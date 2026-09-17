-- example

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

--// GUI
local gui = Instance.new("ScreenGui")
gui.Name = "CoordinateGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")


--// Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 150)
frame.Position = UDim2.new(0, 25, 0, 120)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame


--// Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 35)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = "Coordinates"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame


--// Coordinates
local coordinates = Instance.new("TextLabel")
coordinates.Size = UDim2.new(1, -20, 0, 65)
coordinates.Position = UDim2.new(0, 10, 0, 40)
coordinates.BackgroundTransparency = 1
coordinates.Text = "X: 0.0\nY: 0.0\nZ: 0.0"
coordinates.TextColor3 = Color3.fromRGB(220, 220, 220)
coordinates.TextSize = 16
coordinates.Font = Enum.Font.Gotham
coordinates.TextXAlignment = Enum.TextXAlignment.Left
coordinates.TextYAlignment = Enum.TextYAlignment.Top
coordinates.Parent = frame


--// Copy Button
local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(1, -20, 0, 32)
copyButton.Position = UDim2.new(0, 10, 1, -42)
copyButton.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
copyButton.BorderSizePixel = 0
copyButton.Text = "Copy Coordinates"
copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
copyButton.TextSize = 14
copyButton.Font = Enum.Font.GothamBold
copyButton.Parent = frame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 7)
buttonCorner.Parent = copyButton


--// Current coordinates
local currentCoordinates = "X: 0.0, Y: 0.0, Z: 0.0"


--==================================================
-- NOTIFICATION
--==================================================

local function showNotification(message)

	local notification = Instance.new("Frame")
	notification.Size = UDim2.new(0, 260, 0, 55)

	-- Mulai di luar layar sebelah kanan
	notification.Position = UDim2.new(1, 20, 1, -80)

	notification.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
	notification.BackgroundTransparency = 0

	notification.BorderSizePixel = 0
	notification.Parent = gui

	local notificationCorner = Instance.new("UICorner")
	notificationCorner.CornerRadius = UDim.new(0, 10)
	notificationCorner.Parent = notification


	-- Text
	local text = Instance.new("TextLabel")
	text.Size = UDim2.new(1, -20, 1, 0)
	text.Position = UDim2.new(0, 10, 0, 0)

	text.BackgroundTransparency = 1
	text.Text = message
	text.TextColor3 = Color3.fromRGB(255, 255, 255)
	text.TextSize = 15
	text.Font = Enum.Font.GothamBold

	text.TextXAlignment = Enum.TextXAlignment.Left
	text.Parent = notification


	-- Slide masuk
	local slideIn = TweenService:Create(
		notification,
		TweenInfo.new(
			0.35,
			Enum.EasingStyle.Quart,
			Enum.EasingDirection.Out
		),
		{
			Position = UDim2.new(1, -280, 1, -80)
		}
	)

	slideIn:Play()

	-- Tunggu sebentar
	task.wait(1.5)


	-- Fade + slide keluar
	local slideOut = TweenService:Create(
		notification,
		TweenInfo.new(
			0.35,
			Enum.EasingStyle.Quart,
			Enum.EasingDirection.In
		),
		{
			Position = UDim2.new(1, 20, 1, -80),
			BackgroundTransparency = 1
		}
	)

	local textFade = TweenService:Create(
		text,
		TweenInfo.new(0.35),
		{
			TextTransparency = 1
		}
	)

	slideOut:Play()
	textFade:Play()

	slideOut.Completed:Wait()

	notification:Destroy()
end


--==================================================
-- COPY
--==================================================

copyButton.MouseButton1Click:Connect(function()

	if setclipboard then

		setclipboard(currentCoordinates)

		copyButton.Text = "✓ Copied!"

		task.spawn(function()
			showNotification("✓ Coordinates copied!")
		end)

		task.wait(1)

		copyButton.Text = "Copy Coordinates"

	else

		copyButton.Text = "Clipboard unavailable"

		task.spawn(function()
			showNotification("⚠ Clipboard unavailable")
		end)

		task.wait(1)

		copyButton.Text = "Copy Coordinates"
	end
end)


--==================================================
-- DRAG SYSTEM
--==================================================

local dragging = false
local dragStart
local startPosition

title.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPosition = frame.Position
	end
end)


UserInputService.InputChanged:Connect(function(input)

	if not dragging then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then

		local delta = input.Position - dragStart

		frame.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,

			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)
	end
end)


UserInputService.InputEnded:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = false
	end
end)


--==================================================
-- UPDATE COORDINATES
--==================================================

RunService.RenderStepped:Connect(function()

	local character = player.Character

	if not character then
		return
	end

	local root = character:FindFirstChild("HumanoidRootPart")

	if not root then
		return
	end

	local position = root.Position

	currentCoordinates = string.format(
		"X: %.1f, Y: %.1f, Z: %.1f",
		position.X,
		position.Y,
		position.Z
	)

	coordinates.Text = string.format(
		"X: %.1f\nY: %.1f\nZ: %.1f",
		position.X,
		position.Y,
		position.Z
	)
end)
