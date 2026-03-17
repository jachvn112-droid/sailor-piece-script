return {
	["getUserFlag"] = function(p_u_1)
		local v2, v3 = pcall(function()
			-- upvalues: (copy) p_u_1
			return UserSettings():IsUserFeatureEnabled(p_u_1)
		end)
		return v2 and v3
	end
}