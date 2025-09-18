local gui = Instance.new("ScreenGui")
gui.Name = "CacahubGUI"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local logoButton = Instance.new("TextButton", gui)
logoButton.Size = UDim2.new(0, 200, 0, 50)
logoButton.Position = UDim2.new(0.85, 0, 0.15, 0)
logoButton.Text = "Cacahub"
logoButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
logoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
logoButton.Font = Enum.Font.GothamBold
logoButton.TextScaled = true
logoButton.Draggable = true

local menu = Instance.new("Frame", gui)
menu.Size = UDim2.new(0, 400, 0, 600)
menu.Position = UDim2.new(0.5, -200, 0.5, -300)
menu.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
menu.Visible = false
menu.Active = true
menu.Draggable = true

local title = Instance.new("TextLabel", menu)
title.Size = UDim2.new(1, 0, 0.1, 0)
title.Text = "Cacahub v1 Panel"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextScaled = true

logoButton.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
end)
