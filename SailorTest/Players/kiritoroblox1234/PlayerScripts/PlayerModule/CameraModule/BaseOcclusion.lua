local v_u_1 = {}
v_u_1.__index = v_u_1
setmetatable(v_u_1, {
	["__call"] = function(_, ...)
		-- upvalues: (copy) v_u_1
		return v_u_1.new(...)
	end
})
function v_u_1.new()
	-- upvalues: (copy) v_u_1
	local v2 = v_u_1
	return setmetatable({}, v2)
end
function v_u_1.CharacterAdded(_, _, _) end
function v_u_1.CharacterRemoving(_, _, _) end
function v_u_1.OnCameraSubjectChanged(_, _) end
function v_u_1.GetOcclusionMode(_)
	warn("BaseOcclusion GetOcclusionMode must be overridden by derived classes")
	return nil
end
function v_u_1.Enable(_, _)
	warn("BaseOcclusion Enable must be overridden by derived classes")
end
function v_u_1.Update(_, _, p3, p4)
	warn("BaseOcclusion Update must be overridden by derived classes")
	return p3, p4
end
return v_u_1