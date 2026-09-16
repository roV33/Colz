local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer


local IMAGE_ID = "rbxassetid://85440565007657"


local gui = Instance.new("ScreenGui")
gui.Name = "CoordinateGui"
gui.ResetOnSpawn = false
gui.DisplayOrder = 999
gui.Parent = player:WaitForChild("PlayerGui")


local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 150)
frame.Position = UDim2.new(0, 25, 0, 120)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame



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



local function showNotification(notificationTitle, subtitle)

	local notification = Instance.new("Frame")

	notification.Size = UDim2.new(0, 310, 0, 75)

	-- Start outside screen
	notification.Position = UDim2.new(1, 20, 1, -100)

	notification.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
	notification.BackgroundTransparency = 1

	notification.BorderSizePixel = 0
	notification.Parent = gui


	-- Corner
	local notificationCorner = Instance.new("UICorner")
	notificationCorner.CornerRadius = UDim.new(0, 12)
	notificationCorner.Parent = notification


	
	local image = Instance.new("ImageLabel")

	image.Size = UDim2.new(0, 48, 0, 48)
	image.Position = UDim2.new(0, 13, 0.5, -24)

	image.BackgroundTransparency = 1
	image.Image = IMAGE_ID
	image.ImageTransparency = 1

	image.Parent = notification


	local imageCorner = Instance.new("UICorner")
	imageCorner.CornerRadius = UDim.new(1, 0)
	imageCorner.Parent = image


	
	local notifTitle = Instance.new("TextLabel")

	notifTitle.Size = UDim2.new(1, -80, 0, 25)
	notifTitle.Position = UDim2.new(0, 75, 0, 13)

	notifTitle.BackgroundTransparency = 1
	notifTitle.Text = notificationTitle

	notifTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	notifTitle.TextTransparency = 1

	notifTitle.TextSize = 16
	notifTitle.Font = Enum.Font.GothamBold

	notifTitle.TextXAlignment = Enum.TextXAlignment.Left
	notifTitle.Parent = notification


	
	local notifSubtitle = Instance.new("TextLabel")

	notifSubtitle.Size = UDim2.new(1, -80, 0, 25)
	notifSubtitle.Position = UDim2.new(0, 75, 0, 38)

	notifSubtitle.BackgroundTransparency = 1
	notifSubtitle.Text = subtitle

	notifSubtitle.TextColor3 = Color3.fromRGB(190, 190, 195)
	notifSubtitle.TextTransparency = 1

	notifSubtitle.TextSize = 13
	notifSubtitle.Font = Enum.Font.Gotham

	notifSubtitle.TextXAlignment = Enum.TextXAlignment.Left
	notifSubtitle.Parent = notification


	
	local slideIn = TweenService:Create(
		notification,

		TweenInfo.new(
			0.45,
			Enum.EasingStyle.Quart,
			Enum.EasingDirection.Out
		),

		{
			Position = UDim2.new(1, -330, 1, -100),
			BackgroundTransparency = 0
		}
	)


	local titleFade = TweenService:Create(
		notifTitle,
		TweenInfo.new(0.35),
		{
			TextTransparency = 0
		}
	)


	local subtitleFade = TweenService:Create(
		notifSubtitle,
		TweenInfo.new(0.35),
		{
			TextTransparency = 0
		}
	)


	local imageFade = TweenService:Create(
		image,
		TweenInfo.new(0.35),
		{
			ImageTransparency = 0
		}
	)


	slideIn:Play()
	titleFade:Play()
	subtitleFade:Play()
	imageFade:Play()


	
	task.wait(2.5)


	
	local slideOut = TweenService:Create(
		notification,

		TweenInfo.new(
			0.4,
			Enum.EasingStyle.Quart,
			Enum.EasingDirection.In
		),

		{
			Position = UDim2.new(1, 20, 1, -100),
			BackgroundTransparency = 1
		}
	)


	local titleOut = TweenService:Create(
		notifTitle,
		TweenInfo.new(0.3),
		{
			TextTransparency = 1
		}
	)


	local subtitleOut = TweenService:Create(
		notifSubtitle,
		TweenInfo.new(0.3),
		{
			TextTransparency = 1
		}
	)


	local imageOut = TweenService:Create(
		image,
		TweenInfo.new(0.3),
		{
			ImageTransparency = 1
		}
	)


	slideOut:Play()
	titleOut:Play()
	subtitleOut:Play()
	imageOut:Play()


	slideOut.Completed:Wait()

	notification:Destroy()
end



local currentCoordinates = "X: 0.0, Y: 0.0, Z: 0.0"



copyButton.MouseButton1Click:Connect(function()

	if setclipboard then

		setclipboard(currentCoordinates)

		copyButton.Text = "✓ Copied!"

		task.spawn(function()
			showNotification(
				"Coordinates",
				"Coordinates copied successfully!"
			)
		end)

		task.wait(1)

		copyButton.Text = "Copy Coordinates"

	else

		copyButton.Text = "Clipboard unavailable"

		task.spawn(function()
			showNotification(
				"Coordinates",
				"Clipboard is unavailable."
			)
		end)

		task.wait(1)

		copyButton.Text = "Copy Coordinates"
	end
end)



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



RunService.RenderStepped:Connect(function()

	local character = player.Character

	if not character then
		return
	end

	local root = character:FindFirstChild("
