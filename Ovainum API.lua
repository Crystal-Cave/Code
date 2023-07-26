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
		return false
	end
	
	for _, model in E_workspace:GetDescendants() do
		if model:IsA("Model") and players:GetPlayerFromCharacter(model) ~= nil and players:GetPlayerFromCharacter(model) ~= plr and Ovainum:IsInRadiusOf(Plr_Char, model, radius) == true then
			table.insert(T_players, players:GetPlayerFromCharacter(model))
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

return Ovainum
