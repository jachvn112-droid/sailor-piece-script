local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = v1.LocalPlayer
local v4 = v2:WaitForChild("Remotes")
local v5 = v4:WaitForChild("AdminEventConfirm")
local v_u_6 = v4:WaitForChild("AdminEventResponse")
local v_u_7 = require(v2:WaitForChild("Modules"):WaitForChild("AdminEventConfig"))
local v_u_8 = v3:WaitForChild("PlayerGui"):WaitForChild("AdminEventUI"):WaitForChild("ConfirmFrame")
local v_u_9 = v_u_8:WaitForChild("Description")
local v_u_10 = v_u_8:WaitForChild("Timer")
local v11 = v_u_8:WaitForChild("ConfirmButton")
local v12 = v_u_8:WaitForChild("CancelButton")
local v_u_13 = false
local v_u_14 = nil
v11.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_13, (copy) v_u_8, (ref) v_u_14, (copy) v_u_6
	if v_u_13 then
		v_u_13 = false
		v_u_8.Visible = false
		if v_u_14 then
			task.cancel(v_u_14)
			v_u_14 = nil
		end
		v_u_6:FireServer(true)
	end
end)
v12.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_13, (copy) v_u_8, (ref) v_u_14, (copy) v_u_6
	if v_u_13 then
		v_u_13 = false
		v_u_8.Visible = false
		if v_u_14 then
			task.cancel(v_u_14)
			v_u_14 = nil
		end
		v_u_6:FireServer(false)
	end
end)
v5.OnClientEvent:Connect(function(p15)
	-- upvalues: (ref) v_u_13, (copy) v_u_9, (copy) v_u_8, (copy) v_u_7, (copy) v_u_10, (ref) v_u_14, (copy) v_u_6
	if not v_u_13 then
		v_u_13 = true
		v_u_9.Text = p15.description or "Unknown event"
		v_u_8.Visible = true
		local v_u_16 = v_u_7.ConfirmTimeout
		v_u_10.Text = "Expires in " .. v_u_16 .. "s"
		v_u_14 = task.spawn(function()
			-- upvalues: (copy) v_u_16, (ref) v_u_13, (ref) v_u_10, (ref) v_u_8, (ref) v_u_14, (ref) v_u_6
			for v17 = v_u_16, 1, -1 do
				if not v_u_13 then
					return
				end
				v_u_10.Text = "Expires in " .. v17 .. "s"
				task.wait(1)
			end
			if v_u_13 then
				if not v_u_13 then
					return
				end
				v_u_13 = false
				v_u_8.Visible = false
				if v_u_14 then
					task.cancel(v_u_14)
					v_u_14 = nil
				end
				v_u_6:FireServer(false)
			end
		end)
	end
end)