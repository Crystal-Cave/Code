local Ovainum = {}

local TS = game:GetService("TeleportService")
local RS = game:GetService("RunService")
local players = game:GetService("Players")
local lighting = game:GetService("Lighting")
local terrain = game:GetService("Workspace"):FindFirstChildWhichIsA("Terrain")
local LP = players.LocalPlayer
local camara = game:GetService("Workspace").CurrentCamera
local CoreGui = game.CoreGui
local startergui = game:GetService("StarterGui")
local E_workspace = game:GetService("Workspace")

function Ovainum:reset()
	local hum = LP.Character:FindFirstChild("Humanoid")
	hum.Health = 0
end

function Ovainum:fire(color, color2)
	local main = Instance.new('Part')
	local fire = Instance.new("Fire")
	local fire_Light = Instance.new('PointLight')
	local weld = Instance.new('Weld')

	main.Parent = LP.Character:WaitForChild("Head")
	main.Transparency = 1
	main.Size = Vector3.new(1, 1, 1)
	main.Massless = true
	main.Position = LP.Character:WaitForChild("Head").Position
	main.Name = "Ovainum Fire"

	fire.Parent = main
	fire.Color = color
	fire.SecondaryColor = color2

	fire_Light.Parent = main
	fire_Light.Color = color

	weld.Part0 = LP.Character:WaitForChild("Head")
	weld.Part1 = main
	weld.Parent = main
end

function Ovainum:unfire()
	LP.Character:WaitForChild("Head"):WaitForChild("Ovainum Fire"):Destroy()
end

function Ovainum:ToGame(place)
	TS:Teleport(place, LP)
end

function Ovainum:trace(target)
	if target == "All" then
		for _,person in players:GetPlayers() do
			if person.UserId ~= LP.UserId and person.Character:FindFirstChild("HumanoidRootPart") then
				if person.Character.HumanoidRootPart:FindFirstChild(tostring(person)) and LP.Character.HumanoidRootPart:FindFirstChild(tostring(person)) and game:GetService("Workspace"):FindFirstChild("Ovainum Tracer "..tostring(person)) then
					print(tostring(person).." already has tracer")
				else
					if person.Character.HumanoidRootPart:FindFirstChild(tostring(person)) then
						person.Character.HumanoidRootPart:FindFirstChild(tostring(person)):Destroy()
					end

					if LP.Character.HumanoidRootPart:FindFirstChild(tostring(person)) then
						LP.Character.HumanoidRootPart:FindFirstChild(tostring(person)):Destroy()
					end

					if game:GetService("Workspace"):FindFirstChild("Ovainum Tracer "..tostring(person)) then
						game:GetService("Workspace")["Ovainum Tracer "..tostring(person)]:Destroy()
					end

					local line  = Instance.new("Beam")
					local A0 = Instance.new("Attachment")
					local A1 = Instance.new("Attachment")

					A0.Parent = LP.Character.HumanoidRootPart
					A0.Name = tostring(person)
					A1.Parent = person.Character.HumanoidRootPart
					A1.Name = tostring(person)

					line.Name = "Ovainum Tracer "..tostring(person)
					line.Parent = game:GetService("Workspace")
					line.Attachment0 = A0
					line.Attachment1 = A1
					line.Width0 = 0.5
					line.Width1 = 0.5
					line.FaceCamera = true
					print("Added Tracer to "..tostring(person))
				end
			end
		end
	else
		if target ~= LP.Name and target ~= "n i l" and players:FindFirstChild(target) and players[target].Character:FindFirstChild("HumanoidRootPart") then
			if players[target].Character.HumanoidRootPart:FindFirstChild(target) and LP.Character.HumanoidRootPart:FindFirstChild(target) and game:GetService("Workspace"):FindFirstChild("Ovainum Tracer "..target) then
				print(target.." already has a tracer")
			else
				if players[target].Character.HumanoidRootPart:FindFirstChild(tostring(target)) then
					players[target].Character.HumanoidRootPart:FindFirstChild(tostring(target)):Destroy()
				end

				if LP.Character.HumanoidRootPart:FindFirstChild(tostring(target)) then
					LP.Character.HumanoidRootPart:FindFirstChild(tostring(target)):Destroy()
				end

				if game:GetService("Workspace"):FindFirstChild("Ovainum Tracer "..target) then
					game:GetService("Workspace")["Ovainum Tracer "..target]:Destroy()
				end

				local line  = Instance.new("Beam")
				local A0 = Instance.new("Attachment")
				local A1 = Instance.new("Attachment")

				A0.Parent = LP.Character.HumanoidRootPart
				A0.Name = target
				A1.Parent = players[target].Character.HumanoidRootPart
				A1.Name = target

				line.Name = "Ovainum Tracer "..target
				line.Parent = game:GetService("Workspace")
				line.Attachment0 = A0
				line.Attachment1 = A1
				line.Width0 = 0.5
				line.Width1 = 0.5
				line.FaceCamera = true
				print("Added Tracer to "..target)
			end
		end
	end
end

function Ovainum:RTX()
	game:GetService("Workspace").GlobalWind = Vector3.new(-15.3, 27, 25.6)

	terrain.WaterTransparency = 0.5

	lighting.ShadowSoftness = 0.05
	lighting.GlobalShadows = true

	for _, child in lighting:GetChildren() do
		if child:IsA("ColorCorrectionEffect") then
			child:Destroy()
		elseif child:IsA("BloomEffect") then
			child:Destroy()
		elseif child:IsA("SunRaysEffect") then
			child:Destroy()
		elseif child:IsA("DepthOfFieldEffect") then
			child:Destroy()
		elseif child:IsA("Sky") then
			child:Destroy()
		elseif child:IsA("Atmosphere") then
			child:Destroy()
		end
	end

	for _, child in terrain:GetChildren() do
		if child:IsA("Clouds") then
			child:Destroy()
		end
	end

	local Clouds = Instance.new("Clouds")
	local CC = Instance.new("ColorCorrectionEffect")
	local SR = Instance.new("SunRaysEffect")
	local Bloom = Instance.new("BloomEffect")
	local DOF = Instance.new("DepthOfFieldEffect")
	local Sky = Instance.new("Sky")
	local ATM = Instance.new("Atmosphere")

	Clouds.Parent = terrain
	Clouds.Cover = 0.6
	Clouds.Density = 1
	Clouds.Color = Color3.fromRGB(200, 200, 200)
	Clouds.Name = "CloudsOvainum"

	CC.Parent = lighting
	CC.Brightness = 0.03
	CC.Contrast = 0.04
	CC.Saturation = 0.5
	CC.TintColor = Color3.fromRGB(255, 255, 255)
	CC.Name = "ColorCorrectionOvainum"

	SR.Parent = lighting
	SR.Intensity = 0.08
	SR.Spread = 1
	SR.Name = "SunRayOvainum"

	Bloom.Parent = lighting
	Bloom.Intensity = 0.7
	Bloom.Size = 56
	Bloom.Threshold = 3.264
	Bloom.Name = "BloomOvainum"

	DOF.Parent = lighting
	DOF.FarIntensity = 0.22
	DOF.FocusDistance = 0
	DOF.InFocusRadius = 30
	DOF.NearIntensity = 0
	DOF.Name = "DepthOfFieldOvainum"

	Sky.Parent = lighting
	Sky.CelestialBodiesShown = true
	Sky.MoonAngularSize = 10
	Sky.MoonTextureId = "rbxasset://sky/moon.jpg"
	Sky.SkyboxBk = "rbxasset://textures/sky/sky512_bk.tex"
	Sky.SkyboxDn = "rbxasset://textures/sky/sky512_dn.tex"
	Sky.SkyboxFt = "rbxasset://textures/sky/sky512_ft.tex"
	Sky.SkyboxLf = "rbxasset://textures/sky/sky512_lf.tex"
	Sky.SkyboxRt = "rbxasset://textures/sky/sky512_rt.tex"
	Sky.SkyboxUp = "rbxasset://textures/sky/sky512_up.tex"
	Sky.StarCount = 5000
	Sky.SunAngularSize = 10
	Sky.SunTextureId = "rbxasset://sky/sun.jpg"
	Sky.Name = "SkyBoxOvainum"

	ATM.Parent = lighting
	ATM.Density = 0.22
	ATM.Offset = 0
	ATM.Color = Color3.fromRGB(199, 170, 107)
	ATM.Decay = Color3.fromRGB(92, 60, 13)
	ATM.Glare = 10
	ATM.Haze = 0
	ATM.Name = "AtmosphereOvainum"
end

function Ovainum:SayChildren(parent)
	warn('ClassName : Name')

	for _,child in parent:GetChildren() do
		if game.Players:FindFirstChild(child.Name) then
			print('Player-Character : '..child.Name)
		else
			print(child.ClassName..' : '..child.Name)
		end
	end
end

function Ovainum:TeamCheck(plr)
	if plr.Team ~= nil then
		if plr.Team ~= LP.Team then
			return 'Enemy'
		end
		if plr.Team == LP.Team then
			return 'Teammate'
		end
	elseif plr.Team == nil then
		return 'No Team'
	end
end

function Ovainum:skybox(up, down, front, left, back, right)
	if lighting:FindFirstChild("Ovainum Skybox") then
		lighting:FindFirstChild("Ovainum Skybox"):Destroy()
	end

	local skybox = Instance.new("Sky")

	skybox.Parent = lighting
	skybox.Name = "Ovainum Skybox"
	skybox.SkyboxBk = "http://www.roblox.com/asset/?id="..tonumber(back)
	skybox.SkyboxFt = "http://www.roblox.com/asset/?id="..tonumber(front)
	skybox.SkyboxLf = "http://www.roblox.com/asset/?id="..tonumber(left)
	skybox.SkyboxDn = "http://www.roblox.com/asset/?id="..tonumber(down)
	skybox.SkyboxRt = "http://www.roblox.com/asset/?id="..tonumber(right)
	skybox.SkyboxUp = "http://www.roblox.com/asset/?id="..tonumber(up)
end

function Ovainum:notify(par1, par2, par3)
	startergui:SetCore("SendNotification", {
		Title = par1,
		Text = par2,
		Duration = par3
	})
end

function Ovainum:BetterNotify(TitleText, SubText, WaitTime)
	spawn(function()
		local function MakeNoti(parent)
			local Container = Instance.new("Frame")
			local TitleLabel = Instance.new("TextLabel")
			local SubLabel = Instance.new("TextLabel")
			local CornerUI = Instance.new("UICorner")

			Container.Name = "Notification"
			Container.Parent = parent
			Container.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			Container.BorderSizePixel = 0

			TitleLabel.Parent = Container
			TitleLabel.Name = "Title"
			TitleLabel.Text = TitleText
			TitleLabel.Position = UDim2.new(0.05, 0, 0.05, 0)
			TitleLabel.Size = UDim2.new(0.9, 0, 0.35, 0)
			TitleLabel.RichText = true
			TitleLabel.TextScaled = true
			TitleLabel.BackgroundTransparency = 1
			TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TitleLabel.BorderSizePixel = 0
			TitleLabel.Font = Enum.Font.Arial

			SubLabel.Parent = Container
			SubLabel.Name = "Message"
			SubLabel.Text = SubText
			SubLabel.Position = UDim2.new(0.04, 0, 0.45, 0)
			SubLabel.Size = UDim2.new(0.92, 0, 0.5, 0)
			SubLabel.RichText = true
			SubLabel.TextScaled = true
			SubLabel.BackgroundTransparency = 1
			SubLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			SubLabel.BorderSizePixel = 0
			SubLabel.Font = Enum.Font.Arial

			CornerUI.CornerRadius = UDim.new(0.3, 0)
			CornerUI.Parent = Container

			wait(WaitTime)

			local int = 0

			for _, thing in parent:GetChildren() do
				if thing.Name == "Notification" then
					int += 1
				end
			end

			int -= 1

			if int > 2 then
				parent.CanvasSize = UDim2.new(0, 0, 0.2 * (int / 2))
				parent.Layout.CellSize = UDim2.new(1, 0, 1 / int, 0)
			else
				parent.CanvasSize = UDim2.new(0, 0, 0.2, 0)
				parent.Layout.CellSize = UDim2.new(1, 0, 0.5, 0)
			end

			if int == 0 then
				parent.Parent:Destroy()
			end

			Container:Destroy()
		end

		if not CoreGui:FindFirstChild("Ovainum Noti UI") then
			local Main = Instance.new("ScreenGui")
			local Main_Frame = Instance.new("ScrollingFrame")
			local Layout = Instance.new("UIGridLayout")

			Main.Name = "Ovainum Noti UI"
			Main.Parent = CoreGui
			Main.IgnoreGuiInset = true
			Main.DisplayOrder = 1999999999

			Main_Frame.Name = "Main_Frame"
			Main_Frame.Parent = Main
			Main_Frame.BackgroundTransparency = 1
			Main_Frame.BorderSizePixel = 0
			Main_Frame.Position = UDim2.new(0.3, 0, 0.1, 0)
			Main_Frame.Size = UDim2.new(0.4, 0, 0.2, 0)
			Main_Frame.CanvasSize = UDim2.new(0, 0, 0.2, 0)
			Main_Frame.ScrollBarThickness = 0
			Main_Frame.ScrollingDirection = Enum.ScrollingDirection.Y

			Layout.Parent = Main_Frame
			Layout.Name = "Layout"
			Layout.FillDirection = Enum.FillDirection.Vertical
			Layout.SortOrder = Enum.SortOrder.LayoutOrder
			Layout.CellSize = UDim2.new(1, 0, 0.5, 0)
			Layout.CellPadding = UDim2.new(0, 0, 0, 0)

			MakeNoti(Main_Frame)
		else
			MakeNoti(CoreGui["Ovainum Noti UI"].Main_Frame)
		end
	end)
end

function Ovainum:GetName(person, TYPE)
	local lower = string.lower

	if TYPE == "id" then
		for _, plr in players:GetPlayers() do
			if plr.UserId == person then
				return plr.Name
			end
		end
	else
		for _, plr in players:GetPlayers() do
			if lower(plr.Name) == lower(person) or lower(plr.DisplayName) == lower(person) then
				return plr.Name
			end
		end
	end

	return "n i l"
end

function Ovainum:ShowNames()
	for _, plr in players:GetPlayers() do
		if plr.Character:FindFirstChild("Humanoid") then
			plr.Character.Humanoid.DisplayName = plr.Name
			plr.Character.Humanoid.NameDisplayDistance = 100
			plr.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
		end
	end
end

function Ovainum:ViewPlayer(PlayerName)
	camara.CameraSubject = players[PlayerName].Character
end

function Ovainum:NewGUI(name, parent)
	if parent:FindFirstChild(name) then
		parent[name]:Destroy()
	end

	local Main = Instance.new("ScreenGui")

	Main.Name = name
	Main.Parent = parent
	Main.IgnoreGuiInset = true

	return Main
end

function Ovainum:NewMainFrame(title, parent, name)
	--Main
	local Main_Frame = Instance.new("Frame")
	local Main_Frame_Corner = Instance.new("UICorner")
	local Title = Instance.new("TextLabel")
	local Min = Instance.new("TextButton")
	local Scroll_Frame = Instance.new("ScrollingFrame")
	local Layout = Instance.new("UIGridLayout")

	--Fake Main
	local Main_Frame_F = Instance.new("Frame")
	local Main_Frame_Corner_F = Instance.new("UICorner")
	local Title_F = Instance.new("TextLabel")
	local Max_F = Instance.new("TextButton")

	Main_Frame_F.Name = "Main Frame F"
	Main_Frame_F.Parent = parent
	Main_Frame_F.Size = UDim2.new(0.2, 0, 0.6/12, 0)
	Main_Frame_F.BorderSizePixel = 0
	Main_Frame_F.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Main_Frame_F.Active = true
	Main_Frame_F.Draggable = true

	Main_Frame_Corner_F.Name = "CornerUI"
	Main_Frame_Corner_F.CornerRadius = UDim.new(0.4, 0)
	Main_Frame_Corner_F.Parent = Main_Frame_F

	Title_F.Name = "Title"
	Title_F.Text = title
	Title_F.TextScaled = true
	Title_F.BackgroundTransparency = 1
	Title_F.Size = UDim2.new(0.9, 0, 1, 0)
	Title_F.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title_F.Parent = Main_Frame_F

	Max_F.Name = "Minimize Button"
	Max_F.Parent = Main_Frame_F
	Max_F.Position = UDim2.new(0.9, 0, 0, 0)
	Max_F.Size = UDim2.new(0.1, 0, 1, 0)
	Max_F.Text = "+"
	Max_F.TextScaled = true
	Max_F.BackgroundTransparency = 1
	Max_F.TextColor3 = Color3.fromRGB(100, 255, 100)
	Max_F.MouseButton1Click:Connect(function()
		Main_Frame.Position = Main_Frame_F.Position
		Main_Frame.Visible = true
		Main_Frame_F.Visible = false
	end)

	Main_Frame_F.Visible = false

	--Main
	Main_Frame.Name = "Main Frame"
	Main_Frame.Parent = parent
	Main_Frame.Position = UDim2.new(0.4, 0, 0.2, 0)
	Main_Frame.Size = UDim2.new(0.2, 0, 0.6, 0)
	Main_Frame.BorderSizePixel = 0
	Main_Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Main_Frame.Active = true
	Main_Frame.Draggable = true

	Main_Frame_Corner.Name = "CornerUI"
	Main_Frame_Corner.CornerRadius = UDim.new(0.05, 0)
	Main_Frame_Corner.Parent = Main_Frame

	Title.Name = "Title"
	Title.Text = title
	Title.TextScaled = true
	Title.BackgroundTransparency = 1
	Title.Size = UDim2.new(0.9, 0, 1/12, 0)
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.Parent = Main_Frame


	Min.Name = "Minimize Button"
	Min.Parent = Main_Frame
	Min.Position = UDim2.new(0.9, 0, 0, 0)
	Min.Size = UDim2.new(0.1, 0, 1/12, 0)
	Min.Text = "-"
	Min.TextScaled = true
	Min.BackgroundTransparency = 1
	Min.TextColor3 = Color3.fromRGB(255, 100, 100)
	Min.MouseButton1Click:Connect(function()
		Main_Frame_F.Position = Main_Frame.Position
		Main_Frame.Visible = false
		Main_Frame_F.Visible = true
	end)

	Scroll_Frame.Name = "ScrollFrame"
	Scroll_Frame.Parent = Main_Frame
	Scroll_Frame.BackgroundTransparency = 1
	Scroll_Frame.Size = UDim2.new(1, 0, 21 / 24, 0)
	Scroll_Frame.Position = UDim2.new(0, 0, 1 / 12, 0)
	Scroll_Frame.ScrollingDirection = Enum.ScrollingDirection.Y
	Scroll_Frame.CanvasSize = UDim2.new(0, 0, 1 / 12, 0)
	Scroll_Frame.ScrollBarThickness = 5

	Layout.Parent = Scroll_Frame
	Layout.Name = "Layout"
	Layout.SortOrder = Enum.SortOrder.LayoutOrder
	Layout.CellSize = UDim2.new(1, 0, 1 / 12, 0)
	Layout.CellPadding = UDim2.new(0, 0, 0, 0)

	if name ~= nil then
		Main_Frame.Name = name
		Main_Frame_F.Name = name.." F"
	end

	return Main_Frame
end

function Ovainum:MakeButton(name, text, parent)
	--Scale Correction
	local Child_Instances = 0

	for _, UI_Instance in parent:GetChildren() do
		Child_Instances += 1
	end

	if Child_Instances > 12 then
		parent.CanvasSize = UDim2.new(0, 0, 0.875 * (Child_Instances / 12), 0)
		parent.Layout.CellSize = UDim2.new(1, 0, 1 / Child_Instances, 0)
	else
		parent.CanvasSize = UDim2.new(0, 0, 1 / 12, 0)
		parent.Layout.CellSize = UDim2.new(1, 0, 1 / 12, 0)
	end

	--Variables
	local ButtonFrame = Instance.new("Frame")
	local Button = Instance.new("TextButton")
	local Round = Instance.new("UICorner")


	ButtonFrame.Name = name
	ButtonFrame.Parent = parent
	ButtonFrame.Size = UDim2.new(1, 0, 1/12, 0)
	ButtonFrame.BackgroundTransparency = 1

	Button.Parent = ButtonFrame
	Button.Size = UDim2.new(0.9, 0, 0.8, 0)
	Button.Position = UDim2.new(0.05, 0, 0.1, 0)
	Button.BackgroundTransparency = 0
	Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Button.TextColor3 = Color3.fromRGB(255, 255, 255)
	Button.TextScaled = true
	Button.Text = text

	Round.CornerRadius = UDim.new(0.5, 0)
	Round.Parent = Button

	return Button
end

function Ovainum:MakeToggle(name, text, parent, premadeBV)
	--Scale Correction
	local Child_Instances = 0

	for _, UI_Instance in parent:GetChildren() do
		Child_Instances += 1
	end

	if Child_Instances > 12 then
		parent.CanvasSize = UDim2.new(0, 0, 0.875 * (Child_Instances / 12), 0)
		parent.Layout.CellSize = UDim2.new(1, 0, 1 / Child_Instances, 0)
	else
		parent.CanvasSize = UDim2.new(0, 0, 1 / 12, 0)
		parent.Layout.CellSize = UDim2.new(1, 0, 1 / 12, 0)
	end

	--Variables
	local ToggleFrame = Instance.new("Frame")
	local Label = Instance.new("TextLabel")
	local Round = Instance.new("UICorner")
	local Toggle = Instance.new("TextButton")
	local RoundToggle = Instance.new("UICorner")
	local Bool = Instance.new("BoolValue")
	local ratio = Instance.new("UIAspectRatioConstraint")

	ToggleFrame.Name = name
	ToggleFrame.Parent = parent
	ToggleFrame.Size = UDim2.new(1, 0, 1 / 12, 0)
	ToggleFrame.BackgroundTransparency = 1

	Label.Parent = ToggleFrame
	Label.Size = UDim2.new(0.82, 0, 0.8, 0)
	Label.Position = UDim2.new(0.05, 0, 0.1, 0)
	Label.BackgroundTransparency = 0
	Label.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label.TextScaled = true
	Label.Text = text

	Round.CornerRadius = UDim.new(0.5, 0)
	Round.Parent = Label

	Toggle.Name = "Toggle"
	Toggle.Parent = ToggleFrame
	Toggle.Size = UDim2.new(0.1, 0, 0.8, 0)
	Toggle.Position = UDim2.new(0.9, 0, 0.1, 0)
	Toggle.BackgroundTransparency = 0
	Toggle.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
	Toggle.Text = ""

	RoundToggle.CornerRadius = UDim.new(0.25, 0)
	RoundToggle.Parent = Toggle

	ratio.Parent = Toggle
	ratio.AspectRatio = 1

	Bool.Name = "Bool"
	if premadeBV ~= nil then
		Bool.Value = premadeBV
		if Bool.Value == true then
			Toggle.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
		elseif Bool.Value == false then
			Toggle.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
		end
	elseif premadeBV == nil then
		Bool.Value = false
	end
	Bool.Parent = ToggleFrame

	Toggle.MouseButton1Click:Connect(function()
		Bool.Value = not Bool.Value
		if Bool.Value == true then
			Toggle.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
		elseif Bool.Value == false then
			Toggle.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
		end
	end)

	return Bool
end

function Ovainum:MakeDisplay(name, text, parent)
	--Scale Correction
	local Child_Instances = 0

	for _, UI_Instance in parent:GetChildren() do
		Child_Instances += 1
	end

	if Child_Instances > 12 then
		parent.CanvasSize = UDim2.new(0, 0, 0.875 * (Child_Instances / 12), 0)
		parent.Layout.CellSize = UDim2.new(1, 0, 1 / Child_Instances, 0)
	else
		parent.CanvasSize = UDim2.new(0, 0, 1 / 12, 0)
		parent.Layout.CellSize = UDim2.new(1, 0, 1 / 12, 0)
	end

	--Variables
	local DisplayFrame = Instance.new("Frame")
	local Display = Instance.new("TextLabel")
	local Round = Instance.new("UICorner")

	DisplayFrame.Name = name
	DisplayFrame.Parent = parent
	DisplayFrame.Size = UDim2.new(1, 0, 1/12, 0)
	DisplayFrame.BackgroundTransparency = 1

	Display.Parent = DisplayFrame
	Display.Size = UDim2.new(0.9, 0, 0.8, 0)
	Display.Position = UDim2.new(0.05, 0, 0.1, 0)
	Display.BackgroundTransparency = 0
	Display.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Display.TextColor3 = Color3.fromRGB(255, 255, 255)
	Display.TextScaled = true
	Display.Text = text

	Round.CornerRadius = UDim.new(0.5, 0)
	Round.Parent = Display

	return Display
end

function Ovainum:MakeTextbox(name, text, idleText, parent)
	--Scale Correction
	local Child_Instances = 0

	for _, UI_Instance in parent:GetChildren() do
		Child_Instances += 1
	end

	if Child_Instances > 12 then
		parent.CanvasSize = UDim2.new(0, 0, 0.875 * (Child_Instances / 12), 0)
		parent.Layout.CellSize = UDim2.new(1, 0, 1 / Child_Instances, 0)
	else
		parent.CanvasSize = UDim2.new(0, 0, 1 / 12, 0)
		parent.Layout.CellSize = UDim2.new(1, 0, 1 / 12, 0)
	end

	--Variables
	local TextBoxFrame = Instance.new("Frame")
	local TextBox = Instance.new("TextBox")
	local Round = Instance.new("UICorner")

	TextBoxFrame.Name = name
	TextBoxFrame.Parent = parent
	TextBoxFrame.Size = UDim2.new(1, 0, 1/12, 0)
	TextBoxFrame.BackgroundTransparency = 1

	TextBox.Parent = TextBoxFrame
	TextBox.Size = UDim2.new(0.9, 0, 0.8, 0)
	TextBox.Position = UDim2.new(0.05, 0, 0.1, 0)
	TextBox.BackgroundTransparency = 0
	TextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextBox.TextScaled = true
	TextBox.Text = text
	TextBox.PlaceholderText = idleText

	Round.CornerRadius = UDim.new(0.5, 0)
	Round.Parent = TextBox

	return TextBox
end

function Ovainum:MakeInteract(name, title, parent, btnText, PreText)
	local main = Instance.new("ScreenGui")
	local Main_Frame = Instance.new("Frame")
	local Title_Label = Instance.new("TextLabel")
	local TextBox = Instance.new("TextBox")
	local Button = Instance.new("TextButton")
	local close = Instance.new("TextButton")

	main.Name = name
	main.Parent = parent
	main.IgnoreGuiInset = true

	Main_Frame.Name = "Main Frame"
	Main_Frame.Parent = main
	Main_Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Main_Frame.BorderSizePixel = 0
	Main_Frame.Size = UDim2.new(0.2, 0, 0.4 , 0)
	Main_Frame.Position = UDim2.new(0.4, 0, 0.3, 0)

	Title_Label.Parent = Main_Frame
	Title_Label.Name = "Title"
	Title_Label.Text = title
	Title_Label.Position = UDim2.new(0, 0, 0, 0)
	Title_Label.Size = UDim2.new(0.8, 0, 0.2, 0)
	Title_Label.TextScaled = true
	Title_Label.BorderSizePixel = 0
	Title_Label.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Title_Label.TextColor3 = Color3.fromRGB(255, 255, 255)

	TextBox.Name = "Input Box"
	TextBox.Parent = Main_Frame
	TextBox.Text = ""
	TextBox.PlaceholderText = PreText
	TextBox.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
	TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextBox.TextScaled = true
	TextBox.Size = UDim2.new(0.8, 0, 0.2, 0)
	TextBox.Position = UDim2.new(0.1, 0, 0.4)
	TextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	TextBox.BorderSizePixel = 0

	Button.BackgroundColor3 = Color3.fromRGB(0, 255, 90)
	Button.Name = "Button"
	Button.BorderSizePixel = 0
	Button.Text = btnText
	Button.Parent = Main_Frame
	Button.Size = UDim2.new(0.4, 0, 0.1, 0)
	Button.Position = UDim2.new(0.3, 0, 0.8, 0)
	Button.TextScaled = true

	close.Parent = Main_Frame
	close.Name = "Close Button"
	close.Position = UDim2.new(0.8, 0, 0, 0)
	close.Size = UDim2.new(0.2, 0, 0.2, 0)
	close.TextScaled = true
	close.TextColor3 = Color3.fromRGB(255, 100, 100)
	close.Text = "X"
	close.BorderSizePixel = 0
	close.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	close.MouseButton1Click:Connect(function()
		main:Destroy()
	end)

	return {Main_Frame, TextBox, Button}
end

function Ovainum:GoToCoords(element, x, y, g_time)
	spawn(function()
		local o_x = element.Position.X.Scale
		local o_y = element.Position.Y.Scale

		local delta_x = math.round((x - o_x) * 1000) / 1000
		local delta_y = math.round((y - o_y) * 1000) / 1000

		local subdivisions = g_time * 50

		local iteration = 0

		while wait(g_time/subdivisions) do
			iteration += 1
			if iteration > subdivisions then
				break
			end
			element.Position = UDim2.new(o_x + ((iteration * delta_x)/subdivisions), 0, o_y + ((iteration * delta_y)/subdivisions), 0)
		end
	end)
end

function Ovainum:SetRotationTo(model, x, y, z)
	model:PivotTo(CFrame.new(model:GetPivot().Position.X, model:GetPivot().Position.Y, model:GetPivot().Position.Z) * CFrame.Angles(x, y, z))
end

function Ovainum:GetNearbyPlayers(plr, radius)
	local T_players = {}
	local Plr_Char
	local cout = 0

	if plr.Character ~= nil then
		Plr_Char = plr.Character
	else
		return {false}
	end

	for _, model in E_workspace:GetDescendants() do
		if model:IsA("Model") and players:GetPlayerFromCharacter(model) ~= nil and players:GetPlayerFromCharacter(model) ~= plr and Ovainum:GetDistanceBetween(Plr_Char, model) <= radius then
			table.insert(T_players, players:GetPlayerFromCharacter(model))
			cout += 1
		end 
	end

	return {cout, T_players}
end

function Ovainum:GetDistanceBetween(Thing1, Thing2)
	local dx = Thing2:GetPivot().Position.X - Thing1:GetPivot().Position.X
	local dy = Thing2:GetPivot().Position.Y - Thing1:GetPivot().Position.Y
	local dz = Thing2:GetPivot().Position.Z - Thing1:GetPivot().Position.Z

	local dxy = math.sqrt(math.pow(dx, 2) + math.pow(dy, 2))
	return math.sqrt(math.pow(dxy, 2) + math.pow(dz, 2))
end

function Ovainum:FixMessage(text)
	local FixedMessage
	local int = 0
	local int2 = 0
	for _, chunck in string.split(text, "<") do
		int += 1
		if int == 2 then
			for _, complex in string.split(chunck, ">") do
				int2 += 1
				if int2 == 2 then
					FixedMessage = complex
				end
			end
		end
	end

	return FixedMessage
end

function Ovainum:GetMaxIterations(tbl)
	local iter = 0
	for _, v in tbl do
		iter += 1
	end
	return iter
end

function Ovainum:TableToString(tbl, level)
	local Completed_String = "{"
	local iteration = 0

	for i, v in tbl do
		iteration += 1

		if type(i) == "number" then
			Completed_String = Completed_String.."["..tostring(i).."] = "
		elseif type(i) == "string" then
			Completed_String = Completed_String..'["'..tostring(i)..'"] = '
		end

		if type(v) == "number" then
			Completed_String = Completed_String..tostring(v)
		elseif type(v) == "string" then
			Completed_String = Completed_String..'"'..tostring(v)..'"'
		elseif type(v) == "table" then
			Completed_String = Completed_String..Ovainum:TableToString(v, 2)
		elseif typeof(v) == "Vector2" then
			Completed_String = Completed_String.."Vector2.new("..tostring(v.X)..", "..tostring(v.Y)..")"
		elseif typeof(v) == "Vector3" then
			Completed_String = Completed_String.."Vector3.new("..tostring(v.X)..", "..tostring(v.Y)..", "..tostring(v.Z)..")"
		end

		if iteration ~= Ovainum:GetMaxIterations(tbl) then
			Completed_String = Completed_String..", "
		end
	end

	Completed_String = Completed_String.."}"

	if level == 1 then
		return "return "..Completed_String
	elseif level == 2 then
		return Completed_String
	end
end

function Ovainum:SavePlayers()
	local Movement = {}

	for _, plr in players:GetPlayers() do
		local T_plr = {["UserId"] = plr.UserId}


		for _, part in plr.Character:GetChildren() do
			if part:IsA("BasePart") then
				table.insert(T_plr, {["Name"] = part.Name, ["Pos"] = part.Position, ["Rot"] = part.Rotation, ["Size"] = part.Size})
			end
		end

		table.insert(Movement, T_plr)
	end

	return Movement
end

function Ovainum:LoadPlayers(tbl)
	local Ovainum_Re
	if game:GetService("Workspace"):FindFirstChild("Ovainum_Re") then
		Ovainum_Re = game:GetService("Workspace").Ovainum_Re
	else
		Ovainum_Re = Instance.new("Folder", workspace)
	end

	Ovainum_Re.Name = "Ovainum_Re"

	for _, plr in tbl do
		for i, part in plr do
			if i ~= "UserId" then
				local brick = Instance.new("Part", game:GetService("Workspace").Ovainum_Re)

				brick.Anchored = true

				for e, property in part do
					if e == "Name" then
						brick.Name = property
						if property == "HumanoidRootPart" then
							brick:Destroy()
							break
						elseif property == "Head" then
							local b = Instance.new("BillboardGui", brick)
							local TL = Instance.new("TextLabel", b)

							b.StudsOffset = Vector3.new(0, 1, 0)
							b.Size = UDim2.new(4, 0, 1, 0)

							TL.Size = UDim2.new(1, 0, 1, 0)
							TL.BackgroundTransparency = 1
							TL.Text = "@"..players:GetNameFromUserIdAsync(plr["UserId"])
							TL.TextColor3 = Color3.fromRGB(255, 255, 255)
						end
					elseif e == "Pos" then
						brick.Position = property
					elseif e == "Rot" then
						brick.Rotation = property
					elseif e == "Size" then
						brick.Size = property
					end
				end
			end
		end		
	end
end

function Ovainum:ReAnimate(tbl)
	local iteration = 0

	while wait(0.5) do
		if game:GetService("Workspace"):FindFirstChild("Ovainum_Re") then
			for _, e in game:GetService("Workspace").Ovainum_Re:GetChildren() do
				e:Destroy()
			end
		end

		if iteration ~= Ovainum:GetMaxIterations(tbl) then
			iteration += 1
			Ovainum:LoadPlayers(tbl[iteration])
		else
			break
		end
	end

	print("Exited")
end

function Ovainum:FE_PartMove(ToBeMoved : BasePart, strength : IntValue)
	local PartToFollow = Instance.new("Part", E_workspace)
	local A1 = Instance.new("Attachment", ToBeMoved)
	local A2 = Instance.new("Attachment", PartToFollow)
	local Ori_Align = Instance.new("AlignOrientation", ToBeMoved)
	local Pos_Align = Instance.new("AlignPosition", ToBeMoved)

	Ori_Align.Attachment0 = A1
	Ori_Align.Attachment1 = A2
	Ori_Align.Responsiveness = strength

	Pos_Align.Attachment0 = A1
	Pos_Align.Attachment1 = A2
	Pos_Align.Responsiveness = strength

	PartToFollow.CanCollide = false
	PartToFollow.Anchored = true
	PartToFollow.Size = Vector3.new(1, 1, 1)
	PartToFollow.Transparency = 1

	return {PartToFollow, A1, A2, Ori_Align, Pos_Align}
end

return Ovainum
