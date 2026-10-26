-- SAB Mobile Route Recorder - touch fix
-- For Roblox Studio / experiences you own or are authorized to test.
-- Fix: only the title bar can drag the panel, so touches on buttons are not swallowed.
-- Route persistence: export text, copy/save it externally, then import it next session.
-- A LocalScript cannot write persistent files by itself. Game servers may override WalkSpeed.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local recording, playing = false, false
local route, recordConnection = {}, nil
local playToken = 0
local currentSpeed = 16
local SAMPLE_INTERVAL, MAX_WAYPOINTS = 0.25, 5000
local speedMonitorConnection

local function getParts()
    local char = player.Character
    if not char then return nil, nil end
    return char:FindFirstChildOfClass("Humanoid"), char:FindFirstChild("HumanoidRootPart")
end

local gui = Instance.new("ScreenGui")
gui.Name = "MobileRouteRecorder"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = player:WaitForChild("PlayerGui")

local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.new(0, 245, 0, 330)
panel.Position = UDim2.new(1, -260, 0.38, -165)
panel.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
panel.BackgroundTransparency = 0.06
panel.BorderSizePixel = 0
panel.Active = false
panel.Parent = gui
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -12, 0, 28)
title.Position = UDim2.new(0, 6, 0, 4)
title.BackgroundTransparency = 1
title.Text = "SAB Mobile Route"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.Active = true
title.Parent = panel

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -16, 0, 26)
status.Position = UDim2.new(0, 8, 0, 32)
status.BackgroundTransparency = 1
status.Text = "Ready | 0 points"
status.TextColor3 = Color3.fromRGB(220, 220, 220)
status.Font = Enum.Font.Gotham
status.TextSize = 11
status.TextWrapped = true
status.Parent = panel

local function statusText(message)
    status.Text = message .. " | " .. #route .. " points"
end

local function makeButton(text, y, color, height)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -20, 0, height or 30)
    b.Position = UDim2.new(0, 10, 0, y)
    b.BackgroundColor3 = color
    b.BorderSizePixel = 0
    b.Text = text
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.Active = true
    b.Selectable = true
    b.AutoButtonColor = true
    b.Parent = panel
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
    return b
end

local recordButton = makeButton("START RECORDING", 62, Color3.fromRGB(35, 110, 190))
local stopButton = makeButton("STOP / SAVE IN MEMORY", 97, Color3.fromRGB(100, 100, 110))
local replayButton = makeButton("REPLAY ROUTE", 132, Color3.fromRGB(30, 145, 80))

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0, 82, 0, 28)
speedLabel.Position = UDim2.new(0, 10, 0, 169)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Speed (0-200)"
speedLabel.TextColor3 = Color3.new(1, 1, 1)
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextSize = 11
speedLabel.Parent = panel

local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0, 78, 0, 28)
speedBox.Position = UDim2.new(0, 95, 0, 169)
speedBox.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
speedBox.BorderSizePixel = 0
speedBox.Text = "16"
speedBox.PlaceholderText = "0-200"
speedBox.TextColor3 = Color3.new(1, 1, 1)
speedBox.Font = Enum.Font.Gotham
speedBox.TextSize = 13
speedBox.ClearTextOnFocus = false
speedBox.Active = true
speedBox.Parent = panel
Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0, 6)

local setSpeedButton = makeButton("SET SPEED", 202, Color3.fromRGB(90, 90, 150), 28)
local exportButton = makeButton("EXPORT ROUTE TEXT", 234, Color3.fromRGB(120, 85, 35), 28)
local importButton = makeButton("IMPORT ROUTE TEXT", 266, Color3.fromRGB(45, 120, 100), 28)

local dataBox = Instance.new("TextBox")
dataBox.Size = UDim2.new(1, -20, 0, 25)
dataBox.Position = UDim2.new(0, 10, 0, 296)
dataBox.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
dataBox.BorderSizePixel = 0
dataBox.Text = ""
dataBox.PlaceholderText = "Paste route text here"
dataBox.TextColor3 = Color3.new(1, 1, 1)
dataBox.PlaceholderColor3 = Color3.fromRGB(180, 180, 180)
dataBox.Font = Enum.Font.Code
dataBox.TextSize = 10
dataBox.ClearTextOnFocus = false
dataBox.TextXAlignment = Enum.TextXAlignment.Left
dataBox.Active = true
dataBox.Parent = panel
Instance.new("UICorner", dataBox).CornerRadius = UDim.new(0, 6)

-- Drag using title only, never intercept taps on buttons or text fields.
local dragging, dragInput, dragStart, startPos
title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging, dragStart, startPos = true, input.Position, panel.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        panel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local function stopRecording()
    recording = false
    if recordConnection then recordConnection:Disconnect(); recordConnection = nil end
end

recordButton.Activated:Connect(function()
    if playing then statusText("Wait for replay to finish"); return end
    stopRecording()
    route = {}
    local humanoid, root = getParts()
    if not humanoid or not root then statusText("Character not ready"); return end
    recording = true
    statusText("Recording...")
    local elapsed = 0
    recordConnection = RunService.Heartbeat:Connect(function(dt)
        if not recording then return end
        elapsed += dt
        if elapsed < SAMPLE_INTERVAL then return end
        elapsed = 0
        local _, currentRoot = getParts()
        if not currentRoot then return end
        if #route >= MAX_WAYPOINTS then stopRecording(); statusText("Route limit reached"); return end
        local p = currentRoot.Position
        local last = route[#route]
        if not last or (Vector3.new(last.x, last.y, last.z) - p).Magnitude >= 1.5 then
            table.insert(route, {x = p.X, y = p.Y, z = p.Z})
            statusText("Recording...")
        end
    end)
end)

stopButton.Activated:Connect(function()
    stopRecording()
    statusText("Saved in session")
end)

local function applySpeed()
    local humanoid = getParts()
    if not humanoid then
        return false, "Character not ready"
    end

    humanoid.WalkSpeed = currentSpeed
    task.wait(0.15)

    -- Read back the value so the UI can distinguish a successful local change
    -- from a value that the game immediately resets.
    local checkHumanoid = getParts()
    if not checkHumanoid then
        return false, "Character not ready"
    end

    local actual = checkHumanoid.WalkSpeed
    if math.abs(actual - currentSpeed) < 0.1 then
        return true, "Speed value is " .. tostring(math.floor(actual))
    end

    return false, "Game reset speed to " .. tostring(math.floor(actual))
end

local function setSpeed()
    local n = tonumber(speedBox.Text)
    if not n or n < 0 or n > 200 then
        statusText("Enter speed 0 to 200")
        return
    end

    currentSpeed = math.floor(n)
    local humanoid = getParts()
    if not humanoid then
        statusText("Character not ready")
        return
    end

    humanoid.WalkSpeed = currentSpeed
    statusText("Applying speed " .. currentSpeed .. "...")

    task.spawn(function()
        local ok, message = applySpeed()
        statusText(message)
        if not ok then
            -- The game may be controlling movement on the server; the client
            -- cannot guarantee a speed change in that case.
            return
        end
    end)
end

-- Support tap and keyboard submit.
setSpeedButton.Activated:Connect(setSpeed)
speedBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then setSpeed() end
end)

local function encodeRoute()
    local out = {"SAB_ROUTE_V1"}
    for _, p in ipairs(route) do
        table.insert(out, string.format("%.3f,%.3f,%.3f", p.x, p.y, p.z))
    end
    return table.concat(out, ";")
end

exportButton.Activated:Connect(function()
    if #route < 2 then statusText("Record a route first"); return end
    dataBox.Text = encodeRoute()
    dataBox:CaptureFocus()
    dataBox.CursorPosition = #dataBox.Text + 1
    statusText("Copy exported text")
end)

importButton.Activated:Connect(function()
    local segments = string.split(dataBox.Text, ";")
    if segments[1] ~= "SAB_ROUTE_V1" then statusText("Invalid route text"); return end
    local imported = {}
    for i = 2, #segments do
        local parts = string.split(segments[i], ",")
        local x, y, z = tonumber(parts[1]), tonumber(parts[2]), tonumber(parts[3])
        if #parts ~= 3 or not x or not y or not z then statusText("Invalid point data"); return end
        table.insert(imported, {x = x, y = y, z = z})
        if #imported > MAX_WAYPOINTS then statusText("Route too large"); return end
    end
    if #imported < 2 then statusText("Route needs 2+ points"); return end
    stopRecording()
    route = imported
    statusText("Route imported")
end)

replayButton.Activated:Connect(function()
    if recording then statusText("Stop recording first"); return end
    if playing then statusText("Already replaying"); return end
    if #route < 2 then statusText("Record or import a route"); return end
    local humanoid, root = getParts()
    if not humanoid or not root then statusText("Character not ready"); return end
    playing = true
    playToken += 1
    local token = playToken
    statusText("Replaying...")
    task.spawn(function()
        for _, p in ipairs(route) do
            if not playing or token ~= playToken then break end
            local h, r = getParts()
            if not h or not r then break end
            h.WalkSpeed = currentSpeed
            local waypoint = Vector3.new(p.x, p.y, p.z)
            h:MoveTo(waypoint)
            local start = os.clock()
            while playing and token == playToken do
                local _, checkRoot = getParts()
                if not checkRoot or (checkRoot.Position - waypoint).Magnitude <= 4 or os.clock() - start > 8 then break end
                task.wait(0.1)
            end
        end
        if token == playToken then playing = false; statusText("Replay finished") end
    end)
end)

player.CharacterAdded:Connect(function()
    if playing then playing = false; playToken += 1 end
    stopRecording()
    task.wait(0.5)
    local humanoid = getParts()
    if humanoid then
        humanoid.WalkSpeed = currentSpeed
        task.wait(0.2)
        local checkHumanoid = getParts()
        if checkHumanoid and math.abs(checkHumanoid.WalkSpeed - currentSpeed) < 0.1 then
            statusText("Respawned | speed " .. tostring(math.floor(checkHumanoid.WalkSpeed)))
        elseif checkHumanoid then
            statusText("Respawned | game speed " .. tostring(math.floor(checkHumanoid.WalkSpeed)))
        else
            statusText("Character respawned")
        end
    else
        statusText("Character respawned")
    end
end)
