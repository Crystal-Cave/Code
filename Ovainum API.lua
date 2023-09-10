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
				Completed_String = Completed_String.."Vector2.new("..tostring(math.round(v.X))..", "..tostring(math.round(v.Y)).."), "
			elseif typeof(v) == "Vector3" then
				Completed_String = Completed_String.."Vector3.new("..tostring(math.round(v.X))..", "..tostring(math.round(v.Y))..", "..tostring(math.round(v.Z)).."), "
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
				Completed_String = Completed_String.."Vector2.new("..tostring(math.round(v.X))..", "..tostring(math.round(v.Y))..")}"
			elseif typeof(v) == "Vector3" then
				Completed_String = Completed_String.."Vector3.new("..tostring(math.round(v.X))..", "..tostring(math.round(v.Y))..", "..tostring(math.round(v.Z))..")}"
			end
		end
	end
	
	if level == 1 then
		return "return "..Completed_String
	elseif level == 2 then
		return Completed_String
	end
end
