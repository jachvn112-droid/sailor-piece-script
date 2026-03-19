local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("MarketplaceService")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = v_u_1.LocalPlayer
local v_u_5 = v_u_4:WaitForChild("PlayerGui")
local v_u_6 = require(v3:WaitForChild("Modules"):WaitForChild("ShopConfig"))
local v_u_7 = require(v3:WaitForChild("Modules"):WaitForChild("NotificationService"))
local v_u_8 = require(v3:WaitForChild("Modules"):WaitForChild("UIManager"))
local v9 = v_u_5:WaitForChild("ShopUI", 10)
if v9 then
	local v10 = v9:WaitForChild("MainFrame")
	local v11 = v10:WaitForChild("Frame")
	local v12 = v11:WaitForChild("Content")
	local v_u_13 = v12:WaitForChild("ShopHolder")
	local v_u_14 = v12:WaitForChild("GiftingMenu")
	local v_u_15 = v12:WaitForChild("GiftingPopup")
	local v_u_16 = v_u_14:WaitForChild("PlayerList")
	local v_u_17 = v_u_15:WaitForChild("Username")
	local v18 = v11:WaitForChild("CloseButtonFrame"):WaitForChild("CloseButton")
	local v19 = v11:WaitForChild("GiftHolder"):WaitForChild("Gift")
	local v20 = v_u_5:WaitForChild("BasicStatsCurrencyAndButtonsUI"):WaitForChild("MainFrame"):WaitForChild("UIButtons"):WaitForChild("ShopButtonFrame"):WaitForChild("Button")
	local v_u_21 = v_u_16:WaitForChild("PlayerNameSelected")
	local v_u_22 = v_u_16:WaitForChild("PlayerNameNotSelected")
	v_u_21.Visible = false
	v_u_22.Visible = false
	local v23 = v3:WaitForChild("Remotes"):WaitForChild("ShopRemotes")
	local v_u_24 = v23:WaitForChild("GiftProduct")
	local v_u_25 = v23:WaitForChild("PurchaseProduct")
	local v_u_26 = v23:WaitForChild("GetBoosts")
	local v27 = v23:WaitForChild("BoostsUpdated")
	local v_u_28 = v23:FindFirstChild("RefreshBoosts")
	local v_u_29 = false
	local v_u_30 = nil
	local v_u_31 = {}
	local v_u_32 = {}
	local v_u_33 = {}
	v9.Enabled = true
	v_u_8:Register("Shop", v10)
	local function v34()
		-- upvalues: (copy) v_u_8, (ref) v_u_29, (ref) v_u_30, (copy) v_u_15, (copy) v_u_14, (copy) v_u_25
		if v_u_8:IsOpen("Shop") then
			v_u_29 = false
			v_u_30 = nil
			v_u_15.Visible = false
			v_u_14.Visible = false
			v_u_25:FireServer("clearGift")
			v_u_8:Close("Shop")
		end
	end
	local function v35()
		-- upvalues: (copy) v_u_8, (ref) v_u_29, (ref) v_u_30, (copy) v_u_15, (copy) v_u_14, (copy) v_u_25
		if v_u_8:IsOpen("Shop") then
			v_u_29 = false
			v_u_30 = nil
			v_u_15.Visible = false
			v_u_14.Visible = false
			v_u_25:FireServer("clearGift")
		end
		v_u_8:Toggle("Shop")
	end
	local function v_u_45()
		-- upvalues: (ref) v_u_32, (copy) v_u_1, (copy) v_u_4, (ref) v_u_30, (copy) v_u_21, (copy) v_u_22, (copy) v_u_16, (copy) v_u_31, (copy) v_u_15, (copy) v_u_25, (copy) v_u_17, (copy) v_u_24, (copy) v_u_45
		for _, v36 in pairs(v_u_32) do
			v36:Destroy()
		end
		v_u_32 = {}
		for _, v_u_37 in ipairs(v_u_1:GetPlayers()) do
			if v_u_37 ~= v_u_4 then
				local v38 = (v_u_30 == v_u_37.UserId and v_u_21 or v_u_22):Clone()
				v38.Name = "Player_" .. v_u_37.Name
				v38.Visible = true
				v38.Parent = v_u_16
				local v39 = v38:FindFirstChild("Username")
				if v39 then
					v39.Text = v_u_37.Name
				end
				local v_u_40 = v38:FindFirstChild("Placeholder")
				if v_u_40 then
					task.spawn(function()
						-- upvalues: (ref) v_u_1, (copy) v_u_37, (copy) v_u_40
						local v41, v42 = pcall(function()
							-- upvalues: (ref) v_u_1, (ref) v_u_37
							return v_u_1:GetUserThumbnailAsync(v_u_37.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
						end)
						if v41 and v_u_40.Parent then
							v_u_40.Image = v42
						end
					end)
				end
				v38.Activated:Connect(function()
					-- upvalues: (ref) v_u_31, (ref) v_u_30, (copy) v_u_37, (ref) v_u_15, (ref) v_u_25, (ref) v_u_17, (ref) v_u_24, (ref) v_u_45
					local v43 = tick()
					local v44
					if v_u_31.playerSelect and v43 - v_u_31.playerSelect < 0.35 then
						v44 = false
					else
						v_u_31.playerSelect = v43
						v44 = true
					end
					if v44 then
						if v_u_30 == v_u_37.UserId then
							v_u_30 = nil
							v_u_15.Visible = false
							v_u_25:FireServer("clearGift")
						else
							v_u_30 = v_u_37.UserId
							v_u_17.Text = v_u_37.Name
							v_u_15.Visible = true
							v_u_24:FireServer(v_u_37.UserId)
						end
						v_u_45()
					end
				end)
				v_u_32[v_u_37.UserId] = v38
			end
		end
	end
	v_u_1.PlayerAdded:Connect(function()
		-- upvalues: (ref) v_u_29, (copy) v_u_45
		if v_u_29 then
			task.wait(0.5)
			v_u_45()
		end
	end)
	v_u_1.PlayerRemoving:Connect(function(p46)
		-- upvalues: (ref) v_u_30, (copy) v_u_15, (copy) v_u_25, (ref) v_u_29, (copy) v_u_45
		if v_u_30 == p46.UserId then
			v_u_30 = nil
			v_u_15.Visible = false
			v_u_25:FireServer("clearGift")
		end
		if v_u_29 then
			v_u_45()
		end
	end)
	v27.OnClientEvent:Connect(function(p47)
		-- upvalues: (ref) v_u_33
		v_u_33 = p47 or {}
	end)
	function _G.GetPlayerBoosts()
		-- upvalues: (ref) v_u_33
		return v_u_33
	end
	function _G.HasBoost(p48)
		-- upvalues: (ref) v_u_33
		return v_u_33[p48] == true
	end
	local function v53()
		-- upvalues: (copy) v_u_28, (ref) v_u_33, (copy) v_u_26
		if v_u_28 then
			local v49, v50 = pcall(function()
				-- upvalues: (ref) v_u_28
				return v_u_28:InvokeServer()
			end)
			if v49 and v50 then
				v_u_33 = v50
				return true
			end
		end
		local v51, v52 = pcall(function()
			-- upvalues: (ref) v_u_26
			return v_u_26:InvokeServer()
		end)
		if v51 then
			v_u_33 = v52 or {}
		end
	end
	_G.RefreshBoosts = v53
	v20.Activated:Connect(v35)
	v18.Activated:Connect(v34)
	v19.Activated:Connect(function()
		-- upvalues: (copy) v_u_31, (ref) v_u_29, (copy) v_u_14, (copy) v_u_45, (ref) v_u_30, (copy) v_u_15, (copy) v_u_25
		local v54 = tick()
		local v55
		if v_u_31.giftToggle and v54 - v_u_31.giftToggle < 0.35 then
			v55 = false
		else
			v_u_31.giftToggle = v54
			v55 = true
		end
		if v55 then
			v_u_29 = not v_u_29
			v_u_14.Visible = v_u_29
			if v_u_29 then
				v_u_45()
			else
				v_u_30 = nil
				v_u_15.Visible = false
				v_u_25:FireServer("clearGift")
			end
		else
			return
		end
	end)
	v10.Visible = false
	v_u_14.Visible = false
	v_u_15.Visible = false
	v_u_2.PromptProductPurchaseFinished:Connect(function(p56, _, p57)
		-- upvalues: (copy) v_u_4, (ref) v_u_30, (copy) v_u_15, (copy) v_u_25, (ref) v_u_29, (copy) v_u_45
		if p56 == v_u_4.UserId then
			if p57 then
				if v_u_30 then
					v_u_30 = nil
					v_u_15.Visible = false
					v_u_25:FireServer("clearGift")
					if v_u_29 then
						v_u_45()
					end
				end
			end
		else
			return
		end
	end)
	task.spawn(function()
		-- upvalues: (copy) v_u_6, (copy) v_u_31, (copy) v_u_7, (copy) v_u_5, (copy) v_u_2, (copy) v_u_4, (copy) v_u_13, (copy) v_u_26, (ref) v_u_33
		task.wait(1)
		local function v_u_66(p58, p_u_59)
			-- upvalues: (ref) v_u_6, (ref) v_u_31, (ref) v_u_7, (ref) v_u_5, (ref) v_u_2, (ref) v_u_4
			local v60, _, _ = v_u_6.GetProductByFrame(p_u_59)
			if v60 then
				local v61 = p58:FindFirstChild("Holder")
				if v61 then
					v61.Activated:Connect(function()
						-- upvalues: (copy) p_u_59, (ref) v_u_31, (ref) v_u_6, (ref) v_u_7, (ref) v_u_5, (ref) v_u_2, (ref) v_u_4
						local v62 = p_u_59
						local v63 = tick()
						local v64
						if v_u_31[v62] and v63 - v_u_31[v62] < 0.35 then
							v64 = false
						else
							v_u_31[v62] = v63
							v64 = true
						end
						if v64 then
							local v65 = v_u_6.GetProductIDByFrame(p_u_59)
							if v65 and v65 ~= 0 then
								v_u_2:PromptProductPurchase(v_u_4, v65)
							else
								v_u_7:Init(v_u_5)
								v_u_7:Show("Common", {
									["name"] = "Product not available yet!",
									["rolled"] = false
								})
							end
						else
							return
						end
					end)
				end
			else
				return
			end
		end
		local function v_u_70(p67)
			-- upvalues: (ref) v_u_6, (copy) v_u_66, (copy) v_u_70
			for _, v68 in ipairs(p67:GetChildren()) do
				if v68:IsA("Frame") then
					local v69 = v68.Name
					if v_u_6.FrameMappings[v69] then
						v_u_66(v68, v69)
					end
					v_u_70(v68)
				end
			end
		end
		v_u_70(v_u_13)
		local v71, v72 = pcall(function()
			-- upvalues: (ref) v_u_26
			return v_u_26:InvokeServer()
		end)
		if v71 then
			v_u_33 = v72 or {}
		end
	end)
else
	warn("[ShopClient] ShopUI not found!")
end