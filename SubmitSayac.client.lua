-- LocalScript olarak StarterPlayer > StarterPlayerScripts icine koy
-- Kendi oyunundaki Submit butonunu ve altta cikan mesaji izler
local Players = game:GetService("Players")

local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "SubmitSayac"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local sayac = Instance.new("TextLabel")
sayac.Size = UDim2.fromOffset(220, 44)
sayac.AnchorPoint = Vector2.new(0.5, 0)
sayac.Position = UDim2.new(0.5, 0, 0, 10)
sayac.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
sayac.TextColor3 = Color3.new(1, 1, 1)
sayac.Font = Enum.Font.GothamMedium
sayac.TextSize = 16
sayac.Text = "Submit bekleniyor"
sayac.Parent = gui
Instance.new("UICorner", sayac).CornerRadius = UDim.new(0, 8)

local MESAJLAR = { "invalid code", "out of stock", "of stock" }
local baslangic = nil

local function kontrol(label)
	if not baslangic or label == sayac or not label.Visible then return end
	local yazi = string.lower(label.ContentText)
	for _, mesaj in MESAJLAR do
		if string.find(yazi, mesaj, 1, true) then
			sayac.Text = string.format("%.2f sn (%s)", os.clock() - baslangic, label.ContentText)
			baslangic = nil
			return
		end
	end
end

local function izle(obj)
	if obj:IsA("TextButton") and string.find(string.lower(obj.Text .. obj.Name), "submit", 1, true) then
		obj.Activated:Connect(function()
			baslangic = os.clock()
			sayac.Text = "Cevap bekleniyor..."
		end)
	elseif obj:IsA("TextLabel") then
		obj:GetPropertyChangedSignal("Text"):Connect(function()
			kontrol(obj)
		end)
		obj:GetPropertyChangedSignal("Visible"):Connect(function()
			kontrol(obj)
		end)
		kontrol(obj) -- yeni olusturulan mesajlar icin
	end
end

for _, obj in playerGui:GetDescendants() do
	izle(obj)
end
playerGui.DescendantAdded:Connect(izle)
