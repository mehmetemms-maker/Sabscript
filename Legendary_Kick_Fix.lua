-- Legendary Kick Fix
-- Diagnostic-only LocalScript for your OWN Roblox experience.
-- Install in Roblox Studio: StarterPlayer > StarterPlayerScripts.
-- This script does NOT bypass Roblox moderation, anti-cheat, or server kick rules.
-- It displays client-side error messages to help you diagnose problems.

local Players = game:GetService("Players")
local LogService = game:GetService("LogService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local oldGui = playerGui:FindFirstChild("LegendaryKickFix")
if oldGui then
    oldGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "LegendaryKickFix"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Name = "Main"
frame.Size = UDim2.fromOffset(330, 220)
frame.Position = UDim2.new(0.5, -165, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(12, 17, 30)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(35, 115, 220)
stroke.Thickness = 2
stroke.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 38)
title.Position = UDim2.fromOffset(10, 8)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "LEGENDARY KICK FIX"
title.TextColor3 = Color3.fromRGB(90, 170, 255)
title.TextSize = 18
title.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 26)
status.Position = UDim2.fromOffset(10, 48)
status.BackgroundTransparency = 1
status.Font = Enum.Font.Gotham
status.Text = "Status: Monitoring client errors"
status.TextColor3 = Color3.fromRGB(220, 230, 245)
status.TextSize = 12
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = frame

local output = Instance.new("TextLabel")
output.Size = UDim2.new(1, -20, 0, 92)
output.Position = UDim2.fromOffset(10, 78)
output.BackgroundColor3 = Color3.fromRGB(20, 28, 45)
output.BorderSizePixel = 0
output.Font = Enum.Font.Code
output.Text = "No client errors captured yet."
output.TextColor3 = Color3.fromRGB(205, 215, 230)
output.TextSize = 11
output.TextWrapped = true
output.TextXAlignment = Enum.TextXAlignment.Left
output.TextYAlignment = Enum.TextYAlignment.Top
output.Parent = frame

local outputCorner = Instance.new("UICorner")
outputCorner.CornerRadius = UDim.new(0, 7)
outputCorner.Parent = output

local clearButton = Instance.new("TextButton")
clearButton.Size = UDim2.fromOffset(90, 28)
clearButton.Position = UDim2.new(1, -100, 1, -38)
clearButton.BackgroundColor3 = Color3.fromRGB(30, 95, 175)
clearButton.BorderSizePixel = 0
clearButton.Font = Enum.Font.GothamBold
clearButton.Text = "Clear"
clearButton.TextColor3 = Color3.new(1, 1, 1)
clearButton.TextSize = 12
clearButton.Parent = frame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = clearButton

local latestErrors = {}

local function refreshOutput()
    if #latestErrors == 0 then
        output.Text = "No client errors captured yet."
        status.Text = "Status: Monitoring client errors"
        return
    end

    output.Text = table.concat(latestErrors, "\n\n")
    status.Text = "Status: " .. tostring(#latestErrors) .. " client error(s) captured"
end

LogService.MessageOut:Connect(function(message, messageType)
    if messageType == Enum.MessageType.MessageError then
        table.insert(latestErrors, 1, string.sub(tostring(message), 1, 180))
        while #latestErrors > 3 do
            table.remove(latestErrors)
        end
        refreshOutput()
    end
end)

clearButton.MouseButton1Click:Connect(function()
    table.clear(latestErrors)
    refreshOutput()
end)

-- Drag the panel with mouse or touch.
local UserInputService = game:GetService("UserInputService")
local dragging = false
local dragInput
local dragStart
local startPosition

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)
