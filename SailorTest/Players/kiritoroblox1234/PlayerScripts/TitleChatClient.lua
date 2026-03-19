local v1 = game:GetService("Players")
local v2 = game:GetService("TextChatService")
local v3 = game:GetService("ReplicatedStorage")
local _ = v1.LocalPlayer
local v_u_4 = require(v3:WaitForChild("Modules"):WaitForChild("TitlesConfig"))
local v5 = v3:WaitForChild("RemoteEvents"):WaitForChild("TitleChatSync")
local v_u_6 = {}
v5.OnClientEvent:Connect(function(p7, p8, p9)
	-- upvalues: (ref) v_u_6
	if p7 == "init" then
		v_u_6 = p8 or {}
		return
	elseif p7 == "update" then
		v_u_6[p8] = p9
	elseif p7 == "remove" then
		v_u_6[p8] = nil
	end
end)
function v2.OnIncomingMessage(p10)
	-- upvalues: (ref) v_u_6, (copy) v_u_4
	local v11 = Instance.new("TextChatMessageProperties")
	local v12 = p10.TextSource
	if not v12 then
		return v11
	end
	local v13 = v_u_6[v12.UserId]
	if not v13 then
		return v11
	end
	local v14 = v_u_4:GetTitle(v13)
	if not v14 then
		return v11
	end
	local v15 = v_u_4:GetTitleColor(v13)
	local v16 = v15.R * 255
	local v17 = math.floor(v16)
	local v18 = v15.G * 255
	local v19 = math.floor(v18)
	local v20 = v15.B * 255
	local v21 = math.floor(v20)
	local v22 = string.format("#%02X%02X%02X", v17, v19, v21)
	v11.PrefixText = string.format("<font color=\"%s\">[%s]</font> ", v22, v14.displayName) .. p10.PrefixText
	return v11
end