local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v_u_4 = require(v2:WaitForChild("Modules"):WaitForChild("CosmeticConfig"))
local v_u_5 = v3:WaitForChild("CosmeticConfirmUI"):WaitForChild("MainFrame")
local v6 = v_u_5:WaitForChild("ButtonsHolder")
local v_u_7 = v6:WaitForChild("EquipStats")
local v_u_8 = v6:WaitForChild("EquipVisual")
local v_u_9 = v_u_5:WaitForChild("Exit"):WaitForChild("CloseButton")
local v_u_10 = v_u_5:WaitForChild("InfoHolder")
local v_u_11 = v_u_10:WaitForChild("Txt")
local v12 = v2:WaitForChild("Remotes")
local v_u_13 = v12:WaitForChild("EquipCosmetic")
local v_u_14 = v12:WaitForChild("GetEquippedCosmetic")
local v_u_15 = Color3.fromRGB(76, 175, 80)
local v_u_16 = Color3.fromRGB(244, 67, 54)
local v_u_17 = false
local v_u_18 = nil
local v_u_19 = {}
local v_u_20 = 0
local function v_u_22()
	-- upvalues: (ref) v_u_19
	for _, v21 in ipairs(v_u_19) do
		if v21.Connected then
			v21:Disconnect()
		end
	end
	v_u_19 = {}
end
local function v52(p_u_23)
	-- upvalues: (ref) v_u_17, (ref) v_u_18, (copy) v_u_5, (copy) v_u_22, (copy) v_u_14, (copy) v_u_11, (copy) v_u_4, (copy) v_u_10, (copy) v_u_7, (copy) v_u_8, (copy) v_u_16, (copy) v_u_15, (ref) v_u_19, (copy) v_u_9, (ref) v_u_20, (copy) v_u_13
	if v_u_17 and v_u_17 then
		v_u_17 = false
		v_u_18 = nil
		v_u_5.Visible = false
		v_u_22()
	end
	v_u_18 = p_u_23
	v_u_17 = true
	local v24 = {
		["Visual"] = nil,
		["Stats"] = nil
	}
	local v25, v26 = pcall(function()
		-- upvalues: (ref) v_u_14
		return v_u_14:InvokeServer()
	end)
	if v25 then
		v24 = v26 or v24
	end
	local v_u_27 = v24.Visual == p_u_23
	local v_u_28 = v24.Stats == p_u_23
	v_u_11.Text = p_u_23
	local v29 = v_u_4:GetCosmetic(p_u_23)
	local v30 = v_u_10:FindFirstChild("DescTxt")
	if v30 then
		v30.Text = v29 and v29.description or ""
	end
	local v31 = v_u_7:FindFirstChild("Txt")
	local v32 = v_u_8:FindFirstChild("Txt")
	if v_u_28 then
		local v33 = v_u_7
		local v34 = v_u_16
		v33.ImageColor3 = v34
		v33.BackgroundColor3 = v34
		if v31 then
			v31.Text = "Unequip"
		end
	else
		local v35 = v_u_7
		local v36 = v_u_15
		v35.ImageColor3 = v36
		v35.BackgroundColor3 = v36
		if v31 then
			v31.Text = "Equip"
		end
	end
	if v_u_27 then
		local v37 = v_u_8
		local v38 = v_u_16
		v37.ImageColor3 = v38
		v37.BackgroundColor3 = v38
		if v32 then
			v32.Text = "Unvisual"
		end
	else
		local v39 = v_u_8
		local v40 = v_u_15
		v39.ImageColor3 = v40
		v39.BackgroundColor3 = v40
		if v32 then
			v32.Text = "Visual"
		end
	end
	v_u_5.Visible = true
	v_u_22()
	local v41 = v_u_19
	local v42 = v_u_9.Activated
	local function v43()
		-- upvalues: (ref) v_u_17, (ref) v_u_18, (ref) v_u_5, (ref) v_u_22
		if v_u_17 then
			v_u_17 = false
			v_u_18 = nil
			v_u_5.Visible = false
			v_u_22()
		end
	end
	table.insert(v41, v42:Connect(v43))
	local v44 = v_u_19
	local v45 = v_u_7.Activated
	local function v47()
		-- upvalues: (ref) v_u_20, (copy) v_u_28, (ref) v_u_13, (copy) p_u_23, (ref) v_u_17, (ref) v_u_18, (ref) v_u_5, (ref) v_u_22
		local v46 = tick()
		if v46 - v_u_20 < 0.35 then
			return
		else
			v_u_20 = v46
			if v_u_28 then
				v_u_13:FireServer("UnequipStats")
			else
				v_u_13:FireServer("EquipStats", p_u_23)
			end
			if v_u_17 then
				v_u_17 = false
				v_u_18 = nil
				v_u_5.Visible = false
				v_u_22()
			end
		end
	end
	table.insert(v44, v45:Connect(v47))
	local v48 = v_u_19
	local v49 = v_u_8.Activated
	local function v51()
		-- upvalues: (ref) v_u_20, (copy) v_u_27, (ref) v_u_13, (copy) p_u_23, (ref) v_u_17, (ref) v_u_18, (ref) v_u_5, (ref) v_u_22
		local v50 = tick()
		if v50 - v_u_20 < 0.35 then
			return
		else
			v_u_20 = v50
			if v_u_27 then
				v_u_13:FireServer("UnequipVisual")
			else
				v_u_13:FireServer("EquipVisual", p_u_23)
			end
			if v_u_17 then
				v_u_17 = false
				v_u_18 = nil
				v_u_5.Visible = false
				v_u_22()
			end
		end
	end
	table.insert(v48, v49:Connect(v51))
end
_G.OpenCosmeticConfirm = v52