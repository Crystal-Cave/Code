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
			end
		end
	end
	if level == 1 then
		return "return "..Completed_String
	elseif level == 2 then
		return Completed_String
	end
end

return Ovainum
