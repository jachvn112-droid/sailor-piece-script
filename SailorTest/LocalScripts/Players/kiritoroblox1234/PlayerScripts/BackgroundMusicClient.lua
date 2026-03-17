local v_u_1 = { "MusicPirateKing", "MusicAncientMyths" }
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("SoundService")
local v_u_4 = require(v2:WaitForChild("SoundConfig"))
local v_u_5 = v_u_3:FindFirstChild("MusicGroup")
if not v_u_5 then
	v_u_5 = Instance.new("SoundGroup")
	v_u_5.Name = "MusicGroup"
	v_u_5.Volume = 1
	v_u_5.Parent = v_u_3
end
local v_u_6 = 1
local function v_u_11(p7)
	-- upvalues: (copy) v_u_4, (copy) v_u_3, (ref) v_u_5, (ref) v_u_6, (copy) v_u_1, (copy) v_u_11
	local v8 = v_u_4.Sounds[p7]
	if v8 then
		local v9 = v_u_3:FindFirstChild("BackgroundMusic")
		if v9 then
			v9:Destroy()
		end
		local v10 = Instance.new("Sound")
		v10.Name = "BackgroundMusic"
		v10.SoundId = v8.Id
		v10.Volume = 0.35
		v10.Looped = false
		v10.SoundGroup = v_u_5
		v10.Parent = v_u_3
		v10:Play()
		v10.Ended:Once(function()
			-- upvalues: (ref) v_u_6, (ref) v_u_1, (ref) v_u_11
			v_u_6 = v_u_6 % #v_u_1 + 1
			v_u_11(v_u_1[v_u_6])
		end)
	else
		warn("Track not found:", p7)
	end
end
v_u_11(v_u_1[v_u_6])