local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = v1.LocalPlayer
local v4 = v2:WaitForChild("Modules", 10)
if v4 then
	local v_u_5 = require(v4:WaitForChild("AnimationPreloader"))
	_G.ModulesPreloaded = false
	_G.AssetsDownloaded = false
	v_u_5:PreloadAll()
	_G.ModulesPreloaded = true
	_G.AssetsDownloaded = true
	local function v8(p6)
		-- upvalues: (copy) v_u_5
		local v7 = p6:WaitForChild("Humanoid", 10)
		if v7 then
			if v7:WaitForChild("Animator", 10) then
				v_u_5:CreateTracksForCharacter(p6)
			end
		else
			return
		end
	end
	if v_u_3.Character then
		task.spawn(function()
			-- upvalues: (copy) v_u_3, (copy) v_u_5
			local v9 = v_u_3.Character
			local v10 = v9:WaitForChild("Humanoid", 10)
			if v10 then
				if v10:WaitForChild("Animator", 10) then
					v_u_5:CreateTracksForCharacter(v9)
				end
			else
				return
			end
		end)
	end
	v_u_3.CharacterAdded:Connect(v8)
else
	warn("[AnimationPreloaderClient] Modules folder not found!")
end