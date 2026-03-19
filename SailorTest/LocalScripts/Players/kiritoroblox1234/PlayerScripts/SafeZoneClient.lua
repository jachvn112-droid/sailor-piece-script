local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = v1.LocalPlayer:WaitForChild("PlayerGui")
v2:WaitForChild("RemoteEvents"):WaitForChild("SafeZoneEvent").OnClientEvent:Connect(function(p4, _)
	-- upvalues: (copy) v_u_3
	if p4 == "Entered" or p4 == "Changed" then
		local v5 = v_u_3:FindFirstChild("SafeZoneUI")
		local v6
		if v5 then
			v6 = v5:FindFirstChild("SafeZoneNotif")
		else
			v5 = nil
			v6 = nil
		end
		if v5 then
			if v6 then
				v5.Enabled = true
				v6.Visible = true
			end
		end
	elseif p4 == "Left" then
		local v7 = v_u_3:FindFirstChild("SafeZoneUI")
		local v8
		if v7 then
			v8 = v7:FindFirstChild("SafeZoneNotif")
		else
			v7 = nil
			v8 = nil
		end
		if v7 then
			if not v8 then
				return
			end
			v8.Visible = false
		end
	end
end)
local v9 = v_u_3:FindFirstChild("SafeZoneUI")
local v10
if v9 then
	v10 = v9:FindFirstChild("SafeZoneNotif")
else
	v10 = nil
end
if v10 then
	v10.Visible = false
end