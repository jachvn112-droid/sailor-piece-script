local v_u_1 = require(script:WaitForChild("Popper"))
local v_u_2 = math.clamp
local v_u_3 = math.exp
local v_u_4 = math.min
local v_u_5 = math.max
local v_u_6 = nil
local v_u_7 = nil
local v_u_8 = game:GetService("Players").LocalPlayer
assert(v_u_8)
local function v9()
	-- upvalues: (ref) v_u_6, (copy) v_u_8, (ref) v_u_7
	v_u_6 = v_u_8.CameraMinZoomDistance
	v_u_7 = v_u_8.CameraMaxZoomDistance
end
v_u_6 = v_u_8.CameraMinZoomDistance
v_u_7 = v_u_8.CameraMaxZoomDistance
v_u_8:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(v9)
v_u_8:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(v9)
local v_u_10 = {}
v_u_10.__index = v_u_10
function v_u_10.new(p11, p12, p13, p14)
	-- upvalues: (copy) v_u_2, (copy) v_u_10
	local v15 = v_u_2(p12, p13, p14)
	local v16 = v_u_10
	return setmetatable({
		["freq"] = p11,
		["x"] = v15,
		["v"] = 0,
		["minValue"] = p13,
		["maxValue"] = p14,
		["goal"] = v15
	}, v16)
end
function v_u_10.Step(p17, p18)
	-- upvalues: (copy) v_u_3
	local v19 = p17.freq * 2 * 3.141592653589793
	local v20 = p17.x
	local v21 = p17.v
	local v22 = p17.minValue
	local v23 = p17.maxValue
	local v24 = p17.goal
	local v25 = v24 - v20
	local v26 = v19 * p18
	local v27 = v_u_3(-v26)
	local v28 = v24 + (v21 * p18 - v25 * (v26 + 1)) * v27
	local v29 = ((v25 * v19 - v21) * v26 + v21) * v27
	if v28 < v22 then
		v23 = v22
		v29 = 0
	elseif v23 < v28 then
		v29 = 0
	else
		v23 = v28
	end
	p17.x = v23
	p17.v = v29
	return v23
end
local v_u_30 = v_u_10.new(4.5, 12.5, 0.5, v_u_7)
local v_u_31 = 0
return {
	["Update"] = function(p32, p33, p34)
		-- upvalues: (copy) v_u_30, (ref) v_u_31, (ref) v_u_6, (ref) v_u_7, (copy) v_u_2, (copy) v_u_5, (copy) v_u_1, (copy) v_u_4
		local v35
		if v_u_30.goal > 1 then
			local v36 = v_u_30.x
			local v37 = v_u_30.goal
			local v38 = v_u_31
			local v39 = v_u_6
			local v40 = v_u_7
			local v41 = v_u_2(v37 + v38 * (v37 * 0.0375 + 1), v39, v40)
			local v42 = v_u_5(v36, v41 < 1 and (v38 <= 0 and v39 and v39 or 1) or v41)
			v35 = v_u_1(p33 * CFrame.new(0, 0, 0.5), v42 - 0.5, p34) + 0.5
		else
			v35 = (1 / 0)
		end
		v_u_30.minValue = 0.5
		v_u_30.maxValue = v_u_4(v_u_7, v35)
		return v_u_30:Step(p32)
	end,
	["GetZoomRadius"] = function()
		-- upvalues: (copy) v_u_30
		return v_u_30.x
	end,
	["SetZoomParameters"] = function(p43, p44)
		-- upvalues: (copy) v_u_30, (ref) v_u_31
		v_u_30.goal = p43
		v_u_31 = p44
	end,
	["ReleaseSpring"] = function()
		-- upvalues: (copy) v_u_30
		v_u_30.x = v_u_30.goal
		v_u_30.v = 0
	end
}