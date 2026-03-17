local v_u_1 = game:GetService("StarterGui")
local v_u_2 = false
local v_u_6 = {
	["setCameraModeToastEnabled"] = function(p3)
		-- upvalues: (ref) v_u_2, (copy) v_u_6
		if p3 or v_u_2 then
			if not v_u_2 then
				v_u_2 = true
			end
			if not p3 then
				v_u_6.setCameraModeToastOpen(false)
			end
		end
	end,
	["setCameraModeToastOpen"] = function(p4)
		-- upvalues: (ref) v_u_2, (copy) v_u_1
		local v5 = v_u_2
		assert(v5)
		if p4 then
			v_u_1:SetCore("SendNotification", {
				["Title"] = "Camera Control Enabled",
				["Text"] = "Right click to toggle",
				["Duration"] = 3
			})
		end
	end
}
return v_u_6