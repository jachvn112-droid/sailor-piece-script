local v_u_1 = game:GetService("StarterGui");
(function()
	-- upvalues: (copy) v_u_1
	local v2, _ = pcall(function()
		-- upvalues: (ref) v_u_1
		v_u_1:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
	end)
	if not v2 then
		task.wait(1)
		pcall(function()
			-- upvalues: (ref) v_u_1
			v_u_1:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
		end)
	end
end)()