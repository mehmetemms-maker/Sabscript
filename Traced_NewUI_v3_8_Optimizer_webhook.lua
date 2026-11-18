--[[

]]
local sliced85, sliced86, localPlayer, sliced87, net, sliced88, sliced89, sliced90, keyboardEnabled, flag18
local slicedfn29, sliced91, tbl18, flag19, sliced92, flag20, autoRedeem, autoType, manual
local flag21, thread, slicedn32, slicedn33, listenKey, g, str7, tbl19, sliced93, sliced94
local flag22, autoListen, sliced95, sliced96, slicedfn30, slicedfn31, slicedfn32, slicedfn33, slicedfn34, slicedfn35
local slicedfn36, slicedfn37, slicedfn38, slicedfn39, slicedfn40, slicedfn41, tbl21, gothamMedium, gothamBold
local gothamBlack, slicedfn42, slicedfn43, slicedfn44, slicedfn45, slicedfn46, slicedfn47, slicedfn48, slicedfn49, ScreenGui
local Main, Frame, slicedn34, sliced99, slicedfn50, TextBox, sliced100
local clear, redeem, slicedfn51, listen, Frame2, Frame3, TextButton, sliced101, sliced102, sliced103
local sliced104, sliced105, sliced106, start, sliced107, sliced108
do
local visible, showKeybinds, slicedfn52, Settings, Frame4, Frame5, words
do
local tbl22, Frame6
do
do
local sliced109
do
do
local getupvalues_, getconnections_, setupvalue_
do
do
local writeClipboard
do
do
local slicedfn53 = cloneref or function(arg)
return arg
end
local sliced110 = slicedfn53(game:GetService("Players"))
sliced85 = slicedfn53(game:GetService("ReplicatedStorage"))
sliced86 = slicedfn53(game:GetService("UserInputService"))
sliced109 = slicedfn53(game:GetService("TweenService"))
localPlayer = sliced110.LocalPlayer
sliced87 = localPlayer:WaitForChild("PlayerGui")
net = sliced85:WaitForChild("Packages"):WaitForChild("Net")
sliced88 = slicedfn53(game:GetService("RunService"))
end
do
sliced89 = localPlayer
sliced90 = sliced87
getupvalues_ = debug and debug.getupvalues or getupvalues
do
local sliced110 = getconnections
if sliced110 then
getconnections_ = sliced110
else
getconnections_ = debug and debug.getconnections
end
end
end
setupvalue_ = debug and debug.setupvalue or setupvalue
do
local sliced110 = setclipboard or toclipboard
if sliced110 then
writeClipboard = sliced110
else
writeClipboard = syn and syn.write_clipboard
end
end
end
do
keyboardEnabled = sliced86.KeyboardEnabled
flag18 = sliced86.TouchEnabled and not keyboardEnabled
slicedfn29 = function()
if not flag18 then
return 1
end
local currentCamera = workspace.CurrentCamera
currentCamera = currentCamera and currentCamera.ViewportSize.Y or 600
return math.clamp(currentCamera * 0.88 / 340, 0.5, 1.3) * 0.85
end
sliced91 = slicedfn29()
do
local tbl23 = {}
if readfile and isfile then
local ok, result = pcall(function()
if isfile("redeemer_settings.txt") then
return readfile("redeemer_settings.txt")
end
end)
if ok and type(result) == "string" then
for match in result:gmatch("[^\n]+") do
local match2, sliced110 = match:match("^(%w+)=(.*)$")
if match2 then
tbl23[match2] = sliced110
end
end
end
end
_G.__RdmCfgBool = function(arg, arg2)
local sliced110 = tbl23[arg]
if sliced110 == "1" then
return true
end
if sliced110 == "0" then
return false
end
return arg2
end
_G.__RdmCfgStr = function(arg, arg2)
local sliced110 = tbl23[arg]
local sliced111 = "string"
return type(sliced110) == sliced111 and sliced110 ~= "" and sliced110 or arg2
end
_G.__RdmCfgSet = function(arg, arg2)
tbl23[arg] = type(arg2) == "boolean" and (arg2 and "1" or "0") or tostring(arg2)
if not writefile then
return
end
local tbl24 = {}
for k, sliced110 in pairs(tbl23) do
tbl24[#tbl24 + 1] = k .. "=" .. tostring(sliced110)
end
table.sort(tbl24)
pcall(writefile, "redeemer_settings.txt", table.concat(tbl24, "\n"))
end
end
end
do
tbl18 = {
listenKey = Enum.KeyCode.F,
}
flag19 = true
sliced92 = 0.5
flag20 = false
autoRedeem = true
autoType = true
manual = _G.__RdmCfgBool("manual", false)
flag21 = false
thread = nil
slicedn32 = 0
slicedn33 = math.clamp(tonumber(_G.__RdmCfgStr("words", "1")) or 1, 1, 4)
listenKey = tbl18.listenKey
g = Enum.KeyCode.G
str7 = nil
tbl19 = {}
sliced93 = nil
sliced94 = nil
flag22 = false
autoListen = _G.__RdmCfgBool("autoListen", true)
sliced95 = _G.__RdmCfgBool("spamOnListen", true)
showKeybinds = _G.__RdmCfgBool("showKeybinds", keyboardEnabled)
sliced96 = true
slicedfn30 = nil
slicedfn52 = nil
slicedfn31 = nil
slicedfn32 = nil
slicedfn33 = function(arg)
if type(arg) ~= "string" then
return tostring(arg)
end
return (arg:gsub("<[^>]->", ""))
end
slicedfn34 = function(arg)
return (arg or ""):gsub("^%s+", ""):gsub("%s+$", "")
end
slicedfn35 = function(arg)
if not writeClipboard then
return false
end
return (pcall(writeClipboard, arg))
end
slicedfn36 = function(arg)
local tbl23 = {}
for match in arg:gmatch("[%w_]+") do
tbl23[#tbl23 + 1] = match
end
return tbl23
end
slicedfn37 = function(arg)
local sliced110 = nil
for match in arg:gmatch("[%w_]+") do
if #match >= 4 and match:match("%a") and (match:match("%u") or match:match("%d")) then
sliced110 = match
end
end
if sliced110 then
return sliced110
end
for match in arg:gmatch("[%w_]+") do
if #match >= 4 then
return match
end
end
end
do
local tbl23 = {
leads = {
"use",
"using",
"redeem",
"type",
"enter",
"claim",
"with",
"grab",
"got",
"here is",
"heres",
"here's",
"there is",
"theres",
"there's",
},
articles = {
"",
"the%s+",
"a%s+",
"an%s+",
"this%s+",
"your%s+",
"new%s+",
},
patterns = {
"code%s+is",
"codes?%s+are",
"code%s+for",
"code%s+to%s+use",
"code%s*[:%-]",
"new%s+code",
"free%s+code",
"secret%s+code",
"working%s+code",
"another%s+code",
},
}
for _, lead in ipairs(tbl23.leads) do
local str8 = lead:gsub("%s+", "%%s+")
for _, article in ipairs(tbl23.articles) do
tbl23.patterns[#tbl23.patterns + 1] = str8 .. "%s+" .. article .. "code"
end
end
tbl23.names = { "sammy" }
local function slicedfn53(arg)
for match, match2 in arg:gmatch("()([%w_]+)") do
if #match2 >= 4 and match2:match("%a") and (match2:match("%u") or match2:match("%d")) then
return arg:sub(match)
end
end
end
slicedfn38 = function(arg)
local str8 = arg:lower()
local sliced110 = nil
local sliced111 = nil
local function slicedfn54(arg2, arg3, arg4)
local slicedn35 = 1
while true do
local ok, result, result2 = pcall(string.find, str8, arg2, slicedn35, arg3)
if not (not ok or not result) then
if not sliced110 or result2 > sliced110 then
sliced110 = result2
sliced111 = arg4
end
slicedn35 = result2 + 1
continue
end
break
end
end
for _, pattern in ipairs(tbl23.patterns) do
slicedfn54(pattern, false, false)
end
if str8:find("code") then
for _, name in ipairs(tbl23.names) do
local sliced112 = true
slicedfn54(name:lower(), sliced112, true)
end
end
if not sliced110 then
return nil
end
local str9 = arg:sub(sliced110 + 1)
local sliced112 = slicedfn53(str9)
if sliced111 then
return sliced112
end
return sliced112 or ""
end
end
end
end
do
local function slicedfn53(arg)
if not getupvalues_ then
return {}
end
local ok, result = pcall(getupvalues_, arg)
local tbl23 = {}
if ok and result then
for _, sliced110 in pairs(result) do
if typeof(sliced110) == "Instance" and (sliced110:IsA("RemoteEvent") or sliced110:IsA("RemoteFunction") or sliced110:IsA("UnreliableRemoteEvent")) and sliced110.Parent == net then
table.insert(tbl23, sliced110)
end
end
end
return tbl23
end
slicedfn39 = function()
local ok, result = pcall(function()
return require(sliced85.Controllers:FindFirstChild("NotificationController", true))
end)
if ok then
local sliced110 = "table"
ok = type(result) == sliced110
end
if ok then
local sliced110 = "function"
ok = type(result.Start) == sliced110
end
if ok then
return slicedfn53(result.Start)[1]
end
end
end
end
do
local slicedfn53, slicedfn54
do
slicedfn53 = function()
local codes = sliced87:FindFirstChild("Codes")
if not codes then
return nil
end
local sliced110 = (codes:FindFirstChild("Codes") or codes):FindFirstChild("Main")
sliced110 = sliced110 and sliced110:FindFirstChild("TextBox")
if sliced110 and sliced110:IsA("TextBox") then
return sliced110
end
for _, descendant in ipairs(codes:GetDescendants()) do
if descendant:IsA("TextBox") then
return descendant
end
end
end
do
local function slicedfn55()
local codes = sliced87:FindFirstChild("Codes")
if not codes then
return nil
end
local codes2 = codes:FindFirstChild("Codes") or codes
local confirm = (codes2:FindFirstChild("Main") or codes2):FindFirstChild("Confirm")
if confirm and (confirm:IsA("ImageButton") or confirm:IsA("TextButton")) then
return confirm
end
local sliced110 = nil
for _, descendant in ipairs(codes:GetDescendants()) do
if descendant:IsA("ImageButton") or descendant:IsA("TextButton") then
local str8 = descendant.Name:lower()
if str8:find("confirm") or str8:find("submit") or str8:find("redeem") or str8:find("enter") then
return descendant
end
sliced110 = sliced110 or descendant
end
end
return sliced110
end
local slicedfn56 = nil
slicedfn56 = function(arg, arg2)
if not (arg and setupvalue_ and getupvalues_) then
return
end
arg2 = arg2 or 1
local ok, result = pcall(getupvalues_, arg)
if ok and type(result) == "table" then
for k, sliced110 in pairs(result) do
local sliced111 = "boolean"
if type(sliced110) == sliced111 then
pcall(setupvalue_, arg, k, false)
else
local sliced112 = "function"
if type(sliced110) == sliced112 and arg2 > 0 then
slicedfn56(sliced110, arg2 - 1)
end
end
end
end
end
local function slicedfn57(arg, ...)
if not getconnections_ then
return false
end
local ok, result = pcall(getconnections_, arg)
local flag23 = not ok
if not flag23 then
local sliced110 = "table"
flag23 = type(result) ~= sliced110
end
if flag23 or #result == 0 then
return false
end
local sliced110 = table.pack(...)
local sliced111, sliced112, sliced113 = ipairs(result)
local flag24 = false
for _, sliced114 in sliced111, sliced112, sliced113 do
if sliced114.Enabled ~= false then
local function_ = nil
pcall(function()
function_ = sliced114.Function
end)
slicedfn56(function_)
local ok2
if function_ then
ok2 = pcall(task.spawn, function_, table.unpack(sliced110, 1, sliced110.n))
else
ok2 = pcall(function()
sliced114:Fire(table.unpack(sliced110, 1, sliced110.n))
end)
end
flag24 = flag24 or ok2
end
end
return flag24
end
slicedfn40 = function(text)
if type(text) ~= "string" or text == "" then
return
end
local sliced110 = slicedfn53()
if not sliced110 then
return
end
pcall(function()
if sliced110.Text ~= text then
sliced110.Text = text
end
end)
end
slicedfn54 = function(text)
if not getconnections_ then
return false, "no getconnections"
end
local sliced110 = slicedfn53()
if not sliced110 then
return false, "code box not found"
end
pcall(function()
sliced110.Text = text
sliced110.Active = true
sliced110.Selectable = true
end)
local sliced111 = slicedfn55()
local flag23 = false
if sliced111 then
local flag24 = slicedfn57(sliced111.MouseButton1Click)
flag24 = flag24 or false
flag23 = slicedfn57(sliced111.Activated) or flag24
end
if not flag23 then
flag23 = slicedfn57(sliced110.FocusLost, true) or flag23
end
return flag23, flag23 and "submitted" or "no submit control"
end
end
end
do
local function slicedfn55(text)
local sliced110 = slicedfn53()
if not sliced110 then
return false, "code box not found"
end
if not pcall(function()
sliced110.Text = text
sliced110:CaptureFocus()
end) then
return false, "focus failed"
end
task.wait(0.1)
local ok = pcall(function()
sliced110:ReleaseFocus(true)
end)
return ok, ok and "submitted" or "release failed"
end
slicedfn41 = function(arg)
local sliced110, sliced111 = slicedfn54(arg)
if sliced110 then
return true, sliced111
end
if getconnections_ then
return false, sliced111
end
return slicedfn55(arg)
end
end
end
end
end
local sliced110
do
do
tbl21 = {
bg = Color3.fromRGB(14, 14, 14),
panel = Color3.fromRGB(22, 22, 22),
panel2 = Color3.fromRGB(32, 32, 32),
line = Color3.fromRGB(52, 52, 52),
acc = Color3.fromRGB(235, 235, 235),
acc2 = Color3.fromRGB(150, 150, 150),
accHi = Color3.fromRGB(255, 255, 255),
txt = Color3.fromRGB(240, 240, 240),
sub = Color3.fromRGB(150, 150, 150),
ok = Color3.fromRGB(52, 211, 153),
err = Color3.fromRGB(248, 90, 100),
warn = Color3.fromRGB(251, 191, 36),
input = Color3.fromRGB(10, 10, 10),
dark = Color3.fromRGB(6, 6, 6),
}
gothamMedium = Enum.Font.GothamMedium
gothamBold = Enum.Font.GothamBold
gothamBlack = Enum.Font.GothamBlack
slicedfn42 = function(arg, arg2, parent)
local instance = Instance.new(arg)
local sliced111 = pairs
local tbl23 = arg2 or {}
for k, sliced112 in sliced111(tbl23) do
instance[k] = sliced112
end
if parent then
instance.Parent = parent
end
return instance
end
slicedfn43 = function(arg, arg2)
slicedfn42("UICorner", { CornerRadius = UDim.new(0, arg2 or 8) }, arg)
end
slicedfn44 = function(arg, arg2, arg3, arg4)
return slicedfn42("UIStroke", { Color = arg2 or tbl21.line, Thickness = arg3 or 1, Transparency = arg4 or 0 }, arg)
end
slicedfn45 = function(arg, arg2, arg3, arg4)
sliced109:Create(arg, TweenInfo.new(arg2, arg4 or Enum.EasingStyle.Quad), arg3):Play()
end
do
local function slicedfn53(arg, arg2, arg3, arg4)
return slicedfn42("UIGradient", { Color = ColorSequence.new(arg2, arg3), Rotation = arg4 or 90 }, arg)
end
slicedfn46 = function(arg, arg2, arg3, arg4, arg5, arg6)
return slicedfn42("TextLabel", {
BackgroundTransparency = 1,
Text = arg,
Font = arg4 or gothamMedium,
TextSize = arg2 or 12,
TextColor3 = arg3 or tbl21.txt,
TextXAlignment = arg5 or Enum.TextXAlignment.Left,
}, arg6)
end
local function slicedfn54(arg, arg2)
local flag23 = nil
local sliced111 = nil
local sliced112 = nil
arg.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
local position = input.Position
local position2 = arg2.Position
flag23 = true
sliced111 = position
sliced112 = position2
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
flag23 = false
end
end)
end
end)
sliced86.InputChanged:Connect(function(input)
if flag23 and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
local slicedn35 = input.Position - sliced111
arg2.Position = UDim2.new(sliced112.X.Scale, sliced112.X.Offset + slicedn35.X, sliced112.Y.Scale, sliced112.Y.Offset + slicedn35.Y)
end
end)
end
slicedfn47 = function(arg, arg2, arg3, arg4)
local sliced111 = slicedfn42("Frame", {
Name = arg,
Size = UDim2.fromOffset(arg2, arg3),
BackgroundColor3 = tbl21.bg,
BorderSizePixel = 0,
Active = true,
ClipsDescendants = true,
})
slicedfn43(sliced111, 14)
slicedfn53(sliced111, Color3.fromRGB(16, 19, 32), Color3.fromRGB(8, 9, 14), 90)
slicedfn44(sliced111, tbl21.acc, 1.5, 0.45)
if flag18 then
slicedfn42("UIScale", { Name = "WinScale", Scale = sliced91 }, sliced111)
end
local Frame7 = slicedfn42("Frame", { Name = "Header", Size = UDim2.new(1, 0, 0, 44), BackgroundColor3 = tbl21.panel, BorderSizePixel = 0 }, sliced111)
slicedfn43(Frame7, 14)
slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 14),
Position = UDim2.new(0, 0, 1, -14),
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
}, Frame7)
local ImageLabel = slicedfn42("ImageLabel", {
Size = UDim2.fromOffset(24, 24),
Position = UDim2.new(0, 12, 0.5, -12),
BackgroundColor3 = tbl21.acc,
BorderSizePixel = 0,
Image = "",
}, Frame7)
slicedfn43(ImageLabel, 12)
slicedfn44(ImageLabel, tbl21.acc, 1.5, 0.2)
local sliced112 = slicedfn46(arg4, 14, tbl21.txt, gothamBlack, Enum.TextXAlignment.Left, Frame7)
sliced112.Size = UDim2.new(1, -80, 1, 0)
sliced112.Position = UDim2.fromOffset(44, 0)
slicedfn54(Frame7, sliced111)
return sliced111, Frame7, ImageLabel, sliced112
end
slicedfn48 = function(arg, arg2)
local TextButton2 = slicedfn42("TextButton", {
BackgroundColor3 = tbl21.panel2,
Text = arg,
Font = gothamBold,
TextSize = 12,
TextColor3 = tbl21.txt,
AutoButtonColor = false,
BorderSizePixel = 0,
}, arg2)
slicedfn43(TextButton2, 8)
local sliced111 = slicedfn44(TextButton2, tbl21.line, 1, 0.2)
TextButton2.MouseEnter:Connect(function()
slicedfn45(TextButton2, 0.12, { BackgroundColor3 = tbl21.panel })
slicedfn45(sliced111, 0.12, { Color = tbl21.acc, Transparency = 0 })
end)
TextButton2.MouseLeave:Connect(function()
slicedfn45(TextButton2, 0.12, { BackgroundColor3 = tbl21.panel2 })
slicedfn45(sliced111, 0.12, { Color = tbl21.line, Transparency = 0.2 })
end)
return TextButton2
end
slicedfn49 = function(arg, arg2)
local TextButton2 = slicedfn42("TextButton", {
BackgroundColor3 = tbl21.acc,
Text = arg,
Font = gothamBlack,
TextSize = 13,
TextColor3 = Color3.fromRGB(255, 255, 255),
AutoButtonColor = false,
BorderSizePixel = 0,
}, arg2)
slicedfn43(TextButton2, 8)
slicedfn53(TextButton2, tbl21.acc, tbl21.acc2, 90)
TextButton2.MouseEnter:Connect(function()
slicedfn45(TextButton2, 0.12, { BackgroundColor3 = tbl21.accHi })
end)
TextButton2.MouseLeave:Connect(function()
slicedfn45(TextButton2, 0.12, { BackgroundColor3 = tbl21.acc })
end)
return TextButton2
end
end
end
do
local hui = gethui and gethui() or sliced87
local traced = hui:FindFirstChild("Traced")
if traced then
traced:Destroy()
end
ScreenGui = slicedfn42("ScreenGui", {
Name = "Traced",
ResetOnSpawn = false,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
DisplayOrder = 250,
}, hui)
end
do
local sliced111, sliced112
Main, sliced110, sliced111, sliced112 = slicedfn47("Main", 320, 330, "TRACED")
Main.Position = UDim2.new(1, -344, 0.5, -165)
if flag18 then
Main.Position = UDim2.new(1, -math.floor(320 * sliced91) - 8, 0.5, -math.floor(330 * sliced91 / 2))
end
Main.Parent = ScreenGui
sliced112.Size = UDim2.new(1, -262, 1, 0)
end
end
do
local accentBar = slicedfn42("Frame", {
Name = "AccentBar",
Size = UDim2.new(1, 0, 0, 3),
BackgroundColor3 = tbl21.acc,
BorderSizePixel = 0,
ZIndex = 5,
}, Main)
slicedfn42("UIGradient", {
Color = ColorSequence.new(tbl21.acc2, tbl21.accHi),
Rotation = 0,
}, accentBar)
end
do
Frame = slicedfn42("Frame", {
Size = UDim2.fromOffset(8, 8),
Position = UDim2.new(1, -212, 0.5, -4),
BackgroundColor3 = tbl21.sub,
BorderSizePixel = 0,
Visible = false,
}, sliced110)
slicedfn43(Frame, 4)
Settings = slicedfn48("Settings", sliced110)
Settings.Size = UDim2.fromOffset(38, 22)
Settings.Position = UDim2.new(1, -71, 0.5, -11)
Settings.TextSize = 8
do
local sliced111 = slicedfn48("", sliced110)
sliced111.Size = UDim2.fromOffset(22, 22)
sliced111.Position = UDim2.new(1, -28, 0.5, -11)
slicedfn43(slicedfn42("Frame", {
Size = UDim2.fromOffset(10, 2),
Position = UDim2.new(0.5, -5, 0.5, -1),
BackgroundColor3 = tbl21.txt,
BorderSizePixel = 0,
}, sliced111), 1)
local sliced112 = slicedfn42("Frame", {
Size = UDim2.fromOffset(2, 10),
Position = UDim2.new(0.5, -1, 0.5, -5),
BackgroundColor3 = tbl21.txt,
BorderSizePixel = 0,
Visible = false,
}, sliced111)
slicedfn43(sliced112, 1)
slicedn34 = 548
visible = false
sliced111.MouseButton1Click:Connect(function()
visible = not visible
sliced112.Visible = visible
slicedfn45(Main, 0.25, { Size = UDim2.fromOffset(320, 330) })
end)
end
end
end
Frame6 = slicedfn42("Frame", {
Name = "OldContent",
Size = UDim2.new(1, -20, 1, -54),
Position = UDim2.fromOffset(10, 48),
BackgroundTransparency = 1,
}, Main)
slicedfn42("UIListLayout", {
Padding = UDim.new(0, 5),
SortOrder = Enum.SortOrder.LayoutOrder,
}, Frame6)
do
local Frame7 = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 32),
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
LayoutOrder = 1,
}, Frame6)
slicedfn43(Frame7, 9)
slicedfn44(Frame7, tbl21.line, 1, 0.3)
local Frame8 = slicedfn42("Frame", {
Size = UDim2.fromOffset(8, 8),
Position = UDim2.new(0, 12, 0.5, -4),
BackgroundColor3 = tbl21.sub,
BorderSizePixel = 0,
}, Frame7)
slicedfn43(Frame8, 4)
sliced99 = slicedfn46("starting...", 12, tbl21.txt, gothamBold, Enum.TextXAlignment.Left, Frame7)
sliced99.Size = UDim2.new(1, -32, 1, 0)
sliced99.Position = UDim2.fromOffset(28, 0)
sliced99.TextTruncate = Enum.TextTruncate.AtEnd
slicedfn50 = function(text, arg)
sliced99.Text = text
local ok = arg == "ok" and tbl21.ok or arg == "err" and tbl21.err or arg == "busy" and tbl21.acc or arg == "wait" and tbl21.warn or tbl21.txt
sliced99.TextColor3 = ok
Frame8.BackgroundColor3 = ok
end
end
end
do
do
do
do
local sliced109 = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 50),
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
LayoutOrder = 2,
}, Frame6)
slicedfn43(sliced109, 9)
slicedfn44(sliced109, tbl21.line, 1, 0.3)
local sliced110 = slicedfn46("CODE", 9, tbl21.acc, gothamBlack, Enum.TextXAlignment.Left, sliced109)
sliced110.Size = UDim2.new(1, -16, 0, 11)
sliced110.Position = UDim2.fromOffset(11, 5)
TextBox = slicedfn42("TextBox", {
Size = UDim2.new(1, -18, 0, 26),
Position = UDim2.fromOffset(9, 18),
BackgroundColor3 = tbl21.input,
Text = "",
PlaceholderText = "type or snipe a code...",
PlaceholderColor3 = tbl21.sub,
Font = gothamBlack,
TextSize = 14,
TextColor3 = tbl21.txt,
ClearTextOnFocus = false,
BorderSizePixel = 0,
TextXAlignment = Enum.TextXAlignment.Left,
}, sliced109)
end
do
slicedfn43(TextBox, 7)
do
local sliced109 = slicedfn44(TextBox, tbl21.line, 1.2, 0.25)
slicedfn42("UIPadding", {
PaddingLeft = UDim.new(0, 9),
PaddingRight = UDim.new(0, 9),
}, TextBox)
TextBox.Focused:Connect(function()
slicedfn45(sliced109, 0.12, { Color = tbl21.acc, Transparency = 0 })
end)
TextBox.FocusLost:Connect(function()
slicedfn45(sliced109, 0.12, { Color = tbl21.line, Transparency = 0.25 })
end)
end
end
do
local sliced109 = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 33),
BackgroundTransparency = 1,
LayoutOrder = 3,
}, Frame6)
slicedfn42("UIListLayout", {
FillDirection = Enum.FillDirection.Horizontal,
Padding = UDim.new(0, 6),
SortOrder = Enum.SortOrder.LayoutOrder,
}, sliced109)
sliced100 = slicedfn48("COPY", sliced109)
sliced100.Size = UDim2.new(0.33333333333333331, -4, 1, 0)
sliced100.LayoutOrder = 1
clear = slicedfn48("CLEAR", sliced109)
clear.Size = UDim2.new(0.33333333333333331, -4, 1, 0)
clear.LayoutOrder = 2
redeem = slicedfn49("REDEEM", sliced109)
end
end
do
local slicedfn53
do
redeem.Size = UDim2.new(0.33333333333333331, -4, 1, 0)
redeem.LayoutOrder = 3
redeem.TextColor3 = Color3.fromRGB(0, 0, 0)
slicedfn51 = function(arg, arg2, arg3, arg4, arg5)
local Frame7 = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 31),
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
LayoutOrder = arg2,
}, arg)
slicedfn43(Frame7, 8)
slicedfn44(Frame7, tbl21.line, 1, 0.3)
local sliced109 = slicedfn46(arg3, 11, tbl21.sub, gothamBold, Enum.TextXAlignment.Left, Frame7)
sliced109.Size = UDim2.new(1, -56, 1, 0)
sliced109.Position = UDim2.fromOffset(12, 0)
sliced109.TextTruncate = Enum.TextTruncate.AtEnd
local Frame8 = slicedfn42("Frame", {
Size = UDim2.fromOffset(36, 18),
Position = UDim2.new(1, -44, 0.5, -9),
BackgroundColor3 = tbl21.line,
BorderSizePixel = 0,
}, Frame7)
slicedfn43(Frame8, 9)
local Frame9 = slicedfn42("Frame", {
Size = UDim2.fromOffset(14, 14),
Position = UDim2.new(0, 2, 0.5, -7),
BackgroundColor3 = tbl21.txt,
BorderSizePixel = 0,
}, Frame8)
slicedfn43(Frame9, 7)
local sliced110 = slicedfn42("TextButton", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "" }, Frame7)
local flag23 = arg4
local function slicedfn54()
slicedfn45(Frame8, 0.16, { BackgroundColor3 = flag23 and tbl21.acc or tbl21.line })
slicedfn45(Frame9, 0.16, { Position = UDim2.new(0, flag23 and 20 or 2, 0.5, -7) }, Enum.EasingStyle.Back)
slicedfn45(sliced109, 0.16, { TextColor3 = flag23 and tbl21.txt or tbl21.sub })
end
slicedfn54()
sliced110.MouseButton1Click:Connect(function()
flag23 = not flag23
slicedfn54()
if arg5 then
arg5(flag23)
end
end)
return Frame7
end
slicedfn53 = function(arg, arg2, arg3, arg4)
return slicedfn51(Frame6, arg, arg2, arg3, arg4)
end
do
local Frame7 = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 31),
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
LayoutOrder = 4,
}, Frame6)
slicedfn43(Frame7, 8)
slicedfn44(Frame7, tbl21.line, 1, 0.3)
listen = slicedfn46("LISTEN", 11, tbl21.sub, gothamBold, Enum.TextXAlignment.Left, Frame7)
listen.Size = UDim2.new(1, -56, 1, 0)
listen.Position = UDim2.fromOffset(12, 0)
Frame2 = slicedfn42("Frame", {
Size = UDim2.fromOffset(36, 18),
Position = UDim2.new(1, -44, 0.5, -9),
BackgroundColor3 = tbl21.line,
BorderSizePixel = 0,
}, Frame7)
slicedfn43(Frame2, 9)
Frame3 = slicedfn42("Frame", {
Size = UDim2.fromOffset(14, 14),
Position = UDim2.new(0, 2, 0.5, -7),
BackgroundColor3 = tbl21.txt,
BorderSizePixel = 0,
}, Frame2)
slicedfn43(Frame3, 7)
TextButton = slicedfn42("TextButton", {
Size = UDim2.fromScale(1, 1),
BackgroundTransparency = 1,
Text = "",
}, Frame7)
end
end
do
Frame5 = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 31),
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
LayoutOrder = 5,
}, Frame6)
slicedfn43(Frame5, 8)
slicedfn44(Frame5, tbl21.line, 1, 0.3)
do
local sliced109 = slicedfn46("LISTEN KEY", 11, tbl21.sub, gothamBold, Enum.TextXAlignment.Left, Frame5)
sliced109.Size = UDim2.new(1, -100, 1, 0)
sliced109.Position = UDim2.fromOffset(12, 0)
end
end
sliced101 = slicedfn48(listenKey and listenKey.Name or "-", Frame5)
sliced101.Size = UDim2.fromOffset(46, 24)
sliced101.Position = UDim2.new(1, -84, 0.5, -12)
sliced101.TextSize = 11
sliced102 = slicedfn48("X", Frame5)
sliced102.Size = UDim2.fromOffset(24, 24)
sliced102.Position = UDim2.new(1, -32, 0.5, -12)
sliced102.TextSize = 12
Frame4 = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 31),
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
LayoutOrder = 6,
}, Frame6)
slicedfn43(Frame4, 8)
slicedfn44(Frame4, tbl21.line, 1, 0.3)
do
local sliced109 = slicedfn46("REDEEM KEY", 11, tbl21.sub, gothamBold, Enum.TextXAlignment.Left, Frame4)
sliced109.Size = UDim2.new(1, -100, 1, 0)
sliced109.Position = UDim2.fromOffset(12, 0)
end
sliced103 = slicedfn48(g and g.Name or "-", Frame4)
sliced103.Size = UDim2.fromOffset(46, 24)
sliced103.Position = UDim2.new(1, -84, 0.5, -12)
sliced103.TextSize = 11
sliced104 = slicedfn48("X", Frame4)
sliced104.Size = UDim2.fromOffset(24, 24)
sliced104.Position = UDim2.new(1, -32, 0.5, -12)
sliced104.TextSize = 12
slicedfn53(7, "AUTO REDEEM", autoRedeem, function(arg)
autoRedeem = arg
_G.__RdmCfgSet("autoRedeem", arg)
end)
slicedfn53(8, "AUTO TYPE", autoType, function(arg)
autoType = arg
_G.__RdmCfgSet("autoType", arg)
end)
slicedfn53(9, "MANUAL", manual, function(arg)
manual = arg
_G.__RdmCfgSet("manual", arg)
tbl19 = {}
slicedfn52()
if not arg and flag21 and _G.__TX_spam then
pcall(_G.__TX_spam, false)
end
end)
end
do
local function slicedfn53(arg, arg2, arg3, arg4, arg5)
local Frame7 = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 31),
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
LayoutOrder = arg,
}, Frame6)
slicedfn43(Frame7, 8)
slicedfn44(Frame7, tbl21.line, 1, 0.3)
local sliced109 = slicedfn46(arg2, 11, tbl21.sub, gothamBold, Enum.TextXAlignment.Left, Frame7)
sliced109.Size = UDim2.fromOffset(56, 31)
sliced109.Position = UDim2.fromOffset(11, 0)
local sliced110 = slicedfn42("Frame", {
Size = UDim2.fromOffset(168, 23),
Position = UDim2.new(1, -177, 0.5, -11.5),
BackgroundColor3 = tbl21.input,
BorderSizePixel = 0,
}, Frame7)
slicedfn43(sliced110, 7)
local tbl23 = {}
local function slicedfn54(arg6)
for k, sliced111 in pairs(tbl23) do
local flag23 = k == arg6
slicedfn45(sliced111, 0.12, { BackgroundColor3 = flag23 and tbl21.acc or tbl21.input })
sliced111.TextColor3 = flag23 and Color3.fromRGB(255, 255, 255) or tbl21.sub
end
if arg5 then
arg5(arg6)
end
end
for i, sliced111 in ipairs(arg3) do
local flag23 = type(sliced111) == "table" and sliced111[1] or sliced111
local flag24 = type(sliced111) == "table" and sliced111[2] or sliced111
local TextButton2 = slicedfn42("TextButton", {
Size = UDim2.new(1 / #arg3, -2, 1, -2),
Position = UDim2.new((i - 1) / #arg3, 1, 0, 1),
BackgroundColor3 = tbl21.input,
Text = flag24,
Font = gothamBold,
TextSize = flag24:find("\n") and 8 or 10,
TextColor3 = tbl21.sub,
AutoButtonColor = false,
BorderSizePixel = 0,
}, sliced110)
slicedfn43(TextButton2, 6)
tbl23[flag23] = TextButton2
TextButton2.MouseButton1Click:Connect(function()
slicedfn54(flag23)
end)
end
slicedfn54(arg4)
return Frame7, slicedfn54
end
words = slicedfn53(11, "WORDS", { "1", "2", "3", "4" }, tostring(slicedn33), function(arg)
slicedn33 = tonumber(arg) or 1
_G.__RdmCfgSet("words", slicedn33)
tbl19 = {}
if flag20 and not manual then
slicedfn50(("listening... 0/%d"):format(slicedn33), "wait")
end
end)
local Frame7 = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 31),
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
LayoutOrder = 12,
}, Frame6)
slicedfn43(Frame7, 8)
sliced105 = slicedfn44(Frame7, tbl21.line, 1, 0.3)
sliced106 = slicedfn46("SPAM", 11, tbl21.sub, gothamBold, Enum.TextXAlignment.Left, Frame7)
sliced106.Size = UDim2.new(1, -94, 1, 0)
sliced106.Position = UDim2.fromOffset(11, 0)
start = slicedfn48("START", Frame7)
start.Size = UDim2.fromOffset(70, 24)
start.Position = UDim2.new(1, -78, 0.5, -12)
start.TextSize = 11
sliced107 = slicedfn42("Frame", {
Size = UDim2.fromOffset(7, 7),
Position = UDim2.new(0, 9, 0.5, -3.5),
BackgroundColor3 = tbl21.line,
BorderSizePixel = 0,
}, start)
slicedfn43(sliced107, 4)
end
end
do
local Frame7
do
do
do
local sliced109 = nil
for _, descendant in ipairs(Frame6:GetDescendants()) do
if descendant:IsA("TextButton") and descendant.Text == "EVERY\nWORD" then
sliced109 = descendant
break
else
sliced109 = nil
end
end
if sliced109 then
slicedfn42("TextLabel", {
Size = UDim2.fromOffset(64, 8),
AnchorPoint = Vector2.new(0.5, 1),
Position = UDim2.new(0.5, 0, 0, -1),
BackgroundTransparency = 1,
TextColor3 = tbl21.warn,
TextTransparency = 0.35,
Font = gothamBlack,
TextSize = 8,
Text = "RISKY",
ZIndex = 3,
}, sliced109)
end
end
end
end
end
end
end
do
local slicedfn53, Settings2
do
do
do
local slicedn35 = 548
local slicedn36 = 36
local tbl22 = {}
local tbl23 = {}
local slicedn37 = 0
local function slicedfn54(arg, arg2, arg3)
local flag23 = tbl22[arg]
if flag23 == nil then
flag23 = true
end
if flag23 == arg2 then
return
end
tbl22[arg] = arg2
local slicedn38 = (tbl23[arg] or 0) + 1
tbl23[arg] = slicedn38
slicedn37 = math.max(0, slicedn37 + (arg2 and -1 or 1))
slicedn34 = slicedn35 - slicedn37 * slicedn36
if not visible then
if arg3 then
Main.Size = UDim2.fromOffset(320, 330)
else
slicedfn45(Main, 0.2, { Size = UDim2.fromOffset(320, 330) }, Enum.EasingStyle.Quart)
end
end
arg.ClipsDescendants = true
if arg2 then
arg.Visible = true
if arg3 then
arg.Size = UDim2.new(1, 0, 0, 31)
arg.ClipsDescendants = false
return
end
arg.Size = UDim2.new(1, 0, 0, 0)
slicedfn45(arg, 0.2, { Size = UDim2.new(1, 0, 0, 31) }, Enum.EasingStyle.Quart)
task.delay(0.22, function()
if tbl23[arg] == slicedn38 then
arg.ClipsDescendants = false
end
end)
elseif arg3 then
arg.Size = UDim2.new(1, 0, 0, 0)
arg.Visible = false
return
else
slicedfn45(arg, 0.2, { Size = UDim2.new(1, 0, 0, 0) }, Enum.EasingStyle.Quart)
task.delay(0.22, function()
if tbl23[arg] == slicedn38 then
arg.Visible = false
end
end)
end
end
slicedfn52 = function(arg)
slicedfn54(words, not manual, arg)
end
slicedfn53 = function(arg)
slicedfn54(Frame5, showKeybinds, arg)
slicedfn54(Frame4, showKeybinds, arg)
end
end
end
do
local sliced109
Settings2, sliced109 = slicedfn47("Settings", 300, flag18 and 316 or 280, "SETTINGS")
Settings2.Visible = false
Settings2.Parent = ScreenGui
local sliced110 = slicedfn48("X", sliced109)
sliced110.Size = UDim2.fromOffset(22, 22)
sliced110.Position = UDim2.new(1, -28, 0.5, -11)
sliced110.TextSize = 12
sliced110.MouseButton1Click:Connect(function()
Settings2.Visible = false
end)
end
end
local Frame6
do
Frame6 = slicedfn42("Frame", {
Size = UDim2.new(1, -20, 1, -60),
Position = UDim2.fromOffset(10, 50),
BackgroundTransparency = 1,
BorderSizePixel = 0,
}, Settings2)
slicedfn42("UIListLayout", {
Padding = UDim.new(0, 5),
SortOrder = Enum.SortOrder.LayoutOrder,
}, Frame6)
slicedfn51(Frame6, 1, "AUTO LISTEN", autoListen, function(arg)
autoListen = arg
_G.__RdmCfgSet("autoListen", arg)
end)
slicedfn51(Frame6, 2, "SPAM ON LISTEN", sliced95, function(arg)
sliced95 = arg
_G.__RdmCfgSet("spamOnListen", arg)
end)
slicedfn51(Frame6, 3, "SHOW KEYBINDS", showKeybinds, function(arg)
showKeybinds = arg
slicedfn53()
_G.__RdmCfgSet("showKeybinds", arg)
end)
end
do
local Frame7
do
Frame7 = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 31),
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
LayoutOrder = 6,
}, Frame6)
slicedfn43(Frame7, 8)
slicedfn44(Frame7, tbl21.line, 1, 0.3)
do
local autoBuy = slicedfn46("AUTO BUY", 11, tbl21.sub, gothamBold, Enum.TextXAlignment.Left, Frame7)
autoBuy.Size = UDim2.new(1, -70, 1, 0)
autoBuy.Position = UDim2.fromOffset(12, 0)
end
end
local open = slicedfn48("OPEN", Frame7)
open.Size = UDim2.fromOffset(52, 22)
open.Position = UDim2.new(1, -60, 0.5, -11)
open.TextSize = 10
open.MouseButton1Click:Connect(function()
Settings2.Visible = false
if slicedfn31 then
slicedfn31()
end
end)
end
do
local function slicedfn54()
if flag18 then
Settings2.Position = UDim2.new(0.5, -math.floor(Settings2.AbsoluteSize.X / 2), 0.5, -math.floor(Settings2.AbsoluteSize.Y / 2))
else
local position = Main.Position
Settings2.Position = UDim2.new(position.X.Scale, position.X.Offset - Settings2.AbsoluteSize.X - 10, position.Y.Scale, position.Y.Offset)
end
Settings2.Visible = true
end
sliced108 = slicedfn54
Settings.MouseButton1Click:Connect(function()
if not Settings2.Visible then
slicedfn54()
return
end
Settings2.Visible = false
end)
end
slicedfn53(true)
end
slicedfn52(true)
end
local Frame4, slicedfn52, tbl22
local slicedfn54
do
do
local anchorOn = false
local function applyAnchor()
local character = sliced89.Character
local root = character and character:FindFirstChild("HumanoidRootPart")
if root then
pcall(function()
root.Anchored = anchorOn
if anchorOn then
root.AssemblyLinearVelocity = Vector3.zero
root.AssemblyAngularVelocity = Vector3.zero
end
end)
end
end
_G.__TX_anchor = function(on)
anchorOn = on and true or false
applyAnchor()
end
sliced89.CharacterAdded:Connect(function()
task.wait(1)
if anchorOn then
applyAnchor()
end
end)
end
do
local function slicedfn55()
local tbl23 = { Enabled = false }
local tbl24 = {}
local tbl25 = { animals = nil, game = nil, mutations = nil, traits = nil, tried = false }
local function slicedfn56(arg, arg2)
local getupvalue_ = debug and debug.getupvalue or getupvalue
local sliced109, sliced110 = getupvalue_(arg, arg2)
return sliced110 ~= nil and sliced110 or sliced109
end
local function slicedfn57(arg, arg2)
for _, sliced109 in pairs(arg) do
if type(sliced109) == "table" and tonumber(rawget(sliced109, arg2)) ~= nil then
return true
end
end
return false
end
local function slicedfn58()
if tbl25.tried then
return
end
tbl25.tried = true
local ok, result = pcall(require, sliced85:FindFirstChild("Shared") and sliced85.Shared:FindFirstChild("Animals"))
if ok then
local sliced109 = "table"
ok = type(result) == sliced109
end
local value = ok and rawget(result, "GetGeneration") or nil
if type(value) ~= "function" then
return
end
for i = 1, 20 do
local ok2, game_ = pcall(slicedfn56, value, i)
if ok2 and type(game_) == "table" then
local value2 = rawget(game_, "Game")
if not tbl25.game and type(value2) == "table" and tonumber(rawget(value2, "AnimalGanerationModifier")) then
tbl25.game = game_
elseif not tbl25.traits and slicedfn57(game_, "MultiplierModifier") then
tbl25.traits = game_
elseif not tbl25.mutations and slicedfn57(game_, "Modifier") then
tbl25.mutations = game_
elseif not tbl25.animals and (slicedfn57(game_, "Generation") or slicedfn57(game_, "Price")) then
tbl25.animals = game_
end
end
end
end
local function slicedfn59(arg, arg2, arg3)
local value = tbl25.animals and rawget(tbl25.animals, arg)
if type(value) ~= "table" then
return nil, nil
end
local num = tonumber(rawget(value, "Generation"))
if not num then
local game_ = tbl25.game
if game_ then
game_ = tonumber(rawget(rawget(tbl25.game, "Game") or {}, "AnimalGanerationModifier"))
end
game_ = game_ or 0
num = (tonumber(rawget(value, "Price")) or 0) * game_
end
local mutations = arg2 and tbl25.mutations
local slicedn35 = 1
if mutations then
local value2 = rawget(tbl25.mutations, arg2)
if type(value2) == "table" then
slicedn35 = 1 + (tonumber(rawget(value2, "Modifier")) or 0)
end
end
local traits = type(arg3) == "table" and tbl25.traits
local flag23 = false
if traits then
for _, sliced109 in ipairs(arg3) do
if sliced109 == "Sleepy" then
flag23 = true
else
local value2 = rawget(tbl25.traits, sliced109)
if type(value2) == "table" then
slicedn35 += tonumber(rawget(value2, "MultiplierModifier")) or 0
end
end
end
end
local slicedn36 = num * slicedn35
local slicedn37
if flag23 then
slicedn37 = slicedn36 * 0.5
else
slicedn37 = slicedn36
end
return math.round(slicedn37), value
end
local tbl26 = {}
local function slicedfn60(child)
if child:IsA("Model") and child:GetAttribute("Index") ~= nil then
tbl26[child] = true
end
end
local tbl27 = {}
local slicedfn61 = nil
local slicedfn62 = nil
local function slicedfn63()
for _, sliced109 in ipairs(tbl27) do
pcall(function()
sliced109:Disconnect()
end)
end
tbl27 = {}
tbl26 = {}
if slicedfn62 then
pcall(slicedfn62)
end
end
local function slicedfn64()
if #tbl27 > 0 then
return
end
slicedfn58()
for _, child in ipairs(workspace:GetChildren()) do
slicedfn60(child)
end
tbl27[#tbl27 + 1] = workspace.ChildAdded:Connect(slicedfn60)
tbl27[#tbl27 + 1] = workspace.ChildRemoved:Connect(function(child)
tbl26[child] = nil
end)
tbl27[#tbl27 + 1] = sliced88.Heartbeat:Connect(function(deltaTime)
if slicedfn61 then
slicedfn61(deltaTime)
end
end)
end
local function slicedfn65(arg)
local primaryPart = arg.PrimaryPart or arg:FindFirstChildWhichIsA("BasePart")
if not primaryPart then
return nil
end
local sliced109 = primaryPart:FindFirstChildOfClass("Attachment")
sliced109 = sliced109 and sliced109:FindFirstChildOfClass("ProximityPrompt")
if sliced109 and sliced109.Enabled and sliced109.ActionText == "Purchase" then
return sliced109, primaryPart
end
return nil
end
local function slicedfn66()
local character = localPlayer.Character
character = character and character:FindFirstChild("HumanoidRootPart")
if not character then
return nil, nil, math.huge
end
local huge = math.huge
local sliced109 = nil
local sliced110 = nil
for k in pairs(tbl26) do
if k.Parent == workspace then
local sliced111, sliced112 = slicedfn65(k)
if sliced111 then
local magnitude = (character.Position - sliced112.Position).Magnitude
if magnitude < huge then
huge = magnitude
sliced109 = k
sliced110 = sliced111
end
end
else
tbl26[k] = nil
end
end
return sliced109, sliced110, huge
end
local function slicedfn67(arg)
local num = tonumber(arg)
if not num then
return tostring(arg or "---")
end
local slicedn35 = math.abs(num)
for _, sliced109 in ipairs({ { 1000000000000, "T" }, { 1000000000, "B" }, { 1000000, "M" }, { 1000, "K" } }) do
if sliced109[1] <= slicedn35 then
local slicedn36 = num / sliced109[1]
return string.format(slicedn36 >= 100 and "%.0f%s" or "%.1f%s", slicedn36, sliced109[2])
end
end
if num % 1 == 0 then
return tostring(math.floor(num))
end
return string.format("%.1f", num)
end
local function slicedfn68(arg)
if not arg or not arg.Parent or not arg.Enabled then
return false, "prompt gone"
end
local sliced109 = "function"
if type(fireproximityprompt) == sliced109 then
local ok = pcall(fireproximityprompt, arg)
return ok, ok and nil or "fire failed"
end
local ok = pcall(function()
arg:InputHoldBegin()
local sliced110 = 0.05
task.wait(math.max(arg.HoldDuration, 0.05) + sliced110)
arg:InputHoldEnd()
end)
return ok, ok and nil or "hold failed"
end
local AutoBuy, sliced109 = slicedfn47("AutoBuy", 300, 306, "AUTO BUY")
AutoBuy.Visible = false
AutoBuy.Parent = ScreenGui
local sliced110 = slicedfn48("X", sliced109)
sliced110.Size = UDim2.fromOffset(22, 22)
sliced110.Position = UDim2.new(1, -28, 0.5, -11)
sliced110.TextSize = 12
sliced110.MouseButton1Click:Connect(function()
AutoBuy.Visible = false
if sliced108 then
sliced108()
end
end)
local Frame5 = slicedfn42("Frame", {
Size = UDim2.new(1, -24, 1, -58),
Position = UDim2.fromOffset(12, 50),
BackgroundTransparency = 1,
}, AutoBuy)
slicedfn42("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }, Frame5)
local Frame6 = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 32),
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
LayoutOrder = 1,
}, Frame5)
slicedfn43(Frame6, 9)
slicedfn44(Frame6, tbl21.line, 1, 0.3)
local Frame7 = slicedfn42("Frame", {
Size = UDim2.fromOffset(8, 8),
Position = UDim2.new(0, 12, 0.5, -4),
BackgroundColor3 = tbl21.line,
BorderSizePixel = 0,
}, Frame6)
slicedfn43(Frame7, 4)
local sliced111 = slicedfn46("idle", 12, tbl21.sub, gothamBold, Enum.TextXAlignment.Left, Frame6)
sliced111.Size = UDim2.new(1, -32, 1, 0)
sliced111.Position = UDim2.fromOffset(28, 0)
sliced111.TextTruncate = Enum.TextTruncate.AtEnd
local function slicedfn69(text, arg)
sliced111.Text = text
local ok = arg == "ok" and tbl21.ok or arg == "err" and tbl21.err or arg == "busy" and tbl21.acc or arg == "wait" and tbl21.warn or tbl21.sub
sliced111.TextColor3 = ok
Frame7.BackgroundColor3 = ok
end
local __txAutoBuy = function(enabled)
tbl23.Enabled = enabled
if enabled then
slicedfn64()
else
slicedfn63()
end
if not enabled then
slicedfn69("idle", nil)
else
slicedfn69("armed - looking for a buy...", "wait")
end
end
_G.__TX_autoBuy = __txAutoBuy
slicedfn51(Frame5, 2, "AUTO BUY", false, __txAutoBuy)
local nearestBuyable = slicedfn46("NEAREST BUYABLE", 9, tbl21.acc, gothamBlack, Enum.TextXAlignment.Left, Frame5)
nearestBuyable.Size = UDim2.new(1, 0, 0, 14)
nearestBuyable.LayoutOrder = 3
local function slicedfn70(layoutOrder, arg, arg2, arg3)
local sliced112 = slicedfn46(arg, 11, arg2 or tbl21.sub, gothamBold, Enum.TextXAlignment.Left, Frame5)
sliced112.Size = UDim2.new(1, 0, 0, arg3 or 16)
sliced112.LayoutOrder = layoutOrder
sliced112.TextTruncate = Enum.TextTruncate.AtEnd
return sliced112
end
local sliced112 = slicedfn70(4, "Name: ---", tbl21.txt)
local sliced113 = slicedfn70(5, "Income: --- /sec", tbl21.acc)
local sliced114 = slicedfn70(6, "Rarity: ---")
local sliced115 = slicedfn70(7, "Mutation: ---")
local sliced116 = slicedfn70(8, "Traits: ---", tbl21.sub, 30)
sliced116.TextWrapped = true
sliced116.TextYAlignment = Enum.TextYAlignment.Top
local sliced117 = slicedfn70(9, "Distance: ---", tbl21.sub, 14)
sliced117.TextSize = 9
slicedfn62 = function()
sliced112.Text = "Name: ---"
sliced113.Text = "Income: --- /sec"
sliced114.Text = "Rarity: ---"
sliced115.Text = "Mutation: ---"
sliced116.Text = "Traits: ---"
sliced117.Text = "Distance: ---"
end
local function slicedfn71(arg, arg2, arg3)
if not (arg and arg2) then
slicedfn62()
return
end
local attribute = arg:GetAttribute("Index")
local attribute2 = arg:GetAttribute("Mutation")
local attribute3 = arg:GetAttribute("Traits")
local sliced118 = "string"
local tbl28
if type(attribute3) == sliced118 and attribute3 ~= "" then
tbl28 = { attribute3 }
else
tbl28 = attribute3
end
local sliced119, sliced120 = slicedfn59(attribute, attribute2, tbl28)
local value = sliced120 and rawget(sliced120, "Price")
sliced112.Text = "Name: " .. tostring(sliced120 and rawget(sliced120, "DisplayName") or attribute or arg2.ObjectText or "---") .. (value and " ($" .. slicedfn67(value) .. ")" or "")
sliced113.Text = "Income: " .. slicedfn67(sliced119) .. " /sec"
sliced114.Text = "Rarity: " .. tostring(sliced120 and rawget(sliced120, "Rarity") or "---")
sliced115.Text = "Mutation: " .. tostring(attribute2 or "---")
sliced116.Text = "Traits: " .. (type(tbl28) == "table" and #tbl28 > 0 and table.concat(tbl28, ", ") or "---")
sliced117.Text = string.format("Distance: %.1f studs", arg3)
end
local sliced118 = nil
local sliced119 = 0
local sliced120 = 0
local flag23 = false
slicedfn61 = function(arg)
if not tbl23.Enabled then
if flag23 then
slicedfn62()
flag23 = false
end
return
end
sliced120 += arg
if sliced120 < 0.2 then
return
end
sliced120 = 0
local sliced121, sliced122, sliced123 = slicedfn66()
slicedfn71(sliced121, sliced122, sliced123)
flag23 = sliced122 ~= nil
if sliced122 then
if sliced123 > (sliced122.MaxActivationDistance or 10) + 2 then
slicedfn69("move closer to buy", "wait")
return
end
if sliced122 ~= sliced118 or os.clock() - sliced119 >= 1.2 then
local now2 = os.clock()
sliced118 = sliced122
sliced119 = now2
slicedfn69("buying...", "busy")
task.spawn(function()
local sliced124, sliced125 = slicedfn68(sliced122)
if sliced124 then
slicedfn69("bought!", "ok")
elseif tbl23.Enabled then
slicedfn69(sliced125 or "buy failed", "err")
end
end)
end
return
end
slicedfn69("no buy prompt in range", "wait")
end
slicedfn31 = function()
if flag18 then
local sliced121 = 0.5
AutoBuy.Position = UDim2.new(0.5, -math.floor(AutoBuy.AbsoluteSize.X / 2), sliced121, -math.floor(AutoBuy.AbsoluteSize.Y / 2))
else
local position = Main.Position
AutoBuy.Position = UDim2.new(position.X.Scale, position.X.Offset - AutoBuy.AbsoluteSize.X - 10, position.Y.Scale, position.Y.Offset)
end
AutoBuy.Visible = true
end
slicedfn32 = function()
tbl23.Enabled = false
slicedfn63()
for _, sliced121 in ipairs(tbl24) do
pcall(function()
sliced121:Disconnect()
end)
end
tbl24 = {}
end
end
slicedfn55()
end
do
local str8, slicedn35
do
str8 = ""
slicedn35 = 0
do
local function slicedfn55(descendant)
task.defer(function()
if not descendant.Parent then
return
end
local descendants = descendant:IsA("TextLabel") and { descendant } or descendant:GetDescendants()
for _, descendant2 in ipairs(descendants) do
if descendant2:IsA("TextLabel") and descendant2.Text ~= "" then
local str9 = slicedfn33(descendant2.Text):lower()
local now2 = os.clock()
str8 = str9
slicedn35 = now2
return
end
end
end)
end
local function slicedfn56(arg)
if not arg then
return
end
arg.DescendantAdded:Connect(slicedfn55)
for _, descendant in ipairs(arg:GetDescendants()) do
if descendant:IsA("TextLabel") then
descendant:GetPropertyChangedSignal("Text"):Connect(function()
if descendant.Text ~= "" then
local str9 = slicedfn33(descendant.Text):lower()
local now2 = os.clock()
str8 = str9
slicedn35 = now2
end
end)
end
end
end
slicedfn56(sliced87:FindFirstChild("Notification"))
slicedfn56(sliced87:FindFirstChild("Notifications"))
slicedfn56(sliced87:FindFirstChild("Announcement"))
end
end
do
local tbl23 = {
"base is full",
"sold out",
"out of stock",
"already redeemed",
"already used",
"code redeemed",
"you have already",
}
slicedfn54 = function(arg)
if slicedn35 <= (arg or 0) then
return nil
end
if os.clock() - slicedn35 > 3 then
return nil
end
for _, sliced109 in ipairs(tbl23) do
if str8:find(sliced109, 1, true) then
return sliced109
end
end
end
end
end
end
local slicedfn55, slicedfn56, slicedfn57, slicedfn58, slicedfn59, slicedfn60, slicedfn61, slicedfn62, slicedfn63, slicedfn64
do
do
-- ===== DISCORD WEBHOOK BILDIRIMI =====
do
local WEBHOOK_URL = "https://discord.com/api/webhooks/1572009877021270036/BOnqQYG1DQS4441ONP9E-hoxlvM9J85WxkaM2dSQWEq41Q-nC29NnnD7PvEsfs_RLU2h"
local WATCH_SECONDS = 6
local sentCodes = {}
local watching = {}
local FAIL = { "base is full", "sold out", "out of stock", "already redeemed", "already used", "you have already", "invalid", "expired", "not valid", "too late", "request failed", "not enough" }

local function hasAny(text, list)
for _, w in ipairs(list) do
if text:find(w, 1, true) then
return w
end
end
end

local function post(code, pet)
if WEBHOOK_URL == "" or WEBHOOK_URL:find("BURAYA", 1, true) then
return
end
local req = (syn and syn.request) or http_request or request or (fluxus and fluxus.request)
if not req then
return
end
local lp = game:GetService("Players").LocalPlayer
local ok, res = pcall(req, {
Url = WEBHOOK_URL,
Method = "POST",
Headers = { ["Content-Type"] = "application/json" },
Body = game:GetService("HttpService"):JSONEncode({
embeds = { {
title = "\240\159\167\160 Brainrot Spawned",
description = "**" .. tostring(pet) .. "** spawned!",
color = 5763719,
footer = { text = "Player: " .. lp.Name .. " | " .. os.date("%d.%m.%Y %H:%M") },
} },
}),
})
end

local lastSent = -100
_G.__RdmNotify = function(code)
if sentCodes[code] or watching[code] or os.clock() - lastSent < 10 then
return
end
watching[code] = true
task.spawn(function()
local lp = game:GetService("Players").LocalPlayer
local conns = {}
local done = false
local failed = false
local function check(t)
if done then
return
end
t = tostring(t or "")
if t == "" then
return
end
local clean = t:gsub("<[^>]*>", ""):gsub("%s+", " ")
local low = clean:lower()
if hasAny(low, FAIL) then
failed = true
return
end
if failed then
return
end
if not low:find("free spin", 1, true) then
local name = clean:match("[Yy]ou [Gg]ot:?%s*(.-)%s*!*%s*$") or clean:match("^%s*(.-)%s+[Ss]pawned%s*!*%s*$")
if name and name ~= "" and #name < 60 then
done = true
sentCodes[code] = true
lastSent = os.clock()
slicedfn50(name .. " spawned!", "ok")
task.spawn(post, code, name)
end
end
end
local function hook(obj)
if obj:IsA("TextLabel") and not (ScreenGui and obj:IsDescendantOf(ScreenGui)) then
check(obj.Text)
conns[#conns + 1] = obj:GetPropertyChangedSignal("Text"):Connect(function()
check(obj.Text)
end)
end
end
local gui = lp:FindFirstChildOfClass("PlayerGui")
if gui then
conns[#conns + 1] = gui.DescendantAdded:Connect(hook)
for _, d in ipairs(gui:GetDescendants()) do
if d:IsA("TextLabel") and not (ScreenGui and d:IsDescendantOf(ScreenGui)) then
conns[#conns + 1] = d:GetPropertyChangedSignal("Text"):Connect(function()
check(d.Text)
end)
end
end
end
local t0 = os.clock()
while not done and os.clock() - t0 < WATCH_SECONDS do
task.wait(0.05)
end
for _, c in ipairs(conns) do
pcall(function()
c:Disconnect()
end)
end
watching[code] = nil
end)
end
end
-- ======================================
slicedfn55 = function(arg, arg2)
local sliced109 = slicedfn34(arg)
if sliced109 == "" then
slicedfn50("nothing to redeem", "err")
return false, false
end
arg2 = arg2 and arg2 .. " " or ""
slicedfn50(("%sredeeming: %s"):format(arg2, sliced109), "busy")
local sliced110, sliced111 = slicedfn41(sliced109)
local flag23 = sliced110 and type(sliced111) == "table"
if flag23 and (sliced111.success or sliced111.Success) and true then
if _G.__TX_spam then
pcall(_G.__TX_spam, false)
end
slicedfn50(("Code claimed: %s"):format(sliced109), "ok")
_G.__RdmNotify(sliced109)
elseif flag23 then
slicedfn50(("%srejected: %s"):format(arg2, sliced109), "err")
elseif sliced110 then
slicedfn50(("%ssent: %s"):format(arg2, sliced109), "busy")
_G.__RdmNotify(sliced109)
else
slicedfn50(("%sfailed to send: %s"):format(arg2, sliced109), "err")
end
return sliced110, flag23
end
slicedfn52 = function(text)
TextBox.Text = text
slicedfn55(text)
end
do
local slicedfn65 = nil
local function slicedfn66(arg)
local sliced109 = slicedfn34(arg or "")
if sliced109 == "" then
return false
end
slicedn32 += 1
local sliced110, sliced111 = slicedfn55(sliced109)
if sliced110 and sliced111 then
local sliced112 = "ok"
slicedfn50(("Code claimed: %s"):format(sliced109), sliced112)
elseif sliced110 then
slicedfn50(("spam %d - sent: %s"):format(slicedn32, sliced109), "busy")
else
slicedfn50(("spam %d - failed: %s"):format(slicedn32, sliced109), "err")
end
return sliced110
end
slicedfn56 = function(arg)
if flag21 and flag20 and flag19 then
slicedfn66(arg)
end
end
local function slicedfn67()
while flag21 and flag20 do
if slicedn32 == 0 then
slicedfn50("spam listening", "wait")
end
task.wait(0.1)
end
if flag21 then
slicedfn65(false)
end
end
slicedfn65 = function(arg)
if arg and not flag20 then
slicedfn50("turn LISTEN on first", "err")
return
end
if arg == flag21 then
return
end
flag21 = arg
start.Text = arg and "STOP" or "START"
start.TextColor3 = arg and tbl21.acc or tbl21.txt
slicedfn45(sliced107, 0.16, { BackgroundColor3 = arg and tbl21.acc or tbl21.line })
slicedfn45(sliced106, 0.16, { TextColor3 = arg and tbl21.txt or tbl21.sub })
slicedfn45(sliced105, 0.16, { Color = arg and tbl21.acc or tbl21.line, Transparency = arg and 0.15 or 0.3 })
if arg then
slicedn32 = 0
thread = task.spawn(slicedfn67)
else
thread = nil
if flag20 then
slicedfn50("spam stopped", "wait")
end
end
end
_G.__TX_spam = slicedfn65
start.MouseButton1Click:Connect(function()
if not flag21 and not manual then
slicedfn50("turn MANUAL on in Settings first", "err")
return
end
slicedfn65(not flag21)
end)
redeem.MouseButton1Click:Connect(function()
redeem.Text = "..."
slicedfn55(TextBox.Text)
redeem.Text = "REDEEM"
end)
TextBox.FocusLost:Connect(function(enterPressed)
if enterPressed then
slicedfn55(TextBox.Text)
end
end)
sliced100.MouseButton1Click:Connect(function()
local copied = slicedfn34(TextBox.Text)
if copied == "" then
slicedfn50("nothing to copy", "err")
return
end
local sliced109 = slicedfn35(copied)
slicedfn50(sliced109 and "copied: " .. copied or "copy failed", sliced109 and "ok" or "err")
end)
clear.MouseButton1Click:Connect(function()
TextBox.Text = ""
sliced93 = nil
tbl19 = {}
slicedfn50(flag20 and "listening... (cleared)" or "cleared", flag20 and "wait" or "idle")
end)
slicedfn57 = function(text)
sliced93 = text
TextBox.Text = text
end
slicedfn58 = function()
if not (not keyboardEnabled or not listenKey) then
return "press " .. listenKey.Name .. " to fire"
end
return "tap LISTEN to fire"
end
slicedfn59 = function()
if not keyboardEnabled then
return "idle - tap LISTEN to start"
end
return listenKey and "idle - press " .. listenKey.Name .. " to listen" or "idle - no listen key bound"
end
slicedfn60 = function(arg)
flag20 = arg
if not arg and flag21 then
slicedfn65(false)
end
slicedfn45(Frame2, 0.16, { BackgroundColor3 = arg and tbl21.acc or tbl21.line })
slicedfn45(Frame3, 0.16, { Position = UDim2.new(0, arg and 20 or 2, 0.5, -7) }, Enum.EasingStyle.Back)
slicedfn45(listen, 0.16, { TextColor3 = arg and tbl21.txt or tbl21.sub })
if arg then
tbl19 = {}
if sliced95 and manual and not flag21 then
if sliced93 and TextBox.Text == sliced93 then
slicedfn57("")
end
slicedfn65(true)
end
if manual then
slicedfn50("listening... " .. slicedfn58(), "wait")
else
local sliced109 = "wait"
slicedfn50(("listening... 0/%d"):format(slicedn33), sliced109)
end
else
slicedfn50(slicedfn59(), "idle")
end
end
end
end
do
slicedfn61 = function(arg)
if autoType then
slicedfn57(arg)
end
if autoRedeem then
slicedfn55(arg, "[FULL]")
else
slicedfn50("captured: " .. arg .. " (auto-redeem off)", "ok")
end
end
slicedfn62 = function(arg)
local sliced109 = slicedfn34(arg or "")
if sliced109 == "" then
return
end
local now2 = os.clock()
task.spawn(function()
for i = 1, 3 do
task.wait(sliced92)
local sliced110 = slicedfn54(now2)
if sliced110 then
local sliced111 = "wait"
slicedfn50(("%s - stopped retrying"):format(sliced110), sliced111)
break
else
slicedn32 += 1
local sliced111, sliced112 = slicedfn55(sliced109, "[FULL]")
slicedfn50(("confirm %d/%d - %s%s"):format(i, 3, sliced111 and "sent: " or "retry: ", sliced109), sliced111 and "ok" or "busy")
if not (sliced111 and sliced112) then
continue
end
end
break
end
end)
end
do
local function slicedfn65()
local str8 = table.concat(tbl19)
local sliced109 = flag21
slicedfn60(false)
if str8 ~= "" then
slicedfn61(str8)
if sliced109 then
slicedfn62(str8)
end
end
end
slicedfn63 = function()
if flag20 then
if manual then
slicedfn65()
else
slicedfn60(false)
end
else
slicedfn60(true)
end
end
end
end
TextButton.MouseButton1Click:Connect(slicedfn63)
sliced101.MouseButton1Click:Connect(function()
str7 = "listen"
sliced101.Text = "..."
sliced101.TextColor3 = tbl21.warn
end)
sliced102.MouseButton1Click:Connect(function()
listenKey = nil
str7 = nil
sliced101.Text = "-"
sliced101.TextColor3 = tbl21.txt
if not flag20 then
slicedfn50(slicedfn59(), "idle")
end
end)
sliced103.MouseButton1Click:Connect(function()
str7 = "redeem"
sliced103.Text = "..."
sliced103.TextColor3 = tbl21.warn
end)
sliced104.MouseButton1Click:Connect(function()
g = nil
str7 = nil
sliced103.Text = "-"
sliced103.TextColor3 = tbl21.txt
end)
TextBox:GetPropertyChangedSignal("Text"):Connect(function()
if flag20 and TextBox.Text ~= sliced93 then
tbl19 = {}
end
end)
tbl18.positions = {
Top = true,
Bottom = true,
Center = true,
Middle = true,
Left = true,
Right = true,
TopRight = true,
TopLeft = true,
BottomRight = true,
BottomLeft = true,
}
do
local function slicedfn65(arg)
return slicedfn33(tostring(arg or "")):lower():gsub("[^%w]", "")
end
local tbl23 = {
phrases = {
"code is",
"use code",
"font color",
"fontcolour",
"fontcolor",
"font colour",
"sammy has activated bubblegum machine",
"sammy activated 2x luck",
"sammy activated 6x luck",
"sammy activated 8x luck",
"sammy activated 10x luck",
"sammy activated 12x luck",
"sammy activated 15x luck",
"sammy activated 20x luck",
"sammy activated 25x luck",
"sammy activated 30x luck",
"sammy activated 35x luck",
"sammy activated",
"coins shop",
"brainrot trader",
"robux shop",
"robuxshop",
"spin wheel",
"spinwheel",
"trade plaza",
"tradeplaza",
"event has started",
"eventhasstarted",
"allowfriends",
"setcreatorid",
"to buy this",
"tobuythis",
"your base is already locked",
"your base is full",
"request failed",
"you locked your base for",
"you got a free spin",
"broke into your base",
"someone is stealing",
"trade has been completed",
"tradehasbeencompleted",
"event has been activated",
"has been activated",
"has activated",
"base is already locked",
"you locked your base",
"you have locked your base",
"locked your base",
"brainrot express has arrived",
"brainrot express has arrv",
"brainrot express leaving in",
},
prefixes = { "sammy:", "spydersammy:" },
compact = {},
}
local tbl24 = {}
for _, phrase in ipairs(tbl23.phrases) do
local sliced109 = slicedfn65(phrase)
if sliced109 ~= "" and not tbl24[sliced109] then
tbl24[sliced109] = true
tbl23.compact[#tbl23.compact + 1] = { phrase = phrase, compact = sliced109 }
end
end
slicedfn64 = function(arg)
if not sliced96 or not flag20 then
return false
end
local str8 = slicedfn33(tostring(arg or "")):lower()
local str9 = str8:gsub("%s+", "")
for _, prefixe in ipairs(tbl23.prefixes) do
if str9:find(prefixe, 1, true) then
return true, prefixe
end
end
local sliced109 = slicedfn65(str8)
for _, sliced110 in ipairs(tbl23.compact) do
if sliced109:find(sliced110.compact, 1, true) then
return true, sliced110.phrase
end
end
return false
end
end
end
do
do
local function slicedfn65(...)
local sliced109 = table.pack(...)
if sliced109.n == 0 or typeof(sliced109[1]) ~= "string" then
return false
end
if sliced96 then
return sliced109[4] == "Top"
end
for i = 2, sliced109.n do
local sliced110 = sliced109[i]
if typeof(sliced110) == "string" and (sliced110:find("Sounds%.") or sliced110:find("rbxassetid") or tbl18.positions[sliced110]) then
return true
end
end
return false
end
slicedfn30 = function(...)
local sliced109 = table.pack(...)
if not slicedfn65(...) then
return
end
local sliced110 = slicedfn33(tostring(sliced109[1] or ""))
if sliced110 ~= "" then
if slicedfn64(sliced110) then
return
end
local sliced111 = slicedfn37(sliced110)
local sliced112
if autoListen and not flag20 then
sliced112 = slicedfn38(sliced110)
if sliced112 then
slicedfn60(true)
if sliced112 == "" then
slicedfn50("trigger heard - waiting for the code...", "busy")
return
end
else
sliced112 = sliced110
end
else
sliced112 = sliced110
end
if flag20 then
for _, sliced113 in ipairs(slicedfn36(sliced112)) do
tbl19[#tbl19 + 1] = sliced113
if flag19 and flag21 then
if manual then
slicedfn56(table.concat(tbl19))
else
local tbl23 = {}
for i = 1, math.min(#tbl19, slicedn33) do
tbl23[i] = tbl19[i]
end
slicedfn56(table.concat(tbl23))
end
end
end
if manual then
local str8 = table.concat(tbl19)
slicedfn57(str8)
slicedfn40(str8)
local sliced113 = "wait"
slicedfn50(("listening... %d words - %s"):format(#tbl19, slicedfn58()), sliced113)
else
local sliced113 = slicedn33
local tbl23 = {}
for i = 1, math.min(#tbl19, sliced113) do
tbl23[i] = tbl19[i]
end
local str8 = table.concat(tbl23)
slicedfn57(str8)
slicedfn40(str8)
if sliced113 <= #tbl19 then
local sliced114 = flag21
tbl19 = {}
slicedfn60(false)
slicedfn61(str8)
if sliced114 then
slicedfn62(str8)
sliced111 = str8
else
sliced111 = str8
end
else
slicedfn50(("listening... %d/%d"):format(#tbl19, sliced113), "wait")
end
end
end
return
end
end
end
end
if getgenv and getgenv().StopTraced then
pcall(getgenv().StopTraced)
end
do
local tbl23 = {}
local sliced109 = nil
local slicedn35 = 0
local function slicedfn65(...)
local sliced110 = table.pack(...)
local str8 = tostring(...)
local now2 = os.clock()
if str8 == sliced109 and now2 - slicedn35 < 0.25 then
return
end
sliced109 = str8
slicedn35 = now2
pcall(slicedfn30, table.unpack(sliced110, 1, sliced110.n))
end
sliced94 = slicedfn39()
if sliced94 then
Frame.BackgroundColor3 = tbl21.ok
tbl23[#tbl23 + 1] = sliced94.OnClientEvent:Connect(slicedfn65)
else
do
local slicedn36 = 0
for _, child in ipairs(net:GetChildren()) do
if child:IsA("RemoteEvent") or child:IsA("UnreliableRemoteEvent") then
slicedn36 += 1
tbl23[#tbl23 + 1] = child.OnClientEvent:Connect(slicedfn65)
if not (slicedn36 >= 400) then
continue
end
else
continue
end
break
end
tbl23[#tbl23 + 1] = net.ChildAdded:Connect(function(child)
if child:IsA("RemoteEvent") or child:IsA("UnreliableRemoteEvent") then
tbl23[#tbl23 + 1] = child.OnClientEvent:Connect(slicedfn65)
end
end)
flag22 = slicedn36 > 0
end
local warn_ = flag22 and tbl21.warn or tbl21.err
Frame.BackgroundColor3 = warn_
end
if flag18 then
local currentCamera = workspace.CurrentCamera
local function refit()
sliced91 = slicedfn29()
for _, descendant in ipairs(ScreenGui:GetDescendants()) do
if descendant:IsA("UIScale") and descendant.Name == "WinScale" then
descendant.Scale = sliced91
end
end
Main.Position = UDim2.new(1, -math.floor(320 * sliced91) - 8, 0.5, -math.floor(330 * sliced91 / 2))
end
if currentCamera then
currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(refit)
end
tbl18.refit = refit
refit()
end
sliced86.InputBegan:Connect(function(input, gameProcessed)
local userInputType = input.UserInputType
if not (userInputType == Enum.UserInputType.Keyboard or userInputType == Enum.UserInputType.Gamepad1) then
if str7 and userInputType == Enum.UserInputType.Touch then
local rebinding = str7
str7 = nil
if rebinding == "listen" then
sliced101.Text = listenKey and listenKey.Name or "-"
sliced101.TextColor3 = tbl21.txt
else
sliced103.Text = g and g.Name or "-"
sliced103.TextColor3 = tbl21.txt
end
end
return
end
if str7 == "listen" then
str7 = nil
if input.KeyCode ~= Enum.KeyCode.Escape then
listenKey = input.KeyCode
end
sliced101.Text = listenKey and listenKey.Name or "-"
sliced101.TextColor3 = tbl21.txt
if not flag20 then
slicedfn50(slicedfn59(), "idle")
end
return
end
if str7 == "redeem" then
str7 = nil
if input.KeyCode ~= Enum.KeyCode.Escape then
g = input.KeyCode
end
sliced103.Text = g and g.Name or "-"
sliced103.TextColor3 = tbl21.txt
return
end
if gameProcessed then
return
end
if listenKey and input.KeyCode == listenKey then
slicedfn63()
end
if g and input.KeyCode == g then
slicedfn55(TextBox.Text)
end
end)
if getgenv then
getgenv().TracedStatus = function()
return sliced99.Text
end
getgenv().StopTraced = function()
flag21 = false
flag20 = false
if slicedfn32 then
pcall(slicedfn32)
end
for _, sliced110 in ipairs(tbl23) do
pcall(function()
sliced110:Disconnect()
end)
end
tbl23 = {}
if ScreenGui then
ScreenGui:Destroy()
end
end
end
end
;(function()
local BG_IMAGE = ""
local BG_B64 = [==[/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5Ojf/2wBDAQoKCg0MDRoPDxo3JR8lNzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzf/wAARCAMAAbADASIAAhEBAxEB/8QAGwAAAgMBAQEAAAAAAAAAAAAAAAECAwQFBgf/xABCEAACAQMCBAMECAYBAwMEAwAAAQIDBBEhMQUSQVETYXEiMoGRBhQjQlKhwdEzYnKSseFTFUOCJDRjJURUc5Oi8P/EABQBAQAAAAAAAAAAAAAAAAAAAAD/xAAUEQEAAAAAAAAAAAAAAAAAAAAA/9oADAMBAAIRAxEAPwD5tsYOJvMqcOybN6OZxF5usdopAZ1ohNg9iucsAPLlNRSy2dCjTVOOOvV92ZbCnlyqP0RtAYAAAMAQCwZ7illOSWq3NRCS+IHKnHXJWaa0eWcomdrDA6HBanLdOm3pUjj4rU6VxHc4dlPw7ujLtNHo7mO+wHGrR1IJZgvI0XEdTPHZ+oFNTcqZfURSwLIv2V6ARhsSAYmwAAyHYMDAQDAC+k8x8yeH2KaHvNF4C17C1JAAgGAGywvZUGqdTWk//wCp2Vrs9Oh5o63CK7nB0ZPWOsfQDe0GCWO7DAEcCJYHgCGvYPUlgMARx3B+RLAgFgHqPAY8wOTxSyiou4oxxj34rb1OXuj09VKVOcWtHFpo8wtEAsAPIgB7EJMbZVOegDb1wllvZdzXRt0vaqavsK0ocseea9p7LsjSBrS8zk3zzd1PXH5HXRxrx5uqv9QFEngobyy2b0Kksv1A6ttHkowXlqW9RJdBgAxDAYANAApIYYAwXSxU9UY57m26/i+iMc9wFGXLJNdGmesrrKPJxXM0lu2kj19ZaAcm5jvoZIrDZuuepij7zAqqehnkjVNaGeYCp9SwqhpLJaAgGAAAAAhgCWQLaC1bLyFNY0RYAgwNAAgGLABg2cKi3dprZReTNThKpJRgss7dlbxt4YWsn70u4GkB4FgAABgLYGMQALQkICLXYMMkGAKLyoqVrVm3tF/PY8wtjq8duU5RtoPb2p+XZHKQDIykNsrlLqBCciyyo+LPnl7sXou7KYRlWqqEd317HWpwjTgoxWEgGDGIDWjiXP8AHqf1P/J3Dh3P8er/AFv/ACBmqEafvRz3Q6hHqvUDtAC1SfceABDEMBgAAAAQuJ8lJvrsgMNaXNUk+nQzVNy9soqbgW2MHUvKEF1mj1dbXOTg/R6lz3zqNaU4N/F6L9TvVtmBy7lbmNbvBtuluY4rVgQmtDNUWDZJGepEDM9CyLyiEkEZcrAtAS1GAAJvAJ52Aa1LIRCEC6McaASiiQJYGAmAxqLbwgIllKlKo127l1K3beWjdRoY6AK1oqmsJY7+ZtgtBQhgtSAEgwGGMBAMWABiwPAYAWBYJEZzjCLlOSjFbuTwkAGPiN/Czp7p1ZL2I/q/Ix3/ABynFOFmuef42tF6dziSlOrUc6snKUnlt9QJ80pzlObblJ5bfUl0IxQSeEApMonLoSqS7F9jbc78WovZXurv5gX2Vv4VPml78t/I0D2BgIOgZIuQG1b5OHca16j/AJmdyPQ4M9Zyb7sDPUIllRFaA69CXPRhLyRYjJw+eaTh1i/yNaAaGIYAAD6gCMFzWVWpiPux2LLq43pU3/U/0MqWEASKJPLLZvCJ8OtXe3UKSzy7yfZdQO/wC28Gx8SSxOs+b0XQ1Vupowox5UsJaJGau9GBzLl7maK/M0XL1ZQtEAmsoqnEvIyjnUDFOBU4m2UMlbp67AZkmiWr6l/hjVMCmMC2EC2MCyMAIRgWJYHgeAABxg5bGujbgZ6dFy3RspW/kaKVDyNMKaQFNOlgvjDBOMSWiWW0kurASjoNGK54tY0G+aupy/DTXMc6v9JIr+BbN+c5Y/JAd5gjylXj19NvllCmv5YfuY6t/d1W/Euarz05mkB7dtLd49SqV1bxbzXpLG+Zo8NKcpe9KT9XkXwA9nPilhDPNdU9Ozz/AIMtbj9lDPh+JUa/DHC/M8thjUWwO1X+kNeelCjCmu8nzP8AY5dxc17qea9WU+yb0XwIRgWRgBGENS2KwNRwDeEA28FU5Dy5PEVls00LPDUq2/SPYCm0tXVanU0h0Xc6WEtlgYAIUmugN4KZyAcpFa5qk1CmnKT2SCjTqXNTkpLPd9Edm1tYW0MR1m/ek+oFE5ckJS7Js4WNNTq8QnyWsl+L2TlgVTWhV1L5ooawwLrWr4dZN7PRnUOKbrS6i4qFWWGtE31A2jIqUXtJfMjUuKVP3pr0TAszgxXN3vCi/JyRTXup1sxhmMO3chCIDgsdCUmNaEKj7AVVHqeo4DZfVbXxKixUq6vyXRHE4NZO8vFzLNKHtT/RHrugEJbMx3D0Zqm8Iw3MgOfXeWQHN5kwAAAMARayLlJhhAQ5BqJLAACQYGCi5PC3AXwL6VByw2XULbq9zbTo46AU0rfHQ106SXQsjDBYord7ARjHHQjWq0reHPWqRhHvJnL4jx2nQzTtMVamzm/dX7nnrivWuqjqV6kpy7vp6Adu9+kUVmNnTz/8k/0Rxbm8ubp5r1pT8s4XyK1AmoJAUpMfIy5QJKPRAUqDGqZpjRk9oP5E1bVMe7+YGTkGqZrVrV7L5klaVP5fmBjVMkoYNf1Sp3gP6nLGtRL0QGVRwPKNis4dZyf5E429KP3c+uoGBc03iEW/RF1OznL+I+VdlqzcsLRL5IAK6VKFJexHHn1JvyAWQGQlLQJSKZ1ACc8dSVrbVLufs+zTT9qb/wAI02nDZ1GqlzmMekOr9TrRjGEVGKUYrZJbAVUaNOhTUKUcL/JL1JEWB5/iVXnrKmtob+plRHLk25PLby2TQClsUziXsi4sDNgC1xFyAVYJRjlligTjHyAjCJalgcUKTwBGTKZavCWfIlOR0Po/Z+PdOvNZhSeV5y6AdvhNn9TtIwf8SXtT9e3wNjf5DWxCbAqqy3OZcz1ZtrywjmV5ZkBUMXQYAMAAAAAAAGll4W4BFOTwtzoW1so+o7W25IrK9p7m+FPAEadLGpdGOCUURr1qdtRlVrSUYR3f6AKtVpW9KVWtNQhHds8vxTi9W9bp0s06HbOsvX9iniV/V4hWzP2acfch2/2Z4xAgo53JqJLBbRoTrarSHcCpLsaKdpUlrLEV26mylRhSXsLXq+rLEsAZ4WtOO6cn5lyhGOiSS8iQALHYeEAAAAAAAAAsA0MTaQBgNiLkQlPAE5SK5TRbStLittBxXeWhut+G0aetX7WXZ7fIDm0betcyxSj7PWb2R1LWwpW/tPM6n4n09DYsJJJYS6AwIAxgBATGxMDycUTQkMAEMAItByongAIqJJIEPYBMrm9CcngoqSwBCTbeFuz2PDrZWtpTpfeSzJ929zzHCKKr8RoxlsnzP4ansEA3oiqoyyRmrPGQMlzPc57eW2aLmWpmWyAaAEMAABgAgGAjbYUOb7SS/pM1Cm6tVQXXc7lGmopJLCQEqcMFqQJEgBtJPOiWrZ5LjHEJX1xiD+wg/YXd9zq/SK88Oiram/aqrMmukf8AZ51LCAEgbwEngusqHjz55/w4/mwLLS150p1fd6Lub8JbDE3gBiyiEpEYc1SahCLlJ7JAWOXYXPrhavsjfb8MXvXEsv8ADF6G6nThTWIQjFeSA40aFeesaU8d8Fis7n/j/NHYADj/AFK5x7i/uQ/qVz+Bf3I62NAA5Ds7n/jz6SQvqdzj+Fj1kjsiA5H1C57R/uJrhtV+9VgvRZOo0IDDDhlJaznOf5Gmnb0aX8OnFPvjLLQAQmMTAFuAAAmRJPYiAmRJsiB5RDEhgAxDAOoMAAENgDAhNmab1L5meW4HW+jUc3lR9qf+WelSPM/RqeL2cfxU3+TR6dARl1MldmuXUx3C9kDmXL3KkWXG7KoPTHYCQxDQAAAAAA4xcpJLVt4A6XC6PsOo172iOnFFVvTVOEYrosF60AYNpJt7LVgYeNVnR4dV5XiU/YXx/wBZA81eV3dXVSs9eZ6enQpkyT2KqkgIvM5KEd28I7dGmqVOMI7JHL4bDnueZ7QWfidYAbKpywSnLcyVZ4AnmVSpGnTTc5PCR6GytIW1LCw5v3pd/wDRyvo7R551biSzy+xF+b3O6AAGAAAAAAAABAMAEAMAEAxNAIBsQCAAQCexEkyIAyJJkQPKIbEhgAegDAAAABDAAKpmee5pmZ5rUDTwquqHEKM5NKOeWT8noeyj2Z4Lqey4VdK7soVG8zXsz9UBqkZa60Nb1RTVjlAca5juZE+Wfk9zp3FPc59amBMCmE+X2ZfBlwAAAAG3hlHnrc792H+TJCMpyUY6tnctKKpUoxXbV92BpitiQooeAA4v0ln7NCl3bn+h2kjz30jlm9px7U1j4tgciTKJvUvnsZpPUDocIj7FSXmkdB7GDhDzCrHzTN8tgM9aWEzBXmbq3U59cDu/RapF29enn2lU5n6Nf6O2eK4beysbpVUswek490ext69K4pKrRmpRfVdPUCYDABdADIAAAAAABkBAMQCAGHUAEMTATBAwQCIkmRbAGRJdCLA8qgEmMADAbBkBgAAMAACEkUVI51NLKpoDOjocEvvqdzibxSqaS8uzMElhiQHvlqtCEkcTgPFFiNpcTw9qcn/g7+AMdWnk59ejrsdiUcmepSz0A4VSk0+pGKlHY61S3z0KHba7AZItv7pdToynotDRC3wzVRo4wAWltGmtNZPds3QWERpwwi2KAYdQGAHnPpB/79f/AK4/5Z6M8/8ASGOLyEvxU1+TA4szPLc1TWhmmtQNHDavh3KTek/ZZ15bHnlo8o7VncK4p6+/H3l+oBVjuYq0DpTjkz1KeegHKlHDLba7r2lTnoVJQfXGz9UXVKRRKkB2KH0jktLmgn/NTePyZup8esJ45p1KbfSUNvkeWdNi5GgPYR4tYSeFdU/imiz/AKhZZ/8Ad0P70eL5WJxYHt1e2ktVc0X/AOaD65ar/wC4pf3o8RysOXyA9v8AXLb/APIo/wB6JK5t3tcUf/5EeG5fL8g5fL8gPdxqU5+5OEvSSZI8Dy+Q0mtsge93WgYeNn8jwinUW05r0kx+LW/5an97A9zh9n8gw+z+R4bxq3/LU/vYeNV/5an97A9w0+z+QYfZ/I8P41X/AJan97Dxqv8Ay1P72B7ZiZ46N7dRWI3NZLtzsuhxe+h/3+b+qKYHqmRPP0+PXK/iU6U9PNGqlx2hJrxaVSHnHDA5Sp1H91k1QqPsvVmkaAoVvLrNfIHbyWzTNCADLKEo7x+JE27rUrnQT1h7LAzgOUJQftLAgAjJEtAaAzTjkqxg1ziUziBUtz0XB+MqSjQvJYltGo+vk/3PO4AD37IuOdzy/C+M1bXFOvmrRXzj6Hpra4pXNJVKE1OL7dPXsAnSTIuijRhMMAUKkl0LFBIs5R4wAkh9AAAGIYAcb6RQyqFT1j+p2THxah49jUUfej7S88f6A8tJGepE1brQqnEDJsSpVJUpqcHholOBWB17e9p1koyahPs9n6GiUTgF1K6rUtITeOz1QHUlTyVyorsZ4cSl/wBynF+jwWx4hRfvQnH5MAdHyIugWq8tpffx6xZJXFu9qsfi8AZ/A8heB5GtTovapD+5EkotaOL9GBi8APANyh5ByAYPB8g8A3un5C5PIDA6AnRx0Og4IXh+QGDwReCzocgeGuwHP8EPAOg6aFyeQGDwCLo6nRdMj4fkBznR8iMqR0XTIypJgc1wYuVo6EqRXKkBqGhDQDGJAAxoSGANJ7oqnQi/deH+RcAGOdOcPeWncRvyVzoQlqlh+QGPBCUTTKhOOq9peRS0BnnAqawa3EqnACgutrqta1PEoVHCXl19SEoPoQxgD1HD+P0a2IXS8Gf4vuv9jsppxTTTT6o+fGuy4jc2T+xqex1hLWLA9uDOTY8dtrjEa32NR/ifsv4nVTTSaaaezQDAAAEMAAAAAPN8Vsna1nOKfgzej/C+xgayexqQjUg4VIqUXun1OPd8FllytJpr8En/AIYHBnAqlTN9a1uKT+0oTj540M7SAyODQuVmpwI8gGYNepe6fkJwApAt8PyDwwKdALfDF4YCVScfdnJejLI3dxHarLHZ6lfIxcrA1x4lXXvKEvhgujxOP36T+DObhh1A68eIUJLVyT80WxuKE/dqwfxOGAHoY4aysP0B+Z55NrZtejLY3NePu1Z/MDuegsdzkRv7hfei/WJYuJVMe1Ti/RgdPAsGGPE4Y9qlJejJx4hQe/MvVAasCcSELijU92rHPnoWgVuBFwRcICjI0IaAaGhIYAhrcSGAxiDqAyREbAZGcIzXtJMkAGads/uPPkyicHF4lFo6AnFSWqyvMDluBXKB0qlsn7jw+zMs6bi8NYAxuGCODVKBXKAFJrseJXVk8Uaj5OsJaxMzg0RA9bYcctrnEK32NR/ifsv4nV9D56dLhnGK9k1CTdSh+BvVejA9h1GU2txSuqMa1CXNF/NPsy7qAZAAAABBqAEJ0qc3mdOEn5xTwTADNLh9pJtu2pZfXBX/ANJsd/AX9z/c2gBhfB7F/wDY+UmC4PYf8L/vZvBAc2XBbF5xTmvSbIS4FaS2dWP/AJZOoAHFqfR6Df2dxJeUo5MtXgNzH3JUp/HB6QAPIVeHXVFZnQnjullfkZXDue5Kq9tQrrFajCfqtfmB4p0yLpnpq/BKMsuhOUH2lqjl3PDLm3y5U+aP4oaoDlumR8Psa+VCcOwGTwxcrNfIR5AM3KxYZp5BeGBnAu8Mi4MCtFlKvVpe5NpduhDlwRA6VHiEXhVo8v8AMtjYpKUcxaa7o4RZQr1KEswenWL2YHTGhIaAYAgAaH1EhgND6iABjEMBgAAAIAAYpQUliSTRLQSAyVbZx1hquxncTqFNagpe1D3v8gc6UCuUDVKOHhkJRAxNNAaJwKJRwwNfC+IVLC4jJNuk2ueHdfue1pzhVpxqU5KUJLMWuqPnx6b6LXXPQqW0n/DfNH0fT5gd0ADQAAAAAAT2AYEWyMqiisyaS7tgWBkxVOI28HpJzf8AKjPLiy+5Sf8A5MDq5A43/VaudKdP45BcWq51p0/hkDsgcunxdffpP/xeTVS4hb1dFNRfaWgGrqDEmnHKencYCAAAy3VhbXOXOmoy/FHRnIu+E16PtU/tYeW6+B6EAPG4w2nugPU3djQuV9pHEvxx0ZxbvhVehmVP7WHeK1XwA5+A5UMYEeUg4lmBAUuHkVygasIhKIGRxaEaJRKZRYHVQyKZIBrcBIYDRIimCeoEgAAGNCXoPOgDAWRoAGIaAMgga1BAMBgBRcUuZc0VqtzIzpGKvDkqPs9UBRKOhnqRNTKZoDLjB1Po3U5OKQWdJxlH10z+hzJ7m7gT/wDq1t/U/wDDA9oAdAAAeED0ISkA3IhKfcrnUwcy9unJunB6dWBfc8QUW40dX+J7I51SrOrLNSTk/NkdwAQwABDQCAAGAFlC4q0HmlNry6M6ltxOFTEa+Kcu/wB04wPcD1G6A4NnfVLZ8r9un1i+nodujWhWgp05ZT/ICYAJgD1DoMQGO84fQufaceSp+OP6nCu7OtaSxUWY9JrZnqWRnFTi4yScXumtGB5ER0+I8MdFSq2ybhu45y4nMABMYAQkiqUUXsjJAdd04T96K9SErWHSUkWomBmdpP7sk/Ug7esvup+jNy2JIDnOjVX/AG5Z9CPJNbwl8mdVEkwOTiefcl/aySpVml9nP5HWiNbgctW1w9qT+OCas7h/cX9yOlgmgOcrGt+KC+IOxrdHB+jOiSQHIqUatP34PHfoVpncZjurRSXPSWGtXFdQMGOw1uL4gBIQAAFF2vZi/PBeU3f8NeoGQqqFxVUAy1NzdwGOeLW/k2/yZhnudf6LUue/nU6U6b+b0A9UACewCbKas8InNpIw3FXCYFV3cOMcJ6vY5xOrNzk2yAAMAABADAADOoAAAADEwBgHQttripbVOeD9V3KQA9Jb14XFJTp7dV2fYtPPWdzK1rKSy4PSS7o9BFqcVKLymspgNiGIBAAALqcTi9h4bdxQWIffiunmdwjJJxaaymsYfUDyIGniFq7S4cVrTlrF/oZgExDEB2ETIImgJIl0IomA0SRFMkgJIaFEfUCQ0JEkAEkRJIBsEDDoByrymoXEklhS1RSjVxJ/bw/p/UyrUBgAABmvH7sfiaepguJ89Z42WgEehVUZY2UVGBTLVnqfoxbeFYOq960s/BaL9Tzdpbyu7qnQhvN6tdF1PdU4RpU4wgsRilFLyQEiMmNsqqSwBTXng5d1Vy8I1XVXCOdKTcm2BEYgAPIWRN4K5TwgJuSK51lHbVlM6mdEysCcqs5dcehDL7sQATjVnHaTNFK4TeJrDfUyAB09xGa1qv3JP0ZpYCGAgG/M6/B6/PSlSb1g8r0OQaeGTcLyHaWYgd5gAYAGIBAGQYABj4pb/WLWSS+0h7UTzaPXnmL+j4F3Ugvdb5o+jAzsQxAdhEyKJICSJEVuSAksEkRJICSGKJLqA0SREkgAkiJJANggDKSy9luByb6SlezX4cIqRFz8SrKb3k2ySQDAEGUgK7ir4VJy6vRGCI69V1qmV7q0RHZAE3hGapLJZORt4Lw53tx4lVPwKb1/mfYDqfRuwdCj9ZqrFSppFdo/7O08YFovTyE2ApPCMlephMsqzwjm3dfHsrd/kBRcVOeWFsU9RiABN4Qmyqc9ACc9zPOeRzllkAEwAAAAAAGAuoDT5WmtzoJ8yT7rJzzbQ1pR9ALAAAAstXi5pP8AnX+Sr5F9jHnu6S/mz8gPQoBLcYCYBgAF1AGACOHx9Yr0ZdXBp/M7jPPcarRq3ihF5VOPK35gYhMOggOyiXUhnBFywBcmEqkYLM5RS7tmK4ufBjprJ7I5tSpKpLM22/MDuq7t848aGfU0Rakk4vK7o8uyyhXqUJc1KTXl0YHp4jM9jcxuqXOtGtJLszQBIkiKJIAJJESSAfQy8Rq+Hay7z9lGo4/Ea3jXLhHWNPT1fUCmGxNEYrBJAMyX1bC8KO795+XYvr1VRp8z1fReZy8uTcm8t6sCUVhCnLA28CoUal1cQo0Y5lL8l3YE7C0qX9yqUNI7yl+FHsLahTtqMaVJcsIrRfr6lfD7KnYW6pU9XvKX4maGwBsqqTwgnPBhu7jkXd9EBG6r8qwt2c5tt5e45ScnzN6kcgAm8A3oVTmATmZ5z1CpMr3AeciGACGAgAAABiGAAbqS5aaXZGOlHmmkbY7AMAABs38IpZqTqtaRWF6mBJuSSWW9kd6zpeDQjDtq/UDQhgtg6AIGPoIAEKUowi5SkkktW+hwOJ8bc80rJtR2dTq/TsBt4pxOFsnSotSr/lD1/Y4Cbbbby3q2yqC69S1ICSABMDqyeEUVKmC2exkrZAz3Muaa8kUkpNiw3sgEBKNOctIxbNtrYZkpVnlfhXUDVwOnKNKpN5xJpJenU6ZVTSjFJLCWyXQt6gSRJEUSQASREcpKEHKTSillt9AKL64+rUG178tI+px6a77jubh3Vdz2itIryJRSxsBJDbUVlvCW+Q6GG9r8z8KD0XvPv5AU16rr1ebXlWkUR2EtCM5PZb9gBKVWap005Sk8JLqes4Vw6NhRecSrS9+X6LyKOB8N+qw+sV19vNaJ/cXb1Oo2A2yqc8dRTngw3dz4ei1k9kA7q5VNYz7T2RzZSc5OUnlsUpSlLMnlieQB7CbwDZVKeACctDPUnkc55Kt9QDcAABgIAAAAABDEAxDHCPMwLreOnM+ppWxXTWhagBB1BllCk61RRXxfZAauG0OaXiyWz9n9zrRRVRpqEEorCRoQBgAABMz3l5QsqXiV54/DFby9DPxXitKxjyRxUrtaRzpHzZ5evWq3VV1a83Ob6vp5IC/iHEq9/Npvkop6U1+vczxiOMC1IBRiTQYwMBCzqMMaAdOSyZ6kMmtoi4Ac2dF+gRovy+BvdLJJUgKKNLCNtKGEKFM0RiBKCJiiPqBJEkRRJMBnH4leePLwKT+zT9p93+wcQ4j4maNtL2XpKa6+SMdKGEtAJ046F6RGKwiFesqNPL1k9l3AheV/CjyR9+X5HPSBtzm5SeZN6g3hAKTO59H+GN8t5cR//XF/5f6GXgvDXeVfGrL/ANPB/wB77HqG0ttF2QA2VVJ4QVJ4MF1c8mi1k9kAXd1yLC1kc6Tcm23lsUm5NuTy3uw2ABNicsIqnMBzmZ5zyEp5K+oD3EMAF1AAAYgAAGIAABiAe5fRjghTjk0wWEBKKJAg6AEU5NKOreiOxZ26pwSfvPdmewtnH7Sa1e3kjpwjhASiiYkh6ZAW5x+McYVvzW9q1KttKW6j/sq4zxjl5razl7W06i6eS/c4MY5AMOcnKTbk3lt9SyMBxjgsUQEokhiAAAAAiMQHZWw8CWxIAUdSXKgRJANImiKJICUdCXUz1rqhbL7apGL7Z1+RzLnjMpezawwvxS3+QHXuLilbQ5601FdF1focW84hVu8whmFLt1l6mP26tTnqycpPq3kvp00gCnDCNMI4QoxwhVq8KEMyevRdWBKtVjRg5T+C7nMqTlWnzyevRdkKpUnWnzz+C6INkAN4Ro4bY1L+45FlU46zljZfuVWttVvLiNGkvae7eyXc9dZ21Kzt40aK0W76yfcC2lCFGnGnSiowisJIjOe4TlhGO4rKMW8gRurhQi9dTmyk5y5pbsdSbqTcn8iADIylhClLBTOYDnPQolLIpSz6EdwAHsAwEAAADEMAAQAMBAAEoRywjHLNFOGwDpxwXJaCisEgBGqyt/EfPJeynp5ldtQdaXaK3Z2KNNRSS0SAnThgtSCKJAHU4XG+LcvNbWklzbVJrp5It45xTwE7a3f20l7Ul9xfuedhDuARgWRiSUcIklgAQBkTkAwFHMniKb9CyNvUe+F6gQAt+qy/HH5A7aXSSYFL8xFsqFRdM+jK5RlHdNeoHXRNHPnxO3p+7zVPRYRmqcWrS/hQjDzerA7aZVVvLejpOtHPZPLPP1a9et79SbXbOhBUwOxV4zTjpRpSm+8tEYq3ErusseJyR7Q0/MojSLYUgKI023ltt92X06RdCnoWxgBCFPHQujHBVVr0qPvSzL8KMVa7q1tI+xDsgNdxeRpZjTxOflsjDJyqSc5vMn1YowJpYQBokOjSqXFWNKjFynLZfqOhRqXNVUqEXKb+S9T1XDeH07GliPtVH708b+XoA+HWNOwocixKcvfn3f7GibwhyeNTPVqaPUCFarjXJy69XxJ75S2LLqtzPlXxM2wARb7hJlU5AKcyiUsscpNsgA2AgABgAAIA6gAIYAAgygz2AfQcVnoOMMl0IAKEC+McBGJIBpaFlKlKrPlitOoqVN1JYS9Tq2tBQjhICdtRVOCUVhI1RjgIxSJ4wAGDi/EFZUcQadefuLt5mm8uadpbyrVdlsusn2PIXFapdV5VqzzKXyS7AVpSm3KTbk3lt9S2MRRjgmAPQi2KTK23JqMdW3hICXM28R1Zqo2nWrv+FFttbqisvWb3ZcwBJRWIpJdhdRsWPIAAGAARYxAcaNMmqXkaFTJqAFEaRZGl5FygSUfICuMMdCxQKq1zTpZXvS7IxVbmrVym+WPZAbqlzSpaN8z7IyVbupUyo+zHy3KFHJOMAIKLbLIxJKOBrLajFNt7JbgLY0WdlWvanLTWIr3pvZG6x4NOpid3mMf+Nbv17HepU4UqcYU4qMY7JAVWVnSsqShSTz96T3Ze2DehXOaSAjUmc+6r40T1ZZc1lFZyc6UnKTbAXViY0QnLAEJyM9SWdCdSRTuABkAAAYAADEMBB1B6BhsBZDVk40yyNPyAqjAtjT8i1UyyMAK4wLIxwTSQJN7ABbRoSqPtHuWUbdyackdGlRwloBG3oKCSSNkI4CEcIsSAEsCnKMIOc2oxistvoh+bwkjzXG+JfW5fV7eT8CL9p/jf7AZuKX0r+4ysqlDSEf1KIxFCJYkALQjJkmympICM5mzh1HEfGlu/d9DBTg61aEF1Z24pRSitEtkAxDEAMXUbEAMAYAITGgYGbCJJAU3FzGl7K1n2AtnUhSjmbwYa11OplQXLH82UylOpJym22SjACCjkmoE1HA84ASihtpFttbVrqbjShnvJ7I7dlwujb4nU+1qd2tF6IDl2fDbi6xJrw6f4pLf0R3bOwoWi+zjmfWb3ZoRJAMG8IRCUgHKehkr1lFNtjr1VBNt6HLrVnVl5dAFVqOpJt7EdgBagD0KpvQskUVHoBTUkRWxGbzIkAAAwEMAAQYzsSUWy2FPQCqMMl0aZZGBYo4ArjAmok8YABJIMFkacpPyNNK26sDPClKXkjXQt0jTSoeRphTSAqp0sGiEMElEljAAkNtRi5SaUUstvZGe8vLeyp81xPl7RW8vRHmOJcUr38nBfZ0FtBdfXuBp4xxd3PNb2rao/fn1n/o5kI6IUIlyQAkSAGBXMz1WX1GZam4GvhceavKX4Y/5Ooc/hC/iv0OiAmG3mDEgAXUbEAMAYssAYmGSLkgMFzc4zCk8vq+xkjHO5KMCxRwARjhEtgISkBJs3cP4dK5xUrZjS6LrL/Q+FWHjYr117H3Yv73+jursAUacKUFCnFRitkie4kSAa3Hkg2QcwJymZrivGnHLZTdXcYeynmXY585yqS5pPP6ASrVpVZa7diAiQACAEBGRnqmiexnqIDNJ6k91kjJaijLG+wE8gHMvMEmwGmTjDJKEC6MMARhAtjHBJLC7jASQ8ATpU3UeF8wIxi5PRGmjbPOWtTRQt1HZGynSSAz0qGmxphSSLYwJqIEFDHQmkRrVadCm6lWahBbuRwb/6RPWFjDT/AJJrf0QHduLijbU+evUjCPm9zg330ik8wsYcv/yT3+COJVqVbio51pynJ9ZPIRpgOcqlabnVnKc3vKTyycIEoxLFEAUSSQIAGRYxPYCmozNLc0VDO9wOhwj3a3qjoGHhKxRm+8jcAMQPbAdNAARJkQBkJSHJ6GepPAEpVEupusrPnjGrWWU9Yx/c5duvHuqVJ7Slr6HpXhbbAeSihvYNiEnoApSNHDbR3df2v4cNZPv5GPWTUYrLbwkensrdW1vGkt95PuwNMUkkkksdF0JIiiSYEltqJyIuWhVOpjqBOdRI5tzeOTcae3WRG7ruT5IvC6mZAMaECAZIQIBgAIBMqnHJdgi0BklAhyGtwFyAURplsKZbGHkTUcARjEsSwIYAABvoBOnTdSaijqW9BQikiNpbckVlavc3QhhAKEMFiiSSGAksHP4pxejYrkX2ldr3FtHzf7GbjfGPqzdtavNb70l9z/Z5tJyk5Sbberbe4Fl3d3F7U569RyfRbJeiK4wLI0yxRwBXGBYokkh6IASGDaFlAMBJ521Hr2fyABSB57P5Efafuxk/RAU1GZ3ubPq1eptBr+rQ02thGlLnqSU5rZLZAXWdJ0reMXvu/iXDEAAAs9wGyLG9hNAV1HoYq0sGuqYa4FvCZJ8Uo57vHrg9M9Dx1vWdvc06y+5JP4HsIyjOKlB5jJZT8gPJtlVRk5Mok8sDocFoeLdeJJezT1+PQ9AjncEp8lmp41qNv4HRAkgbwHQi3gCM54MVxWwmW157nOrSzLDAj6h1BDQDGhIaABoAAYAADAEABgMDABAMQDH0IjAZq4fR8SpzNezHb1Mp3LOj4VKMeuNfUC6EEkWpCiiQAczjfEvqVFU6T+3qL2f5V3OhXqwoUp1ajxCCyzxdxWnd3M69T3pPbsuwFMY5eXq3uy2MSUY4HsgGljUMlcpmmhaykuaroukeoFUeabxBOXoXwtZy9+SXktTWoqKxFYQ+gFEbWmt8y9WWKlTW0I/ImgAFotAAAAGAADEAAAZAAB4F0GxboAaENiAqqLQw10dCayjNVhnIHNksM6nCuKK2iqNdOVL7susf9GGpTKXFoCybKXqy2oUoD1PD1izoL+RGlbGThk1OxovtHHyNfQBkJ7E+hCYGK4e5zpt850bhbnNqrVgWICNOWY+aJIBrckiKJABJCABgAwAAAAAAAAGhAMAADRZU/FuYp7R9p/A7sUc7hFP2J1H1eEdOKAkgBABxfpLcctKnbRes3zyx2W35nChE18WrePxGrLOYxfLH0X+zNsANpFc5inMnZUfHq80l7Ed/NgabK3wlVqLV+6n0NgwAQDDAAACAYCGwAQAAAAAAAAAJoYmACG9RJADRVOOS0i1rqBlnTKJUcm9xTIuAHKqFSLpopejA7HAa6xUoS3zzR/U7J5GhVlRqRqU3iUXlHqLW4hc0Y1Kb33XZ9gNCIyRJDaAx14ZObXg85OzOGTFXpabAcvWDyi2LTQ6tPD2KUnF5QGhDRXCal6lgAMQwGHUAAYAAAADAQAADAC60p+Lcwj0zl+gHatKXh0IR7LX1NC2IxRMAK7qr4FtVqv7kGyxHL+kNXkslSWc1JpfBa/sB51POr1b1ZGcsIk2U1JAQk3KWFu9js29JUaMaa3W77s53DaXiXDm1mMNfidYADoJvBCUsATyJyK4c1WahTTlJ7JHTt+GRSUriTk/wxegGDmQ029ov5Hbp0aVNYhTivgT3A4LbT1TQZT6newQnSpzWJU4tegHEA6k7GjL3U4PyM1WwqR1hKMl22YGQBzhKm8Ti4vzQkAAAAAhiABLJJ+ZEAExgAsCGDA5MkUTjrk0MhJZQFCNFpdVLWrz09nvF7NFDWBAersrundw5qT9pe9F7o1I8dTqTpVFOnJxktmju8P4vCriFziE+kuj/AGA6biVTgmi9aoHHIHMrUTHVo+R25U8marRyBxpQwSjUxpI2VaG5lnSaAmnnYZQswenyLI1FLfRgTGhIYDAAABiAAAAAZ0+EUtJVWt9F+pzqcHUmoR3bO/QpqnTjCOyWALookLZDADzn0gq+JeqmnpSil8Xr+x6KUlGLlLSKWWeMr1XWrVKst5ycgK5Mz1HqW1GV0KfjV4w7vX0A6nD6Xh20W95+0/0NLYtkV1JYAJzK6ancVo0qMczl/wD7JTUqNvC1PQcKsvqtDNRfbT1l5eQF1naQtafLHWT96T3ZoAAAAAAEwAAAAAjKMZLEkmuzRkr2EHrRfK/wvZmwYHDnCVOXLNYZE7ValCtDlmvR9UcmvSlRnyy26PuBWxDzkTQDZEb20EAMAZGc1CLlJ4S3AJNRWW8JdWYq9/uqKz/MzPcXEq8tcqK2RVgDRhMi0SGBTKOSpxZpZGUQMwycoEGsAb7DilW1xCealL8L3Xoz0VrdUbqnzUZZ7xe6PHFlGtUoTU6U3GS6pgezaIuGTn8O4xC45adxy06r0T6S/Y6vKviBkqUc5MlShpsdRxRCUM9AOJVoFEqTR26lHPQy1LfyA5sZSjo9SyE1Lr8CydEolSaAuQFMZSj5osVSL30AkABkB4BeRKMJTfso32lrGOJS1kBPh9t4ftzS52vkjpRWhXTjguigGAMPJAc3j1x4Ni4J4lVfKvTqeZeiN3Gbr6zfS5XmFP2Y/qznzYFVR9DXwqn7U6rW2kf1MMst4W527en4FCMOqWvqBKctDJWmW1ZYMkuarUjTgsym8JeYHR4FbOvcO4ms06T9nzl/o9EU2lvG1t4UY/dWr7vqy0BgAsgAyPMKVRR96UY57vAExEFVpvXxIf3IlFqSzFpry1AYAAAACACq4oqvTcXv919mW9RPcDhyTi2no10EauJU1Gspraa19UZQBiGxADObf1XOp4cX7Md/NnQrT8OlKfZZRx93l9QEvzAk9BRTk0km29El1Auw02nut0M339tzLxqa9pe8l1RgYAtQwCGBW46kJRL8EWgMso4EaJQ8iuUAK08HW4ZxidDFK5zOlsn1j+6OS1gAPc06kKtOM6clOEllNdSeDx/DuIVrKpmL5qbftQb0f7M9XZ3VK7oqpRlldV1XqBNxyVypZRoE4+QGCdBPoZ6ludVwXYhKkuwHFnblboPJ2XRXYg7ddkByo0GXU7fVHQVv5FsaKXQDPSo4NlOGBxhjoWqIBFExbDYB1Ofxm8+qWrjB/a1NI+Xdmy4r07ajKrWliEfz8jyF3dTvLiVappnSMey7AU9Cuo9CbeEUzeXhAX8OpeLX537sNfj0OnORXa0fq9BRfvPWXqKtPAFFee5v+jtr4lSV3NZUfZh69WcvE69WNKmsym8I9fa0I21CFGnjlgseoFgN4B6FcpYAbZVWr06NNzqS5YrdldxcRpwcpvEVuzz17dzuqmXpBe7HsBpveMVqjcbfNOHf7z/Y5spOes25PvLViDqAsLGyJ06k6Us0pyg+8XgiwA6tnxutTajcrxIfi2kv3O7b16VxTVSjJSj/AI9TxpfaXNS0qeJSlh9V0l6gewEUWV3TvKPiU9Me9F7pl4AJjYgM3EIc9s2lrF5OUjuzipRcXs1g4Tjytxe6eAGxdRti6gZuISxQx+JpHO2Ru4k/ZprzZhb0ATOvwC055yuai0g8QT79Wcf0Wp7C0oq3tKVLGsY6+vUDLE5l9a+FLxIe43qvws6aG4qSaaTT3TA4Iy+7tZW88rWnJ6Pt5MzpgMAABYIuJYxAZ5QKmsGxoqnADOaLG7q2dVVKTw+qezXZlM44EgPacPv6N9T5oPE0vag91/o1ng6FapQqRqUZuE47NHpeG8bpV0qdzilV2Uvuy/YDr7g0gQ+oEXEOVEwAjyofKiQALCGAdwGVXNxStaTq15KMV+fkjBf8bt7VOFJqtW7Rfsr1Z5u5uq97V8W4nl9F0j6AaOI8QqX9XLzGlF+xD9X5mbYEsCkwITeho4bb88/Gloov2fNlNvRlc1eVaRW78jrJKEFCKxFLQBVHgxV5l9aeDNSozu7iFGnvJ6vsurA6f0ctMyndzT09mn69Wd7ZEKFKFCjClTWIQWEOTAUmZq1TBOtPC3ORxK6cIcsfelp6AZOI3TrT5Iv2I/mzGAAABkAAAAAAAAvsrqdpXVWG20o/iXY9Xb1qdxRjVpPMZfl5HjTo8Gvfq1Xw6kvsqj1/lfcD0ohiADk38OS5k+ktTrMxcTp81ONT8L1+IHPWqEwWgPuBi4i9IerMD7HQv1mmn2Zz3uBbZxVS8oQezqRz8z19R6s8jw9pX9u//kR6urLcDJEkiKJIBzhGpBwmk4vdHIvLWVvLKzKm9n29TsIk4xlFxksxe6YHnQNl5YyoLxKeZU+3WJjQDAOgADWSLRMOgFMoFMo4NUkQlADLgEWygQcQNljxa6s8RhPnpr7k9UvTsdq2+kNrUSVeM6Mu+OaJ5fAgPdU760q48O5pS/8AJF/NFrKlHHqfPxP0A+gTrUqf8SrCP9UkjLW4tYUc81zCTXSHtP8AI8Ul5DwwPSXH0kpxyrehKT6SqaL5HIu+KXl5pVq4h+COiMigWRgBGMM9C2McIaisCkwCUkRp0p16nJBadX0RZQoTuHppBby/Y6VKlCjDkgsL/ICo0oUaahDbv3FUlhEpSwZa1QCqvUO9wSxdtRdaqvtqq2f3V2MPBrD6xUVzXj9nF+wn959/Q9C+4CbKaksInJ4M1aphAZ7irhNt6HAuKjq1XPOnT0N3Ea+nInq9/Q5vQAAAQAAAAIAABdBgAAABuB6Pgt749Dwaj+0prR/iidI8fbVp21eFWG8X812PW0KsK9GFWDzGSygJkKsPEpyg9pLBMQHCacW0908MOhp4hS5K/OtprPxMwGe6jzUZLrjQ5bOvUWhyqseSco9M6ARpS8OrCa+7JP8AM9bWaksrZ6nkD0fD63j2EG3mUFyy+G35ASt6sa1NTi/h2LTh21xK3qcy1j95dztU5xnFSi8prKYFqJIjEkBJdnsc694c23Utl6w/Y6KJIDzL00aw1uCO9d2NO59pexV6SXX1OLXoVKE+SrHD6Po/QCvI0IaYDFgYAQcSEoFoYAzuBF0zTgXL5AZ+QPDNDiuwcgFCpk40+5aojeAIKGAegOSRKjQqV3mOkfxMCvLlJRSbfZGqhZZalWf/AIo00aFOkvZWr3k9yzIAkkkksJbJEZS0CUiipUwAqsyfDrGV9V5p5jQi/af4vJEuH2M76pzzzGgnq/xeSPRU4RpU1CnFRjFYSXQAhGMIqMElFLCS6BJj2ISYEKssI511VUU23hI1V54RxOI18vw4vzYGOtN1Kjk+pASGAAgAAAAAADoAAAegYAOodAAAOrwK88Kr9XqP2Jv2X2kcoFo9APasRk4XefW7fMn9pDSf7mtgU3VHxqLiveWsfU5B3TmX9Hw6nPFezL8mBhmtDBeQ+8uh0ZIzVo5TA5jN/CLjwq/hyfsVNPR9DFUhyywyOQNBt4dc+HPwpv2JbPszECA9KiRi4dceNS5W/bjo/PszagGiaZFEkBKJGtRp14clSPNH/HoSiMDg3tlO1edZU29JfuZUepcYzi4yScWsNNbnC4hZO1lzwy6L2fbyYGQAAAH0ENbAAAAAJgRlIByeCuUuxGczdaW3IvEqLMnsuwELe0zidZekf3NqSWiAABkZSCTwUVKmMgFSphF3DrCV5PxKuVRXzl5Bw2wleT8WrlUU/jI9BFKKUYpJLRJAOEYwiowioxSwkugwE3gBNlNWWETm8GOvUwmBmvKyhFyeuOhwpyc5OUt2aL6v4tTC91fmZnuAAAAAACAABAAAAAAACAAAAAEAIDTYXTtLmNRP2dpruj1UZRlFSi8prKfc8YdvgN5mP1Wo9YrMPTqgOyyutTjVpuEuv5MsYgOJOLhJxksNPDKJrJ1r+hzx8SC9qO67o5jWQOfcU8+pkwdSrDJir0+qQDBAAF9rVdCtGa26ryO/F5Sa1TWh5tZOvwutz0fDb1h/gDoIkkRRJbASiMURgSQThGcXGaTi9GmC3JAedvrR2lXCy6cvdf6GY9PcUYXFKVOovZf5Puecr0Z29WVOp7y6913ArGthDQAIYmBGTKZy8yc2Z6j7AauH0/Gr80lmMNfj0OqYuFJK3k+rl+hsACLeENvBVUlhAQqVB8PtXe3HLLSlHWbX+DJXqHpeE2/1ayppr25rnl6sDXGMYRUYpJJYSXRDAedQERkyTKpywgKq08dTkcSuOWHKnrLT4G64qHBu6jqV5PotEBT1AAAOoAgAAAAAEAAAAAAAB1AAAAAEAIAJU6kqVSNSm8Si8pkQA9daXEbq3hVh13XZ9i3qed4JduhceFN/Z1H8pdD0QCexzL2h4cnKK9iT+TOoyupFTi4yWU+gHDkjPUp5N9xRdGfK9YvZ9zPKKA5wAAEkX2VXwa8ZfdekihDWwHpo6kkY+HVvFoJN5lDRmwCUR9BRGBJbkkRRJABl4jZq6o5hhVYe6+/kaxrYDyTTi2msNaNPoNbHb4pw/wAZOtQX2iWsV97/AGcTvncAFIBSApqPVmeW5fU3Zne4HU4TLNGce0v8m3ByuF1OWu4Paa/M6vQCMnoZK0tzTPYxV3uBn9+rCL+9JL8z2+MaLZHhYS5a0JPaMk38z3Wc6rYAGAARkZ6z0NEjNWQHNuZHHqrFSXm8nYuY5yYKtJS3AxgXeA+j/IPq8u6+QFIM0K27tklbLswMoZNf1dfhDwEugGRganQRB0QKALHTaIuLXQCIBrkADqAAAMABAAAAB5nquHXH1qzhUfv+7L1R5U6/0erNVKtLo1zL9QO2J7kmQe4EKtONWDjL4PscqtSlSm4z+D7nYKqtONWLjNZ/QDyvUAQASQ1sIa2A0Wdd29ZS+69JI78GpJSTynqmeZXY6HDrzwmqVR+w9n+EDsoZGOpICRIgTQASWwmNbAP4nM4nw7xc1reP2n3o/i/2dMYHkeuOvUT2O/xLhquM1aOFV6rpL/ZwZxcXKMk1JPDT6AUVEZp7muayjPUQEIScJqUd4vKO7SqRq04zjtJHBNnDrjkk6U3iMno+zA6NTYw3HU3z21MdeOUwOdLc9hwa6V1YU23mcFyT+G35YPI1I4Zr4PfuxueaWXSnpNfqB7ICMJRnFSi8xaymuo9gE9SupHKLRNAYKtHOTLK3z0OtKCZW6SA5f1byJK28jpeEPwwOcrcf1ZHR8NIfhrsBznbIi7ZHS8NByaAcuVt5FUrfHQ7DpohKkBxZUGuhVKl5HalQ8imdvnoBxpUvIrlS7HWnb+RTOh5Acx02hNPszdKljoVypgZARfKkuxF0muoFQE/Cn5DVCq9ofmBWdDgSf15tbKDyymlw+vUxnliu7Z3OH2kLSm4xfNJ6yk1uBseomMQCIkmRYHkkAIFuBJDWwkNAMkRJAbbG+dHEKmZU/wA0dmnUhUhzU5KSfVHmUW0K1ShPNOTXddGB6RE0cy34nTnhVlyPv0OhCcZxTi013TAsGiJJANDEMA6mTiFhC8jlNQqraX6M19RgeRuKM6NR06sXGS6Myzj5HsLy0pXdPlqLEl7s1vFnmr20q2tTkrL0ktpAc1rDEXTiUvRgdOyufFiqVR+2lo+6LasdDjptNNPDXU6VtcqslCo8T6eYGetAzPQ6dWmn0MVSnuBt4TxaVnilVzKg38Yen7HqKNWFamqlKSnB7NM8I00y+0va9pPmoTcc7p6p+qA9vsBxrP6QUKmI3UXSl+Jaxf7HVo1qVePNRqQmv5XkCx4FhDABYDCGCAWEPCKqtzQorNatCH9UkjDX47Y0/clOq/5I6fNgdPCFjPQ87X+kVaX8ChCHnJ5Zgr8Svq+VO4mk+kXyr8gPXTnTh784x/qkkUSvrOLw7qgmunOjxrjKTbllt9XqHK9gPYO/sv8A8qh/eTjUoVPcq05ekkeLw8CxrsB7Z0srK2KpUV2PJU7ivSf2VWpDHaTNdLjF7TSzVU0uk4pgdyVBdimdt2Rmo8fTWK9v6uEv0ZuocSsq+irKMn0qez/oDNK2fYrdv5HXVOMlmOGu6eSMqIHJ8B9i6lRedjeqK7ElSwBXSp46GiKBRxsTSABDYgEyL2JMi2B5JDIokA0NCSGgGiQluMAiSIokA0Tp1KlJp05OL8mQTGB0aHFKkcKtFTXdaM6NveUa2kJpS7S0PPIYHqQR5+3va9DCjLmj2lqdO24lRq4VT7OXnswN4CzlJp6PsADK69Cnc03TrRzF/l5osADy3EeHVLOWvtUn7s/0ZzakD3U4RqQcJxUovRp7M89xThMrfNWhmdLqt3H90BwWsBtsWzh1KmsAbbe805K3wl+5dOCksrVPbBzCyjXqUX7D07PYC+pS1KJU2mbKdzSq6S9iXnsTlST2A5vK0CcovMW0+6eDbKiQdHyAVPiN7TWIXVVLzln/ACXrjXEFhKuvjTi/0M/geQ1R8gLZcX4hNf8AuHH+mKX6FNW6uq2fEuKsk905MmqPkTjQ8gMipt69ScaRsjRXYsVLyAxKgyaoG1Q8iXLjXZeYGLwPIHQNE61CG9SPw1KZX1Fe7GcvhgCHgEHQ8hyvvw0vmyH12X/HEBSosg6RZ9bzvTXzD6xB7waAocGhYa32NPPSltLHqgdNSXstP4gU0birQlzUak4P+V4OhQ47dU8KqoVV5rD+aMLpYK3Bgekt+N2lTCqqdF/zLK+aOlSqU60ealUjOPeLyeIw0OnUnTlzU5ShJdYvAHuUD3PM2vHbmlhVcVo9c6S+Z17Xi1pc+zz+HN/dnp+YG5iB7CAHqQZJibA8ihiiMBpjEhgSRIiNANEiI0BJDI5JLYAQ1uIkgAYhoDRb3lW3fsSzH8L2Ova39K4xHPJP8LOCGQPUgcaz4lOniNbM4d+q/c69KpCrBTpyUovqgJgIYHK4hwanXzUt8U6j3j91/seeubWpQm4VoOEuzPbFdajSuIclWEZR7NAeElBpkT0l5wDOZWk//Cb/AMM41zZ1rd4r0pQ82tPmBkJ06tSn7k2vITg0LlYGmF9Je/BS9NC6N5Re8ZR+GTn4DqB01Xt3/wBxL1JqpRe1WHzOSAHXU6K/7kPmLx6Ed6sfmckAOq7y2j95y9EVy4jBe5Tb85PBzsNkuQDRO/rS93lgvJGedWpU9+Un6sagSUAKsDwy5QHygZ8MeGaoUJ1GlCEpZ2xFvJdHhl5PLjbVPisf5A52AOn/ANHvdH9Xl81+5CXCb1J5tanww/1A5w9jTUsrin79CrH1gzO0BKNaa05srzJqtF+9HHminAAaeSM/daZCVJ9ilabaFsa8l7y5kBCUWiO25qXJUXsPXsQnS8gLrPidxa4UZ89Nfcnqv9HeseJ0Lz2F7FX8Euvp3PKyi0JPD3w0B7d6EWcfhXFXLFC6lmT0hN9fJnYf5geQg9cMmVNYZYnlaASQyJICQ1uRRJAMa2ENANDQkMBjEAEhkRgMYgAZbQr1Lepz0pY7royoMgd60v6VxiLfJU/C+voazyxstuIVqPsy+0h2k9vQDugZKHELerhOXJLtI1Z0ygJBJJrlaTT3TEAGKvwmyrNvwvDl3g8HPr/R55zRrp+U4/qju7BkDytXgd7DakprvCSZlqWNzTeJ29WP/gz2g0wPBunjdY9RKCZ7ySjJe1FSXZrJVO2oTWJUKTXnBAeK5PIFA9k7Gzax9Vo/2CjYWa/+2pf2geQ5cdhxg5P2Vn0WT2MLS2hLMbekn5QRakorEYqK8lgDyVGwuq2sLeo13ccf5NlLgdzLDqSp0165f5HosgBy6PAreP8AFqTqeWyNlGxtKP8ADt4erWX+ZoyGQGtFhaIELIsgPAdRZAB5fQqq29GssVaVOf8AVFFmch1A5lxwK0q5dPmpS8nlfJnIu+B3VHMqfLWgvwb/ACPVPYAPAyi4tqSaa3TWBM9re2FveRxWgubpOOkkeb4lwmtZ5mvbo/jS29QOetNi+nXzpV/uM70ADXUprGVrkzTg0ydCtyPllrF/kXVILfuBkW56Pg199Yo+FUeatNfNHnZxwy20uJW1xCrDeL1XddUBKpHDIxeHjuaqsDLOOAJkkVwfRliAaHnyEtxgSBbiQwJAJbDwBJbARWhIBghMfQBjQgAkAsgAwEMBonSr1aP8OpKPknoVgBvp8Urx9+MJ/kzRDi1N+/TmvTU5AZA7seJW0vvtesWWRvLeW1aHxeDzwAemjVhLVSi/Rkso8votSSlJe7KS9GB6bKDKPOwua8fdrT/uJq+uksKs/ikwO/p3DQ4S4jcreUX6xH/1K5S3h/aB3MoMnD/6lc94f2ifEbl/eivSIHc5g5tTgSvbmW9V/DQqlVqS0lUnL1YHfnXpwXt1Ir1ZnnxKhH3XKfojjZEB0Z8Vm8+HTivOTyUTv7mT0qcv9KSMoZAudzXe9ap/cxK5rratU/uZUAGmN/cxf8VteaTL6fFakf4kIyXloc8QHeocQoVXy83JLtL9zUeXNVpfVbfEX7dPrF9PRgd4UsNYeq8yujXhWgp05ZXbqibA4HF+EKKlXtF7O8qaW3mjhPQ94jzXHLBUKnjUlinN6pdJf7A5BptamV4b36GXYlGTjJSW6AvrRM/U21MSipLZrJjmsSA7FWGTHVpnS0nFSi8xksplFSnkDmtYZKEuj3LalLUpccAWEkVRljcnFpgTQyKGgGtCRHqNPIDGuwgAkCEhgMEIeQGAgyBIBIAGMjkaYAAAAwI8wcwEgI8wcwEgI8wZAlkBZQZAYCygyAwFkG0AwE2hcwEhEXIXOu6AsERU4vqvmPIDAQAAPcWeyDcC+1uZ21Tnjqn70e53qVSNWnGcHmMllHmjo8Hr4nKjLZ6x9QOsU3dGNzbzpS+8vk+hblCyB4irFxk01hp4a8yJ0ONUlTv6uNpYkvic8DXbvmoYf3XgorLUstHrOPkmKsgL+G3Spvwqj9hvR9mdOUPI88dCxv8AlxSrv2doy7eoGqpSyZp0vI6XKpLK1T2aK508gcuVPBDlaOjKj5FUqIGRTa3WSamibokXSYDTT2Ag4NB7S6sC1MZUpSXQaqd0wLAzqRU15j5kwJgRT7MaYDDIAAwEDAYNizoQlLuBJy8yMqiW7KpTwQzkCx1n0Iucn1IgANt7tgAAGX3Hl92IAGpSWzY/En+JkQAn4s+4eLPuvkQACaqy8vkLxZ90RACXiS7icpPqyPUYBkAAAHzNbPAgAthW6S+ZeYy+jJuOOwFuRZAAAttZ+HcU5L8SKQjnnj/UgPTZE9RIYHB+kMf/AFNN94fqcbqdz6Q6zod+WRw3uBdafxvVMsrIqtP46+JdWAyCyTcfIg0Bptbyrb6RalD8LOpQ4hQrJJy5JvpL9zhbAB6ZxTWVsRdLJwKVxVov7KpKPknoa6fFq8dJxhNemH+QHRdHsiDolMOL0n79KcfRpl0eI2cnrUcfWLAg6HkRdA1RuLWfu16evRvDLEoS91xfo8gc50CLoHUdFEXRXYDlOiyLptHUdFdiqVDyA52q2Y1Ua3RqnRx0KZUgFGalsyRTKLQRqOPvAXJg2iMWmtBgJvBTORa9zPMCPNmSJFWzLd0mAwFjUYC6jFgMAAMMBgBgL0DADEAAHQAABiAABAAAAwABdC2hlJsrLqeiAsyLqGQACy2jz3FOP8yZWbOGQ5q0p9IrHxA7CYNkVsMDh8ekncwXaH6nIlub+K1Oe+qvOUmor4GCXvAW2n8dejLa/Ursl9q32iW1lnIH/9k=]==]
local WW, WH = 320, 330
local WHITE = Color3.fromRGB(255, 255, 255)
local BLACK = Color3.fromRGB(0, 0, 0)
local BG = Color3.fromRGB(21, 21, 21)
local bgAsset = nil
local function b64decode(data)
local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local map = {}
for i = 1, 64 do
map[chars:sub(i, i)] = i - 1
end
data = data:gsub("[^%w%+/=]", "")
local out = {}
for i = 1, #data, 4 do
local a = map[data:sub(i, i)] or 0
local b = map[data:sub(i + 1, i + 1)] or 0
local c1 = data:sub(i + 2, i + 2)
local d1 = data:sub(i + 3, i + 3)
local c = map[c1] or 0
local d = map[d1] or 0
local n = a * 262144 + b * 4096 + c * 64 + d
local b1 = math.floor(n / 65536)
local b2 = math.floor(n / 256) % 256
local b3 = n % 256
if c1 == "=" then
out[#out + 1] = string.char(b1)
elseif d1 == "=" then
out[#out + 1] = string.char(b1, b2)
else
out[#out + 1] = string.char(b1, b2, b3)
end
end
return table.concat(out)
end
local function getBgAsset()
if bgAsset ~= nil then
return bgAsset
end
bgAsset = false
if BG_IMAGE ~= "" then
bgAsset = BG_IMAGE
return bgAsset
end
local ok, result = pcall(function()
if not (writefile and getcustomasset) then
return nil
end
writefile("traced_bg.jpg", b64decode(BG_B64))
return getcustomasset("traced_bg.jpg")
end)
if ok and result then
bgAsset = result
end
return bgAsset
end
local ICON_B64 = [==[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]==]
local iconAsset = nil
local function getIconAsset()
if iconAsset ~= nil then
return iconAsset
end
iconAsset = false
local ok, result = pcall(function()
if not (writefile and getcustomasset) then
return nil
end
writefile("traced_icon.jpg", b64decode(ICON_B64))
return getcustomasset("traced_icon.jpg")
end)
if ok and result then
iconAsset = result
end
return iconAsset
end
local function mkBg(parent)
local bg = slicedfn42("Frame", {
Name = "Bg",
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = BG,
BorderSizePixel = 0,
Active = true,
ClipsDescendants = true,
ZIndex = 0,
}, parent)
slicedfn43(bg, 18)
local asset = getBgAsset()
if asset then
local img = slicedfn42("ImageLabel", {
Name = "BgImage",
Size = UDim2.fromScale(1, 1),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Image = asset,
ScaleType = Enum.ScaleType.Crop,
ZIndex = 0,
}, bg)
slicedfn43(img, 18)
end
return bg
end
local function drag(handle, target)
local dragging = false
local startPos, startUi
handle.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging = true
startPos = input.Position
startUi = target.Position
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dragging = false
end
end)
end
end)
sliced86.InputChanged:Connect(function(input)
if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
local d = input.Position - startPos
target.Position = UDim2.new(startUi.X.Scale, startUi.X.Offset + d.X, startUi.Y.Scale, startUi.Y.Offset + d.Y)
end
end)
end
local pills = {}
local function skinCard(row, w, h, x, y, parent)
row.Parent = parent
row.Size = UDim2.fromOffset(w, h)
row.Position = UDim2.fromOffset(x, y)
row.BackgroundColor3 = WHITE
row.BackgroundTransparency = 0.92
for _, c in ipairs(row:GetChildren()) do
if c:IsA("UICorner") then
c.CornerRadius = UDim.new(0, 12)
elseif c:IsA("UIStroke") then
c.Color = WHITE
c.Transparency = 0.92
end
end
end
local function skinLabel(lbl, text)
lbl.Text = text
lbl.Font = gothamBold
lbl.TextSize = 12
lbl.Size = UDim2.new(1, -80, 1, 0)
lbl.Position = UDim2.fromOffset(12, 0)
end
local function addPill(row, track)
local knob = track:FindFirstChildWhichIsA("Frame")
track.Visible = false
local pill = slicedfn42("TextLabel", {
Size = UDim2.fromOffset(44, 24),
Position = UDim2.new(1, -54, 0.5, -12),
BackgroundColor3 = BLACK,
BackgroundTransparency = 0.4,
Text = "OFF",
Font = gothamBold,
TextSize = 11,
TextColor3 = WHITE,
BorderSizePixel = 0,
ZIndex = 2,
}, row)
slicedfn43(pill, 8)
pills[#pills + 1] = function()
local on = knob ~= nil and knob.Position.X.Offset > 10
pill.Text = on and "ON" or "OFF"
pill.BackgroundColor3 = on and Color3.fromRGB(242, 242, 242) or BLACK
pill.BackgroundTransparency = on and 0 or 0.4
pill.TextColor3 = on and Color3.fromRGB(17, 17, 17) or WHITE
end
end
local manualRow
for _, d in ipairs(Main:GetDescendants()) do
if d:IsA("TextLabel") and d.Text == "MANUAL" then
manualRow = d.Parent
break
end
end
local statusRow = sliced99.Parent
local codeCard = TextBox.Parent
local listenRow = listen.Parent
local spamRow = start.Parent
Main.BackgroundColor3 = BG
Main.Size = UDim2.fromOffset(WW, WH)
local g1 = Main:FindFirstChildOfClass("UIGradient")
if g1 then
g1:Destroy()
end
local st1 = Main:FindFirstChildOfClass("UIStroke")
if st1 then
st1.Color = Color3.fromRGB(70, 70, 70)
st1.Transparency = 0.2
end
local cr1 = Main:FindFirstChildOfClass("UICorner")
if cr1 then
cr1.CornerRadius = UDim.new(0, 18)
end
local bgMain = mkBg(Main)
local pageMain = slicedfn42("Frame", { Name = "PageMain", Position = UDim2.fromOffset(0, 30), Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1 }, Main)
local pageSet = slicedfn42("Frame", { Name = "PageSettings", Position = UDim2.fromOffset(0, 30), Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false }, Main)
skinCard(statusRow, 292, 34, 14, 60, pageMain)
statusRow.BackgroundColor3 = BLACK
statusRow.BackgroundTransparency = 0.5
for _, c in ipairs(statusRow:GetChildren()) do
if c:IsA("UIStroke") then
c.Transparency = 1
elseif c:IsA("UICorner") then
c.CornerRadius = UDim.new(0, 10)
elseif c:IsA("Frame") then
c.Visible = false
end
end
sliced99.Size = UDim2.new(1, -20, 1, 0)
sliced99.Position = UDim2.fromOffset(10, 0)
sliced99.TextXAlignment = Enum.TextXAlignment.Center
sliced99.TextSize = 13
skinCard(codeCard, 292, 78, 14, 106, pageMain)
for _, c in ipairs(codeCard:GetChildren()) do
if c:IsA("TextLabel") then
c.TextColor3 = WHITE
c.Position = UDim2.fromOffset(12, 5)
end
end
TextBox.PlaceholderText = ""
TextBox.TextEditable = false
TextBox.ClearTextOnFocus = false
TextBox.Size = UDim2.new(1, -20, 0, 40)
TextBox.Position = UDim2.fromOffset(10, 28)
TextBox.BackgroundColor3 = BLACK
TextBox.BackgroundTransparency = 0.4
skinCard(listenRow, 142, 44, 14, 196, pageMain)
skinLabel(listen, "Listen")
addPill(listenRow, Frame2)
skinCard(spamRow, 142, 44, 164, 196, pageMain)
skinLabel(sliced106, "Spam")
sliced106.Size = UDim2.new(1, -80, 1, 0)
start.Size = UDim2.fromOffset(56, 24)
start.Position = UDim2.new(1, -64, 0.5, -12)
start.BackgroundColor3 = BLACK
start.BackgroundTransparency = 0.4
start.TextSize = 11
sliced107.Visible = false
if manualRow then
local mTrack = manualRow:FindFirstChildWhichIsA("Frame")
skinCard(manualRow, 292, 44, 14, 60, pageSet)
skinLabel(manualRow:FindFirstChildWhichIsA("TextLabel"), "Manual")
addPill(manualRow, mTrack)
end
local helper = slicedfn42("Frame", {
Name = "Helper",
AnchorPoint = Vector2.new(0.5, 0.5),
Size = UDim2.fromOffset(320, 176),
Position = UDim2.fromScale(0.5, 0.5),
BackgroundColor3 = BG,
BorderSizePixel = 0,
Visible = false,
ClipsDescendants = true,
Active = true,
}, ScreenGui)
slicedfn43(helper, 18)
slicedfn44(helper, Color3.fromRGB(70, 70, 70), 1.5, 0.2)
if flag18 then
slicedfn42("UIScale", { Name = "WinScale", Scale = sliced91 }, helper)
end
local bgHelper = mkBg(helper)
local hbar = slicedfn42("Frame", {
Size = UDim2.fromOffset(292, 34),
Position = UDim2.fromOffset(14, 14),
BackgroundColor3 = BLACK,
BackgroundTransparency = 0.45,
BorderSizePixel = 0,
Active = true,
ZIndex = 3,
}, helper)
slicedfn43(hbar, 17)
local htitle = slicedfn46("HELPER", 12, WHITE, gothamBold, Enum.TextXAlignment.Center, hbar)
htitle.Size = UDim2.fromScale(1, 1)
htitle.ZIndex = 4
local function helperRow(y, text, cb, key)
local saved = _G.__RdmCfgBool(key, false)
local row = slicedfn51(helper, 1, text, saved, function(on)
_G.__RdmCfgSet(key, on)
cb(on)
end)
if saved then
task.delay(2, function()
pcall(cb, true)
end)
end
skinCard(row, 292, 44, 14, y, helper)
skinLabel(row:FindFirstChildWhichIsA("TextLabel"), text)
addPill(row, row:FindFirstChildWhichIsA("Frame"))
return row
end
helperRow(60, "Auto buy", function(on)
if _G.__TX_autoBuy then
pcall(_G.__TX_autoBuy, on)
end
end, "txAutoBuy")
helperRow(112, "Anchor", function(on)
if _G.__TX_anchor then
pcall(_G.__TX_anchor, on)
end
end, "txAnchor")
drag(hbar, helper)
drag(bgHelper, helper)
local hrow = slicedfn51(pageSet, 2, "Helper", false, function(on)
helper.Visible = on
end)
skinCard(hrow, 292, 44, 14, 112, pageSet)
skinLabel(hrow:FindFirstChildWhichIsA("TextLabel"), "Helper")
addPill(hrow, hrow:FindFirstChildWhichIsA("Frame"))
local wordsRow = slicedfn42("Frame", {
Name = "WordsRow",
Size = UDim2.fromOffset(292, 44),
Position = UDim2.fromOffset(14, 164),
BackgroundColor3 = WHITE,
BackgroundTransparency = 0.92,
BorderSizePixel = 0,
}, pageSet)
slicedfn43(wordsRow, 12)
slicedfn44(wordsRow, WHITE, 1, 0.92)
local wordsLbl = slicedfn46("Words", 12, WHITE, gothamBold, Enum.TextXAlignment.Left, wordsRow)
wordsLbl.Size = UDim2.new(1, -130, 1, 0)
wordsLbl.Position = UDim2.fromOffset(12, 0)
local function wordsBtn(text, x)
local b = slicedfn42("TextButton", {
Size = UDim2.fromOffset(28, 24),
Position = UDim2.new(0, x, 0.5, -12),
BackgroundColor3 = BLACK,
BackgroundTransparency = 0.4,
Text = text,
Font = gothamBold,
TextSize = 15,
TextColor3 = WHITE,
AutoButtonColor = false,
BorderSizePixel = 0,
ZIndex = 2,
}, wordsRow)
slicedfn43(b, 8)
return b
end
local wMinus = wordsBtn("-", 190)
local wCount = slicedfn42("TextLabel", {
Size = UDim2.fromOffset(24, 24),
Position = UDim2.new(0, 224, 0.5, -12),
BackgroundTransparency = 1,
Text = "1",
Font = gothamBold,
TextSize = 14,
TextColor3 = WHITE,
ZIndex = 2,
}, wordsRow)
local wPlus = wordsBtn("+", 254)
local function setWords(n)
n = math.clamp(tonumber(n) or 1, 1, 4)
slicedn33 = n
_G.__RdmCfgSet("words", n)
tbl19 = {}
wCount.Text = tostring(n)
wMinus.TextTransparency = n <= 1 and 0.6 or 0
wPlus.TextTransparency = n >= 4 and 0.6 or 0
if flag20 and not manual then
slicedfn50(("listening... 0/%d"):format(n), "wait")
end
end
wMinus.MouseButton1Click:Connect(function()
if slicedn33 > 1 then
setWords(slicedn33 - 1)
end
end)
wPlus.MouseButton1Click:Connect(function()
if slicedn33 < 4 then
setWords(slicedn33 + 1)
end
end)
wCount.Text = tostring(math.clamp(slicedn33 or 1, 1, 4))
wMinus.TextTransparency = slicedn33 <= 1 and 0.6 or 0
wPlus.TextTransparency = slicedn33 >= 4 and 0.6 or 0
-- ===== OPTIMIZER (event blocker) =====
local function buildEventBlocker()
	local RS = (cloneref or function(x) return x end)(game:GetService("ReplicatedStorage"))
	local function ctrl(name)
		local c = RS:FindFirstChild("Controllers")
		local m = c and c:FindFirstChild(name, true)
		if m and m:IsA("ModuleScript") then
			local ok, r = pcall(require, m)
			if ok and type(r) == "table" then return r end
		end
	end
	local EC, FX = ctrl("EventController"), ctrl("EffectController")
	if not (EC and type(EC.Events) == "table" and type(EC.Execute) == "function") then
		return nil, "EventController missing Events/Execute"
	end
	local S = _G.__BrainrotEventTool or {}
	_G.__BrainrotEventTool = S
	S.origExecute = S.origExecute or EC.Execute
	S.origGetActive = S.origGetActive or EC.GetActiveEvents
	S.origRun = S.origRun or (FX and FX.Run)
	S.cleared = S.cleared or {}
	S.blocked = S.blocked or false
	if not S.shimmed then
		EC.GetActiveEvents = function(self)
			return S.blocked and {} or S.origGetActive(self)
		end
		S.shimmed = true
	end
	local KEEP = {
		EventsLoaded = true, NextCrystalEvent = true, CrystalEventLastTime = true,
		SantaMerchantStockId = true, SantaMerchantNextStockId = true,
		FuseMachineLuck = true, FuseMachineLuckTimer = true,
	}
	local function refresh()
		for _, n in ipairs({ "Lighting", "WallRecolor", "Atmosphere" }) do
			local e = FX and type(FX.Effects) == "table" and FX.Effects[n]
			if e and type(e.OnUpdate) == "function" then pcall(function() e:OnUpdate() end) end
		end
		local l, so = ctrl("LightingController"), ctrl("SoundController")
		if l and l.Update then pcall(function() l:Update() end) end
		if so and so.UpdateOST then pcall(function() so:UpdateOST() end) end
	end
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local frozen = setmetatable({}, { __mode = "k" })
	local animConns, animDescConn, animLoopConn = {}, nil, nil
	local function isCharacter(inst)
		for _, p in ipairs(Players:GetPlayers()) do
			if p.Character and inst:IsDescendantOf(p.Character) then return true end
		end
		return false
	end
	local function freezeTrack(t)
		if frozen[t] == nil then frozen[t] = t.Speed end
		if t.Speed ~= 0 then pcall(function() t:AdjustSpeed(0) end) end
	end
	local function hookAnimator(a)
		if animConns[a] or isCharacter(a) then return end
		for _, t in ipairs(a:GetPlayingAnimationTracks()) do freezeTrack(t) end
		animConns[a] = a.AnimationPlayed:Connect(freezeTrack)
	end
	local function scanAnimators()
		for _, d in ipairs(workspace:GetDescendants()) do
			if d:IsA("Animator") then pcall(hookAnimator, d) end
		end
	end
	local function freezeAnimations()
		scanAnimators()
		if not animDescConn then
			animDescConn = workspace.DescendantAdded:Connect(function(d)
				if d:IsA("Animator") then pcall(hookAnimator, d) end
			end)
		end
		if not animLoopConn then
			local acc, scanAcc = 0, 0
			animLoopConn = RunService.Heartbeat:Connect(function(dt)
				acc += dt
				scanAcc += dt
				if acc < 0.1 then return end
				acc = 0
				-- re-freeze tracks the game un-paused, drop dead animators
				for a, c in pairs(animConns) do
					if not a.Parent then
						pcall(function() c:Disconnect() end)
						animConns[a] = nil
					else
						for _, t in ipairs(a:GetPlayingAnimationTracks()) do
							if t.Speed ~= 0 then freezeTrack(t) end
						end
					end
				end
				-- safety net: catch respawned pets that slipped through
				if scanAcc >= 1 then
					scanAcc = 0
					scanAnimators()
				end
			end)
		end
	end
	local function unfreezeAnimations()
		if animDescConn then animDescConn:Disconnect() animDescConn = nil end
		if animLoopConn then animLoopConn:Disconnect() animLoopConn = nil end
		for a, c in pairs(animConns) do pcall(function() c:Disconnect() end) animConns[a] = nil end
		for t, speed in pairs(frozen) do
			pcall(function() t:AdjustSpeed(speed == 0 and 1 or speed) end)
			frozen[t] = nil
		end
	end
	local EB = {}
	function EB.Block()
		for k, ev in pairs(EC.Events) do
			if type(ev) == "table" and rawget(ev, "Active") then
				if not (type(EC.Cancel) == "function" and pcall(EC.Cancel, EC, k)) then
					rawset(ev, "Active", false)
					rawset(ev, "__started", false)
				end
			end
		end
		if FX and type(FX.ActiveEffects) == "table" then
			for k in pairs(FX.ActiveEffects) do
				local e = type(FX.Effects) == "table" and FX.Effects[k]
				FX.ActiveEffects[k] = nil
				if type(e) == "table" then
					if e.OnUpdate then pcall(function() e:OnUpdate() end) end
					if e.OnStop then pcall(function() e:OnStop() end) end
				end
			end
			FX.Run = function() return false, false end
		end
		EC.Execute = function() return false end
		S.blocked = true
		for k, v in pairs(RS:GetAttributes()) do
			if v == true and not KEEP[k] and (k:find("Event") or k:find("Phase") or k:find("Hour")) then
				pcall(function() RS:SetAttribute(k, nil) end)
				S.cleared[k] = true
			end
		end
		for _, d in ipairs(workspace:GetDescendants()) do
			if d:IsA("Sound") and d.Playing and d.Looped then pcall(function() d:Stop() end) end
		end
		freezeAnimations()
		refresh()
	end
	function EB.Unblock()
		-- events stay removed on purpose; only animations are restored
		unfreezeAnimations()
	end
	return EB
end
local optEB = nil
local optRow
local function setOptimizer(on)
	if not optEB then
		local eb, why = buildEventBlocker()
		if not eb then
			slicedfn50("optimizer: " .. tostring(why), "err")
			return
		end
		optEB = eb
	end
	if on then
		pcall(optEB.Block)
		slicedfn50("optimizer ON - events + animations off", "ok")
	else
		pcall(optEB.Unblock)
		slicedfn50("optimizer OFF - animations on (events stay removed)", "wait")
	end
end
local optSaved = _G.__RdmCfgBool("optimizer", false)
optRow = slicedfn51(pageSet, 4, "Optimizer", optSaved, function(on)
	_G.__RdmCfgSet("optimizer", on)
	setOptimizer(on)
end)
if optSaved then
	task.delay(2, function()
		pcall(setOptimizer, true)
	end)
end
skinCard(optRow, 292, 44, 14, 216, pageSet)
skinLabel(optRow:FindFirstChildWhichIsA("TextLabel"), "Optimizer")
addPill(optRow, optRow:FindFirstChildWhichIsA("Frame"))
-- ===== /OPTIMIZER =====
local bar = slicedfn42("Frame", {
Name = "TabBar",
Size = UDim2.fromOffset(292, 34),
Position = UDim2.fromOffset(14, 44),
BackgroundColor3 = BLACK,
BackgroundTransparency = 0.45,
BorderSizePixel = 0,
Active = true,
ZIndex = 3,
}, Main)
slicedfn43(bar, 17)
local hi = slicedfn42("Frame", {
Size = UDim2.fromOffset(138, 26),
Position = UDim2.fromOffset(4, 4),
BackgroundColor3 = WHITE,
BackgroundTransparency = 0.84,
BorderSizePixel = 0,
ZIndex = 3,
}, bar)
slicedfn43(hi, 13)
local function tabBtn(text, x)
return slicedfn42("TextButton", {
Size = UDim2.fromOffset(146, 34),
Position = UDim2.fromOffset(x, 0),
BackgroundTransparency = 1,
Text = text,
Font = gothamBold,
TextSize = 12,
TextColor3 = WHITE,
AutoButtonColor = false,
ZIndex = 4,
}, bar)
end
local tMain = tabBtn("MAIN", 0)
local tSet = tabBtn("SETTINGS", 146)
local function showTab(settings)
pageMain.Visible = not settings
pageSet.Visible = settings
slicedfn45(hi, 0.18, { Position = UDim2.fromOffset(settings and 150 or 4, 4) })
tMain.TextTransparency = settings and 0.3 or 0
tSet.TextTransparency = settings and 0 or 0.3
end
tMain.MouseButton1Click:Connect(function()
showTab(false)
end)
tSet.MouseButton1Click:Connect(function()
showTab(true)
end)
local legendHeader = slicedfn42("Frame", {
Name = "LegendHeader",
Size = UDim2.fromOffset(292, 36),
Position = UDim2.fromOffset(14, 6),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Active = true,
ZIndex = 3,
}, Main)
slicedfn42("UIListLayout", {
FillDirection = Enum.FillDirection.Horizontal,
HorizontalAlignment = Enum.HorizontalAlignment.Left,
VerticalAlignment = Enum.VerticalAlignment.Center,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 8),
}, legendHeader)
slicedfn42("UIPadding", { PaddingLeft = UDim.new(0, 6) }, legendHeader)
local iconAssetId = getIconAsset()
if iconAssetId then
local icon = slicedfn42("ImageLabel", {
Name = "LegendIcon",
Size = UDim2.fromOffset(34, 34),
BackgroundColor3 = BLACK,
BorderSizePixel = 0,
Image = iconAssetId,
ScaleType = Enum.ScaleType.Crop,
LayoutOrder = 1,
ZIndex = 4,
}, legendHeader)
slicedfn42("UICorner", { CornerRadius = UDim.new(1, 0) }, icon)
slicedfn44(icon, WHITE, 1, 0.5)
end
slicedfn42("TextLabel", {
Name = "LegendTitle",
Size = UDim2.fromOffset(0, 34),
AutomaticSize = Enum.AutomaticSize.X,
BackgroundTransparency = 1,
Text = "LEGEND",
Font = gothamBlack,
TextSize = 22,
TextColor3 = WHITE,
LayoutOrder = 2,
ZIndex = 4,
}, legendHeader)
drag(bar, Main)
drag(legendHeader, Main)
drag(bgMain, Main)
local oldHeader = Main:FindFirstChild("Header")
if oldHeader then
oldHeader.Visible = false
end
local oldAccent = Main:FindFirstChild("AccentBar")
if oldAccent then
oldAccent.Visible = false
end
local oldContent = Main:FindFirstChild("OldContent")
if oldContent then
oldContent.Visible = false
end
showTab(false)
task.spawn(function()
while Main.Parent do
for _, f in ipairs(pills) do
pcall(f)
end
local m = manual
start.TextTransparency = m and 0 or 0.55
sliced106.TextTransparency = m and 0 or 0.55
task.wait(0.08)
end
end)
end)()
slicedfn60(false)
if sliced94 or flag22 then
slicedfn50(keyboardEnabled and (listenKey and "ready - press " .. listenKey.Name .. " to listen" or "ready - no listen key bound") or "ready - tap LISTEN to start", "idle")
else
slicedfn50("notify remote not found", "err")
end