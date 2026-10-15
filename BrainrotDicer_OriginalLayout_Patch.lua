-- LocalScript inside StarterGui

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local COLORS = {
	{ name = "Add More",   color = Color3.fromRGB(59, 130, 246)  },
	{ name = "Deal?",      color = Color3.fromRGB(250, 204, 21)  },
	{ name = "L Trade",    color = Color3.fromRGB(220, 50, 50)   },
	{ name = "Fair Trade", color = Color3.fromRGB(34, 197, 94)   },
	{ name = "Last Offer", color = Color3.fromRGB(168, 85, 247)  },
	{ name = "No Thanks",  color = Color3.fromRGB(249, 115, 22)  },
}

local NUM_DICE = 4
local selectedColor = nil
local isRolling = false
local uiLocked = false
local userLabelText = "User: blala"

local DOT_LAYOUTS = {
	{ {0.5, 0.5} },
	{ {0.72, 0.28}, {0.28, 0.72} },
	{ {0.72, 0.28}, {0.5, 0.5}, {0.28, 0.72} },
	{ {0.28, 0.28}, {0.72, 0.28}, {0.28, 0.72}, {0.72, 0.72} },
	{ {0.28, 0.28}, {0.72, 0.28}, {0.5, 0.5}, {0.28, 0.72}, {0.72, 0.72} },
	{ {0.28, 0.22}, {0.72, 0.22}, {0.28, 0.5}, {0.72, 0.5}, {0.28, 0.78}, {0.72, 0.78} },
}

local DOT_RADIUS = 4

-- ── DIMENSIONS (scaled down ~30%) ──
local PANEL_H    = 112
local DICE_SIZE  = 76
local DICE_GAP   = 8
local DICE_PAD   = 10
local DICE_ZONE_W = DICE_PAD + NUM_DICE * DICE_SIZE + (NUM_DICE - 1) * DICE_GAP + DICE_PAD

local BTN_COLS   = 3
local BTN_ROWS   = 2
local BTN_W      = 76
local BTN_H      = 26
local BTN_GAP_X  = 6
local BTN_GAP_Y  = 6
local COLOR_PAD  = 10
local COLOR_ZONE_W = COLOR_PAD + BTN_COLS * BTN_W + (BTN_COLS - 1) * BTN_GAP_X + COLOR_PAD

local ACTION_W   = 84
local ACTION_PAD = 10
local ACTION_ZONE_W = ACTION_PAD + ACTION_W + ACTION_PAD

local PANEL_W = DICE_ZONE_W + COLOR_ZONE_W + ACTION_ZONE_W

-- ── SCREEN GUI ──
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BrainrotDicer"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- ── MAIN PANEL ──
local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.new(0, PANEL_W, 0, PANEL_H)
panel.Position = UDim2.new(0.5, -PANEL_W / 2, 1, -(PANEL_H + 12))
panel.BackgroundColor3 = Color3.fromRGB(8, 6, 28)
panel.BackgroundTransparency = 0
panel.BorderSizePixel = 0
panel.ZIndex = 10
panel.Parent = screenGui

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 14)
panelCorner.Parent = panel

local panelStroke = Instance.new("UIStroke")
panelStroke.Color = Color3.fromRGB(100, 70, 200)
panelStroke.Thickness = 1.5
panelStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
panelStroke.Parent = panel

local innerGlow = Instance.new("Frame")
innerGlow.Size = UDim2.new(1, -4, 1, -4)
innerGlow.Position = UDim2.new(0, 2, 0, 2)
innerGlow.BackgroundColor3 = Color3.fromRGB(120, 80, 255)
innerGlow.BackgroundTransparency = 0.94
innerGlow.BorderSizePixel = 0
innerGlow.ZIndex = 10
innerGlow.Parent = panel
local igc = Instance.new("UICorner"); igc.CornerRadius = UDim.new(0, 12); igc.Parent = innerGlow

-- ── DRAG ──
local dragging, dragStart, startPos = false, nil, nil
panel.InputBegan:Connect(function(inp)
	if not uiLocked and (inp.UserInputType == Enum.UserInputType.MouseButton1
		or inp.UserInputType == Enum.UserInputType.Touch) then
		dragging  = true
		dragStart = inp.Position
		startPos  = panel.Position
	end
end)
UserInputService.InputChanged:Connect(function(inp)
	if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement
		or inp.UserInputType == Enum.UserInputType.Touch) then
		local delta = inp.Position - dragStart
		panel.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)
UserInputService.InputEnded:Connect(function(inp)
	if inp.UserInputType == Enum.UserInputType.MouseButton1
		or inp.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

-- ── HELPERS ──
local function applyTextStroke(label)
	label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	label.TextStrokeTransparency = 0.2
end

local function makeVDivider(xOffset)
	local d = Instance.new("Frame")
	d.Size = UDim2.new(0, 1, 1, -16)
	d.Position = UDim2.new(0, xOffset, 0, 8)
	d.BackgroundColor3 = Color3.fromRGB(70, 50, 130)
	d.BackgroundTransparency = 0.4
	d.BorderSizePixel = 0
	d.ZIndex = 11
	d.Parent = panel
end

local function clearDots(parent)
	for _, child in ipairs(parent:GetChildren()) do
		if child.Name == "Dot" then child:Destroy() end
	end
end

local function drawDots(parent, count, dotColor)
	clearDots(parent)
	if count < 1 or count > 6 then return end
	for _, pos in ipairs(DOT_LAYOUTS[count]) do
		local dot = Instance.new("Frame")
		dot.Name = "Dot"
		dot.Size = UDim2.new(0, DOT_RADIUS * 2, 0, DOT_RADIUS * 2)
		dot.Position = UDim2.new(pos[1], -DOT_RADIUS, pos[2], -DOT_RADIUS)
		dot.BackgroundColor3 = dotColor
		dot.BorderSizePixel = 0
		dot.ZIndex = parent.ZIndex + 2
		dot.Parent = parent
		local dc = Instance.new("UICorner"); dc.CornerRadius = UDim.new(1, 0); dc.Parent = dot
	end
end

local function dotColorFor(bgColor)
	local lum = 0.299 * bgColor.R + 0.587 * bgColor.G + 0.114 * bgColor.B
	return lum > 0.55 and Color3.fromRGB(30, 20, 60) or Color3.new(1, 1, 1)
end

-- ── USER LABEL RECTANGLE ──
local userInfoBox = Instance.new("Frame")
userInfoBox.Name = "UserInfoBox"
userInfoBox.Size = UDim2.new(0, 180, 0, 20)
userInfoBox.Position = UDim2.new(0, DICE_PAD, 0, 4)
userInfoBox.BackgroundColor3 = Color3.fromRGB(20, 14, 52)
userInfoBox.BorderSizePixel = 0
userInfoBox.ZIndex = 17
userInfoBox.Parent = panel
local userBoxCorner = Instance.new("UICorner")
userBoxCorner.CornerRadius = UDim.new(0, 5)
userBoxCorner.Parent = userInfoBox
local userBoxStroke = Instance.new("UIStroke")
userBoxStroke.Color = Color3.fromRGB(100, 70, 200)
userBoxStroke.Thickness = 1
userBoxStroke.Parent = userInfoBox

local userInfoText = Instance.new("TextLabel")
userInfoText.Name = "UserInfoText"
userInfoText.Size = UDim2.new(1, -10, 1, 0)
userInfoText.Position = UDim2.new(0, 5, 0, 0)
userInfoText.BackgroundTransparency = 1
userInfoText.Text = userLabelText
userInfoText.TextColor3 = Color3.fromRGB(220, 210, 255)
userInfoText.TextSize = 10
userInfoText.Font = Enum.Font.GothamBold
userInfoText.TextXAlignment = Enum.TextXAlignment.Left
userInfoText.TextTruncate = Enum.TextTruncate.AtEnd
userInfoText.ZIndex = 18
userInfoText.Parent = userInfoBox

-- ── DICE ZONE ──
local diceList = {}
for i = 1, NUM_DICE do
	local x = DICE_PAD + (i - 1) * (DICE_SIZE + DICE_GAP)
	local y = (PANEL_H - DICE_SIZE) / 2

	local die = Instance.new("Frame")
	die.Size = UDim2.new(0, DICE_SIZE, 0, DICE_SIZE)
	die.Position = UDim2.new(0, x, 0, y)
	die.BackgroundColor3 = Color3.fromRGB(240, 238, 255)
	die.BorderSizePixel = 0
	die.ZIndex = 13
	die.Parent = panel

	local dc = Instance.new("UICorner"); dc.CornerRadius = UDim.new(0, 10); dc.Parent = die
	local ds = Instance.new("UIStroke")
	ds.Color = Color3.fromRGB(70, 50, 130)
	ds.Thickness = 2
	ds.Parent = die

	local shine = Instance.new("Frame")
	shine.Size = UDim2.new(0.75, 0, 0, 2)
	shine.Position = UDim2.new(0.125, 0, 0, 5)
	shine.BackgroundColor3 = Color3.new(1, 1, 1)
	shine.BackgroundTransparency = 0.4
	shine.BorderSizePixel = 0
	shine.ZIndex = 16
	shine.Parent = die
	local sc = Instance.new("UICorner"); sc.CornerRadius = UDim.new(1, 0); sc.Parent = shine

	local dotCanvas = Instance.new("Frame")
	dotCanvas.Name = "DotCanvas"
	dotCanvas.Size = UDim2.new(1, -10, 1, -18)
	dotCanvas.Position = UDim2.new(0, 5, 0, 5)
	dotCanvas.BackgroundTransparency = 1
	dotCanvas.ZIndex = 14
	dotCanvas.Parent = die

	local placeholder = Instance.new("TextLabel")
	placeholder.Name = "Placeholder"
	placeholder.Size = UDim2.fromScale(1, 1)
	placeholder.BackgroundTransparency = 1
	placeholder.Text = "?"
	placeholder.TextColor3 = Color3.fromRGB(160, 150, 210)
	placeholder.TextSize = 20
	placeholder.Font = Enum.Font.GothamBlack
	placeholder.TextXAlignment = Enum.TextXAlignment.Center
	placeholder.ZIndex = 15
	placeholder.Parent = die
	applyTextStroke(placeholder)

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Name = "NameLabel"
	nameLabel.Size = UDim2.new(1, -2, 0, 13)
	nameLabel.Position = UDim2.new(0, 1, 1, -14)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = ""
	nameLabel.TextColor3 = Color3.fromRGB(30, 20, 60)
	nameLabel.TextSize = 7
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextXAlignment = Enum.TextXAlignment.Center
	nameLabel.TextWrapped = true
	nameLabel.ZIndex = 16
	nameLabel.Parent = die
	applyTextStroke(nameLabel)

	diceList[i] = { die = die, dotCanvas = dotCanvas, placeholder = placeholder, nameLabel = nameLabel, stroke = ds }
end

makeVDivider(DICE_ZONE_W)

-- ── COLOR BUTTONS ZONE ──
local COLOR_ZONE_X = DICE_ZONE_W
local GRID_W = BTN_COLS * BTN_W + (BTN_COLS - 1) * BTN_GAP_X
local GRID_H = BTN_ROWS * BTN_H + (BTN_ROWS - 1) * BTN_GAP_Y
local GRID_START_X = COLOR_ZONE_X + (COLOR_ZONE_W - GRID_W) / 2
local GRID_START_Y = (PANEL_H - GRID_H - 16) / 2 + 16

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, COLOR_ZONE_W - 8, 0, 13)
statusLabel.Position = UDim2.new(0, COLOR_ZONE_X + 4, 0, GRID_START_Y - 15)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Tap a color to highlight it"
statusLabel.TextColor3 = Color3.fromRGB(170, 155, 255)
statusLabel.TextSize = 9
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.ZIndex = 12
statusLabel.Parent = panel
applyTextStroke(statusLabel)

local colorButtons = {}
for i, c in ipairs(COLORS) do
	local col = (i - 1) % BTN_COLS
	local row = math.floor((i - 1) / BTN_COLS)
	local bx = GRID_START_X + col * (BTN_W + BTN_GAP_X)
	local by = GRID_START_Y + row * (BTN_H + BTN_GAP_Y)

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, BTN_W, 0, BTN_H)
	btn.Position = UDim2.new(0, bx, 0, by)
	btn.BackgroundColor3 = c.color
	btn.BorderSizePixel = 0
	btn.Text = c.name
	btn.TextColor3 = (c.name == "Deal?") and Color3.fromRGB(20, 20, 20) or Color3.new(1, 1, 1)
	btn.TextSize = 9
	btn.Font = Enum.Font.GothamBold
	btn.ZIndex = 13
	btn.AutoButtonColor = false
	btn.Parent = panel
	applyTextStroke(btn)

	local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0, 7); bc.Parent = btn

	local blackStroke = Instance.new("UIStroke")
	blackStroke.Color = Color3.fromRGB(0, 0, 0)
	blackStroke.Thickness = 2
	blackStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	blackStroke.Parent = btn

	local greenRing = Instance.new("Frame")
	greenRing.Name = "GreenRing"
	greenRing.Size = UDim2.new(1, -4, 1, -4)
	greenRing.Position = UDim2.new(0, 2, 0, 2)
	greenRing.BackgroundTransparency = 1
	greenRing.BorderSizePixel = 0
	greenRing.ZIndex = 14
	greenRing.Visible = false
	greenRing.Parent = btn
	local grc = Instance.new("UICorner"); grc.CornerRadius = UDim.new(0, 5); grc.Parent = greenRing
	local grs = Instance.new("UIStroke")
	grs.Color = c.color
	grs.Thickness = 2.5
	grs.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	grs.Parent = greenRing

	btn.MouseEnter:Connect(function()
		if selectedColor ~= i then
			TweenService:Create(btn, TweenInfo.new(0.1), {
				BackgroundColor3 = c.color:Lerp(Color3.new(1, 1, 1), 0.15)
			}):Play()
		end
	end)
	btn.MouseLeave:Connect(function()
		if selectedColor ~= i then
			TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = c.color}):Play()
		end
	end)

	colorButtons[i] = { btn = btn, greenRing = greenRing, baseColor = c.color }
end

makeVDivider(DICE_ZONE_W + COLOR_ZONE_W)

-- ── ACTION ZONE ──
local ACTION_ZONE_X = DICE_ZONE_W + COLOR_ZONE_W
local ACT_CENTER_X = ACTION_ZONE_X + ACTION_ZONE_W / 2

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, ACTION_ZONE_W - 4, 0, 13)
titleLabel.Position = UDim2.new(0, ACTION_ZONE_X + 2, 0, 7)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🎲 BRAINROT"
titleLabel.TextColor3 = Color3.fromRGB(190, 165, 255)
titleLabel.TextSize = 8
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.ZIndex = 12
titleLabel.Parent = panel
applyTextStroke(titleLabel)

local rollBtn = Instance.new("TextButton")
rollBtn.Size = UDim2.new(0, ACTION_W, 0, 32)
rollBtn.Position = UDim2.new(0, ACT_CENTER_X - ACTION_W / 2, 0, PANEL_H / 2 - 36)
rollBtn.BackgroundColor3 = Color3.fromRGB(100, 65, 230)
rollBtn.Text = "🎲  ROLL"
rollBtn.TextColor3 = Color3.new(1, 1, 1)
rollBtn.TextSize = 12
rollBtn.Font = Enum.Font.GothamBlack
rollBtn.BorderSizePixel = 0
rollBtn.ZIndex = 12
rollBtn.AutoButtonColor = false
rollBtn.Parent = panel
applyTextStroke(rollBtn)
local rollC = Instance.new("UICorner"); rollC.CornerRadius = UDim.new(0, 9); rollC.Parent = rollBtn
local rollStroke = Instance.new("UIStroke")
rollStroke.Color = Color3.fromRGB(0, 0, 0)
rollStroke.Thickness = 2
rollStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
rollStroke.Parent = rollBtn

local resetBtn = Instance.new("TextButton")
resetBtn.Size = UDim2.new(0, ACTION_W, 0, 22)
resetBtn.Position = UDim2.new(0, ACT_CENTER_X - ACTION_W / 2, 0, PANEL_H / 2 + 4)
resetBtn.BackgroundColor3 = Color3.fromRGB(14, 10, 38)
resetBtn.Text = "↺  Reset"
resetBtn.TextColor3 = Color3.fromRGB(160, 140, 220)
resetBtn.TextSize = 9
resetBtn.Font = Enum.Font.GothamBold
resetBtn.BorderSizePixel = 0
resetBtn.ZIndex = 12
resetBtn.AutoButtonColor = false
resetBtn.Parent = panel
applyTextStroke(resetBtn)
local resC = Instance.new("UICorner"); resC.CornerRadius = UDim.new(0, 7); resC.Parent = resetBtn
local resStroke = Instance.new("UIStroke")
resStroke.Color = Color3.fromRGB(0, 0, 0)
resStroke.Thickness = 2
resStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
resStroke.Parent = resetBtn

-- ── SETTINGS (added under Reset; original layout retained) ──
local settingsBtn = Instance.new("TextButton")
settingsBtn.Name = "SettingsButton"
settingsBtn.Size = UDim2.new(0, ACTION_W, 0, 22)
settingsBtn.Position = UDim2.new(0, ACT_CENTER_X - ACTION_W / 2, 0, PANEL_H / 2 + 30)
settingsBtn.BackgroundColor3 = Color3.fromRGB(40, 28, 85)
settingsBtn.Text = "Settings"
settingsBtn.TextColor3 = Color3.fromRGB(220, 210, 255)
settingsBtn.TextSize = 9
settingsBtn.Font = Enum.Font.GothamBold
settingsBtn.BorderSizePixel = 0
settingsBtn.ZIndex = 12
settingsBtn.AutoButtonColor = false
settingsBtn.Parent = panel
local settingsCorner = Instance.new("UICorner")
settingsCorner.CornerRadius = UDim.new(0, 7)
settingsCorner.Parent = settingsBtn
local settingsStroke = Instance.new("UIStroke")
settingsStroke.Color = Color3.fromRGB(0, 0, 0)
settingsStroke.Thickness = 2
settingsStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
settingsStroke.Parent = settingsBtn

local settingsPanel = Instance.new("Frame")
settingsPanel.Name = "SettingsPanel"
settingsPanel.Size = UDim2.new(0, 220, 0, 124)
settingsPanel.Position = UDim2.new(0, PANEL_W - 230, 0, -132)
settingsPanel.BackgroundColor3 = Color3.fromRGB(12, 8, 38)
settingsPanel.BorderSizePixel = 0
settingsPanel.Visible = false
settingsPanel.ZIndex = 30
settingsPanel.Parent = panel
local settingsPanelCorner = Instance.new("UICorner")
settingsPanelCorner.CornerRadius = UDim.new(0, 10)
settingsPanelCorner.Parent = settingsPanel
local settingsPanelStroke = Instance.new("UIStroke")
settingsPanelStroke.Color = Color3.fromRGB(100, 70, 200)
settingsPanelStroke.Thickness = 1.5
settingsPanelStroke.Parent = settingsPanel

local settingsTitle = Instance.new("TextLabel")
settingsTitle.Size = UDim2.new(1, -16, 0, 22)
settingsTitle.Position = UDim2.new(0, 8, 0, 4)
settingsTitle.BackgroundTransparency = 1
settingsTitle.Text = "Settings"
settingsTitle.TextColor3 = Color3.fromRGB(230, 220, 255)
settingsTitle.TextSize = 13
settingsTitle.Font = Enum.Font.GothamBold
settingsTitle.TextXAlignment = Enum.TextXAlignment.Left
settingsTitle.ZIndex = 31
settingsTitle.Parent = settingsPanel

local lockBtn = Instance.new("TextButton")
lockBtn.Name = "UILockButton"
lockBtn.Size = UDim2.new(1, -16, 0, 25)
lockBtn.Position = UDim2.new(0, 8, 0, 29)
lockBtn.BackgroundColor3 = Color3.fromRGB(40, 28, 85)
lockBtn.BorderSizePixel = 0
lockBtn.TextColor3 = Color3.fromRGB(230, 220, 255)
lockBtn.TextSize = 10
lockBtn.Font = Enum.Font.GothamBold
lockBtn.Text = "UI Lock: OFF"
lockBtn.ZIndex = 31
lockBtn.Parent = settingsPanel
local lockCorner = Instance.new("UICorner")
lockCorner.CornerRadius = UDim.new(0, 6)
lockCorner.Parent = lockBtn

local userTextInput = Instance.new("TextBox")
userTextInput.Name = "UserTextInput"
userTextInput.Size = UDim2.new(1, -16, 0, 26)
userTextInput.Position = UDim2.new(0, 8, 0, 61)
userTextInput.BackgroundColor3 = Color3.fromRGB(25, 18, 60)
userTextInput.BorderSizePixel = 0
userTextInput.PlaceholderText = "User: blala"
userTextInput.Text = userLabelText
userTextInput.ClearTextOnFocus = false
userTextInput.TextColor3 = Color3.fromRGB(240, 235, 255)
userTextInput.PlaceholderColor3 = Color3.fromRGB(155, 140, 200)
userTextInput.TextSize = 10
userTextInput.Font = Enum.Font.Gotham
userTextInput.TextXAlignment = Enum.TextXAlignment.Left
userTextInput.ZIndex = 31
userTextInput.Parent = settingsPanel
local userInputCorner = Instance.new("UICorner")
userInputCorner.CornerRadius = UDim.new(0, 6)
userInputCorner.Parent = userTextInput

local userApplyBtn = Instance.new("TextButton")
userApplyBtn.Name = "ApplyUserTextButton"
userApplyBtn.Size = UDim2.new(1, -16, 0, 22)
userApplyBtn.Position = UDim2.new(0, 8, 0, 93)
userApplyBtn.BackgroundColor3 = Color3.fromRGB(75, 50, 150)
userApplyBtn.BorderSizePixel = 0
userApplyBtn.Text = "Apply User Text"
userApplyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
userApplyBtn.TextSize = 10
userApplyBtn.Font = Enum.Font.GothamBold
userApplyBtn.ZIndex = 31
userApplyBtn.Parent = settingsPanel
local userApplyCorner = Instance.new("UICorner")
userApplyCorner.CornerRadius = UDim.new(0, 6)
userApplyCorner.Parent = userApplyBtn

settingsBtn.MouseButton1Click:Connect(function()
	settingsPanel.Visible = not settingsPanel.Visible
end)

lockBtn.MouseButton1Click:Connect(function()
	uiLocked = not uiLocked
	lockBtn.Text = uiLocked and "UI Lock: ON" or "UI Lock: OFF"
	lockBtn.BackgroundColor3 = uiLocked and Color3.fromRGB(100, 45, 70) or Color3.fromRGB(40, 28, 85)
	if uiLocked then dragging = false end
end)

userApplyBtn.MouseButton1Click:Connect(function()
	local value = userTextInput.Text
	if value == "" then value = "User: blala" end
	userLabelText = value
	userInfoText.Text = userLabelText
end)

-- ── LOGIC ──
local function clearDice()
	for i = 1, NUM_DICE do
		local d = diceList[i]
		TweenService:Create(d.die, TweenInfo.new(0.2), {
			BackgroundColor3 = Color3.fromRGB(240, 238, 255)
		}):Play()
		clearDots(d.dotCanvas)
		d.placeholder.Visible = true
		d.nameLabel.Text = ""
		d.stroke.Color = Color3.fromRGB(70, 50, 130)
		d.stroke.Thickness = 2
	end
end

local function showDieResult(d, r)
	d.die.BackgroundColor3 = r.color
	d.placeholder.Visible = false
	clearDots(d.dotCanvas)
	drawDots(d.dotCanvas, math.random(1, 6), dotColorFor(r.color))
	local tc = (r.name == "Deal?") and Color3.fromRGB(20, 20, 20) or Color3.new(1, 1, 1)
	d.nameLabel.Text = r.name
	d.nameLabel.TextColor3 = tc
end

local function toggleColor(index)
	if isRolling then return end
	local c = COLORS[index]
	if selectedColor == index then
		colorButtons[index].greenRing.Visible = false
		TweenService:Create(colorButtons[index].btn, TweenInfo.new(0.15), {
			BackgroundColor3 = colorButtons[index].baseColor
		}):Play()
		selectedColor = nil
		statusLabel.Text = "Tap a color to highlight it"
		statusLabel.TextColor3 = Color3.fromRGB(170, 155, 255)
	else
		if selectedColor then
			colorButtons[selectedColor].greenRing.Visible = false
			TweenService:Create(colorButtons[selectedColor].btn, TweenInfo.new(0.15), {
				BackgroundColor3 = colorButtons[selectedColor].baseColor
			}):Play()
		end
		selectedColor = index
		colorButtons[index].greenRing.Visible = true
		TweenService:Create(colorButtons[index].btn, TweenInfo.new(0.15), {
			BackgroundColor3 = c.color:Lerp(Color3.new(1, 1, 1), 0.2)
		}):Play()
		statusLabel.Text = c.name .. " — Roll now!"
		statusLabel.TextColor3 = c.color
	end
end

for i, cb in ipairs(colorButtons) do
	cb.btn.MouseButton1Click:Connect(function() toggleColor(i) end)
end

rollBtn.MouseEnter:Connect(function()
	if not isRolling then
		TweenService:Create(rollBtn, TweenInfo.new(0.12), {
			BackgroundColor3 = Color3.fromRGB(130, 90, 255)
		}):Play()
	end
end)
rollBtn.MouseLeave:Connect(function()
	TweenService:Create(rollBtn, TweenInfo.new(0.12), {
		BackgroundColor3 = Color3.fromRGB(100, 65, 230)
	}):Play()
end)

rollBtn.MouseButton1Click:Connect(function()
	if isRolling then return end
	local pool = {}
	for i, c in ipairs(COLORS) do
		if i ~= selectedColor then table.insert(pool, c) end
	end
	if #pool == 0 then return end

	isRolling = true
	rollBtn.BackgroundTransparency = 0.4
	statusLabel.Text = "Rolling…"
	statusLabel.TextColor3 = Color3.fromRGB(180, 157, 255)
	clearDice()

	local ticks = 0
	local conn
	conn = RunService.Heartbeat:Connect(function()
		ticks += 1
		for i = 1, NUM_DICE do
			local r = pool[math.random(#pool)]
			local d = diceList[i]
			d.die.BackgroundColor3 = r.color
			d.placeholder.Visible = false
			clearDots(d.dotCanvas)
			drawDots(d.dotCanvas, math.random(1, 6), dotColorFor(r.color))
			d.nameLabel.Text = r.name
			d.nameLabel.TextColor3 = (r.name == "Deal?") and Color3.fromRGB(20, 20, 20) or Color3.new(1, 1, 1)
		end

		if ticks >= 28 then
			conn:Disconnect()
			local results = {}
			for i = 1, NUM_DICE do results[i] = pool[math.random(#pool)] end

			for i = 1, NUM_DICE do
				task.delay((i - 1) * 0.1, function()
					local d = diceList[i]
					local r = results[i]
					d.die.BackgroundColor3 = Color3.new(1, 1, 1)
					d.stroke.Color = Color3.new(1, 1, 1)
					d.stroke.Thickness = 2.5
					clearDots(d.dotCanvas)
					task.delay(0.07, function()
						TweenService:Create(d.die, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
							BackgroundColor3 = r.color
						}):Play()
						TweenService:Create(d.stroke, TweenInfo.new(0.3), {
							Color = Color3.fromRGB(70, 50, 130),
							Thickness = 2,
						}):Play()
						showDieResult(d, r)
					end)
				end)
			end

			task.delay(NUM_DICE * 0.1 + 0.4, function()
				local seen, names = {}, {}
				for _, r in ipairs(results) do
					if not seen[r.name] then seen[r.name] = true; table.insert(names, r.name) end
				end
				TweenService:Create(panelStroke, TweenInfo.new(0.15), {
					Color = selectedColor and COLORS[selectedColor].color or Color3.fromRGB(100, 65, 230),
					Thickness = 2.5,
				}):Play()
				task.delay(0.5, function()
					TweenService:Create(panelStroke, TweenInfo.new(0.4), {
						Color = Color3.fromRGB(100, 70, 200),
						Thickness = 1.5,
					}):Play()
				end)
				statusLabel.Text = table.concat(names, " · ")
				statusLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
				isRolling = false
				rollBtn.BackgroundTransparency = 0
			end)
		end
	end)
end)

resetBtn.MouseButton1Click:Connect(function()
	if isRolling then return end
	if selectedColor then
		colorButtons[selectedColor].greenRing.Visible = false
		TweenService:Create(colorButtons[selectedColor].btn, TweenInfo.new(0.15), {
			BackgroundColor3 = colorButtons[selectedColor].baseColor
		}):Play()
		selectedColor = nil
	end
	clearDice()
	statusLabel.Text = "Tap a color to highlight it"
	statusLabel.TextColor3 = Color3.fromRGB(170, 155, 255)
end)