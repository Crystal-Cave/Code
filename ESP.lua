--API
local OvainumAPI = loadstring(game:HttpGet("https://bit.ly/Ovainum-API", true))()

--Local Player
local LP = game:GetService("Players").LocalPlayer

--Main Function
function AddESP(player, team)
	local copyBG1 = Instance.new("BillboardGui")
	local copyBG2 = Instance.new("BillboardGui")
	local copyFrame1 = Instance.new("Frame")
	local copyFrame2 = Instance.new("Frame")
	local highlight = Instance.new("Highlight")
	highlight.Parent = player.Character
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Enabled = true
	highlight.FillTransparency = 0.5
	highlight.OutlineTransparency = 1
	copyBG1.AlwaysOnTop = true
	copyBG2.AlwaysOnTop = false
	copyBG1.Parent = player.Character.HumanoidRootPart
	copyBG2.Parent = player.Character.Head
	copyFrame1.Parent = copyBG1
	copyFrame2.Parent = copyBG2
	copyFrame1.Size = UDim2.new(1, 0, 1, 0)
	copyFrame2.Size = UDim2.new(1, 0, 1, 0)
	copyBG1.Size = UDim2.new(0, 50, 0, 50)
	copyBG2.Size = UDim2.new(0, 30, 0, 30)
	highlight.Name = "TeamColorHighlight"
	copyBG1.Name = "TeamColorFrame"
	copyBG2.Name = "copyBackground"
	copyFrame1.BackgroundTransparency = 0.5
	copyFrame2.BackgroundTransparency = 0
	copyFrame1.Name = "ColorFrame"
	if team == "Teammate" then
		highlight.FillColor = Color3.fromRGB(0, 255, 106)
		copyFrame1.BackgroundColor3 = Color3.fromRGB(0, 255, 106)
	elseif team == "Enemy" then
		highlight.FillColor = Color3.fromRGB(255, 0, 0)
		copyFrame1.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
	elseif team == "No Team" then
		highlight.FillColor = Color3.fromRGB(150, 150, 150)
		copyFrame1.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
	end
	copyFrame2.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
	copyFrame1.BorderSizePixel = 0
	copyFrame2.BorderSizePixel = 0
end

--Main
for _,player in pairs(game.Players:GetPlayers()) do
	if player.UserId ~= LP.UserId and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("Humanoid").Health > 0 then
		if player.Character.HumanoidRootPart:FindFirstChild("TeamColorFrame") and player.Character:FindFirstChild("TeamColorHighlight") then
			print("Updating "..tostring(player).."'s ESP")
			if OvainumAPI:TeamCheck(player) == "Teammate" then
				player.Character.TeamColorHighlight.FillColor = Color3.fromRGB(0, 255, 106)
				player.Character.HumanoidRootPart.TeamColorFrame.ColorFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 106)
			elseif OvainumAPI:TeamCheck(player) == "Enemy" then
				player.Character.TeamColorHighlight.FillColor = Color3.fromRGB(255, 0, 0)
				player.Character.HumanoidRootPart.TeamColorFrame.ColorFrame.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
			elseif OvainumAPI:TeamCheck(player) == "No Team" then
				player.Character.TeamColorHighlight.FillColor = Color3.fromRGB(150, 150, 150)
				player.Character.HumanoidRootPart.TeamColorFrame.ColorFrame.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
			end
		else
			if OvainumAPI:TeamCheck(player) == "Enemy" then
				AddESP(player, "Enemy")
				print("Added Enemy Team ESP to "..tostring(player))
			elseif OvainumAPI:TeamCheck(player) == "Teammate" then
				AddESP(player, "Teammate")
				print("Added Teammate ESP to "..tostring(player))
			elseif OvainumAPI:TeamCheck(player) == "No Team" then
				AddESP(player, "No Team")
				print("Added ESP to "..tostring(player))
			end
		end
	elseif player.UserId ~= LP.UserId then
		warn("Something went wrong with player: "..tostring(player))
	end
end
