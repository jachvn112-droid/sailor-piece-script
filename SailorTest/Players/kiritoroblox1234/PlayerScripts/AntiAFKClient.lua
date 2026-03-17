local v1 = game:GetService("Players")
local v2 = game:GetService("UserInputService")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("TeleportService")
local v_u_5 = v1.LocalPlayer
local v_u_6 = require(v3:WaitForChild("Modules"):WaitForChild("AntiAFKConfig"))
if require(v3:WaitForChild("PlaceConfig")).IsMainGame() then
	local v_u_7 = v3:WaitForChild("Remotes"):WaitForChild("AntiAFKHeartbeat")
	local v_u_8 = os.clock()
	local v_u_9 = v_u_5:GetAttribute("EnableAutoRejoin") == true
	task.spawn(function()
		-- upvalues: (copy) v_u_4, (copy) v_u_5
		local v10, v11 = pcall(function()
			-- upvalues: (ref) v_u_4
			return v_u_4:GetLocalPlayerTeleportData()
		end)
		if v10 and (v11 and (v11.antiAFKRejoin and v11.savedPos)) then
			local v12 = v11.savedPos
			local v13 = CFrame.new(v12.x, v12.y, v12.z) * CFrame.Angles(v12.rx, v12.ry, v12.rz)
			local v14 = (v_u_5.Character or v_u_5.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart", 10)
			if v14 then
				task.wait(0.5)
				v14.CFrame = v13
			end
		else
			return
		end
	end)
	v_u_5:GetAttributeChangedSignal("EnableAutoRejoin"):Connect(function()
		-- upvalues: (ref) v_u_9, (copy) v_u_5
		v_u_9 = v_u_5:GetAttribute("EnableAutoRejoin") == true
	end)
	local function v15()
		-- upvalues: (ref) v_u_8
		v_u_8 = os.clock()
	end
	v2.InputBegan:Connect(v15)
	v2.InputChanged:Connect(v15)
	v2.InputEnded:Connect(v15)
	task.spawn(function()
		-- upvalues: (copy) v_u_6, (ref) v_u_9, (ref) v_u_8, (copy) v_u_7
		while true do
			repeat
				task.wait(v_u_6.HEARTBEAT_INTERVAL)
			until v_u_9 and os.clock() - v_u_8 < v_u_6.HEARTBEAT_INTERVAL
			v_u_7:FireServer()
		end
	end)
end