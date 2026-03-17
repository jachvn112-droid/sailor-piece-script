local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
game:GetService("RunService")
local v_u_3 = require(v1:WaitForChild("VFXModule"))
local v4 = v1:WaitForChild("RemoteEvents"):WaitForChild("HitVFX")
local v5 = v1:WaitForChild("VFXAssets")
local v_u_6 = v2.LocalPlayer
v_u_3:InitializePool("HitEffect", (v5:WaitForChild("GetHitVFX")))
v4.OnClientEvent:Connect(function(p_u_7, p_u_8, p_u_9, p10)
	-- upvalues: (copy) v_u_6, (copy) v_u_3
	if v_u_6:GetAttribute("DisableVFX") == true then
		return
	elseif not p10 or (p10 == v_u_6 or not v_u_6:GetAttribute("DisableOtherVFX")) then
		if p_u_7 and p_u_7:FindFirstChild("Humanoid") then
			coroutine.wrap(function()
				-- upvalues: (ref) v_u_3, (copy) p_u_7, (copy) p_u_8, (copy) p_u_9
				v_u_3:SpawnCharacterHitEffect(p_u_7, p_u_8, p_u_9)
			end)()
		end
	end
end)
local v_u_11 = false
game:GetService("UserInputService").InputBegan:Connect(function(p12)
	-- upvalues: (ref) v_u_11, (copy) v_u_3
	v_u_11 = p12.KeyCode == Enum.KeyCode.F9 and not v_u_11
	if v_u_11 then
		local v13 = v_u_3:GetStats()
		for _, _ in pairs(v13.Pools) do

		end
	end
end)
local function v15(p14)
	-- upvalues: (copy) v_u_3
	p14:WaitForChild("Humanoid").Died:Connect(function()
		-- upvalues: (ref) v_u_3
		v_u_3:Cleanup()
	end)
end
if v_u_6.Character then
	v_u_6.Character:WaitForChild("Humanoid").Died:Connect(function()
		-- upvalues: (copy) v_u_3
		v_u_3:Cleanup()
	end)
end
v_u_6.CharacterAdded:Connect(v15)