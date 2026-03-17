local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v4 = v2:WaitForChild("Modules")
local v_u_5 = require(v4:WaitForChild("NotificationService"))
local v_u_6 = require(v4:WaitForChild("UIManager"))
task.spawn(function()
	-- upvalues: (copy) v_u_3, (copy) v_u_5
	if v_u_3:WaitForChild("NotificationUI", 10) then
		v_u_5:Init(v_u_3)
	end
end)
local v7 = v2:WaitForChild("Remotes")
local v_u_8 = v7:WaitForChild("ExchangeItem")
local v9 = v7:WaitForChild("OpenExchangeUI")
local v10 = v_u_3:WaitForChild("ExchangeUI"):WaitForChild("MainFrame")
local v11 = v10:WaitForChild("Frame")
local v12 = v11:WaitForChild("Content"):WaitForChild("Holder")
local v13 = v11:WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
local v14 = v12:FindFirstChild("SaberAbilityFrame")
if v14 then
	v14 = v14:FindFirstChild("Exchange")
end
local v15 = v12:FindFirstChild("QinShiAbilityFrame")
if v15 then
	v15 = v15:FindFirstChild("Exchange")
end
local v16 = v12:FindFirstChild("IchigoAbilityFrame")
if v16 then
	v16 = v16:FindFirstChild("Exchange")
end
v_u_6:Register("Exchange", v10)
local v_u_17 = {}
v9.OnClientEvent:Connect(function()
	-- upvalues: (copy) v_u_6
	v_u_6:Open("Exchange")
end)
v13.Activated:Connect(function()
	-- upvalues: (copy) v_u_17, (copy) v_u_6
	local v18 = v_u_17.CloseButton
	if not v18 or tick() - v18 >= 0.35 then
		v_u_17.CloseButton = tick()
		v_u_6:Close("Exchange")
	end
end)
if v14 then
	v14.Activated:Connect(function()
		-- upvalues: (copy) v_u_17, (copy) v_u_8, (copy) v_u_5
		local v19 = v_u_17.SaberExchange
		if v19 and tick() - v19 < 0.35 and true or false then
			return
		else
			v_u_17.SaberExchange = tick()
			local v20, v21, v22 = v_u_8:InvokeServer("Saber")
			if v20 then
				return
			elseif v21 == "already_owned" then
				v_u_5:Show("Quest", {
					["message"] = "You already have " .. (v22 or "this item") .. "!"
				})
			elseif v21 == "missing_items" then
				v_u_5:Show("Quest", {
					["message"] = "You need " .. (v22 or "more items") .. " to exchange!"
				})
			end
		end
	end)
end
if v15 then
	v15.Activated:Connect(function()
		-- upvalues: (copy) v_u_17, (copy) v_u_8, (copy) v_u_5
		local v23 = v_u_17.QinShiExchange
		if v23 and tick() - v23 < 0.35 and true or false then
			return
		else
			v_u_17.QinShiExchange = tick()
			local v24, v25, v26 = v_u_8:InvokeServer("Qin Shi")
			if v24 then
				return
			elseif v25 == "already_owned" then
				v_u_5:Show("Quest", {
					["message"] = "You already have " .. (v26 or "this item") .. "!"
				})
			elseif v25 == "missing_items" then
				v_u_5:Show("Quest", {
					["message"] = "You need " .. (v26 or "more items") .. " to exchange!"
				})
			end
		end
	end)
end
if v16 then
	v16.Activated:Connect(function()
		-- upvalues: (copy) v_u_17, (copy) v_u_8, (copy) v_u_5
		local v27 = v_u_17.IchigoExchange
		if v27 and tick() - v27 < 0.35 and true or false then
			return
		else
			v_u_17.IchigoExchange = tick()
			local v28, v29, v30 = v_u_8:InvokeServer("Ichigo")
			if v28 then
				return
			elseif v29 == "already_owned" then
				v_u_5:Show("Quest", {
					["message"] = "You already have " .. (v30 or "this item") .. "!"
				})
			elseif v29 == "missing_items" then
				v_u_5:Show("Quest", {
					["message"] = "You need " .. (v30 or "more items") .. " to exchange!"
				})
			end
		end
	end)
end