--Reload
getgenv().OvainumMenuLoaded = false
wait()
getgenv().OvainumMenuLoaded = true

--Important Variables
local OvainumAPI = loadstring(game:HttpGet("https://bit.ly/Ovainum-API", true))()
local CoreGui = game.CoreGui

--Services
local UIS = game:GetService("UserInputService")

if CoreGui:FindFirstChild("Ovainum") then
	CoreGui:FindFirstChild("Ovainum"):Destroy()
end

--Player Variables
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

--GUI Variables
local Main = OvainumAPI:NewGUI("Ovainum", CoreGui)
local Main_Frame = Instance.new("Frame")

--Modules
local Other = OvainumAPI:NewMainFrame("Other", Main_Frame, "Mod_Other")
local Player = OvainumAPI:NewMainFrame("Player", Main_Frame, "Mod_Player")
local Render = OvainumAPI:NewMainFrame("Render", Main_Frame, "Mod_Render")
local World = OvainumAPI:NewMainFrame("World", Main_Frame, "Mod_World")

--Properties
Main_Frame.BorderSizePixel = 0
Main_Frame.Parent = Main
Main_Frame.BackgroundTransparency = 0.2
Main_Frame.Size = UDim2.new(1, 0, 1, 0)
Main_Frame.Name = "Main Frame"
Main_Frame.Visible = false
Main_Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

Other.Position = UDim2.new(0.025, 0, 0.1, 0)
Player.Position = UDim2.new(0.275, 0, 0.1, 0)
Render.Position = UDim2.new(0.525, 0, 0.1, 0)
World.Position = UDim2.new(0.775, 0, 0.1, 0)

--Other Subs
local Fly = OvainumAPI:MakeButton("Fly Button", "Fly", Other.ScrollFrame)
local RTX = OvainumAPI:MakeButton("RTX Button", "Cheap RTX", Other.ScrollFrame)
local TP = OvainumAPI:MakeButton("Tp Button", "TP To", Other.ScrollFrame)

--Player Subs
local Jump = OvainumAPI:MakeButton("Jump Button", "Jump", Player.ScrollFrame)
local Speed = OvainumAPI:MakeButton("Speed Button", "Speed", Player.ScrollFrame)
local Unlock_Zoom = OvainumAPI:MakeButton("Unlock Zoom Button", "Unlock Zoom", Player.ScrollFrame)

--Render Subs
local Reveal_Names = OvainumAPI:MakeToggle("Names Toggle", "Show @Names", Render.ScrollFrame, getgenv().Reveal_NamesBV)
local ESP = OvainumAPI:MakeToggle("ESP Button", "ESP", Render.ScrollFrame, getgenv().ESPBV)
local Tracers = OvainumAPI:MakeToggle("Tracers Button", "Tracers", Render.ScrollFrame, getgenv().tracersBV)
local Way_Points = OvainumAPI:MakeButton("Way Points Button", "Way Points", Render.ScrollFrame)

--World Subs
local FOV = OvainumAPI:MakeButton("FOV Button", "FOV", World.ScrollFrame)
local Gravity = OvainumAPI:MakeButton("Gravity Button", "Gravity", World.ScrollFrame)

--Functions
Fly.MouseButton1Click:Connect(function()
	if LP.Character:FindFirstChild("Humanoid") then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Crystal-Cave/Scripts/main/Fly.lua", true))()
	end
end)

RTX.MouseButton1Click:Connect(function()
	OvainumAPI:RTX()
end)

TP.MouseButton1Click:Connect(function()
	local Interaction = OvainumAPI:MakeInteract("TP Interaction", "Teleportation", CoreGui, "TP", "Player")
	
	Interaction[3].MouseButton1Click:Connect(function()
		if Players:FindFirstChild(OvainumAPI:GetName(Interaction[2].Text)) and Players[OvainumAPI:GetName(Interaction[2].Text)].Character:FindFirstChild("HumanoidRootPart") then
			LP.Character:PivotTo(Players[OvainumAPI:GetName(Interaction[2].Text)].Character:GetPivot())
		end
		Interaction[1].Parent:Destroy()
	end)
end)

Jump.MouseButton1Click:Connect(function()
	local Interaction = OvainumAPI:MakeInteract("Jump Interaction", "Jump Power", CoreGui, "Set", "50")

	Interaction[3].MouseButton1Click:Connect(function()
		if tonumber(Interaction[2].Text) ~= nil and LP.Character:FindFirstChild("Humanoid") then
			LP.Character.Humanoid.JumpPower = tonumber(Interaction[2].Text)
		end
		Interaction[1].Parent:Destroy()
	end)
end)

Speed.MouseButton1Click:Connect(function()
	local Interaction = OvainumAPI:MakeInteract("Speed Interaction", "Speed", CoreGui, "Set", "16")

	Interaction[3].MouseButton1Click:Connect(function()
		if tonumber(Interaction[2].Text) ~= nil and LP.Character:FindFirstChild("Humanoid") then
			LP.Character.Humanoid.WalkSpeed = tonumber(Interaction[2].Text)
		end
		Interaction[1].Parent:Destroy()
	end)
end)

Unlock_Zoom.MouseButton1Click:Connect(function()
	LP.CameraMaxZoomDistance = math.huge
	LP.CameraMinZoomDistance = 0.5
end)

Way_Points.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Crystal-Cave/Scripts/main/Way%20Points.lua", true))()
end)

FOV.MouseButton1Click:Connect(function()
	local Interaction = OvainumAPI:MakeInteract("FOV Interaction", "FOV", CoreGui, "Set", "70")

	Interaction[3].MouseButton1Click:Connect(function()
		game:GetService("Workspace").CurrentCamera.FieldOfView = tonumber(Interaction[2].Text)
		Interaction[1].Parent:Destroy()
	end)
end)

Gravity.MouseButton1Click:Connect(function()
	local Interaction = OvainumAPI:MakeInteract("Gravity Interaction", "Gravity", CoreGui, "Set", "196.2")

	Interaction[3].MouseButton1Click:Connect(function()
		game:GetService("Workspace").Gravity = tonumber(Interaction[2].Text)
		Interaction[1].Parent:Destroy()
	end)
end)

Reveal_Names.Parent.Toggle.MouseButton1Click:Connect(function()
	wait(0.1)
	if getgenv().Reveal_NamesBV == true then
		while getgenv().Reveal_NamesBV == true do
			OvainumAPI:ShowNames()
			wait(15)
		end
	end
end)

ESP.Parent.Toggle.MouseButton1Click:Connect(function()
	wait(0.1)
	if getgenv().ESPBV == true then
		while getgenv().ESPBV == true do
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Crystal-Cave/Scripts/main/ESP.lua", true))()
			wait(15)
		end
	end
end)

Tracers.Parent.Toggle.MouseButton1Click:Connect(function()
	wait(0.1)
	if getgenv().tracersBV == true then
		while getgenv().tracersBV == true do
			OvainumAPI:trace("All")
			wait(15)
		end
	end
end)

UIS.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Insert then
		Main_Frame.Visible = not Main_Frame.Visible
	end
end)

OvainumAPI:BetterNotify("<font color = \"rgb(0, 255, 90)\" face = \"FredokaOne\">Ovainum</font>", "Press <b>Insert</b> to toggle", 2)

while getgenv().OvainumMenuLoaded == true do
	getgenv().Reveal_NamesBV = Reveal_Names.Value
	getgenv().ESPBV = ESP.Value
	getgenv().tracersBV = Tracers.Value
	wait()
end
