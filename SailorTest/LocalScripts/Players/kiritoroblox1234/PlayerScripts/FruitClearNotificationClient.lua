local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("StarterGui")
repeat
	task.wait()
until game:IsLoaded()
task.wait(1)
local v3 = v1:WaitForChild("RemoteEvents", 10)
if v3 then
	local v4 = v3:WaitForChild("FruitClearWarning", 10)
	if v4 then
		local function v_u_8(p_u_5, p_u_6, p_u_7)
			-- upvalues: (copy) v_u_2
			for _ = 1, 5 do
				if pcall(function()
					-- upvalues: (ref) v_u_2, (copy) p_u_5, (copy) p_u_6, (copy) p_u_7
					v_u_2:SetCore("SendNotification", {
						["Title"] = p_u_5,
						["Text"] = p_u_6,
						["Duration"] = p_u_7 or 5
					})
				end) then
					return true
				end
				task.wait(0.5)
			end
			return false
		end
		v4.OnClientEvent:Connect(function(p9, p10)
			-- upvalues: (copy) v_u_8
			local v11, v12
			if p9 <= 10 then
				v11 = "\240\159\154\168 FINAL WARNING"
				v12 = 5
			elseif p9 <= 30 then
				v11 = "\226\154\160\239\184\143 Cleanup Soon"
				v12 = 6
			else
				v11 = "\226\154\160\239\184\143 Fruit Cleanup"
				v12 = 8
			end
			local v13
			if p10 and p10 > 0 then
				v13 = p10 .. " dropped fruit(s) despawn in " .. p9 .. "s"
			else
				v13 = "Dropped fruits will despawn in " .. p9 .. "s"
			end
			local v14 = v_u_8
			local v15 = p9 - 1
			v14(v11, v13, (math.min(v15, v12)))
		end)
	end
else
	return
end