local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = v1.LocalPlayer
local v_u_4 = v_u_3:WaitForChild("PlayerGui")
local v_u_5 = require(v2:WaitForChild("Modules"):WaitForChild("UsableItemConfig"))
local v_u_6 = require(v2:WaitForChild("Modules"):WaitForChild("ShopConfig"))
local v_u_7 = require(v2:WaitForChild("Modules"):WaitForChild("RaceConfig"))
local v_u_8 = require(v2:WaitForChild("Modules"):WaitForChild("ClanConfig"))
local v_u_9 = require(v2:WaitForChild("Modules"):WaitForChild("HakiColorConfig"))
require(v2:WaitForChild("Modules"):WaitForChild("UIManager"))
local v_u_10 = require(v2:WaitForChild("Modules"):WaitForChild("NotificationService"))
local v_u_11 = v_u_4:WaitForChild("ConfirmUI")
local v_u_12 = v_u_11:WaitForChild("MainFrame")
local v13 = v_u_12:WaitForChild("ButtonsHolder")
local v_u_14 = v13:WaitForChild("Yes")
local v_u_15 = v13:WaitForChild("No")
local v_u_16 = v13:WaitForChild("Input")
local v_u_17 = v_u_16:WaitForChild("AmountBox")
v_u_17:GetPropertyChangedSignal("Text"):Connect(function()
	-- upvalues: (copy) v_u_17
	local v18 = v_u_17.Text
	local v19 = tonumber(v18)
	if v19 and v19 > 10000 then
		v_u_17.Text = tostring(10000)
	end
end)
local v_u_20 = v_u_12:WaitForChild("InfoHolder"):WaitForChild("Txt")
local v21 = v2:WaitForChild("Remotes")
local v_u_22 = v21:WaitForChild("UseItem")
local v_u_23 = v21:WaitForChild("ShopRemotes"):WaitForChild("RedeemProduct")
local v_u_24 = nil
local v_u_25 = nil
local v_u_26 = false
local v_u_27 = {}
local v_u_28 = 0
local v_u_29 = false
local v_u_30 = {
	["Epic"] = true,
	["Legendary"] = true,
	["Mythical"] = true
}
local function v_u_32()
	-- upvalues: (ref) v_u_27
	for _, v31 in ipairs(v_u_27) do
		if v31.Connected then
			v31:Disconnect()
		end
	end
	v_u_27 = {}
end
local function v33()
	-- upvalues: (ref) v_u_26, (ref) v_u_24, (ref) v_u_25, (copy) v_u_11, (copy) v_u_12, (copy) v_u_32
	if v_u_26 then
		v_u_26 = false
		v_u_24 = nil
		v_u_25 = nil
		v_u_11.Enabled = false
		v_u_12.Visible = false
		v_u_32()
	end
end
local v_u_34 = nil
local function v_u_45(p_u_35)
	-- upvalues: (ref) v_u_26, (ref) v_u_24, (ref) v_u_25, (copy) v_u_11, (copy) v_u_12, (copy) v_u_32, (copy) v_u_3, (copy) v_u_7, (copy) v_u_20, (copy) v_u_16, (ref) v_u_27, (copy) v_u_14, (ref) v_u_28, (ref) v_u_29, (ref) v_u_34, (copy) v_u_15
	if v_u_26 and v_u_26 then
		v_u_26 = false
		v_u_24 = nil
		v_u_25 = nil
		v_u_11.Enabled = false
		v_u_12.Visible = false
		v_u_32()
	end
	v_u_24 = p_u_35
	v_u_25 = "safety_race"
	v_u_26 = true
	local v36 = v_u_3:GetAttribute("CurrentRace") or "Human"
	v_u_20.Text = "You have a " .. v_u_7:GetRarity(v_u_3:GetAttribute("CurrentRace") or "Human") .. " race (" .. v36 .. ")!\nAre you sure you want to spin?"
	v_u_16.Visible = false
	v_u_11.Enabled = true
	v_u_12.Visible = true
	v_u_32()
	local v37 = v_u_27
	local v38 = v_u_14.MouseButton1Click
	local function v40()
		-- upvalues: (ref) v_u_28, (ref) v_u_26, (ref) v_u_24, (ref) v_u_25, (ref) v_u_11, (ref) v_u_12, (ref) v_u_32, (ref) v_u_29, (ref) v_u_34, (copy) p_u_35
		local v39 = tick()
		if v39 - v_u_28 >= 0.25 then
			v_u_28 = v39
			if v_u_26 then
				v_u_26 = false
				v_u_24 = nil
				v_u_25 = nil
				v_u_11.Enabled = false
				v_u_12.Visible = false
				v_u_32()
			end
			v_u_29 = true
			task.wait(0.1)
			v_u_34(p_u_35, true, true)
		end
	end
	table.insert(v37, v38:Connect(v40))
	local v41 = v_u_27
	local v42 = v_u_15.MouseButton1Click
	local function v44()
		-- upvalues: (ref) v_u_28, (ref) v_u_26, (ref) v_u_24, (ref) v_u_25, (ref) v_u_11, (ref) v_u_12, (ref) v_u_32
		local v43 = tick()
		if v43 - v_u_28 < 0.25 then
			return
		else
			v_u_28 = v43
			if v_u_26 then
				v_u_26 = false
				v_u_24 = nil
				v_u_25 = nil
				v_u_11.Enabled = false
				v_u_12.Visible = false
				v_u_32()
			end
		end
	end
	table.insert(v41, v42:Connect(v44))
end
local function v_u_55(p_u_46)
	-- upvalues: (ref) v_u_26, (ref) v_u_24, (ref) v_u_25, (copy) v_u_11, (copy) v_u_12, (copy) v_u_32, (copy) v_u_20, (copy) v_u_16, (ref) v_u_27, (copy) v_u_14, (ref) v_u_28, (ref) v_u_34, (copy) v_u_15
	if v_u_26 and v_u_26 then
		v_u_26 = false
		v_u_24 = nil
		v_u_25 = nil
		v_u_11.Enabled = false
		v_u_12.Visible = false
		v_u_32()
	end
	v_u_24 = p_u_46
	v_u_25 = "safety_haki"
	v_u_26 = true
	v_u_20.Text = "You have Rainbow Haki (1% chance)!\nAre you sure you want to reroll?"
	v_u_16.Visible = false
	v_u_11.Enabled = true
	v_u_12.Visible = true
	v_u_32()
	local v47 = v_u_27
	local v48 = v_u_14.MouseButton1Click
	local function v50()
		-- upvalues: (ref) v_u_28, (ref) v_u_26, (ref) v_u_24, (ref) v_u_25, (ref) v_u_11, (ref) v_u_12, (ref) v_u_32, (ref) v_u_34, (copy) p_u_46
		local v49 = tick()
		if v49 - v_u_28 >= 0.25 then
			v_u_28 = v49
			if v_u_26 then
				v_u_26 = false
				v_u_24 = nil
				v_u_25 = nil
				v_u_11.Enabled = false
				v_u_12.Visible = false
				v_u_32()
			end
			task.wait(0.1)
			v_u_34(p_u_46, true, true)
		end
	end
	table.insert(v47, v48:Connect(v50))
	local v51 = v_u_27
	local v52 = v_u_15.MouseButton1Click
	local function v54()
		-- upvalues: (ref) v_u_28, (ref) v_u_26, (ref) v_u_24, (ref) v_u_25, (ref) v_u_11, (ref) v_u_12, (ref) v_u_32
		local v53 = tick()
		if v53 - v_u_28 < 0.25 then
			return
		else
			v_u_28 = v53
			if v_u_26 then
				v_u_26 = false
				v_u_24 = nil
				v_u_25 = nil
				v_u_11.Enabled = false
				v_u_12.Visible = false
				v_u_32()
			end
		end
	end
	table.insert(v51, v52:Connect(v54))
end
local function v_u_66(p_u_56)
	-- upvalues: (ref) v_u_26, (ref) v_u_24, (ref) v_u_25, (copy) v_u_11, (copy) v_u_12, (copy) v_u_32, (copy) v_u_3, (copy) v_u_8, (copy) v_u_20, (copy) v_u_16, (ref) v_u_27, (copy) v_u_14, (ref) v_u_28, (ref) v_u_34, (copy) v_u_15
	if v_u_26 and v_u_26 then
		v_u_26 = false
		v_u_24 = nil
		v_u_25 = nil
		v_u_11.Enabled = false
		v_u_12.Visible = false
		v_u_32()
	end
	v_u_24 = p_u_56
	v_u_25 = "safety_clan"
	v_u_26 = true
	local v57 = v_u_3:GetAttribute("CurrentClan") or "None"
	v_u_20.Text = "You have a " .. v_u_8:GetRarity(v_u_3:GetAttribute("CurrentClan") or "None") .. " clan (" .. v57 .. ")!\nAre you sure you want to spin?"
	v_u_16.Visible = false
	v_u_11.Enabled = true
	v_u_12.Visible = true
	v_u_32()
	local v58 = v_u_27
	local v59 = v_u_14.MouseButton1Click
	local function v61()
		-- upvalues: (ref) v_u_28, (ref) v_u_26, (ref) v_u_24, (ref) v_u_25, (ref) v_u_11, (ref) v_u_12, (ref) v_u_32, (ref) v_u_34, (copy) p_u_56
		local v60 = tick()
		if v60 - v_u_28 >= 0.25 then
			v_u_28 = v60
			if v_u_26 then
				v_u_26 = false
				v_u_24 = nil
				v_u_25 = nil
				v_u_11.Enabled = false
				v_u_12.Visible = false
				v_u_32()
			end
			v_u_34(p_u_56, true, false)
		end
	end
	table.insert(v58, v59:Connect(v61))
	local v62 = v_u_27
	local v63 = v_u_15.MouseButton1Click
	local function v65()
		-- upvalues: (ref) v_u_28, (ref) v_u_26, (ref) v_u_24, (ref) v_u_25, (ref) v_u_11, (ref) v_u_12, (ref) v_u_32
		local v64 = tick()
		if v64 - v_u_28 < 0.25 then
			return
		else
			v_u_28 = v64
			if v_u_26 then
				v_u_26 = false
				v_u_24 = nil
				v_u_25 = nil
				v_u_11.Enabled = false
				v_u_12.Visible = false
				v_u_32()
			end
		end
	end
	table.insert(v62, v63:Connect(v65))
end
v_u_34 = function(p_u_67, p68, p69)
	-- upvalues: (ref) v_u_26, (ref) v_u_24, (ref) v_u_25, (copy) v_u_11, (copy) v_u_12, (copy) v_u_32, (copy) v_u_5, (copy) v_u_3, (copy) v_u_7, (copy) v_u_30, (copy) v_u_45, (copy) v_u_8, (copy) v_u_66, (copy) v_u_9, (copy) v_u_55, (copy) v_u_20, (copy) v_u_16, (copy) v_u_17, (ref) v_u_27, (copy) v_u_14, (ref) v_u_28, (ref) v_u_29, (copy) v_u_22, (copy) v_u_15
	if v_u_26 and v_u_26 then
		v_u_26 = false
		v_u_24 = nil
		v_u_25 = nil
		v_u_11.Enabled = false
		v_u_12.Visible = false
		v_u_32()
	end
	local v_u_70 = v_u_5.GetConfig(p_u_67)
	if v_u_70 then
		if not p68 and v_u_70.Action == "RaceReroll" then
			local v71 = v_u_7:GetRarity(v_u_3:GetAttribute("CurrentRace") or "Human")
			local v72
			if v_u_30[v71] then
				if v71 == "Mythical" then
					v72 = true
				elseif v71 == "Epic" and v_u_3:GetAttribute("SkipEpicReroll") then
					v72 = false
				else
					v72 = (v71 ~= "Legendary" or not v_u_3:GetAttribute("SkipLegendaryReroll")) and true or false
				end
			else
				v72 = false
			end
			if v72 then
				v_u_45(p_u_67)
				return
			end
		end
		if not p68 and v_u_70.Action == "ClanReroll" then
			local v73 = v_u_8:GetRarity(v_u_3:GetAttribute("CurrentClan") or "None")
			local v74
			if v73 == "Common" or (v73 == "Uncommon" or v73 == "Rare") or v73 == "Epic" and v_u_3:GetAttribute("SkipEpicClan") then
				v74 = false
			else
				v74 = (v73 ~= "Legendary" or not v_u_3:GetAttribute("SkipLegendaryClan")) and true or false
			end
			if v74 then
				v_u_66(p_u_67)
				return
			end
		end
		if not p69 and v_u_70.Action == "HakiColorReroll" then
			local v75 = v_u_3:GetAttribute("HakiColor") or "White"
			if v_u_9.IsRainbow(v75) then
				v_u_55(p_u_67)
				return
			end
		end
		v_u_24 = p_u_67
		v_u_25 = "usable"
		v_u_26 = true
		v_u_20.Text = v_u_5.GetConfirmText(p_u_67)
		v_u_16.Visible = v_u_70.ShowAmountInput == true
		v_u_17.Text = "1"
		v_u_11.Enabled = true
		v_u_12.Visible = true
		v_u_32()
		local v76 = v_u_27
		local v77 = v_u_14.MouseButton1Click
		local function v84()
			-- upvalues: (ref) v_u_28, (copy) v_u_70, (ref) v_u_17, (ref) v_u_29, (ref) v_u_22, (copy) p_u_67, (ref) v_u_26, (ref) v_u_24, (ref) v_u_25, (ref) v_u_11, (ref) v_u_12, (ref) v_u_32
			local v78 = tick()
			if v78 - v_u_28 < 0.25 then
				return
			else
				v_u_28 = v78
				local v79
				if v_u_70.ShowAmountInput then
					local v80 = v_u_17.Text
					local v81 = tonumber(v80) or 1
					local v82 = math.floor(v81)
					v79 = math.clamp(v82, 1, 10000)
				else
					v79 = 1
				end
				local v83 = v_u_29 or false
				v_u_29 = false
				v_u_22:FireServer("Use", p_u_67, v79, v83)
				if v_u_26 then
					v_u_26 = false
					v_u_24 = nil
					v_u_25 = nil
					v_u_11.Enabled = false
					v_u_12.Visible = false
					v_u_32()
				end
			end
		end
		table.insert(v76, v77:Connect(v84))
		local v85 = v_u_27
		local v86 = v_u_15.MouseButton1Click
		local function v88()
			-- upvalues: (ref) v_u_28, (ref) v_u_26, (ref) v_u_24, (ref) v_u_25, (ref) v_u_11, (ref) v_u_12, (ref) v_u_32
			local v87 = tick()
			if v87 - v_u_28 < 0.25 then
				return
			else
				v_u_28 = v87
				if v_u_26 then
					v_u_26 = false
					v_u_24 = nil
					v_u_25 = nil
					v_u_11.Enabled = false
					v_u_12.Visible = false
					v_u_32()
				end
			end
		end
		table.insert(v85, v86:Connect(v88))
	end
end
local function v101(p_u_89)
	-- upvalues: (ref) v_u_26, (ref) v_u_24, (ref) v_u_25, (copy) v_u_11, (copy) v_u_12, (copy) v_u_32, (copy) v_u_5, (copy) v_u_6, (copy) v_u_20, (copy) v_u_16, (ref) v_u_27, (copy) v_u_14, (ref) v_u_28, (copy) v_u_23, (copy) v_u_10, (copy) v_u_4, (copy) v_u_15
	if v_u_26 and v_u_26 then
		v_u_26 = false
		v_u_24 = nil
		v_u_25 = nil
		v_u_11.Enabled = false
		v_u_12.Visible = false
		v_u_32()
	end
	if v_u_5.IsShopProduct(p_u_89) then
		local v90 = v_u_6.GetProduct(p_u_89)
		if v90 then
			v_u_24 = p_u_89
			v_u_25 = "shop"
			v_u_26 = true
			v_u_20.Text = v90.Description or "Redeem " .. v90.DisplayName .. "?"
			v_u_16.Visible = false
			v_u_11.Enabled = true
			v_u_12.Visible = true
			v_u_32()
			local v91 = v_u_27
			local v92 = v_u_14.MouseButton1Click
			local function v96()
				-- upvalues: (ref) v_u_28, (ref) v_u_23, (copy) p_u_89, (ref) v_u_10, (ref) v_u_4, (ref) v_u_26, (ref) v_u_24, (ref) v_u_25, (ref) v_u_11, (ref) v_u_12, (ref) v_u_32
				local v93 = tick()
				if v93 - v_u_28 < 0.25 then
					return
				else
					v_u_28 = v93
					local v94, v95 = v_u_23:InvokeServer(p_u_89)
					if not v94 then
						v_u_10:Init(v_u_4)
						v_u_10:Show("Common", {
							["name"] = v95 or "Failed to redeem!",
							["error"] = true
						})
					end
					if v_u_26 then
						v_u_26 = false
						v_u_24 = nil
						v_u_25 = nil
						v_u_11.Enabled = false
						v_u_12.Visible = false
						v_u_32()
					end
				end
			end
			table.insert(v91, v92:Connect(v96))
			local v97 = v_u_27
			local v98 = v_u_15.MouseButton1Click
			local function v100()
				-- upvalues: (ref) v_u_28, (ref) v_u_26, (ref) v_u_24, (ref) v_u_25, (ref) v_u_11, (ref) v_u_12, (ref) v_u_32
				local v99 = tick()
				if v99 - v_u_28 < 0.25 then
					return
				else
					v_u_28 = v99
					if v_u_26 then
						v_u_26 = false
						v_u_24 = nil
						v_u_25 = nil
						v_u_11.Enabled = false
						v_u_12.Visible = false
						v_u_32()
					end
				end
			end
			table.insert(v97, v98:Connect(v100))
		end
	else
		return
	end
end
v_u_22.OnClientEvent:Connect(function(p102, p103)
	-- upvalues: (copy) v_u_10, (copy) v_u_4
	if p102 == "HakiColorUpdated" and p103 then
		if _G.UpdateHakiColor then
			_G.UpdateHakiColor(p103)
			return
		end
	elseif p102 == "UseFailed" then
		v_u_10:Init(v_u_4)
		if p103 == "NoHaki" then
			v_u_10:Show("Quest", {
				["message"] = "Unlock Haki first!"
			})
			return
		end
		if p103 == "NoItem" then
			v_u_10:Show("Quest", {
				["message"] = "You don\'t have this item!"
			})
			return
		end
		if p103 == "Cooldown" then
			v_u_10:Show("Quest", {
				["message"] = "Please wait..."
			})
			return
		end
		if p103 == "DataNotLoaded" then
			v_u_10:Show("Quest", {
				["message"] = "Data not loaded!"
			})
		end
	end
end)
_G.OpenUsableItemConfirm = v_u_34
_G.OpenShopProductConfirm = v101
_G.CloseConfirmUI = v33
v_u_11.Enabled = false
v_u_12.Visible = false