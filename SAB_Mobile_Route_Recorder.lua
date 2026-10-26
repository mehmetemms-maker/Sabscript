-- SAB Mobile Route Recorder (prototype)
-- For Roblox Studio / games you own or have permission to test.
-- Mobile UI: Record, Stop, Replay.
-- Records character positions and replays them using Humanoid:MoveTo.
-- This does not bypass server-side movement checks and may not work in every game.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local recording = false
local playing = false
local route = {}
local recordConnection
local playToken = 0

local SAMPLE_INTERVAL = 0.25
local WAYPOINT_REACHED_DISTANCE = 4
local MAX_WAYPOINTS = 5000

local function getCharacterParts()
    local character = player.Character
    if not character then return nil, nil end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")

    if not humanoid or not root then return nil, nil end
    return humanoid, root
end

local gui = Instance.new("ScreenGui")
gui.Name = "MobileRouteRecorder"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.new(0, 220, 0, 190)
panel.Position = UDim2.new(1, -235, 0.45, -95)
panel.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
panel.BackgroundTransparency = 0.08
panel.BorderSizePixel = 0
panel.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = panel

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -12, 0, 32)
title.Position = UDim2.new(0, 6, 0, 4)
title.BackgroundTransparency = 1
title.Text = "SAB Route Recorder"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.Parent = panel

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -16, 0, 25)
status.Position = UDim2.new(0, 8, 0, 36)
status.BackgroundTransparency = 1
status.Text = "Status: Ready"
status.TextColor3 = Color3.fromRGB(210, 210, 210)
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.Parent = panel

local function makeButton(text, y, color)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 34)
    button.Position = UDim2.new(0, 10, 0, y)
    button.BackgroundColor3 = color
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 13
    button.Parent = panel

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    return button
end

local recordButton = makeButton("START RECORDING", 65, Color3.fromRGB(35, 110, 190))
local stopButton = makeButton("STOP / SAVE ROUTE", 105, Color3.fromRGB(100, 100, 110))
local replayButton = makeButton("REPLAY ROUTE", 145, Color3.fromRGB(30, 145, 80))

local function stopRecording()
    recording = false
    if recordConnection then
        recordConnection:Disconnect()
        recordConnection = nil
    end
end

recordButton.Activated:Connect(function()
    if playing then
        status.Text = "Status: Wait for replay to finish"
        return
    end

    stopRecording()
    route = {}

    local humanoid, root = getCharacterParts()
    if not humanoid or not root then
        status.Text = "Status: Character not ready"
        return
    end

    recording = true
    status.Text = "Status: Recording..."

    local elapsed = 0
    recordConnection = RunService.Heartbeat:Connect(function(dt)
        if not recording then return end
        elapsed += dt
        if elapsed < SAMPLE_INTERVAL then return end
        elapsed = 0

        local _, currentRoot = getCharacterParts()
        if not currentRoot then return end
        if #route >= MAX_WAYPOINTS then
            stopRecording()
            status.Text = "Status: Route limit reached"
            return
        end

        local pos = currentRoot.Position
        local last = route[#route]
        if not last or (pos - last).Magnitude >= 1.5 then
            table.insert(route, pos)
            status.Text = ("Status: Recording (%d points)"):format(#route)
        end
    end)
end)

stopButton.Activated:Connect(function()
    stopRecording()
    status.Text = ("Status: Saved %d points"):format(#route)
end)

replayButton.Activated:Connect(function()
    if recording then
        status.Text = "Status: Stop recording first"
        return
    end
    if playing then
        status.Text = "Status: Already replaying"
        return
    end
    if #route < 2 then
        status.Text = "Status: Record a longer route first"
        return
    end

    local humanoid, root = getCharacterParts()
    if not humanoid or not root then
        status.Text = "Status: Character not ready"
        return
    end

    playing = true
    playToken += 1
    local myToken = playToken
    status.Text = "Status: Replaying..."

    task.spawn(function()
        for i, waypoint in ipairs(route) do
            if not playing or myToken ~= playToken then break end

            local currentHumanoid, currentRoot = getCharacterParts()
            if not currentHumanoid or not currentRoot then
                status.Text = "Status: Character lost"
                break
            end

            currentHumanoid:MoveTo(waypoint)
            local started = os.clock()

            while playing and myToken == playToken do
                local _, checkRoot = getCharacterParts()
                if not checkRoot then break end

                if (checkRoot.Position - waypoint).Magnitude <= WAYPOINT_REACHED_DISTANCE then
                    break
                end

                if os.clock() - started > 8 then
                    -- Skip a waypoint if it cannot be reached in time.
                    break
                end
                task.wait(0.1)
            end
        end

        if myToken == playToken then
            playing = false
            status.Text = "Status: Replay finished"
        end
    end)
end)

player.CharacterAdded:Connect(function()
    if playing then
        playing = false
        playToken += 1
    end
    stopRecording()
    status.Text = "Status: Character respawned"
end)
