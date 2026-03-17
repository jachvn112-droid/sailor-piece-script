local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TextChatService")
v1:WaitForChild("Remotes"):WaitForChild("ServerAnnouncement").OnClientEvent:Connect(function(p_u_3, p4)
	-- upvalues: (copy) v_u_2
	local v5 = p4 or "INFO"
	local v6 = {
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
		},
		["ADMIN_ABUSE"] = {
			["prefix"] = "#FF0000",
			["text"] = "#FF4444"
		}
	}
	local v7 = v6[v5] or v6.INFO
	local v8 = v5 == "ADMIN_ABUSE" and "\240\159\148\165 [ADMIN ABUSE]" or "\226\154\148\239\184\143 [SERVER]"
	local v_u_9 = string.format("<font color=\"%s\"><b>%s</b></font> <font color=\"%s\">%s</font>", v7.prefix, v8, v7.text, p_u_3)
	local v10 = v_u_2:FindFirstChild("TextChannels")
	local v_u_11 = v10 and v10:FindFirstChild("RBXGeneral")
	if v_u_11 then
		pcall(function()
			-- upvalues: (copy) v_u_11, (copy) v_u_9
			v_u_11:DisplaySystemMessage(v_u_9)
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