local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TextChatService")
v1:WaitForChild("Remotes"):WaitForChild("ServerAnnouncement").OnClientEvent:Connect(function(p_u_3, p4)
	-- upvalues: (copy) v_u_2
	local v5 = {
		["BOSS_SPAWN"] = {
			["prefix"] = "#FF6B00",
			["text"] = "#FFD700"
		},
		["BOSS_DEATH"] = {
			["prefix"] = "#FF4444",
			["text"] = "#AAAAAA"
		},
		["INFO"] = {
			["prefix"] = "#00BFFF",
			["text"] = "#FFFFFF"
		}
	}
	local v6 = v5[p4 or "INFO"] or v5.INFO
	local v_u_7 = string.format("<font color=\"%s\"><b>\226\154\148\239\184\143 [SERVER]</b></font> <font color=\"%s\">%s</font>", v6.prefix, v6.text, p_u_3)
	local v8 = v_u_2:FindFirstChild("TextChannels")
	local v_u_9 = v8 and v8:FindFirstChild("RBXGeneral")
	if v_u_9 then
		pcall(function()
			-- upvalues: (copy) v_u_9, (copy) v_u_7
			v_u_9:DisplaySystemMessage(v_u_7)
		end)
	else
		pcall(function()
			-- upvalues: (copy) p_u_3
			game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
				["Text"] = p_u_3,
				["Color"] = Color3.fromRGB(255, 170, 0),
				["Font"] = Enum.Font.SourceSansBold
			})
		end)
	end
end)