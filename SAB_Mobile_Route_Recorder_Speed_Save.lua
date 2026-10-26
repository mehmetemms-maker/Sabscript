-- SAB Mobile Route Recorder + Speed + Export/Import
-- For Roblox Studio / games you own or have permission to test.
-- Use Export Route Text, copy it somewhere safe, then paste it and Import after restarting.
-- A LocalScript cannot persist arbitrary data across sessions on its own.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local recording, playing = false, false
local route, recordConnection = {}, nil
local playToken = 0
local currentSpeed = 16
local SAMPLE_INTERVAL, MAX_WAYPOINTS = 0.25, 5000

local function getParts()
    local char = player.Character
    if not char then return nil, nil end
    return char:FindFirstChildOfClass("Humanoid"), char:FindFirstChild("HumanoidRootPart")
end

local gui = Instance.new("ScreenGui")
gui.Name, gui.ResetOnSpawn, gui.Parent = "MobileRouteRecorder", false, player:WaitForChild("PlayerGui")

local panel = Instance.new("Frame")
panel.Name, panel.Size = "Panel", UDim2.new(0, 245, 0, 330)
panel.Position = UDim2.new(1, -260, 0.38, -165)
panel.BackgroundColor3, panel.BackgroundTransparency, panel.BorderSizePixel = Color3.fromRGB(25,25,30), 0.06, 0
panel.Active, panel.Parent = true, gui
Instance.new("UICorner", panel).CornerRadius = UDim.new(0,12)

local function label(text, y, h, size)
    local o = Instance.new("TextLabel")
    o.Size, o.Position = UDim2.new(1,-12,0,h), UDim2.new(0,6,0,y)
    o.BackgroundTransparency, o.Text, o.TextColor3 = 1, text, Color3.new(1,1,1)
    o.Font, o.TextSize, o.Parent = Enum.Font.GothamBold, size or 12, panel
    return o
end
label("SAB Mobile Route", 4, 28, 15)
local status = label("Ready | 0 points", 32, 26, 11)
status.TextWrapped = true

local function button(text, y, color, h)
    local b = Instance.new("TextButton")
    b.Size, b.Position = UDim2.new(1,-20,0,h or 30), UDim2.new(0,10,0,y)
    b.BackgroundColor3, b.BorderSizePixel = color, 0
    b.Text, b.TextColor3, b.Font, b.TextSize = text, Color3.new(1,1,1), Enum.Font.GothamBold, 12
    b.Parent = panel
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,7)
    return b
end

local recordButton = button("START RECORDING", 62, Color3.fromRGB(35,110,190))
local stopButton = button("STOP / SAVE IN MEMORY", 97, Color3.fromRGB(100,100,110))
local replayButton = button("REPLAY ROUTE", 132, Color3.fromRGB(30,145,80))
label("Speed (0-200)", 169, 28, 11).Size = UDim2.new(0,82,0,28)

local speedBox = Instance.new("TextBox")
speedBox.Size, speedBox.Position = UDim2.new(0,78,0,28), UDim2.new(0,95,0,169)
speedBox.BackgroundColor3, speedBox.BorderSizePixel = Color3.fromRGB(55,55,65), 0
speedBox.Text, speedBox.PlaceholderText = "16", "0-200"
speedBox.TextColor3, speedBox.Font, speedBox.TextSize = Color3.new(1,1,1), Enum.Font.Gotham, 13
speedBox.ClearTextOnFocus, speedBox.Parent = false, panel
Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0,6)
local setSpeedButton = button("SET SPEED", 202, Color3.fromRGB(90,90,150), 28)
local exportButton = button("EXPORT ROUTE TEXT", 234, Color3.fromRGB(120,85,35), 28)
local importButton = button("IMPORT ROUTE TEXT", 266, Color3.fromRGB(45,120,100), 28)

local dataBox = Instance.new("TextBox")
dataBox.Size, dataBox.Position = UDim2.new(1,-20,0,25), UDim2.new(0,10,0,296)
dataBox.BackgroundColor3, dataBox.BorderSizePixel = Color3.fromRGB(45,45,52), 0
dataBox.Text, dataBox.PlaceholderText = "", "Paste route text here"
dataBox.TextColor3, dataBox.Font, dataBox.TextSize = Color3.new(1,1,1), Enum.Font.Code, 10
dataBox.ClearTextOnFocus, dataBox.TextXAlignment, dataBox.Parent = false, Enum.TextXAlignment.Left, panel
Instance.new("UICorner", dataBox).CornerRadius = UDim.new(0,6)

-- Drag panel on touch/mouse.
local dragging, dragInput, dragStart, startPos
panel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging, dragStart, startPos = true, input.Position, panel.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
panel.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        panel.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
    end
end)

local function statusText(s) status.Text = s .. " | " .. #route .. " points" end
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
        if not last or (Vector3.new(last.x,last.y,last.z)-p).Magnitude >= 1.5 then
            table.insert(route,{x=p.X,y=p.Y,z=p.Z})
            statusText("Recording...")
        end
    end)
end)

stopButton.Activated:Connect(function()
    stopRecording()
    statusText("Saved in session")
end)

setSpeedButton.Activated:Connect(function()
    local n = tonumber(speedBox.Text)
    if not n or n < 0 or n > 200 then statusText("Enter speed 0 to 200"); return end
    currentSpeed = math.floor(n)
    local humanoid = getParts()
    if humanoid then humanoid.WalkSpeed = currentSpeed end
    statusText("Speed set to "..currentSpeed)
end)

local function encodeRoute()
    local out = {"SAB_ROUTE_V1"}
    for _,p in ipairs(route) do table.insert(out,string.format("%.3f,%.3f,%.3f",p.x,p.y,p.z)) end
    return table.concat(out,";")
end

exportButton.Activated:Connect(function()
    if #route < 2 then statusText("Record a route first"); return end
    dataBox.Text = encodeRoute()
    dataBox:CaptureFocus()
    dataBox.CursorPosition = #dataBox.Text + 1
    statusText("Copy exported text")
end)

importButton.Activated:Connect(function()
    local raw = dataBox.Text
    local segments = string.split(raw,";")
    if segments[1] ~= "SAB_ROUTE_V1" then statusText("Invalid route text"); return end
    local imported = {}
    for i=2,#segments do
        local parts = string.split(segments[i],",")
        local x,y,z = tonumber(parts[1]),tonumber(parts[2]),tonumber(parts[3])
        if #parts ~= 3 or not x or not y or not z then statusText("Invalid point data"); return end
        table.insert(imported,{x=x,y=y,z=z})
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
        for _,p in ipairs(route) do
            if not playing or token ~= playToken then break end
            local h, r = getParts()
            if not h or not r then break end
            h.WalkSpeed = currentSpeed
            local waypoint = Vector3.new(p.x,p.y,p.z)
            h:MoveTo(waypoint)
            local start = os.clock()
            while playing and token == playToken do
                local _, checkRoot = getParts()
                if not checkRoot or (checkRoot.Position-waypoint).Magnitude <= 4 or os.clock()-start > 8 then break end
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
    if humanoid then humanoid.WalkSpeed = currentSpeed end
    statusText("Character respawned")
end)
