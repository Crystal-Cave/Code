local Ovainum = {}

local E_workspace = game:GetService("Workspace")
local players = game:GetService("Players")

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
		if model:IsA("Model") and players:GetPlayerFromCharacter(model) ~= nil and players:GetPlayerFromCharacter(model) ~= plr and Ovainum:IsInRadiusOf(Plr_Char, model, radius) == true then
			table.insert(T_players, players:GetPlayerFromCharacter(model))
			cout += 1
		end 
	end

	return {cout, T_players}
end

function Ovainum:IsInRadiusOf(orgin, thing, radius)
	if (orgin:GetPivot().Position.X - radius <= thing:GetPivot().Position.X and thing:GetPivot().Position.X <= orgin:GetPivot().Position.X + radius) and (orgin:GetPivot().Position.Y - radius <= thing:GetPivot().Position.Y and thing:GetPivot().Position.Y <= orgin:GetPivot().Position.Y + radius) and (orgin:GetPivot().Position.Z - radius <= thing:GetPivot().Position.Z and thing:GetPivot().Position.Z <= orgin:GetPivot().Position.Z + radius) then
		return true
	else
		return false
	end
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
		if iteration ~= Ovainum:GetMaxIterations(tbl) then
			if type(i) == "number" then
				Completed_String = Completed_String.."["..tostring(i).."] = "
			elseif type(i) == "string" then
				Completed_String = Completed_String..'["'..tostring(i)..'"] = '
			end

			if type(v) == "number" then
				Completed_String = Completed_String..tostring(v)..", "
			elseif type(v) == "string" then
				Completed_String = Completed_String..'"'..tostring(v)..'", '
			elseif type(v) == "table" then
				Completed_String = Completed_String..Ovainum:TableToString(v, 2)..", "
			elseif typeof(v) == "Vector2" then
				Completed_String = Completed_String.."Vector2.new("..tostring(v.X)..", "..tostring(v.Y).."), "
			elseif typeof(v) == "Vector3" then
				Completed_String = Completed_String.."Vector3.new("..tostring(v.X)..", "..tostring(v.Y)..", "..tostring(v.Z).."), "
			end
		else
			if type(i) == "number" then
				Completed_String = Completed_String.."["..tostring(i).."] = "
			elseif type(i) == "string" then
				Completed_String = Completed_String..'["'..tostring(i)..'"] = '
			end

			if type(v) == "number" then
				Completed_String = Completed_String..tostring(v).."}"
			elseif type(v) == "string" then
				Completed_String = Completed_String..'"'..tostring(v)..'"}'
			elseif type(v) == "table" then
				Completed_String = Completed_String..Ovainum:TableToString(v, 2).."}"
			elseif typeof(v) == "Vector2" then
				Completed_String = Completed_String.."Vector2.new("..tostring(v.X)..", "..tostring(v.Y)..")}"
			elseif typeof(v) == "Vector3" then
				Completed_String = Completed_String.."Vector3.new("..tostring(v.X)..", "..tostring(v.Y)..", "..tostring(v.Z)..")}"
			end
		end
	end

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

return Ovainum
