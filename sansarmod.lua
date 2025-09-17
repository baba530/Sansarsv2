-- Ana GUI (Logo)
local gui = Instance.new("ScreenGui", game.CoreGui)

local logoButton = Instance.new("TextButton", gui)
logoButton.Size = UDim2.new(0, 180, 0, 40)
logoButton.Position = UDim2.new(0.02, 0, 0.2, 0)
logoButton.Text = "SANSARSV2xFARM"
logoButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
logoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
logoButton.Font = Enum.Font.SourceSansBold
logoButton.TextScaled = true
logoButton.Draggable = true

-- Menü
local menu = Instance.new("Frame", gui)
menu.Size = UDim2.new(0, 250, 0, 150)
menu.Position = UDim2.new(0.05, 0, 0.3, 0)
menu.BackgroundColor3 = Color3.fromRGB(30,30,30)
menu.Visible = false
menu.Active = true
menu.Draggable = true

local title = Instance.new("TextLabel", menu)
title.Size = UDim2.new(1, 0, 0.2, 0)
title.Text = "SANSARSV2xFARM"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true

local toggleFarm = Instance.new("TextButton", menu)
toggleFarm.Size = UDim2.new(1, -20, 0.3, 0)
toggleFarm.Position = UDim2.new(0, 10, 0.25, 0)
toggleFarm.Text = "Auto Farm: OFF"
toggleFarm.BackgroundColor3 = Color3.fromRGB(50,50,50)
toggleFarm.TextColor3 = Color3.fromRGB(255,255,255)
toggleFarm.Font = Enum.Font.SourceSans
toggleFarm.TextScaled = true

local rejoinButton = Instance.new("TextButton", menu)
rejoinButton.Size = UDim2.new(1, -20, 0.3, 0)
rejoinButton.Position = UDim2.new(0, 10, 0.6, 0)
rejoinButton.Text = "🔄 Rejoin Server"
rejoinButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
rejoinButton.TextColor3 = Color3.fromRGB(255,255,255)
rejoinButton.Font = Enum.Font.SourceSans
rejoinButton.TextScaled = true

-- Menü Aç/Kapa
logoButton.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
end)

-- Variables
local autoFarm = false

-- Toggle Farm
toggleFarm.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm
    toggleFarm.Text = "Auto Farm: " .. (autoFarm and "ON" or "OFF")
end)

-- Rejoin Server
rejoinButton.MouseButton1Click:Connect(function()
    game:GetService("TeleportService"):Teleport(game.PlaceId)
end)

-- Functions
function getNearestMob()
    local mobs = workspace.Enemies:GetChildren()
    local player = game.Players.LocalPlayer
    local closest, dist = nil, math.huge
    for _, mob in pairs(mobs) do
        if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
            local d = (mob.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if d < dist then
                closest = mob
                dist = d
            end
        end
    end
    return closest
end

-- Mobil uyumlu Observation açma
function activateObservation()
    local remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):FindFirstChild("CommF_")
    if remote then
        remote:InvokeServer("EnableObservationHaki")
    end
end

-- Main Loop
spawn(function()
    while true do
        if autoFarm then
            local mob = getNearestMob()
            if mob then
                repeat
                    pcall(function()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0,5,0)
                        activateObservation()
                    end)
                    wait(0.5)
                until not game.Players.LocalPlayer.PlayerGui:FindFirstChild("Dodge")
            end
        end
        wait(1)
    end
end)

-- Auto Restart (Server değişince GUI tekrar gelsin, OFF durumda başlasın)
local function resetGUI()
    wait(2)
    autoFarm = false
    toggleFarm.Text = "Auto Farm: OFF"
    menu.Visible = false
end

if game.Players.LocalPlayer.Character then
    resetGUI()
end

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    resetGUI()
end)
