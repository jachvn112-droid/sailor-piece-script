local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = v1.LocalPlayer
local v_u_4 = v3:WaitForChild("PlayerGui"):WaitForChild("AccessoryPopupUI"):WaitForChild("MainFrame")
local v_u_5 = v_u_4:WaitForChild("InfoHolder"):WaitForChild("Txt")
local v6 = v_u_4:WaitForChild("ButtonsHolder")
local v_u_7 = v6:WaitForChild("EquipStats")
local v_u_8 = v6:WaitForChild("EquipVisual")
local v_u_9 = v_u_4:WaitForChild("Exit"):WaitForChild("CloseButton")
local v10 = v2:WaitForChild("Remotes")
local v_u_11 = v10:WaitForChild("EquipAccessory")
local v_u_12 = v10:WaitForChild("GetAccessoryEquipped")
local v_u_13 = Color3.fromRGB(76, 175, 80)
local v_u_14 = Color3.fromRGB(244, 67, 54)
local v_u_15 = false
local v_u_16 = nil
local v_u_17 = {}
local v_u_18 = 0
local function v_u_20()
	-- upvalues: (ref) v_u_17
	for _, v19 in ipairs(v_u_17) do
		if v19.Connected then
			v19:Disconnect()
		end
	end
	v_u_17 = {}
end
local function v21()
	-- upvalues: (ref) v_u_15, (ref) v_u_16, (copy) v_u_4, (copy) v_u_20
	if v_u_15 then
		v_u_15 = false
		v_u_16 = nil
		v_u_4.Visible = false
		v_u_20()
	end
end
local function v49(p_u_22)
	-- upvalues: (ref) v_u_15, (ref) v_u_16, (copy) v_u_4, (copy) v_u_20, (copy) v_u_12, (copy) v_u_5, (copy) v_u_7, (copy) v_u_8, (copy) v_u_14, (copy) v_u_13, (ref) v_u_17, (ref) v_u_18, (copy) v_u_11, (copy) v_u_9
	if v_u_15 and v_u_15 then
		v_u_15 = false
		v_u_16 = nil
		v_u_4.Visible = false
		v_u_20()
	end
	v_u_16 = p_u_22
	v_u_15 = true
	local v23 = {
		["Visual"] = nil,
		["Stats"] = nil
	}
	local v24, v25 = pcall(function()
		-- upvalues: (ref) v_u_12
		return v_u_12:InvokeServer()
	end)
	if v24 then
		v23 = v25 or v23
	end
	local v_u_26 = v23.Stats == p_u_22
	local v_u_27 = v23.Visual == p_u_22
	v_u_5.Text = p_u_22
	local v28 = v_u_7:FindFirstChild("Txt")
	local v29 = v_u_8:FindFirstChild("Txt")
	if v_u_26 then
		local v30 = v_u_7
		local v31 = v_u_14
		v30.ImageColor3 = v31
		v30.BackgroundColor3 = v31
		if v28 then
			v28.Text = "Unequip"
		end
	else
		local v32 = v_u_7
		local v33 = v_u_13
		v32.ImageColor3 = v33
		v32.BackgroundColor3 = v33
		if v28 then
			v28.Text = "Equip"
		end
	end
	if v_u_27 then
		local v34 = v_u_8
		local v35 = v_u_14
		v34.ImageColor3 = v35
		v34.BackgroundColor3 = v35
		if v29 then
			v29.Text = "Unvisual"
		end
	else
		local v36 = v_u_8
		local v37 = v_u_13
		v36.ImageColor3 = v37
		v36.BackgroundColor3 = v37
		if v29 then
			v29.Text = "Visual"
		end
	end
	v_u_4.Visible = true
	v_u_20()
	local v38 = v_u_17
	local v39 = v_u_7.Activated
	local function v41()
		-- upvalues: (ref) v_u_18, (copy) v_u_26, (ref) v_u_11, (copy) p_u_22, (ref) v_u_15, (ref) v_u_16, (ref) v_u_4, (ref) v_u_20
		local v40 = tick()
		if v40 - v_u_18 < 0.35 then
			return
		else
			v_u_18 = v40
			if v_u_26 then
				v_u_11:FireServer("UnequipStats")
			else
				v_u_11:FireServer("EquipStats", p_u_22)
			end
			if v_u_15 then
				v_u_15 = false
				v_u_16 = nil
				v_u_4.Visible = false
				v_u_20()
			end
		end
	end
	table.insert(v38, v39:Connect(v41))
	local v42 = v_u_17
	local v43 = v_u_8.Activated
	local function v45()
		-- upvalues: (ref) v_u_18, (copy) v_u_27, (ref) v_u_11, (copy) p_u_22, (ref) v_u_15, (ref) v_u_16, (ref) v_u_4, (ref) v_u_20
		local v44 = tick()
		if v44 - v_u_18 < 0.35 then
			return
		else
			v_u_18 = v44
			if v_u_27 then
				v_u_11:FireServer("UnequipVisual")
			else
				v_u_11:FireServer("EquipVisual", p_u_22)
			end
			if v_u_15 then
				v_u_15 = false
				v_u_16 = nil
				v_u_4.Visible = false
				v_u_20()
			end
		end
	end
	table.insert(v42, v43:Connect(v45))
	local v46 = v_u_17
	local v47 = v_u_9.Activated
	local function v48()
		-- upvalues: (ref) v_u_15, (ref) v_u_16, (ref) v_u_4, (ref) v_u_20
		if v_u_15 then
			v_u_15 = false
			v_u_16 = nil
			v_u_4.Visible = false
			v_u_20()
		end
	end
	table.insert(v46, v47:Connect(v48))
end
_G.OpenAccessoryConfirm = v49
_G.CloseAccessoryPopup = v21
local function v51(p50)
	-- upvalues: (ref) v_u_15, (ref) v_u_16, (copy) v_u_4, (copy) v_u_20
	if v_u_15 then
		v_u_15 = false
		v_u_16 = nil
		v_u_4.Visible = false
		v_u_20()
	end
	p50:WaitForChild("Humanoid").Died:Connect(function()
		-- upvalues: (ref) v_u_15, (ref) v_u_16, (ref) v_u_4, (ref) v_u_20
		if v_u_15 then
			v_u_15 = false
			v_u_16 = nil
			v_u_4.Visible = false
			v_u_20()
		end
	end)
end
v3.CharacterAdded:Connect(v51)
if v3.Character then
	local v52 = v3.Character
	if v_u_15 then
		v_u_15 = false
		v_u_16 = nil
		v_u_4.Visible = false
		v_u_20()
	end
	v52:WaitForChild("Humanoid").Died:Connect(function()
		-- upvalues: (ref) v_u_15, (ref) v_u_16, (copy) v_u_4, (copy) v_u_20
		if v_u_15 then
			v_u_15 = false
			v_u_16 = nil
			v_u_4.Visible = false
			v_u_20()
		end
	end)
end
v_u_4.Visible = false