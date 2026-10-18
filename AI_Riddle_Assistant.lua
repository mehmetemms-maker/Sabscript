-- AI RIDDLE ASSISTANT - Starter LocalScript
-- Place in StarterPlayer > StarterPlayerScripts in your own Roblox Studio experience.
-- This version provides a local helper UI and answer lookup from the supplied rules.
-- It does not read another game's private UI, invoke hidden remotes, or bypass anti-cheat.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Optional API settings. Keep real API keys private; do not publish this script with a key inside it.
-- For a secure live API integration, route requests through your own trusted server/proxy.
local GEMINI_MODEL = "gemini-3.8-flash"
local apiKey = ""

local answers = {
    ["MY NAME"] = "SAMMY",
    ["MY REAL LIFE NAME"] = "BRAKTA",
    ["MY IRL NAME"] = "BRAKTA",
    ["MY USERNAME"] = "SPYDERSAMMY",
    ["MY AGE"] = "24",
    ["MY FAVORITE COLOR"] = "BLUE",
    ["MY FAVORITE BRAINROT"] = "MEOWL",
    ["MY CAT NAME"] = "NOVA",
    ["MY PET NAME"] = "NOVA",
    ["MY COUNTRY"] = "BRAZIL",
    ["MY NATIONALITY"] = "BRAZILIAN",
    ["MY BIRTHDAY MONTH"] = "FEBRUARY",
    ["THE FIRST MUTATION"] = "BLOODROT",
    ["THE FIRST TRAIT"] = "BUBBLEGUM",
    ["THE FIRST OG"] = "STRAWBERRYELEPHANT",
    ["THE NEWEST OG"] = "HEADLESSHORSEMAN",
    ["THE NEWEST MUTATION"] = "ECLIPSE",
    ["THE BEST MUTATION"] = "ECLIPSE",
    ["THE BEST TRAIT"] = "STRAWBERRY",
    ["THE HIGHEST INCOME BRAINROT"] = "SPYDERELEPHANT",
    ["THE MOST EXPENSIVE BRAINROT"] = "SPYDERELEPHANT",
    ["THE BEST ADMIN"] = "HASTED",
    ["THE BEST DEV"] = "HASTED",
    ["THE TOP PROGRAMMER"] = "HASTED",
    ["THE FIRST OG BRAINROT"] = "STRAWBERRYELEPHANT",
    ["THE NEWEST BRAINROT"] = "PHOENIX",
    ["THE MOST OP BRAINROT RELEASED TODAY"] = "PHOENIX",
}

local mutations = {
    GOLD = "1.25",
    DIAMOND = "1.5",
    BLOODROT = "2",
    CANDY = "4",
    LAVA = "6",
    GALAXY = "7",
    YINYANG = "7.5",
    RADIOACTIVE = "8.5",
    CURSED = "9",
    RAINBOW = "10",
    DIVINE = "10",
    CYBER = "11",
    PHANTOM = "12",
    CRYSTAL = "13",
}

local traits = {
    STRAWBERRY = "10",
    MEOWL = "9",
    ["JOHN PORK"] = "8",
    ["PINK EGG"] = "7.5",
    SKIBIDI = "7.5",
    ["RAINBOW BALLOON"] = "7.5",
    ["QUEEN BEE"] = "7",
    ["PINK BALLOON"] = "6.5",
    GRANNY = "6.5",
    ["1 YEAR"] = "6.5",
}

local function normalize(text)
    text = string.upper(text or "")
    text = text:gsub("^%s*RIDDLE:%s*", "")
    text = text:gsub("[%?%.!]", "")
    text = text:gsub("%s+", " ")
    return text:match("^%s*(.-)%s*$") or ""
end

local function solve(question)
    local q = normalize(question)
    if q == "" then
        return ""
    end

    -- Exact mappings first.
    if answers[q] then
        return answers[q]
    end

    -- Multipliers: return only the number when a known item and multiplier are asked.
    for name, value in pairs(mutations) do
        if q:find(name, 1, true) and
            (q:find("MULTIPLIER", 1, true) or q:find("MULTIPLY", 1, true) or q:find("HOW MUCH", 1, true)) then
            return value
        end
    end

    for name, value in pairs(traits) do
        local normalizedName = normalize(name)
        if q:find(normalizedName, 1, true) and
            (q:find("MULTIPLIER", 1, true) or q:find("MULTIPLY", 1, true) or q:find("HOW MUCH", 1, true)) then
            return value
        end
    end

    -- Basic two-part combinations from the supplied rules.
    local combinations = {
        { "BEST MUTATION", "BEST TRAIT", "ECLIPSE", "STRAWBERRY" },
        { "MY CAT NAME", "MOST OP BRAINROT RELEASED TODAY", "NOVA", "PHOENIX" },
        { "MY NAME", "MY FAVORITE COLOR", "SAMMY", "BLUE" },
        { "FIRST MUTATION", "FIRST TRAIT", "BLOODROT", "BUBBLEGUM" },
    }

    for _, combo in ipairs(combinations) do
        if q:find(combo[1], 1, true) and q:find(combo[2], 1, true) then
            if q:find(" AND ", 1, true) or q:find(" + ", 1, true) or q:find(" PLUS ", 1, true) then
                return combo[3] .. combo[4]
            end
        end
    end

    return "UNKNOWN - ADD A RULE"
end

-- Build a simple draggable-style helper panel.
local gui = Instance.new("ScreenGui")
gui.Name = "AIRiddleAssistant"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(410, 414)
main.Position = UDim2.new(0.5, -205, 0.5, -207)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 220, 255)
stroke.Thickness = 1.5
stroke.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, 42)
title.Position = UDim2.fromOffset(14, 2)
title.BackgroundTransparency = 1
title.Active = true
title.Text = "AI RIDDLE  /  ASSISTANT"
title.TextColor3 = Color3.fromRGB(0, 225, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 17
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

local hide = Instance.new("TextButton")
hide.Size = UDim2.fromOffset(30, 28)
hide.Position = UDim2.new(1, -38, 0, 8)
hide.Text = "—"
hide.TextSize = 18
hide.Font = Enum.Font.GothamBold
hide.TextColor3 = Color3.new(1, 1, 1)
hide.BackgroundColor3 = Color3.fromRGB(45, 45, 62)
hide.Parent = main
Instance.new("UICorner", hide).CornerRadius = UDim.new(0, 6)

local apiKeyBox = Instance.new("TextBox")
apiKeyBox.Size = UDim2.new(1, -116, 0, 34)
apiKeyBox.Position = UDim2.fromOffset(14, 48)
apiKeyBox.PlaceholderText = "API key (optional; kept only in this session)"
apiKeyBox.Text = ""
apiKeyBox.ClearTextOnFocus = false
apiKeyBox.TextXAlignment = Enum.TextXAlignment.Left
apiKeyBox.Font = Enum.Font.Gotham
apiKeyBox.TextSize = 13
apiKeyBox.TextColor3 = Color3.fromRGB(240, 240, 250)
apiKeyBox.PlaceholderColor3 = Color3.fromRGB(140, 145, 165)
apiKeyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 44)
apiKeyBox.Parent = main
apiKeyBox.TextEditable = true
apiKeyBox:SetAttribute("SecretInput", true)
Instance.new("UICorner", apiKeyBox).CornerRadius = UDim.new(0, 8)

local setKeyButton = Instance.new("TextButton")
setKeyButton.Name = "SetAPIKey"
setKeyButton.Size = UDim2.fromOffset(88, 34)
setKeyButton.Position = UDim2.new(1, -102, 0, 48)
setKeyButton.Text = "SET KEY"
setKeyButton.Font = Enum.Font.GothamBold
setKeyButton.TextSize = 12
setKeyButton.TextColor3 = Color3.fromRGB(10, 15, 25)
setKeyButton.BackgroundColor3 = Color3.fromRGB(120, 255, 170)
setKeyButton.Parent = main
Instance.new("UICorner", setKeyButton).CornerRadius = UDim.new(0, 8)

local questionBox = Instance.new("TextBox")
questionBox.Size = UDim2.new(1, -28, 0, 66)
questionBox.Position = UDim2.fromOffset(14, 90)
questionBox.PlaceholderText = "Paste the riddle question here..."
questionBox.Text = ""
questionBox.ClearTextOnFocus = false
questionBox.TextWrapped = true
questionBox.TextXAlignment = Enum.TextXAlignment.Left
questionBox.TextYAlignment = Enum.TextYAlignment.Top
questionBox.Font = Enum.Font.Gotham
questionBox.TextSize = 14
questionBox.TextColor3 = Color3.fromRGB(240, 240, 250)
questionBox.PlaceholderColor3 = Color3.fromRGB(140, 145, 165)
questionBox.BackgroundColor3 = Color3.fromRGB(30, 30, 44)
questionBox.Parent = main
Instance.new("UICorner", questionBox).CornerRadius = UDim.new(0, 8)

local solveButton = Instance.new("TextButton")
solveButton.Size = UDim2.new(0.5, -20, 0, 36)
solveButton.Position = UDim2.fromOffset(14, 164)
solveButton.Text = "LOCAL SOLVE"
solveButton.Font = Enum.Font.GothamBold
solveButton.TextSize = 14
solveButton.TextColor3 = Color3.fromRGB(10, 15, 25)
solveButton.BackgroundColor3 = Color3.fromRGB(0, 220, 255)
solveButton.Parent = main
Instance.new("UICorner", solveButton).CornerRadius = UDim.new(0, 8)

local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(0.5, -20, 0, 36)
copyButton.Position = UDim2.new(0.5, 6, 0, 164)
copyButton.Text = "AUTO CODE"
copyButton.Font = Enum.Font.GothamBold
copyButton.TextSize = 13
copyButton.TextColor3 = Color3.new(1, 1, 1)
copyButton.BackgroundColor3 = Color3.fromRGB(55, 55, 78)
copyButton.Parent = main
Instance.new("UICorner", copyButton).CornerRadius = UDim.new(0, 8)

local answerBox = Instance.new("TextBox")
answerBox.Size = UDim2.new(1, -28, 0, 44)
answerBox.Position = UDim2.fromOffset(14, 212)
answerBox.Text = ""
answerBox.PlaceholderText = "CODE / ANSWER"
answerBox.ClearTextOnFocus = false
answerBox.TextEditable = true
answerBox.Font = Enum.Font.GothamBold
answerBox.TextSize = 16
answerBox.TextColor3 = Color3.fromRGB(120, 255, 170)
answerBox.BackgroundColor3 = Color3.fromRGB(30, 30, 44)
answerBox.Parent = main
Instance.new("UICorner", answerBox).CornerRadius = UDim.new(0, 8)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -28, 0, 42)
status.Position = UDim2.fromOffset(14, 270)
status.BackgroundTransparency = 1
status.Text = "Paste a question, then press SOLVE."
status.TextWrapped = true
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.TextColor3 = Color3.fromRGB(175, 180, 200)
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = main

solveButton.MouseButton1Click:Connect(function()
    local result = solve(questionBox.Text)
    answerBox.Text = result

    if result == "UNKNOWN - ADD A RULE" and apiKey ~= "" then
        status.Text = "API key entered, but live API calls need a secure server/proxy; local lookup did not match."
        status.TextColor3 = Color3.fromRGB(255, 190, 100)
    elseif result == "UNKNOWN - ADD A RULE" then
        status.Text = "No matching rule. Add a rule or connect a secure API server."
        status.TextColor3 = Color3.fromRGB(255, 190, 100)
    else
        status.Text = "Answer ready. API key field is optional; local rules were used."
        status.TextColor3 = Color3.fromRGB(120, 255, 170)
    end
end)

copyButton.MouseButton1Click:Connect(function()
    local question = normalize(questionBox.Text)

    if apiKey == "" then
        status.Text = "Enter your Google Gemini API key first."
        status.TextColor3 = Color3.fromRGB(255, 190, 100)
        return
    end

    if question == "" then
        status.Text = "Enter a riddle question first."
        status.TextColor3 = Color3.fromRGB(255, 190, 100)
        return
    end

    -- Direct API calls are not supported by a normal Roblox LocalScript.
    -- This uses an executor-provided HTTP function if present. For Roblox Studio,
    -- use a trusted server/proxy and never ship an API key in a public client script.
    local httpRequest = request or http_request
    if not httpRequest then
        status.Text = "No HTTP request function found. Roblox Studio needs a secure server/proxy."
        status.TextColor3 = Color3.fromRGB(255, 190, 100)
        return
    end

    status.Text = "AUTO CODE: sending the question to Gemini..."
    status.TextColor3 = Color3.fromRGB(0, 220, 255)

    local prompt = "Answer this AI Riddle using the rules below. Return exactly one line, uppercase, no spaces, labels, punctuation, or explanation. If multiple parts are asked, concatenate answers in order. If unknown, make the most plausible answer without explanation.\n\nQUESTION: " .. question

    task.spawn(function()
        local ok, response = pcall(function()
            return httpRequest({
                Url = "https://generativelanguage.googleapis.com/v1beta/models/" .. GEMINI_MODEL .. ":generateContent?key=" .. apiKey,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = HttpService:JSONEncode({
                    contents = {{
                        parts = {{ text = prompt }}
                    }},
                    generationConfig = {
                        temperature = 0.1,
                        maxOutputTokens = 128
                    }
                })
            })
        end)

        if not ok or not response then
            status.Text = "Gemini request failed. Check the API key, network, or API access."
            status.TextColor3 = Color3.fromRGB(255, 120, 120)
            return
        end

        local body = response.Body or response.body or ""
        local decodedOk, decoded = pcall(function()
            return HttpService:JSONDecode(body)
        end)

        if not decodedOk then
            status.Text = "Gemini returned an unreadable response."
            status.TextColor3 = Color3.fromRGB(255, 120, 120)
            return
        end

        local textResult = decoded.candidates
            and decoded.candidates[1]
            and decoded.candidates[1].content
            and decoded.candidates[1].content.parts
            and decoded.candidates[1].content.parts[1]
            and decoded.candidates[1].content.parts[1].text

        if type(textResult) == "string" and textResult ~= "" then
            textResult = textResult:upper():gsub("[%s%p]", "")
            answerBox.Text = textResult
            status.Text = "AUTO CODE complete: Gemini's answer was placed in CODE / ANSWER."
            status.TextColor3 = Color3.fromRGB(120, 255, 170)
        else
            local apiError = decoded.error and decoded.error.message
            status.Text = "Gemini returned no answer" .. (apiError and (": " .. apiError) or ".")
            status.TextColor3 = Color3.fromRGB(255, 120, 120)
        end
    end)
end)

hide.MouseButton1Click:Connect(function()
    main.Visible = false
    local reopen = Instance.new("TextButton")
    reopen.Name = "ReopenAI"
    reopen.Size = UDim2.fromOffset(150, 38)
    reopen.Position = UDim2.new(0, 20, 0.5, 0)
    reopen.Text = "OPEN AI RIDDLE"
    reopen.Font = Enum.Font.GothamBold
    reopen.TextSize = 13
    reopen.TextColor3 = Color3.fromRGB(10, 15, 25)
    reopen.BackgroundColor3 = Color3.fromRGB(0, 220, 255)
    reopen.Parent = gui
    Instance.new("UICorner", reopen).CornerRadius = UDim.new(0, 8)
    reopen.MouseButton1Click:Connect(function()
        main.Visible = true
        reopen:Destroy()
    end)
end)

-- Allow toggling the panel with RightShift.
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.RightShift then
        main.Visible = not main.Visible
    end
end)
