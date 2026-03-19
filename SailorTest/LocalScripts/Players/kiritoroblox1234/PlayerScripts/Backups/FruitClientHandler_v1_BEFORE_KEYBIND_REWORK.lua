local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v3 = game:GetService("UserInputService")
local v_u_4 = v2.LocalPlayer
local v_u_5 = v_u_4:WaitForChild("PlayerGui")
local v_u_6 = require(v1:WaitForChild("Modules"):WaitForChild("NotificationService"))
local v7 = v1:WaitForChild("RemoteEvents")
local v8 = v7:WaitForChild("FruitReroll")
local v_u_9 = v7:WaitForChild("FruitAction")
local v_u_10 = v7:WaitForChild("DropFruit")
local v_u_11 = v_u_5:WaitForChild("ConfirmUI")
local v_u_12 = v_u_11:WaitForChild("MainFrame")
local v13 = v_u_12:WaitForChild("ButtonsHolder")
local v_u_14 = v13:WaitForChild("Yes")
local v_u_15 = v13:WaitForChild("No")
local v_u_16 = v13:WaitForChild("Input")
local v_u_17 = v_u_12:WaitForChild("InfoHolder"):WaitForChild("Txt")
local v_u_18 = nil
local v_u_19 = false
local v_u_20 = nil
local v_u_21 = {}
local v_u_22 = 0
local function v_u_24()
	-- upvalues: (ref) v_u_21
	for _, v23 in ipairs(v_u_21) do
		if v23.Connected then
			v23:Disconnect()
		end
	end
	v_u_21 = {}
end
local function v_u_34(p25)
	-- upvalues: (ref) v_u_19, (ref) v_u_20, (copy) v_u_11, (copy) v_u_12, (copy) v_u_24, (copy) v_u_17, (copy) v_u_16, (ref) v_u_21, (copy) v_u_14, (ref) v_u_22, (copy) v_u_9, (copy) v_u_15
	if v_u_19 and v_u_19 then
		v_u_19 = false
		v_u_20 = nil
		v_u_11.Enabled = false
		v_u_12.Visible = false
		v_u_24()
	end
	v_u_20 = p25
	v_u_19 = true
	v_u_17.Text = "Eat " .. p25 .. " Fruit?\nThis will give you its powers."
	v_u_16.Visible = false
	v_u_11.Enabled = true
	v_u_12.Visible = true
	v_u_24()
	local v26 = v_u_21
	local v27 = v_u_14.MouseButton1Click
	local function v29()
		-- upvalues: (ref) v_u_22, (ref) v_u_20, (ref) v_u_9, (ref) v_u_19, (ref) v_u_11, (ref) v_u_12, (ref) v_u_24
		local v28 = tick()
		if v28 - v_u_22 < 0.35 then
			return
		else
			v_u_22 = v28
			if v_u_20 then
				v_u_9:FireServer("eat", v_u_20)
			end
			if v_u_19 then
				v_u_19 = false
				v_u_20 = nil
				v_u_11.Enabled = false
				v_u_12.Visible = false
				v_u_24()
			end
		end
	end
	table.insert(v26, v27:Connect(v29))
	local v30 = v_u_21
	local v31 = v_u_15.MouseButton1Click
	local function v33()
		-- upvalues: (ref) v_u_22, (ref) v_u_19, (ref) v_u_20, (ref) v_u_11, (ref) v_u_12, (ref) v_u_24
		local v32 = tick()
		if v32 - v_u_22 < 0.35 then
			return
		else
			v_u_22 = v32
			if v_u_19 then
				v_u_19 = false
				v_u_20 = nil
				v_u_11.Enabled = false
				v_u_12.Visible = false
				v_u_24()
			end
		end
	end
	table.insert(v30, v31:Connect(v33))
end
local function v_u_35()
	-- upvalues: (ref) v_u_18, (copy) v_u_4, (copy) v_u_34
	if v_u_18 then
		if v_u_18.Parent == v_u_4.Character then
			v_u_34(v_u_18.Name)
		end
	else
		return
	end
end
local function v39(p36)
	-- upvalues: (ref) v_u_19, (ref) v_u_20, (copy) v_u_11, (copy) v_u_12, (copy) v_u_24, (ref) v_u_18, (copy) v_u_35
	if v_u_19 then
		v_u_19 = false
		v_u_20 = nil
		v_u_11.Enabled = false
		v_u_12.Visible = false
		v_u_24()
	end
	p36.ChildAdded:Connect(function(p37)
		-- upvalues: (ref) v_u_18, (ref) v_u_35
		if p37:IsA("Tool") and p37:FindFirstChild("FruitData") then
			task.wait(0.1)
			if p37:FindFirstChild("FruitData") then
				v_u_18 = p37
			end
			p37.Activated:Connect(v_u_35)
		end
	end)
	p36.ChildRemoved:Connect(function(p38)
		-- upvalues: (ref) v_u_18
		if p38:IsA("Tool") and (p38:FindFirstChild("FruitData") and v_u_18 == p38) then
			v_u_18 = nil
		end
	end)
end
v8.OnClientEvent:Connect(function(p40, p41)
	-- upvalues: (copy) v_u_6, (copy) v_u_5
	if p40 then
		v_u_6:Init(v_u_5)
		v_u_6:Show(p40.Rarity, {
			["name"] = p40.Name,
			["rolled"] = true
		})
	else
		v_u_6:Init(v_u_5)
		v_u_6:Show("Common", {
			["name"] = p41 or "Not enough currency!",
			["rolled"] = false
		})
	end
end)
v3.InputBegan:Connect(function(p42, p43)
	-- upvalues: (ref) v_u_18, (copy) v_u_4, (copy) v_u_10
	if not p43 then
		local v44 = (p42.KeyCode == Enum.KeyCode.Backspace or p42.KeyCode == Enum.KeyCode.DPadDown) and (v_u_18 and (v_u_18.Parent == v_u_4.Character and v_u_18:FindFirstChild("FruitID")))
		if v44 then
			v_u_10:FireServer(v44.Value)
			v_u_18 = nil
		end
	end
end)
if v_u_4.Character then
	v39(v_u_4.Character)
end
v_u_4.CharacterAdded:Connect(v39)