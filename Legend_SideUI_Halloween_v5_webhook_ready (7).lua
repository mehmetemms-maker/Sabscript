--[[

]]
local embedHost, showPage, pageMap
local sliced85, sliced86, localPlayer, sliced87, net, sliced88, sliced89, sliced90, keyboardEnabled, flag18
local slicedfn29, sliced91, tbl18, max, flag19, sliced92, flag20, autoRedeem, autoType, manual
local flag21, thread, slicedn32, slicedn33, listenKey, g, str7, tbl19, sliced93, sliced94
local flag22, autoListen, sliced95, sliced96, slicedfn30, slicedfn31, slicedfn32, slicedfn33, slicedfn34, slicedfn35
local slicedfn36, slicedfn37, slicedfn38, slicedfn39, slicedfn40, slicedfn41, tbl20, tbl21, gothamMedium, gothamBold
local gothamBlack, slicedfn42, slicedfn43, slicedfn44, slicedfn45, slicedfn46, slicedfn47, slicedfn48, slicedfn49, ScreenGui
local Main, Frame, Rag, sliced97, sliced98, slicedn34, sliced99, slicedfn50, TextBox, sliced100
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
local uiSize = _G.__RdmCfgStr and _G.__RdmCfgStr("uiSize", "MEDIUM") or "MEDIUM"
local slicedn35 = uiSize == "BIG" and 1.15 or uiSize == "SMALL" and 0.8 or 1
return math.clamp(currentCamera * 0.88 / 548, 0.5, 1.3) * slicedn35
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
maxFeed = 36,
}
tbl22 = { MAX = 0.06 }
max = tbl22[_G.__RdmCfgStr("speed", "MAX")] or tbl22.MAX
flag19 = _G.__RdmCfgBool("wordMode", false)
sliced92 = 0.2
flag20 = false
autoRedeem = _G.__RdmCfgBool("autoRedeem", true)
autoType = _G.__RdmCfgBool("autoType", true)
manual = _G.__RdmCfgBool("manual", false)
flag21 = false
thread = nil
slicedn32 = 0
slicedn33 = 1
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
sliced96 = _G.__RdmCfgBool("ignoreSystem", true)
_G.__RdmDuo = false
_G.__SabClassifyDrop = function(arg)
local str8 = tostring(arg or "")
local str9 = str8:lower()
local tbl23 = {}
for match in str8:gmatch("[%w']+") do
tbl23[#tbl23 + 1] = match
end
local slicedn35 = #tbl23
if slicedn35 == 0 then
return nil
end
local str10 = " " .. str9:gsub("[^%w]", " ") .. " "
if str9:find("?", 1, true) then
return "riddle"
end
for _, sliced110 in ipairs({
" what ",
" how ",
" which ",
" whose ",
" when ",
" who ",
" whats ",
" where ",
" why ",
" guess ",
" riddle ",
" answer ",
}) do
if str10:find(sliced110, 1, true) then
return "riddle"
end
end
if str10:find(" my ", 1, true) then
return "riddle"
end
local flag23 = slicedn35 >= 2
local pos
if flag23 then
pos = str10:find(" plus ", 1, true) or str9:find("+", 1, true)
else
pos = flag23
end
if pos then
return "riddle"
end
if slicedn35 >= 4 and str10:find(" and ", 1, true) then
return "riddle"
end
if str9:find("code", 1, true) then
return "code"
end
for _, sliced110 in ipairs({ " redeem ", " type ", " enter ", " claim " }) do
if str10:find(sliced110, 1, true) then
return "code"
end
end
if slicedn35 >= 7 then
return "riddle"
end
if slicedn35 == 1 then
return "code"
end
if slicedn35 <= 3 then
local sliced110 = 0
for _, sliced111 in ipairs(tbl23) do
if #sliced111 >= 3 and (sliced111 == sliced111:upper() and sliced111:match("%a") or sliced111:match("%d")) then
sliced110 += 1
end
end
if sliced110 == slicedn35 then
return "code"
end
end
return nil
end
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
local cachedBox
local findBoxSlow
slicedfn53 = function()
local c = cachedBox
if c and c:IsDescendantOf(sliced87) then
return c
end
c = findBoxSlow()
cachedBox = c
return c
end
findBoxSlow = function()
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
local cachedConfirm
local findConfirmSlow
local function slicedfn55()
local c = cachedConfirm
if c and c:IsDescendantOf(sliced87) then
return c
end
c = findConfirmSlow()
cachedConfirm = c
return c
end
findConfirmSlow = function()
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
task.wait()
local ok = pcall(function()
sliced110:ReleaseFocus(true)
end)
return ok, ok and "submitted" or "release failed"
end
local lastSubmitAt = 0
slicedfn41 = function(arg)
local gap = 0.02 - (os.clock() - lastSubmitAt)
if gap > 0 then
task.wait(gap)
end
lastSubmitAt = os.clock()
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
tbl20 = {
ready = false,
why = "EventController unavailable",
IsBlocked = function()
return false
end,
}
do
local function slicedfn53(arg)
local sliced110 = sliced85:FindFirstChild("Controllers")
sliced110 = sliced110 and sliced110:FindFirstChild(arg, true)
if not (sliced110 and sliced110:IsA("ModuleScript")) then
return nil
end
local ok, result = pcall(require, sliced110)
if ok and type(result) == "table" then
return result
end
end
local EventController = slicedfn53("EventController")
local EffectController = slicedfn53("EffectController")
local flag23 = EventController and type(EventController.Events) == "table"
if flag23 then
local sliced110 = "function"
flag23 = type(EventController.Execute) == sliced110
end
if not flag23 then
tbl20.why = "EventController missing Events/Execute"
else
local brainrotEventTool, sliced110, slicedfn54, slicedfn55, slicedfn56, slicedfn57, slicedfn58
do
do
brainrotEventTool = _G.__BrainrotEventTool
if not brainrotEventTool then
brainrotEventTool = {}
_G.__BrainrotEventTool = brainrotEventTool
end
brainrotEventTool.origExecute = brainrotEventTool.origExecute or EventController.Execute
brainrotEventTool.origGetActive = brainrotEventTool.origGetActive or EventController.GetActiveEvents
if EffectController then
brainrotEventTool.origRun = brainrotEventTool.origRun or EffectController.Run
end
brainrotEventTool.fakes = brainrotEventTool.fakes or {}
brainrotEventTool.capture = brainrotEventTool.capture or {}
brainrotEventTool.spawned = brainrotEventTool.spawned or {}
brainrotEventTool.clearedAttrs = brainrotEventTool.clearedAttrs or {}
brainrotEventTool.stashed = brainrotEventTool.stashed or {}
if brainrotEventTool.blocked == nil then
brainrotEventTool.blocked = false
end
tbl20.S = brainrotEventTool
tbl20.IsBlocked = function()
return brainrotEventTool.blocked and true or false
end
sliced110 = nil
do
local getupvalue_ = debug and debug.getupvalue
if getupvalue_ then
local ok, result = pcall(getupvalue_, brainrotEventTool.origExecute, 5)
if ok and type(result) == "table" then
sliced110 = result
end
end
end
end
if not brainrotEventTool.shimmed then
EventController.GetActiveEvents = function(arg)
local tbl23 = {}
if not brainrotEventTool.blocked then
local ok, result = pcall(brainrotEventTool.origGetActive, arg)
if ok and type(result) == "table" then
for _, sliced112 in pairs(result) do
tbl23[#tbl23 + 1] = sliced112
end
end
end
for _, fake in pairs(brainrotEventTool.fakes) do
tbl23[#tbl23 + 1] = fake
end
return tbl23
end
brainrotEventTool.shimmed = true
end
slicedfn54 = function()
local sliced111 = slicedfn53("LightingController")
if sliced111 and type(sliced111.Update) == "function" then
pcall(function()
sliced111:Update()
end)
end
local SoundController = slicedfn53("SoundController")
local flag24
if SoundController then
local sliced112 = "function"
flag24 = type(SoundController.UpdateOST) == sliced112
else
flag24 = SoundController
end
if flag24 then
pcall(function()
SoundController:UpdateOST()
end)
end
end
slicedfn55 = function(arg)
return arg:IsA("Sky") or arg:IsA("Atmosphere") or arg:IsA("Clouds") or arg:IsA("PostEffect")
end
slicedfn56 = function()
local flag24 = EffectController
if EffectController then
local sliced111 = "table"
flag24 = type(EffectController.ActiveEffects) == sliced111
end
if not flag24 then
return 0
end
local tbl23 = {}
for k in pairs(EffectController.ActiveEffects) do
tbl23[#tbl23 + 1] = k
end
for _, sliced111 in ipairs(tbl23) do
local sliced112 = "table"
local flag25 = type(EffectController.Effects) == sliced112 and EffectController.Effects[sliced111] or nil
EffectController.ActiveEffects[sliced111] = nil
if type(flag25) == "table" then
local sliced113 = "function"
if type(flag25.OnUpdate) == sliced113 then
pcall(function()
flag25:OnUpdate()
end)
end
if type(flag25.OnStop) == "function" then
pcall(function()
flag25:OnStop()
end)
end
end
end
return #tbl23
end
do
local tbl23 = {
EventsLoaded = true,
NextCrystalEvent = true,
CrystalEventLastTime = true,
SantaMerchantStockId = true,
SantaMerchantNextStockId = true,
FuseMachineLuck = true,
FuseMachineLuckTimer = true,
}
local tbl24 = {
"AyMiGatitoEvent",
"ChicleteiraBicicleteiraEvent",
"EasterEvent",
"ExtinctEvent",
"IndonesiaEvent",
"MeowlEvent",
"MexicoEvent",
"RipMyGrannyEvent",
"SkibidiEvent",
"StPatricksEvent",
"StrawberryEvent",
"TrickOrTreatEvent",
"ValentinesEvent",
"YinYangEvent",
"WitchingHourEvent",
}
local tbl25 = {
"Lighting",
"WallRecolor",
"Atmosphere",
}
slicedfn57 = function()
if not (EffectController and type(EffectController.Effects) == "table") then
return
end
for _, sliced111 in ipairs(tbl25) do
local sliced112 = EffectController.Effects[sliced111]
local flag24
if sliced112 then
local sliced113 = "function"
flag24 = type(sliced112.OnUpdate) == sliced113
else
flag24 = sliced112
end
if flag24 then
pcall(function()
sliced112:OnUpdate()
end)
end
end
end
slicedfn58 = function()
local tbl26 = {}
for _, sliced111 in ipairs(tbl24) do
tbl26[sliced111] = true
end
local sliced111 = 0
for k, sliced112 in pairs(sliced85:GetAttributes()) do
local sliced113 = "string"
local flag24 = type(k) == sliced113 and sliced112 == true and not tbl23[k]
local pos
if flag24 then
pos = tbl26[k] or k:find("Event") or k:find("Phase") or k:find("Hour")
else
pos = flag24
end
if pos then
pcall(function()
sliced85:SetAttribute(k, nil)
end)
brainrotEventTool.clearedAttrs[k] = true
sliced111 += 1
end
end
slicedfn57()
return sliced111
end
end
end
do
local function slicedfn59()
local slicedn35 = 0
for k in pairs(brainrotEventTool.clearedAttrs) do
pcall(function()
sliced85:SetAttribute(k, true)
end)
slicedn35 += 1
end
table.clear(brainrotEventTool.clearedAttrs)
slicedfn57()
return slicedn35
end
local function slicedfn60()
local slicedn35 = 0
for _, descendant in ipairs(workspace:GetDescendants()) do
if descendant:IsA("Sound") and descendant.Playing and descendant.Looped then
pcall(function()
descendant:Stop()
end)
slicedn35 += 1
end
end
return slicedn35
end
local function slicedfn61()
local slicedn35 = 0
for k, sliced111 in pairs(brainrotEventTool.stashed) do
if typeof(k) == "Instance" then
pcall(function()
k.Parent = sliced111
end)
slicedn35 += 1
end
brainrotEventTool.stashed[k] = nil
end
return slicedn35
end
local function slicedfn62()
local effects = _G.Effects
if type(effects) == "table" and type(effects.Block) == "function" and type(effects.Unblock) == "function" then
return effects
end
end
tbl20.Block = function()
local sliced111 = slicedfn62()
if sliced111 then
sliced111.Block()
brainrotEventTool.blocked = true
return true, "blocked (effects panel)"
end
local slicedn35 = 0
for k, event in pairs(EventController.Events) do
if type(event) == "table" and rawget(event, "Active") then
if not (type(EventController.Cancel) == "function" and pcall(function()
return EventController:Cancel(k)
end)) then
rawset(event, "Active", false)
rawset(event, "__started", false)
end
slicedn35 += 1
end
end
local sliced112 = slicedfn56()
for k, sliced113 in pairs(brainrotEventTool.capture) do
local flag24 = type(sliced113) == "table"
if flag24 then
local sliced114 = "table"
flag24 = type(sliced113.caught) == sliced114
end
if flag24 then
for k2 in pairs(sliced113.caught) do
local sliced114 = "Instance"
if typeof(k2) == sliced114 and k2.Parent and not slicedfn55(k2) then
pcall(function()
k2:Destroy()
end)
end
end
end
brainrotEventTool.capture[k] = nil
end
table.clear(brainrotEventTool.spawned)
table.clear(brainrotEventTool.fakes)
if sliced110 then
for k, sliced113 in pairs(sliced110) do
local sliced114 = "table"
if type(sliced113) == sliced114 then
for _, sliced115 in ipairs(sliced113) do
if typeof(sliced115) == "Instance" and not slicedfn55(sliced115) then
pcall(function()
sliced115:Destroy()
end)
end
end
end
sliced110[k] = nil
end
end
EventController.Execute = function()
return false
end
if EffectController then
EffectController.Run = function()
return false, false
end
end
brainrotEventTool.blocked = true
slicedfn54()
slicedfn58()
local sliced113 = slicedfn60()
return true, ("blocked %d event(s), %d fx, %d sound(s)"):format(slicedn35, sliced112, sliced113)
end
tbl20.Unblock = function()
local sliced111 = slicedfn62()
if sliced111 then
sliced111.Unblock()
brainrotEventTool.blocked = false
return true, "unblocked (effects panel)"
end
EventController.Execute = brainrotEventTool.origExecute
if EffectController and brainrotEventTool.origRun then
EffectController.Run = brainrotEventTool.origRun
end
brainrotEventTool.blocked = false
local sliced112 = slicedfn59()
local sliced113 = slicedfn61()
slicedfn54()
return true, ("unblocked - %d flag(s), %d model(s) restored"):format(sliced112, sliced113)
end
end
tbl20.ready = true
tbl20.why = nil
end
end
end
local sliced110
do
do
tbl21 = {
bg = Color3.fromRGB(14, 8, 20),
panel = Color3.fromRGB(30, 17, 38),
panel2 = Color3.fromRGB(46, 27, 58),
line = Color3.fromRGB(126, 70, 36),
acc = Color3.fromRGB(255, 122, 24),
acc2 = Color3.fromRGB(196, 58, 8),
accHi = Color3.fromRGB(255, 170, 70),
txt = Color3.fromRGB(255, 241, 226),
sub = Color3.fromRGB(184, 152, 170),
ok = Color3.fromRGB(132, 224, 72),
err = Color3.fromRGB(255, 72, 72),
warn = Color3.fromRGB(255, 200, 40),
input = Color3.fromRGB(18, 10, 24),
dark = Color3.fromRGB(9, 5, 12),
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
arg2:SetAttribute("UserMoved", true)
end
end)
end
slicedfn47 = function(arg, arg2, arg3, arg4)
if arg ~= "Main" and embedHost then
local ew = slicedfn42("Frame", {
Name = arg,
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
ClipsDescendants = true,
Visible = false,
}, embedHost)
slicedfn43(ew, 12)
slicedfn44(ew, tbl21.line, 1, 0.3)
local ehdr = slicedfn42("Frame", { Size = UDim2.new(1, 0, 0, 44), BackgroundTransparency = 1, BorderSizePixel = 0 }, ew)
slicedfn42("Frame", {
Size = UDim2.new(1, -24, 0, 1),
Position = UDim2.new(0, 12, 1, -1),
BackgroundColor3 = tbl21.line,
BackgroundTransparency = 0.3,
BorderSizePixel = 0,
}, ehdr)
local elogo = slicedfn42("Frame", { Size = UDim2.fromOffset(1, 1), BackgroundTransparency = 1, Visible = false }, ehdr)
local etitle = slicedfn46(arg4, 14, tbl21.txt, gothamBlack, Enum.TextXAlignment.Left, ehdr)
etitle.Size = UDim2.new(1, -80, 1, 0)
etitle.Position = UDim2.fromOffset(14, 0)
pageMap[arg] = ew
ew:GetPropertyChangedSignal("Position"):Connect(function()
if ew.Position ~= UDim2.fromScale(0, 0) then
ew.Position = UDim2.fromScale(0, 0)
end
end)
ew:GetPropertyChangedSignal("Visible"):Connect(function()
if ew.Visible then
showPage(arg)
else
local any = false
for _, f in pairs(pageMap) do
if f.Visible then
any = true
end
end
if not any then
showPage("snipe")
end
end
end)
return ew, ehdr, elogo, etitle
end
local win = slicedfn42("Frame", {
Name = arg,
Size = UDim2.fromOffset(arg2, arg3),
BackgroundColor3 = tbl21.bg,
BorderSizePixel = 0,
Active = true,
ClipsDescendants = true,
})
slicedfn43(win, 18)
slicedfn53(win, Color3.fromRGB(52, 20, 64), Color3.fromRGB(10, 5, 14), 135)
slicedfn44(win, tbl21.acc, 2, 0.25)
-- ===== HALLOWEEN BACKGROUND =====
do
local decor = slicedfn42("Frame", {
Name = "HalloweenBG",
Size = UDim2.fromScale(1, 1),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Active = false,
ClipsDescendants = true,
}, win)
slicedfn43(decor, 18)

-- embedded wallpaper (jpg, base64) -> written to workspace -> getcustomasset
local imgOK = false
pcall(function()
local getAsset = getcustomasset or getsynasset
if not (writefile and getAsset) then
return
end
local data = [==[
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
]==]
local map = {}
local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
for n = 1, #chars do
map[chars:byte(n)] = n - 1
end
local out, buf, bits = {}, 0, 0
for n = 1, #data do
local v = map[data:byte(n)]
if v then
buf = buf * 64 + v
bits = bits + 6
if bits >= 8 then
bits = bits - 8
local byte = math.floor(buf / 2 ^ bits)
buf = buf - byte * 2 ^ bits
out[#out + 1] = string.char(byte)
end
end
end
local bin = table.concat(out)
writefile("legend_halloween_bg.jpg", bin)
local asset = getAsset("legend_halloween_bg.jpg")
if asset and asset ~= "" then
local wp = slicedfn42("ImageLabel", {
Name = "Wallpaper",
Size = UDim2.fromScale(1, 1),
BackgroundTransparency = 1,
Image = asset,
ScaleType = Enum.ScaleType.Crop,
ImageTransparency = 0,
Active = false,
}, decor)
slicedfn43(wp, 18)
imgOK = true
end
end)

-- dark veil so text stays readable on top of the busy wallpaper
local veil = slicedfn42("Frame", {
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.fromRGB(10, 4, 14),
BackgroundTransparency = imgOK and 0.5 or 1,
BorderSizePixel = 0,
Active = false,
}, decor)
slicedfn43(veil, 18)
-- warm glow at the bottom
local glow = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 150),
Position = UDim2.new(0, 0, 1, -150),
BackgroundColor3 = Color3.fromRGB(255, 110, 20),
BorderSizePixel = 0,
Active = false,
}, decor)
slicedfn43(glow, 18)
slicedfn42("UIGradient", { Rotation = 90, Transparency = NumberSequence.new(1, 0.8) }, glow)

local function emo(txt, size, x, y, tr, rot)
return slicedfn42("TextLabel", {
BackgroundTransparency = 1,
Text = txt,
TextSize = size,
TextTransparency = tr or 0.6,
Font = Enum.Font.GothamBold,
Size = UDim2.fromOffset(size + 10, size + 10),
Position = UDim2.new(x[1], x[2], y[1], y[2]),
Rotation = rot or 0,
Active = false,
}, decor)
end
if not imgOK then
emo("🌕", 64, {1, -86}, {0, 50}, 0.45)
emo("🕸️", 54, {0, 54}, {0, 40}, 0.55)
emo("🪦", 34, {0, 74}, {1, -52}, 0.55)
emo("🎃", 42, {0.30, 0}, {1, -58}, 0.45)
emo("🎃", 30, {0.58, 0}, {1, -44}, 0.55, -10)
emo("🪦", 30, {0.80, 0}, {1, -46}, 0.6)
emo("🎃", 48, {1, -74}, {1, -62}, 0.4, 8)
emo("🕷️", 22, {0.46, 0}, {0, 52}, 0.5)
end
local ghost = emo("👻", 36, {0.20, 0}, {0.45, 0}, imgOK and 0.35 or 0.7)
sliced109:Create(ghost, TweenInfo.new(3.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
Position = UDim2.new(0.24, 0, 0.38, 0),
TextTransparency = imgOK and 0.6 or 0.88,
}):Play()
for i, cfg in ipairs({ { 0.14, 8, 26 }, { 0.36, 11, 20 }, { 0.62, 9.5, 24 } }) do
local bat = emo("🦇", cfg[3], { -0.1, 0 }, { cfg[1], 0 }, 0.35)
local t = TweenInfo.new(cfg[2], Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1, false, i * 1.7)
sliced109:Create(bat, t, { Position = UDim2.new(1.1, 0, cfg[1] + 0.06, 0) }):Play()
sliced109:Create(bat, TweenInfo.new(0.35 + i * 0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
Rotation = 16,
}):Play()
end
end
-- ===== /HALLOWEEN BACKGROUND =====
if flag18 then
slicedfn42("UIScale", { Name = "WinScale", Scale = sliced91 }, win)
end
local hdr = slicedfn42("Frame", { Size = UDim2.new(1, 0, 0, 44), BackgroundTransparency = 1, BorderSizePixel = 0 }, win)
slicedfn42("Frame", {
Size = UDim2.new(1, -24, 0, 1),
Position = UDim2.new(0, 12, 1, -1),
BackgroundColor3 = tbl21.line,
BackgroundTransparency = 0.3,
BorderSizePixel = 0,
}, hdr)
local logo = slicedfn42("Frame", { Size = UDim2.fromOffset(1, 1), BackgroundTransparency = 1, Visible = false }, hdr)
hdr.BackgroundTransparency = 1
do
local decorBG = win:FindFirstChild("HalloweenBG")
local tint = slicedfn42("Frame", {
Name = "HeaderTint",
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = tbl21.dark,
BackgroundTransparency = 0,
BorderSizePixel = 0,
Active = false,
}, decorBG or win)
slicedfn43(tint, 18)
local g = slicedfn42("UIGradient", { Rotation = 90 }, tint)
local function upd()
local h = win.AbsoluteSize.Y
local fr = h > 0 and math.clamp(hdr.AbsoluteSize.Y / h, 0.01, 0.98) or 0.1
g.Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0.35),
NumberSequenceKeypoint.new(fr, 0.35),
NumberSequenceKeypoint.new(math.min(fr + 0.002, 0.999), 1),
NumberSequenceKeypoint.new(1, 1),
})
end
upd()
win:GetPropertyChangedSignal("AbsoluteSize"):Connect(upd)
hdr:GetPropertyChangedSignal("AbsoluteSize"):Connect(upd)
end
local title = slicedfn46(arg4, 16, tbl21.accHi, gothamBlack, Enum.TextXAlignment.Left, hdr)
title.TextStrokeColor3 = Color3.fromRGB(120, 40, 0)
title.TextStrokeTransparency = 0.5
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.fromOffset(16, 0)
slicedfn54(hdr, win)
return win, hdr, logo, title
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
local mainW = 480
local fullH = 430
local railW = 62
local compactH = 100
slicedn34 = fullH
visible = false
local header, logo, titleLabel
Main, header, logo, titleLabel = slicedfn47("Main", mainW, fullH, "🎃 LEGEND")
Main.Position = UDim2.new(1, -(mainW + 24), 0.5, -math.floor(fullH / 2))
if flag18 then
Main.Position = UDim2.new(1, -math.floor(mainW * sliced91) - 8, 0.5, -math.floor(fullH * sliced91 / 2))
end
Main.Parent = ScreenGui
titleLabel.Size = UDim2.new(1, -210, 1, 0)


-- header buttons
do
local DISCORD_LINK = "discord.gg/jw32RH4J"
local linkBtn = slicedfn48(DISCORD_LINK, header)
linkBtn.Size = UDim2.fromOffset(150, 22)
linkBtn.Position = UDim2.new(0, 150, 0.5, -11)
linkBtn.TextSize = 10
linkBtn.TextColor3 = tbl21.acc
linkBtn.MouseButton1Click:Connect(function()
local clip = setclipboard or toclipboard or (syn and syn.write_clipboard)
if clip then
pcall(clip, "https://" .. DISCORD_LINK)
end
end)
end
do
local collapseBtn = slicedfn48("", header)
collapseBtn.Size = UDim2.fromOffset(30, 30)
collapseBtn.Position = UDim2.new(1, -42, 0.5, -15)
slicedfn43(slicedfn42("Frame", {
Size = UDim2.fromOffset(10, 2),
Position = UDim2.new(0.5, -5, 0.5, -1),
BackgroundColor3 = tbl21.txt,
BorderSizePixel = 0,
}, collapseBtn), 1)
local plusV = slicedfn42("Frame", {
Size = UDim2.fromOffset(2, 10),
Position = UDim2.new(0.5, -1, 0.5, -5),
BackgroundColor3 = tbl21.txt,
BorderSizePixel = 0,
Visible = false,
}, collapseBtn)
slicedfn43(plusV, 1)
collapseBtn.MouseButton1Click:Connect(function()
visible = not visible
plusV.Visible = visible
slicedn34 = visible and compactH or fullH
slicedfn45(Main, 0.25, { Size = UDim2.fromOffset(mainW, slicedn34) }, Enum.EasingStyle.Quart)
-- compact mode: hide side rail + divider, stretch status card full width
local rail_ = Main:FindFirstChild("Rail")
local line_ = Main:FindFirstChild("RailLine")
local card_ = Main:FindFirstChild("StatusCard")
if visible then
if rail_ then rail_.Visible = false end
if line_ then line_.Visible = false end
if card_ then
slicedfn45(card_, 0.25, { Position = UDim2.fromOffset(10, 50), Size = UDim2.new(1, -20, 0, 40) }, Enum.EasingStyle.Quart)
end
else
if rail_ then rail_.Visible = true end
if line_ then line_.Visible = true end
if card_ then
slicedfn45(card_, 0.25, { Position = UDim2.fromOffset(railW + 10, 50), Size = UDim2.new(1, -(railW + 20), 0, 40) }, Enum.EasingStyle.Quart)
end
end
end)
end

local logAdd = nil
-- status card (always visible)
do
local statusCard = slicedfn42("Frame", {
Name = "StatusCard",
Size = UDim2.new(1, -(railW + 20), 0, 40),
Position = UDim2.fromOffset(railW + 10, 50),
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
}, Main)
slicedfn43(statusCard, 10)
slicedfn44(statusCard, tbl21.line, 1, 0.3)
local statusBar = slicedfn42("Frame", {
Size = UDim2.new(0, 3, 1, -14),
Position = UDim2.fromOffset(9, 7),
BackgroundColor3 = tbl21.sub,
BorderSizePixel = 0,
}, statusCard)
slicedfn43(statusBar, 2)
local tag = slicedfn46("STATUS", 8, tbl21.sub, gothamBlack, Enum.TextXAlignment.Left, statusCard)
tag.Size = UDim2.new(1, -50, 0, 10)
tag.Position = UDim2.fromOffset(21, 7)
sliced99 = slicedfn46("starting...", 13, tbl21.txt, gothamBold, Enum.TextXAlignment.Left, statusCard)
sliced99.Size = UDim2.new(1, -50, 0, 20)
sliced99.Position = UDim2.fromOffset(21, 18)
sliced99.TextTruncate = Enum.TextTruncate.AtEnd
Frame = slicedfn42("Frame", {
Size = UDim2.fromOffset(8, 8),
Position = UDim2.new(1, -20, 0.5, -4),
BackgroundColor3 = tbl21.sub,
BorderSizePixel = 0,
}, statusCard)
slicedfn43(Frame, 4)
slicedfn50 = function(text, kind)
sliced99.Text = text
local col = kind == "ok" and tbl21.ok or kind == "err" and tbl21.err or kind == "busy" and tbl21.acc or kind == "wait" and tbl21.warn or tbl21.txt
sliced99.TextColor3 = col
statusBar.BackgroundColor3 = col
if logAdd then
pcall(logAdd, text, kind)
end
end
end

-- helpers
local function card(parent, order, height)
local f = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, height),
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
LayoutOrder = order,
}, parent)
slicedfn43(f, 14)
local st = slicedfn44(f, tbl21.acc, 1, 0.65)
return f, st
end
embedHost = slicedfn42("Frame", {
Name = "PageHost",
Size = UDim2.new(1, -(railW + 20), 1, -106),
Position = UDim2.fromOffset(railW + 10, 98),
BackgroundTransparency = 1,
BorderSizePixel = 0,
ClipsDescendants = true,
}, Main)
pageMap = {}
local function newPage(name, key)
local page = slicedfn42("Frame", {
Name = name,
Size = UDim2.fromScale(1, 1),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Visible = false,
}, embedHost)
slicedfn42("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }, page)
pageMap[key] = page
return page
end
local pageSnipe = newPage("PageSnipe", "snipe")
local pageAuto = newPage("PageAuto", "auto")
local pageSystem = newPage("PageSystem", "system")
local pageLog = newPage("PageLog", "log")

-- side rail
do
local rail = slicedfn42("Frame", {
Name = "Rail",
Size = UDim2.new(0, railW, 1, -44),
Position = UDim2.fromOffset(0, 44),
BackgroundTransparency = 1,
BorderSizePixel = 0,
}, Main)
slicedfn42("Frame", {
Name = "RailLine",
Size = UDim2.new(0, 1, 1, -60),
Position = UDim2.fromOffset(railW - 1, 50),
BackgroundColor3 = tbl21.line,
BackgroundTransparency = 0.3,
BorderSizePixel = 0,
}, Main)
slicedfn42("UIListLayout", {
Padding = UDim.new(0, 4),
SortOrder = Enum.SortOrder.LayoutOrder,
HorizontalAlignment = Enum.HorizontalAlignment.Center,
}, rail)
slicedfn42("UIPadding", { PaddingTop = UDim.new(0, 8) }, rail)
local railBtn = {}
local railBar = {}
showPage = function(key)
local target = pageMap[key]
if target then
target.Visible = true
end
for k, f in pairs(pageMap) do
if k ~= key then
f.Visible = false
end
end
for k, b in pairs(railBtn) do
local on = k == key
b.TextColor3 = on and tbl21.acc or tbl21.sub
railBar[k].Visible = on
end
end
local items = {
{ "snipe", "🎯" },
{ "auto", "⚡" },
{ "system", "🕯️" },
{ "log", "📜" },
{ "Feed", "🦇" },
{ "AutoBuy", "🛒" },
{ "Settings", "🎃" },
}
for i, it in ipairs(items) do
local key = it[1]
local b = slicedfn48(it[2], rail)
if key == "Feed" then
sliced98 = b
elseif key == "Settings" then
Settings = b
end
b.Size = UDim2.new(1, -14, 0, 34)
b.LayoutOrder = i
b.TextSize = 18
b.TextColor3 = tbl21.sub
local bar = slicedfn42("Frame", {
Size = UDim2.new(0, 3, 1, -14),
Position = UDim2.fromOffset(-1, 7),
BackgroundColor3 = tbl21.acc,
BorderSizePixel = 0,
Visible = false,
}, b)
slicedfn43(bar, 2)
railBtn[key] = b
railBar[key] = bar
if key == "snipe" or key == "auto" or key == "system" or key == "log" then
b.MouseButton1Click:Connect(function()
showPage(key)
end)
elseif key == "AutoBuy" then
b.MouseButton1Click:Connect(function()
if pageMap.AutoBuy and pageMap.AutoBuy.Visible then
showPage("snipe")
elseif slicedfn31 then
slicedfn31()
else
slicedfn50("auto buy not ready yet", "err")
end
end)
end
end
showPage("snipe")
end

-- SNIPE page: code input
do
local codeCard = card(pageSnipe, 1, 84)
local codeLbl = slicedfn46("ENTER OR SNIPE A CODE", 9, tbl21.acc, gothamBlack, Enum.TextXAlignment.Left, codeCard)
codeLbl.Size = UDim2.new(1, -24, 0, 12)
codeLbl.Position = UDim2.fromOffset(12, 8)
TextBox = slicedfn42("TextBox", {
Size = UDim2.new(1, -24, 0, 40),
Position = UDim2.fromOffset(12, 28),
BackgroundColor3 = tbl21.input,
Text = "",
PlaceholderText = "type or snipe a code...",
PlaceholderColor3 = tbl21.sub,
Font = gothamBlack,
TextSize = 17,
TextColor3 = tbl21.txt,
ClearTextOnFocus = false,
BorderSizePixel = 0,
TextXAlignment = Enum.TextXAlignment.Left,
}, codeCard)
slicedfn43(TextBox, 8)
local tbStroke = slicedfn44(TextBox, tbl21.line, 1.2, 0.25)
slicedfn42("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) }, TextBox)
TextBox.Focused:Connect(function()
slicedfn45(tbStroke, 0.12, { Color = tbl21.acc, Transparency = 0 })
end)
TextBox.FocusLost:Connect(function()
slicedfn45(tbStroke, 0.12, { Color = tbl21.line, Transparency = 0.25 })
end)
end

-- SNIPE page: action buttons
do
local row = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 38),
BackgroundTransparency = 1,
LayoutOrder = 2,
}, pageSnipe)
slicedfn42("UIListLayout", {
FillDirection = Enum.FillDirection.Horizontal,
Padding = UDim.new(0, 6),
SortOrder = Enum.SortOrder.LayoutOrder,
}, row)
sliced100 = slicedfn48("COPY", row)
sliced100.Size = UDim2.new(0.3, -4, 1, 0)
sliced100.LayoutOrder = 1
clear = slicedfn48("CLEAR", row)
clear.Size = UDim2.new(0.3, -4, 1, 0)
clear.LayoutOrder = 2
redeem = slicedfn49("REDEEM", row)
redeem.Size = UDim2.new(0.4, -4, 1, 0)
redeem.LayoutOrder = 3
redeem.TextColor3 = Color3.fromRGB(0, 0, 0)
end

-- toggle row factory (also used by the Settings window)
slicedfn51 = function(arg, arg2, arg3, arg4, arg5)
local Frame7 = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
LayoutOrder = arg2,
}, arg)
slicedfn43(Frame7, 10)
slicedfn44(Frame7, tbl21.line, 1, 0.3)
local lbl = slicedfn46(arg3, 11, tbl21.sub, gothamBold, Enum.TextXAlignment.Left, Frame7)
lbl.Size = UDim2.new(1, -56, 1, 0)
lbl.Position = UDim2.fromOffset(12, 0)
lbl.TextTruncate = Enum.TextTruncate.AtEnd
local track = slicedfn42("Frame", {
Size = UDim2.fromOffset(36, 18),
Position = UDim2.new(1, -44, 0.5, -9),
BackgroundColor3 = tbl21.line,
BorderSizePixel = 0,
}, Frame7)
slicedfn43(track, 9)
local knob = slicedfn42("Frame", {
Size = UDim2.fromOffset(14, 14),
Position = UDim2.new(0, 2, 0.5, -7),
BackgroundColor3 = tbl21.txt,
BorderSizePixel = 0,
}, track)
slicedfn43(knob, 7)
local hit = slicedfn42("TextButton", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "" }, Frame7)
local state = arg4
local function paint()
slicedfn45(track, 0.16, { BackgroundColor3 = state and tbl21.acc or tbl21.line })
slicedfn45(knob, 0.16, { Position = UDim2.new(0, state and 20 or 2, 0.5, -7) }, Enum.EasingStyle.Back)
slicedfn45(lbl, 0.16, { TextColor3 = state and tbl21.txt or tbl21.sub })
end
paint()
hit.MouseButton1Click:Connect(function()
state = not state
paint()
if arg5 then
arg5(state)
end
end)
return Frame7, function(v, silent)
state = v and true or false
paint()
if arg5 and not silent then
arg5(state)
end
end
end

-- SNIPE page: listen card
do
local listenCard = card(pageSnipe, 3, 44)
listen = slicedfn46("LISTEN", 12, tbl21.sub, gothamBold, Enum.TextXAlignment.Left, listenCard)
listen.Size = UDim2.new(1, -70, 1, 0)
listen.Position = UDim2.fromOffset(14, 0)
Frame2 = slicedfn42("Frame", {
Size = UDim2.fromOffset(36, 18),
Position = UDim2.new(1, -50, 0.5, -9),
BackgroundColor3 = tbl21.line,
BorderSizePixel = 0,
}, listenCard)
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
}, listenCard)
end

-- SNIPE page: spam card
do
local spamCard, spamStroke = card(pageSnipe, 4, 44)
sliced105 = spamStroke
sliced106 = slicedfn46("SPAM", 12, tbl21.sub, gothamBold, Enum.TextXAlignment.Left, spamCard)
sliced106.Size = UDim2.new(1, -100, 1, 0)
sliced106.Position = UDim2.fromOffset(14, 0)
start = slicedfn48("START", spamCard)
start.Size = UDim2.fromOffset(76, 28)
start.Position = UDim2.new(1, -88, 0.5, -14)
start.TextSize = 11
sliced107 = slicedfn42("Frame", {
Size = UDim2.fromOffset(7, 7),
Position = UDim2.new(0, 9, 0.5, -3.5),
BackgroundColor3 = tbl21.line,
BorderSizePixel = 0,
}, start)
slicedfn43(sliced107, 4)
end

-- AUTO page: toggle chips
do
local chipRow = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 56),
BackgroundTransparency = 1,
LayoutOrder = 1,
}, pageAuto)
slicedfn42("UIListLayout", {
FillDirection = Enum.FillDirection.Horizontal,
Padding = UDim.new(0, 6),
SortOrder = Enum.SortOrder.LayoutOrder,
}, chipRow)
local function chip(order, label, initial, cb)
local f = slicedfn42("TextButton", {
Size = UDim2.new(1 / 3, -4, 1, 0),
LayoutOrder = order,
BackgroundColor3 = tbl21.panel,
Text = "",
AutoButtonColor = false,
BorderSizePixel = 0,
}, chipRow)
slicedfn43(f, 14)
local st = slicedfn44(f, tbl21.line, 1, 0.3)
local lbl = slicedfn46(label, 10, tbl21.sub, gothamBlack, Enum.TextXAlignment.Center, f)
lbl.Size = UDim2.new(1, 0, 0, 14)
lbl.Position = UDim2.fromOffset(0, 13)
local bar = slicedfn42("Frame", {
Size = UDim2.fromOffset(22, 3),
AnchorPoint = Vector2.new(0.5, 0),
Position = UDim2.new(0.5, 0, 0, 36),
BackgroundColor3 = tbl21.line,
BorderSizePixel = 0,
}, f)
slicedfn43(bar, 2)
local on = initial and true or false
local function paint()
slicedfn45(bar, 0.16, { BackgroundColor3 = on and tbl21.acc or tbl21.line, Size = UDim2.fromOffset(on and 36 or 22, 3) })
slicedfn45(st, 0.16, { Color = on and tbl21.acc or tbl21.line, Transparency = on and 0.1 or 0.3 })
lbl.TextColor3 = on and tbl21.txt or tbl21.sub
end
paint()
f.MouseButton1Click:Connect(function()
on = not on
paint()
if cb then
cb(on)
end
end)
return f
end
chip(1, "AUTO REDEEM", autoRedeem, function(arg)
autoRedeem = arg
_G.__RdmCfgSet("autoRedeem", arg)
end)
chip(2, "AUTO TYPE", autoType, function(arg)
autoType = arg
_G.__RdmCfgSet("autoType", arg)
end)
chip(3, "MANUAL", manual, function(arg)
manual = arg
tbl19 = {}
slicedfn52()
end)
end

-- AUTO page: segmented rows
do
local function segRow(parent, order, label, options, default, cb)
local row = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 38),
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
LayoutOrder = order,
}, parent)
slicedfn43(row, 10)
slicedfn44(row, tbl21.line, 1, 0.3)
local lbl = slicedfn46(label, 11, tbl21.sub, gothamBold, Enum.TextXAlignment.Left, row)
lbl.Size = UDim2.fromOffset(56, 38)
lbl.Position = UDim2.fromOffset(12, 0)
local track = slicedfn42("Frame", {
Size = UDim2.new(1, -84, 0, 26),
Position = UDim2.new(0, 72, 0.5, -13),
BackgroundColor3 = tbl21.input,
BorderSizePixel = 0,
}, row)
slicedfn43(track, 8)
local map = {}
local function choose(key)
for k, b in pairs(map) do
local on = k == key
slicedfn45(b, 0.12, { BackgroundColor3 = on and tbl21.acc or tbl21.input })
b.TextColor3 = on and Color3.fromRGB(0, 0, 0) or tbl21.sub
end
if cb then
cb(key)
end
end
for i, opt in ipairs(options) do
local key = type(opt) == "table" and opt[1] or opt
local text = type(opt) == "table" and opt[2] or opt
local b = slicedfn42("TextButton", {
Size = UDim2.new(1 / #options, -2, 1, -2),
Position = UDim2.new((i - 1) / #options, 1, 0, 1),
BackgroundColor3 = tbl21.input,
Text = text,
Font = gothamBold,
TextSize = text:find("\n") and 8 or 10,
TextColor3 = tbl21.sub,
AutoButtonColor = false,
BorderSizePixel = 0,
}, track)
slicedfn43(b, 6)
map[key] = b
b.MouseButton1Click:Connect(function()
choose(key)
end)
end
choose(default)
return row
end
words = segRow(pageAuto, 2, "WORDS", { "1", "2", "3", "4" }, tostring(slicedn33), function(arg)
slicedn33 = tonumber(arg) or 1
tbl19 = {}
if flag20 and not manual then
slicedfn50(("listening... 0/%d"):format(slicedn33), "wait")
end
end)
segRow(pageAuto, 3, "SPEED", { "MAX", { "WORD", "EVERY\nWORD" } }, _G.__RdmCfgBool("wordMode", false) and "WORD" or "MAX", function(arg)
flag19 = arg == "WORD"
if not flag19 then
max = tbl22[arg] or tbl22.MAX
end
_G.__RdmCfgSet("speed", arg)
_G.__RdmCfgSet("wordMode", flag19)
end)
local risky = nil
for _, d in ipairs(pageAuto:GetDescendants()) do
if d:IsA("TextButton") and d.Text == "EVERY\nWORD" then
risky = d
break
end
end
if risky then
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
}, risky)
end
end

-- SYSTEM page: keybinds
do
Frame5 = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 36),
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
LayoutOrder = 1,
}, pageSystem)
slicedfn43(Frame5, 10)
slicedfn44(Frame5, tbl21.line, 1, 0.3)
local l1 = slicedfn46("LISTEN KEY", 11, tbl21.sub, gothamBold, Enum.TextXAlignment.Left, Frame5)
l1.Size = UDim2.new(1, -100, 1, 0)
l1.Position = UDim2.fromOffset(12, 0)
sliced101 = slicedfn48(listenKey and listenKey.Name or "-", Frame5)
sliced101.Size = UDim2.fromOffset(46, 24)
sliced101.Position = UDim2.new(1, -84, 0.5, -12)
sliced101.TextSize = 11
sliced102 = slicedfn48("X", Frame5)
sliced102.Size = UDim2.fromOffset(24, 24)
sliced102.Position = UDim2.new(1, -32, 0.5, -12)
sliced102.TextSize = 12
Frame4 = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 36),
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
LayoutOrder = 2,
}, pageSystem)
slicedfn43(Frame4, 10)
slicedfn44(Frame4, tbl21.line, 1, 0.3)
local l2 = slicedfn46("REDEEM KEY", 11, tbl21.sub, gothamBold, Enum.TextXAlignment.Left, Frame4)
l2.Size = UDim2.new(1, -100, 1, 0)
l2.Position = UDim2.fromOffset(12, 0)
sliced103 = slicedfn48(g and g.Name or "-", Frame4)
sliced103.Size = UDim2.fromOffset(46, 24)
sliced103.Position = UDim2.new(1, -84, 0.5, -12)
sliced103.TextSize = 11
sliced104 = slicedfn48("X", Frame4)
sliced104.Size = UDim2.fromOffset(24, 24)
sliced104.Position = UDim2.new(1, -32, 0.5, -12)
sliced104.TextSize = 12
end

-- SYSTEM page: events
do
local Frame7 = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 36),
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
LayoutOrder = 3,
}, pageSystem)
slicedfn43(Frame7, 10)
slicedfn44(Frame7, tbl21.line, 1, 0.3)
local events = slicedfn46("EVENTS", 11, tbl21.sub, gothamBold, Enum.TextXAlignment.Left, Frame7)
events.Size = UDim2.new(1, -104, 1, 0)
events.Position = UDim2.fromOffset(12, 0)
local blockAll = slicedfn48("BLOCK ALL", Frame7)
blockAll.Size = UDim2.fromOffset(88, 24)
blockAll.Position = UDim2.new(1, -97, 0.5, -12)
blockAll.TextSize = 10
local busy = false
local lastKey = nil
local msg = nil
local msgKind = nil
local blockedUntil = 0
local function refreshBlock()
local isBlocked = os.clock() < blockedUntil
local key = tostring(tbl20.ready) .. tostring(isBlocked)
if key == lastKey then
return
end
lastKey = key
blockAll.Text = isBlocked and "BLOCKED" or "BLOCK ALL"
blockAll.TextColor3 = not tbl20.ready and tbl21.sub or isBlocked and tbl21.ok or tbl21.txt
end
blockAll.MouseButton1Click:Connect(function()
if busy then
return
end
if not tbl20.ready then
slicedfn50("events: " .. tostring(tbl20.why), "err")
return
end
busy = true
slicedfn50("blocking events...", "busy")
task.spawn(function()
local ok, result, result2 = pcall(tbl20.Block)
if ok and result then
result2 = result2 or "blocked"
msg = result2
msgKind = "ok"
else
msg = "events: " .. tostring(result2 or result)
msgKind = "err"
end
busy = false
end)
end)
task.spawn(function()
while Frame7.Parent do
if msg then
local m = msg
local k = msgKind
msg = nil
msgKind = nil
if k == "ok" then
blockedUntil = os.clock() + 1
end
pcall(slicedfn50, m, k)
end
pcall(refreshBlock)
task.wait(0.2)
end
end)
refreshBlock()
end

do
local topRow = slicedfn42("Frame", { Size = UDim2.new(1, 0, 0, 28), BackgroundTransparency = 1, LayoutOrder = 1 }, pageLog)
local cnt = slicedfn46("0 entries", 11, tbl21.sub, gothamBold, Enum.TextXAlignment.Left, topRow)
cnt.Size = UDim2.new(1, -70, 1, 0)
cnt.Position = UDim2.fromOffset(4, 0)
local clearLog = slicedfn48("CLEAR", topRow)
clearLog.Size = UDim2.fromOffset(60, 24)
clearLog.Position = UDim2.new(1, -60, 0.5, -12)
clearLog.TextSize = 10
local scroll = slicedfn42("ScrollingFrame", {
Size = UDim2.new(1, 0, 1, -34),
BackgroundTransparency = 1,
BorderSizePixel = 0,
ScrollBarThickness = 3,
ScrollBarImageColor3 = tbl21.acc,
CanvasSize = UDim2.new(),
AutomaticCanvasSize = Enum.AutomaticSize.Y,
ScrollingDirection = Enum.ScrollingDirection.Y,
LayoutOrder = 2,
}, pageLog)
slicedfn42("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }, scroll)
local rows = {}
local counter = 0
local lastText = nil
logAdd = function(text, kind)
if text == lastText then
return
end
lastText = text
counter = counter + 1
local col = kind == "ok" and tbl21.ok or kind == "err" and tbl21.err or kind == "busy" and tbl21.acc or kind == "wait" and tbl21.warn or tbl21.txt
local row = slicedfn42("Frame", {
Size = UDim2.new(1, -4, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
LayoutOrder = -counter,
}, scroll)
slicedfn43(row, 8)
slicedfn42("UIPadding", {
PaddingTop = UDim.new(0, 6),
PaddingBottom = UDim.new(0, 6),
PaddingLeft = UDim.new(0, 14),
PaddingRight = UDim.new(0, 8),
}, row)
slicedfn42("Frame", {
Size = UDim2.new(0, 3, 1, -12),
Position = UDim2.fromOffset(-9, 0),
BackgroundColor3 = col,
BorderSizePixel = 0,
}, row)
local msgLbl = slicedfn46(os.date("%H:%M:%S") .. "  " .. tostring(text), 11, col, gothamMedium, Enum.TextXAlignment.Left, row)
msgLbl.Size = UDim2.new(1, 0, 0, 0)
msgLbl.AutomaticSize = Enum.AutomaticSize.Y
msgLbl.TextWrapped = true
rows[#rows + 1] = row
if #rows > 60 then
local old = table.remove(rows, 1)
old:Destroy()
end
cnt.Text = #rows .. " entries"
end
clearLog.MouseButton1Click:Connect(function()
for _, r in ipairs(rows) do
r:Destroy()
end
rows = {}
lastText = nil
cnt.Text = "0 entries"
end)
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
slicedfn52 = function()
words.Visible = not manual
end
slicedfn53 = function()
Frame5.Visible = showKeybinds and true or false
Frame4.Visible = showKeybinds and true or false
end
end
end
do
local sliced109
Settings2, sliced109 = slicedfn47("Settings", 300, flag18 and 316 or 280, "SETTINGS")
Settings2.Visible = false
Settings2.Parent = embedHost
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
slicedfn51(Frame6, 4, "IGNORE SYSTEM PHRASES", sliced96, function(arg)
sliced96 = arg
_G.__RdmCfgSet("ignoreSystem", arg)
end)
do
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local GuiService = game:GetService("GuiService")
local lp = Players.LocalPlayer
local rejoinRow = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 31),
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
LayoutOrder = 7,
}, Frame6)
slicedfn43(rejoinRow, 8)
slicedfn44(rejoinRow, tbl21.line, 1, 0.3)
local rejoinLbl = slicedfn46("REJOIN SERVER", 11, tbl21.sub, gothamBold, Enum.TextXAlignment.Left, rejoinRow)
rejoinLbl.Size = UDim2.new(1, -70, 1, 0)
rejoinLbl.Position = UDim2.fromOffset(12, 0)
local rejoinBtn = slicedfn48("GO", rejoinRow)
rejoinBtn.Size = UDim2.fromOffset(52, 22)
rejoinBtn.Position = UDim2.new(1, -60, 0.5, -11)
rejoinBtn.TextSize = 10
rejoinBtn.MouseButton1Click:Connect(function()
pcall(function()
TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
end)
end)

end
end
do
local Frame7
do
if flag18 then
local Frame8
do
local Frame9 = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 31),
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
LayoutOrder = 5,
}, Frame6)
slicedfn43(Frame9, 8)
slicedfn44(Frame9, tbl21.line, 1, 0.3)
local uiSize = slicedfn46("UI SIZE", 11, tbl21.sub, gothamBold, Enum.TextXAlignment.Left, Frame9)
uiSize.Size = UDim2.fromOffset(70, 31)
uiSize.Position = UDim2.fromOffset(11, 0)
Frame8 = slicedfn42("Frame", {
Size = UDim2.fromOffset(168, 23),
Position = UDim2.new(1, -177, 0.5, -11.5),
BackgroundColor3 = tbl21.input,
BorderSizePixel = 0,
}, Frame9)
end
slicedfn43(Frame8, 7)
do
local tbl22 = {}
local function slicedfn54(arg, arg2)
for k, sliced109 in pairs(tbl22) do
local flag23 = k == arg
slicedfn45(sliced109, 0.12, { BackgroundColor3 = flag23 and tbl21.acc or tbl21.input })
sliced109.TextColor3 = flag23 and Color3.fromRGB(255, 255, 255) or tbl21.sub
end
if arg2 then
return
end
_G.__RdmCfgSet("uiSize", arg)
if tbl18.refit then
tbl18.refit()
end
end
local tbl23 = { "BIG", "MEDIUM", "SMALL" }
for i, sliced109 in ipairs(tbl23) do
local TextButton2 = slicedfn42("TextButton", {
Size = UDim2.new(1 / #tbl23, -2, 1, -2),
Position = UDim2.new((i - 1) / #tbl23, 1, 0, 1),
BackgroundColor3 = tbl21.input,
Text = sliced109,
Font = gothamBold,
TextSize = 9,
TextColor3 = tbl21.sub,
AutoButtonColor = false,
BorderSizePixel = 0,
}, Frame8)
slicedfn43(TextButton2, 6)
tbl22[sliced109] = TextButton2
TextButton2.MouseButton1Click:Connect(function()
slicedfn54(sliced109)
end)
end
slicedfn54(_G.__RdmCfgStr("uiSize", "MEDIUM"), true)
end
end
Frame7 = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 31),
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
LayoutOrder = 6,
}, Frame6)
Frame7.Visible = false
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
local Frame4, slicedfn52, slicedfn53, tbl22
do
do
do
local Feed, sliced109, sliced110
do
do
local sliced111
Feed, sliced111 = slicedfn47("Feed", 300, 320, "LIVE FEED")
Feed.Visible = false
Feed.Parent = embedHost
Frame4 = slicedfn42("Frame", {
Size = UDim2.fromOffset(8, 8),
Position = UDim2.new(1, -176, 0.5, -4),
BackgroundColor3 = tbl21.sub,
BorderSizePixel = 0,
}, sliced111)
slicedfn43(Frame4, 4)
sliced109 = slicedfn46("0 caught", 10, tbl21.sub, gothamBold, Enum.TextXAlignment.Right, sliced111)
sliced109.Size = UDim2.fromOffset(80, 44)
sliced109.Position = UDim2.new(1, -166, 0, 0)
sliced110 = slicedfn48("CLEAR", sliced111)
sliced110.Size = UDim2.fromOffset(40, 22)
sliced110.Position = UDim2.new(1, -82, 0.5, -11)
sliced110.TextSize = 10
local sliced112 = slicedfn48("X", sliced111)
sliced112.Size = UDim2.fromOffset(22, 22)
sliced112.Position = UDim2.new(1, -32, 0.5, -11)
sliced112.TextSize = 12
sliced112.MouseButton1Click:Connect(function()
Feed.Visible = false
end)
end
end
local ScrollingFrame = slicedfn42("ScrollingFrame", {
Size = UDim2.new(1, -18, 1, -56),
Position = UDim2.fromOffset(11, 50),
BackgroundTransparency = 1,
BorderSizePixel = 0,
ScrollBarThickness = 3,
ScrollBarImageColor3 = tbl21.acc,
ScrollBarImageTransparency = 0.3,
CanvasSize = UDim2.new(),
AutomaticCanvasSize = Enum.AutomaticSize.Y,
ScrollingDirection = Enum.ScrollingDirection.Y,
}, Feed)
slicedfn42("UIListLayout", {
Padding = UDim.new(0, 6),
SortOrder = Enum.SortOrder.LayoutOrder,
}, ScrollingFrame)
local sliced111 = slicedfn46("waiting for announcements...", 11, tbl21.sub, gothamMedium, Enum.TextXAlignment.Center, ScrollingFrame)
sliced111.Size = UDim2.new(1, 0, 0, 34)
sliced111.LayoutOrder = 999
local tbl23 = {}
local slicedn35 = 0
slicedfn52 = nil
local function slicedfn54()
if flag18 then
Feed.Position = UDim2.new(0.5, -math.floor(Feed.AbsoluteSize.X / 2), 0.5, -math.floor(Feed.AbsoluteSize.Y / 2))
else
local position = Main.Position
Feed.Position = UDim2.new(position.X.Scale, position.X.Offset - Feed.AbsoluteSize.X - 10, position.Y.Scale, position.Y.Offset)
end
Feed.Visible = true
end
slicedfn53 = function(arg, arg2)
if sliced111 then
sliced111:Destroy()
sliced111 = nil
end
slicedn35 += 1
sliced109.Text = slicedn35 .. " caught"
local Frame5 = slicedfn42("Frame", {
Size = UDim2.new(1, -4, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = tbl21.panel,
BorderSizePixel = 0,
LayoutOrder = -slicedn35,
}, ScrollingFrame)
slicedfn43(Frame5, 9)
slicedfn44(Frame5, arg2 and tbl21.acc or tbl21.line, 1, arg2 and 0.3 or 0.5)
slicedfn42("UIPadding", {
PaddingTop = UDim.new(0, 8),
PaddingBottom = UDim.new(0, 8),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
}, Frame5)
slicedfn42("UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder }, Frame5)
local sliced112 = slicedfn42("Frame", { Size = UDim2.new(1, 0, 0, 12), BackgroundTransparency = 1, LayoutOrder = 1 }, Frame5)
slicedfn43(slicedfn42("Frame", {
Size = UDim2.fromOffset(6, 6),
Position = UDim2.new(0, 0, 0.5, -3),
BackgroundColor3 = arg2 and tbl21.acc or tbl21.sub,
BorderSizePixel = 0,
}, sliced112), 3)
slicedfn46("NOTIFY", 8, tbl21.acc, gothamBlack, Enum.TextXAlignment.Left, sliced112).Position = UDim2.fromOffset(12, 0)
local sub = tbl21.sub
local right = Enum.TextXAlignment.Right
local sliced113 = slicedfn46(os.date("%H:%M:%S"), 8, sub, gothamMedium, right, sliced112)
sliced113.Size = UDim2.new(0, 60, 1, 0)
sliced113.Position = UDim2.new(1, -60, 0, 0)
local sliced114 = slicedfn46(arg, 10, tbl21.txt, gothamMedium, Enum.TextXAlignment.Left, Frame5)
sliced114.Size = UDim2.new(1, 0, 0, 0)
sliced114.AutomaticSize = Enum.AutomaticSize.Y
sliced114.TextWrapped = true
sliced114.LayoutOrder = 2
if arg2 then
local Frame6 = slicedfn42("Frame", {
Size = UDim2.new(1, 0, 0, 24),
BackgroundTransparency = 1,
LayoutOrder = 3,
}, Frame5)
local TextLabel = slicedfn42("TextLabel", {
Size = UDim2.new(0.5, -3, 1, 0),
BackgroundColor3 = tbl21.input,
Text = arg2,
Font = gothamBlack,
TextSize = 12,
TextColor3 = tbl21.acc,
BorderSizePixel = 0,
}, Frame6)
slicedfn43(TextLabel, 6)
slicedfn44(TextLabel, tbl21.acc, 1, 0.4)
local copy = slicedfn48("COPY", Frame6)
copy.Size = UDim2.new(0.22, -3, 1, 0)
copy.Position = UDim2.new(0.52, 3, 0, 0)
copy.TextSize = 9
copy.MouseButton1Click:Connect(function()
copy.Text = slicedfn35(arg2) and "OK" or "ERR"
task.delay(0.7, function()
if copy.Parent then
copy.Text = "COPY"
end
end)
end)
local sliced115 = slicedfn49("USE", Frame6)
sliced115.Size = UDim2.new(0.26, -3, 1, 0)
sliced115.Position = UDim2.new(0.74, 3, 0, 0)
sliced115.TextSize = 10
sliced115.MouseButton1Click:Connect(function()
sliced115.Text = "..."
slicedfn52(arg2)
sliced115.Text = "USE"
end)
end
table.insert(tbl23, Frame5)
if #tbl23 > tbl18.maxFeed then
local sliced115 = table.remove(tbl23, 1)
if sliced115 then
sliced115:Destroy()
end
end
end
sliced110.MouseButton1Click:Connect(function()
for _, sliced112 in ipairs(tbl23) do
sliced112:Destroy()
end
tbl23 = {}
slicedn35 = 0
sliced109.Text = "0 caught"
if not sliced111 then
sliced111 = slicedfn46("waiting for announcements...", 11, tbl21.sub, gothamMedium, Enum.TextXAlignment.Center, ScrollingFrame)
sliced111.Size = UDim2.new(1, 0, 0, 34)
sliced111.LayoutOrder = 999
end
end)
sliced98.MouseButton1Click:Connect(function()
if Feed.Visible then
Feed.Visible = false
return
end
slicedfn54()
end)
end
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
local AutoBuy, sliced109 = slicedfn47("AutoBuy", 300, 196, "AUTO BUY")
AutoBuy.Visible = false
AutoBuy.Parent = embedHost
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
_G.__RdmAutoBuySet = select(2, slicedfn51(Frame5, 2, "AUTO BUY", false, function(enabled)
if _G.__RdmSettingsAB then
pcall(_G.__RdmSettingsAB, enabled, true)
end
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
end))
do
local lpA = game:GetService("Players").LocalPlayer
local anchorOn = false
local function setAnchor()
local ch = lpA.Character
local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
if hrp then
pcall(function()
hrp.Anchored = anchorOn
end)
end
end
lpA.CharacterAdded:Connect(function(ch)
if anchorOn then
ch:WaitForChild("HumanoidRootPart", 10)
task.wait(0.3)
setAnchor()
end
end)
task.spawn(function()
while true do
task.wait(0.25)
if anchorOn then
setAnchor()
end
end
end)
slicedfn51(Frame5, 3, "ANCHOR", false, function(v)
anchorOn = v
setAnchor()
end)
end
local sliced118 = nil
local sliced119 = 0
local sliced120 = 0
slicedfn61 = function(arg)
if not tbl23.Enabled then
return
end
sliced120 += arg
if sliced120 < 0.2 then
return
end
sliced120 = 0
local sliced121, sliced122, sliced123 = slicedfn66()
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
slicedfn50(("%sredeemed: %s"):format(arg2, sliced109), "ok")
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
slicedfn50(("spam %d - redeemed: %s"):format(slicedn32, sliced109), sliced112)
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
if flag19 then
if slicedn32 == 0 then
slicedfn50("spam - redeem on every word", "wait")
end
task.wait(0.03)
else
if slicedfn34(TextBox.Text) == "" then
slicedfn50("spam - waiting for a code...", "wait")
else
slicedfn66(TextBox.Text)
end
task.wait(max)
end
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
start.MouseButton1Click:Connect(function()
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
if sliced95 and not flag21 then
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
if str8:find("code is", 1, true) or str8:find("use code", 1, true) or str8:find("code:", 1, true) then
local bad = false
for _, w in ipairs({ "invalid", "expired", "already", "not valid", "wrong", "doesn't exist", "does not exist" }) do
if str8:find(w, 1, true) then
bad = true
break
end
end
if not bad then
return false
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
do
local low = sliced110:lower()
if low:find("sammy", 1, true) and not low:find("activated", 1, true) then
local rest = sliced110:gsub("^%s*[Ss][Pp][Yy][Dd][Ee][Rr][Ss][Aa][Mm][Mm][Yy]%s*[:%-]*", ""):gsub("^%s*[Ss][Aa][Mm][Mm][Yy]%s*[:%-]*", "")
local fastCode
do
local count, only = 0, nil
for tok in rest:gmatch("[%w_]+") do
count += 1
only = tok
end
if count == 1 and #only >= 3 then
fastCode = only
else
fastCode = slicedfn37(rest)
end
end
if fastCode and fastCode:lower() ~= "sammy" then
local fast = _G.__SammyFast
if not fast then
fast = { code = nil, at = 0 }
_G.__SammyFast = fast
end
local now3 = os.clock()
if fast.code ~= fastCode or now3 - fast.at > 3 then
fast.code = fastCode
fast.at = now3
slicedfn40(fastCode)
slicedfn50("sammy -> " .. fastCode, "busy")
slicedfn61(fastCode)
end
slicedfn53(sliced110, fastCode)
return
end
end
end
if slicedfn64(sliced110) then
return
end
if _G.__RdmDuo and _G.__RiddlerDuo then
local sliced111 = _G.__SabClassifyDrop(sliced110)
if sliced111 == "riddle" then
_G.__SabDropClaim = { text = sliced110, kind = "riddle", at = os.clock() }
slicedfn50("riddle - left to the AI riddler", "wait")
slicedfn53(sliced110, nil)
return
end
if sliced111 == "code" then
_G.__SabDropClaim = { text = sliced110, kind = "code", at = os.clock() }
end
end
local sliced111 = slicedfn37(sliced110)
local sliced112
if autoListen and not flag20 then
sliced112 = slicedfn38(sliced110)
if sliced112 then
slicedfn60(true)
if sliced112 == "" then
slicedfn50("trigger heard - waiting for the code...", "busy")
slicedfn53(sliced110, sliced111)
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
slicedfn53(sliced110, sliced111)
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
if str8 == sliced109 and now2 - slicedn35 < 0.1 then
return
end
sliced109 = str8
slicedn35 = now2
pcall(slicedfn30, table.unpack(sliced110, 1, sliced110.n))
end
sliced94 = slicedfn39()
if sliced94 then
Frame.BackgroundColor3 = tbl21.ok
Frame4.BackgroundColor3 = tbl21.ok
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
Frame4.BackgroundColor3 = warn_
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
if not Main:GetAttribute("UserMoved") then
Main.Position = UDim2.new(1, -math.floor(480 * sliced91) - 8, 0.5, -math.floor(slicedn34 * sliced91 / 2))
end
end
if currentCamera then
currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(refit)
end
tbl18.refit = refit
refit()
end
-- Halloween: make panels slightly translucent so the background shows through
do
local function soften(d)
if d:IsA("Frame") and d.BackgroundTransparency == 0 and d.BackgroundColor3 == tbl21.panel then
d.BackgroundTransparency = 0.12
end
end
for _, d in ipairs(Main:GetDescendants()) do
pcall(soften, d)
end
Main.DescendantAdded:Connect(function(d)
task.defer(pcall, soften, d)
end)
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
getgenv().TracedAnnounce = function(...)
slicedfn30(...)
end
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
getgenv().TracedUnblockEvents = function()
if not tbl20.ready then
return false, tbl20.why
end
return tbl20.Unblock()
end
end
end
slicedfn60(false)
if sliced94 or flag22 then
slicedfn50(keyboardEnabled and (listenKey and "ready - press " .. listenKey.Name .. " to listen" or "ready - no listen key bound") or "ready - tap LISTEN to start", "idle")
else
slicedfn50("notify remote not found", "err")
end