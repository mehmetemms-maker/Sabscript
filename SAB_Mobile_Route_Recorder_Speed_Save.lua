-- SAB Mobile Route Recorder + Speed + Persistent Save/Load
-- For Roblox Studio / games you own or have permission to test.
-- Mobile touch UI. Save/load requires executor file APIs (writefile/readfile/isfile).
-- Movement behavior depends on the game; this does not bypass server-side checks.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local recording = false
local playing = false
local route = {}
local recordConnection
local playToken = 0
local replaySpeed = 1
local speedOptions = {1, 1.5, 2, 3}
local speedIndex = 1
local SAVE_FILE = "SAB_Mobile_Route_Recorder_route.json"

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
panel.Size = UDim2.new(0, 235, 0, 315)
panel.Position = UDim2.new(1, -245, 0.4, -155)
panel.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
panel.BackgroundTransparency = 0.08
panel.BorderSizePixel = 0
panel.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = panel

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -12, 0, 30)
title.Position = UDim2.new(0, 6, 0, 4)
title.BackgroundTransparency = 1
title.Text = "SAB Route Recorder"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.Parent = panel

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -16, 0, 32)
status.Position = UDim2.new(0, 8, 0, 34)
status.BackgroundTransparency = 1
status.Text = "Status: Ready"
status.TextWrapped = true
status.TextColor3 = Color3.fromRGB(210, 210, 210)
status.Font = Enum.Font.Gotham
status.TextSize = 11
status.Parent = panel

local function makeButton(text, x, y, width, height, color)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, width, 0, height)
    button.Position = UDim2.new(0, x, 0, y)
    button.BackgroundColor3 = color
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 12
    button.TextWrapped = true
    button.Parent = panel
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    return button
end

local recordButton = makeButton("START RECORDING", 10, 70, 215, 32, Color3.fromRGB(35, 110, 190))
local stopButton = makeButton("STOP RECORDING", 10, 108, 215, 32, Color3.fromRGB(100, 100, 110))
local slowerButton = makeButton("− SPEED", 10, 146, 103, 32, Color3.fromRGB(85, 85, 100))
local fasterButton = makeButton("+ SPEED", 122, 146, 103, 32, Color3.fromRGB(85, 85, 100))
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, -20, 0, 22)
speedLabel.Position = UDim2.new(0, 10, 0, 180)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Replay speed: 1x"
speedLabel.TextColor3 = Color3.new(1, 1, 1)
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextSize = 12
speedLabel.Parent = panel

local saveButton = makeButton("SAVE ROUTE", 10, 207, 103, 32, Color3.fromRGB(115, 85, 35))
local loadButton = makeButton("LOAD ROUTE", 122, 207, 103, 32, Color3.fromRGB(115, 85, 35))
local replayButton = makeButton("REPLAY ROUTE", 10, 245, 215, 32, Color3.fromRGB(30, 145, 80))

local function updateSpeedLabel()
    speedLabel.Text = ("Replay speed: %sx"):format(tostring(replaySpeed))
end

local function stopRecording()
    recording = false
    if recordConnection then
        recordConnection:Disconnect()
        recordConnection = nil
    end
end

local function encodeRoute()
    local serializable = {}
    for _, pos in ipairs(route) do
        table.insert(serializable, {x = pos.X, y = pos.Y, z = pos.Z})
    end
    return HttpService:JSONEncode(serializable)
end

local function decodeRoute(raw)
    local decoded = HttpService:JSONDecode(raw)
    if type(decoded) ~= "table" then error("Invalid route data") end
    local loaded = {}
    for _, point in ipairs(decoded) do
        if type(point) ~= "table" or type(point.x) ~= "number"
            or type(point.y) ~= "number" or type(point.z) ~= "number" then
            error("Invalid waypoint")
        end
        table.insert(loaded, Vector3.new(point.x, point.y, point.z))
        if #loaded >= MAX_WAYPOINTS then break end
    end
    return loaded
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
            status.Text = ("Recording: %d points"):format(#route)
        end
    end)
end)

stopButton.Activated:Connect(function()
    stopRecording()
    status.Text = ("Stopped: %d points. Tap SAVE ROUTE to keep it."):format(#route)
end)

slowerButton.Activated:Connect(function()
    speedIndex = math.max(1, speedIndex - 1)
    replaySpeed = speedOptions[speedIndex]
    updateSpeedLabel()
end)

fasterButton.Activated:Connect(function()
    speedIndex = math.min(#speedOptions, speedIndex + 1)
    replaySpeed = speedOptions[speedIndex]
    updateSpeedLabel()
end)

saveButton.Activated:Connect(function()
    if recording then
        status.Text = "Status: Stop recording before saving"
        return
    end
    if #route < 2 then
        status.Text = "Status: Record a route first"
        return
    end
    if type(writefile) ~= "function" then
        status.Text = "Save unavailable: executor has no writefile"
        return
    end
    local ok, err = pcall(function()
        writefile(SAVE_FILE, encodeRoute())
    end)
    if ok then
        status.Text = ("Saved %d points to file"):format(#route)
    else
        status.Text = "Save failed: " .. tostring(err)
    end
end)

loadButton.Activated:Connect(function()
    if recording or playing then
        status.Text = "Status: Stop recording/replay first"
        return
    end
    if type(readfile) ~= "function" or type(isfile) ~= "function" then
        status.Text = "Load unavailable: executor file APIs missing"
        return
    end
    if not isfile(SAVE_FILE) then
        status.Text = "Status: No saved route file found"
        return
    end
    local ok, result = pcall(function()
        return decodeRoute(readfile(SAVE_FILE))
    end)
    if ok and #result >= 2 then
        route = result
        status.Text = ("Loaded route: %d points"):format(#route)
    else
        status.Text = "Load failed: invalid/empty route"
    end
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
        status.Text = "Status: Record or load a route first"
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
    local originalWalkSpeed = humanoid.WalkSpeed
    local appliedHumanoid = humanoid
    appliedHumanoid.WalkSpeed = math.clamp(originalWalkSpeed * replaySpeed, 1, 100)
    status.Text = ("Status: Replaying at %sx"):format(tostring(replaySpeed))

    task.spawn(function()
        for _, waypoint in ipairs(route) do
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
                if os.clock() - started > 8 / replaySpeed then
                    break
                end
                task.wait(0.1)
            end
        end
        if appliedHumanoid and appliedHumanoid.Parent then
            appliedHumanoid.WalkSpeed = originalWalkSpeed
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

updateSpeedLabel()
