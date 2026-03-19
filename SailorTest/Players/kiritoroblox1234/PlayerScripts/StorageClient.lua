local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v_u_4 = require(v2:WaitForChild("Modules"):WaitForChild("StorageConfig"))
local v_u_5 = require(v2:WaitForChild("Modules"):WaitForChild("UIManager"))
local v6 = v3:WaitForChild("StorageUI"):WaitForChild("MainFrame")
local v7 = v6:WaitForChild("Frame")
local v8 = v7:WaitForChild("Content")
local v_u_9 = v8:WaitForChild("StorageHolder"):WaitForChild("Storages")
local v10 = v7:WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
local v_u_11 = v8:WaitForChild("ToolTipFrame"):WaitForChild("Txt")
local v12 = v2:WaitForChild("RemoteEvents"):WaitForChild("OpenStorageUI")
local v13 = v2:WaitForChild("Remotes")
local v_u_14 = v13:WaitForChild("StorageBuySlot")
local v_u_15 = v13:WaitForChild("StorageStoreItem")
local v_u_16 = v13:WaitForChild("StorageRetrieveItem")
local v17 = v13:WaitForChild("StorageDataUpdate")
local v_u_18 = v13:WaitForChild("GetStorageData")
v_u_5:Register("Storage", v6)
local v_u_19 = {
	["UnlockedSlots"] = {},
	["StoredItems"] = {},
	["EquippedRace"] = nil,
	["EquippedTrait"] = nil,
	["EquippedClan"] = nil
}
local v_u_20 = {}
local v_u_21 = v_u_4.ButtonCooldown
local function v_u_40(p22)
	-- upvalues: (copy) v_u_9, (copy) v_u_4, (copy) v_u_19
	local v23 = v_u_9:FindFirstChild(p22)
	if v23 then
		local v24 = v_u_4.GetSlot(p22)
		if v24 then
			local v25 = v_u_19.UnlockedSlots[p22]
			local v26 = v_u_19.StoredItems[p22]
			local v27 = v24.Type
			if p22 == "FruitStorage1" then
				local v28 = v23:FindFirstChild("Options")
				local v29 = v28 and v28:FindFirstChild("Txt")
				if v29 then
					local v30
					if v26 and v26 ~= "" then
						if v26 and v26 ~= "" then
							if v27 ~= "Fruit" then
								if v27 == "Race" then
									v26 = v26 .. " Race"
								elseif v27 == "Trait" then
									v26 = v26 .. " Trait"
								elseif v27 == "Clan" then
									v26 = v26 .. " Clan"
								end
							end
						else
							v26 = "STORE"
						end
						v30 = v26 or "STORE"
					else
						v30 = "STORE"
					end
					v29.Text = v30
				end
				return
			else
				local v31 = v23:FindFirstChild("BuyOptions")
				if v31 then
					local v32 = v31:FindFirstChild("Locked")
					local v33 = v31:FindFirstChild("Buy")
					local v34 = v31:FindFirstChild("Store")
					local v35 = v31:FindFirstChild("Txt")
					local v36 = v23:FindFirstChild("PriceFrame")
					local v37 = v_u_4.GetPrerequisite(p22)
					local v38 = not v37 or v_u_19.UnlockedSlots[v37]
					if v25 then
						if v32 then
							v32.Visible = false
						end
						if v33 then
							v33.Visible = false
						end
						if v34 then
							v34.Visible = true
						end
						if v36 then
							v36.Visible = false
						end
						if v35 then
							local v39
							if v26 and v26 ~= "" then
								if v26 and v26 ~= "" then
									if v27 ~= "Fruit" then
										if v27 == "Race" then
											v26 = v26 .. " Race"
										elseif v27 == "Trait" then
											v26 = v26 .. " Trait"
										elseif v27 == "Clan" then
											v26 = v26 .. " Clan"
										end
									end
								else
									v26 = "STORE"
								end
								v39 = v26 or "STORE"
							else
								v39 = "STORE"
							end
							v35.Text = v39
							return
						end
					elseif v38 then
						if v32 then
							v32.Visible = false
						end
						if v33 then
							v33.Visible = true
						end
						if v34 then
							v34.Visible = false
						end
						if v35 then
							v35.Text = "BUY"
						end
						if v36 then
							v36.Visible = true
						end
					else
						if v32 then
							v32.Visible = true
						end
						if v33 then
							v33.Visible = false
						end
						if v34 then
							v34.Visible = false
						end
						if v35 then
							v35.Text = "LOCKED"
						end
						if v36 then
							v36.Visible = false
							return
						end
					end
				end
			end
		else
			return
		end
	else
		return
	end
end
v12.OnClientEvent:Connect(function()
	-- upvalues: (copy) v_u_5, (copy) v_u_18, (copy) v_u_19, (copy) v_u_4, (copy) v_u_40, (copy) v_u_11
	if not v_u_5:IsOpen("Storage") then
		v_u_5:Open("Storage")
		task.spawn(function()
			-- upvalues: (ref) v_u_18, (ref) v_u_19, (ref) v_u_4, (ref) v_u_40, (ref) v_u_11
			local v41, v42 = pcall(function()
				-- upvalues: (ref) v_u_18
				return v_u_18:InvokeServer()
			end)
			if v41 and v42 then
				v_u_19.UnlockedSlots = v42.UnlockedSlots or {}
				v_u_19.StoredItems = v42.StoredItems or {}
				v_u_19.EquippedRace = v42.EquippedRace
				v_u_19.EquippedTrait = v42.EquippedTrait
				v_u_19.EquippedClan = v42.EquippedClan
				for v43 in pairs(v_u_4.Slots) do
					v_u_40(v43)
				end
				local v44 = 0
				for _, v45 in pairs(v_u_19.StoredItems) do
					if v45 and v45 ~= "" then
						v44 = v44 + 1
					end
				end
				v_u_11.Text = "Stored Items: " .. tostring(v44)
			end
		end)
	end
end)
v17.OnClientEvent:Connect(function(p46)
	-- upvalues: (copy) v_u_19, (copy) v_u_4, (copy) v_u_40, (copy) v_u_11
	if p46 then
		v_u_19.UnlockedSlots = p46.UnlockedSlots or {}
		v_u_19.StoredItems = p46.StoredItems or {}
		v_u_19.EquippedRace = p46.EquippedRace
		v_u_19.EquippedTrait = p46.EquippedTrait
		v_u_19.EquippedClan = p46.EquippedClan
		for v47 in pairs(v_u_4.Slots) do
			v_u_40(v47)
		end
		local v48 = 0
		for _, v49 in pairs(v_u_19.StoredItems) do
			if v49 and v49 ~= "" then
				v48 = v48 + 1
			end
		end
		v_u_11.Text = "Stored Items: " .. tostring(v48)
	end
end)
v10.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_5
	v_u_5:Close("Storage")
end)
local function v68(p_u_50)
	-- upvalues: (copy) v_u_9, (copy) v_u_20, (copy) v_u_21, (copy) v_u_19, (copy) v_u_16, (copy) v_u_15, (copy) v_u_14
	local v51 = v_u_9:FindFirstChild(p_u_50)
	if v51 then
		if p_u_50 == "FruitStorage1" then
			local v52 = v51:FindFirstChild("Options")
			local v53 = v52 and v52:FindFirstChild("Store")
			if v53 then
				v53.MouseButton1Click:Connect(function()
					-- upvalues: (copy) p_u_50, (ref) v_u_20, (ref) v_u_21, (ref) v_u_19, (ref) v_u_16, (ref) v_u_15
					local v54 = p_u_50
					local v55 = tick()
					local v56
					if v55 - (v_u_20[v54] or 0) < v_u_21 then
						v56 = false
					else
						v_u_20[v54] = v55
						v56 = true
					end
					if v56 then
						local v57 = v_u_19.StoredItems[p_u_50]
						if v57 and v57 ~= "" then
							v_u_16:FireServer(p_u_50)
						else
							v_u_15:FireServer(p_u_50)
						end
					else
						return
					end
				end)
			end
			return
		else
			local v58 = v51:FindFirstChild("BuyOptions")
			if v58 then
				local v59 = v58:FindFirstChild("Buy")
				local v60 = v58:FindFirstChild("Store")
				if v59 then
					v59.MouseButton1Click:Connect(function()
						-- upvalues: (copy) p_u_50, (ref) v_u_20, (ref) v_u_21, (ref) v_u_14
						local v61 = p_u_50
						local v62 = tick()
						local v63
						if v62 - (v_u_20[v61] or 0) < v_u_21 then
							v63 = false
						else
							v_u_20[v61] = v62
							v63 = true
						end
						if v63 then
							v_u_14:FireServer(p_u_50)
						end
					end)
				end
				if v60 then
					v60.MouseButton1Click:Connect(function()
						-- upvalues: (copy) p_u_50, (ref) v_u_20, (ref) v_u_21, (ref) v_u_19, (ref) v_u_16, (ref) v_u_15
						local v64 = p_u_50
						local v65 = tick()
						local v66
						if v65 - (v_u_20[v64] or 0) < v_u_21 then
							v66 = false
						else
							v_u_20[v64] = v65
							v66 = true
						end
						if v66 then
							local v67 = v_u_19.StoredItems[p_u_50]
							if v67 and v67 ~= "" then
								v_u_16:FireServer(p_u_50)
							else
								v_u_15:FireServer(p_u_50)
							end
						else
							return
						end
					end)
				end
			end
		end
	else
		return
	end
end
for v69 in pairs(v_u_4.Slots) do
	v68(v69)
end