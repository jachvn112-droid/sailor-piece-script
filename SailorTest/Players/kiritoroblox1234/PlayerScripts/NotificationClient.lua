local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = v1.LocalPlayer
local v4 = v_u_3:WaitForChild("PlayerGui")
local v5 = v2:WaitForChild("Modules")
local v_u_6 = require(v5:WaitForChild("NotificationService"))
local v_u_7 = require(v5:WaitForChild("ItemRarityConfig"))
v_u_6:Init(v4)
local v_u_8 = {
	["Common"] = "HideCommonNotif",
	["Uncommon"] = "HideUncommonNotif",
	["Rare"] = "HideRareNotif",
	["Epic"] = "HideEpicNotif",
	["Legendary"] = "HideLegendaryNotif",
	["Mythical"] = "HideMythicalNotif"
}
local v9 = v2:WaitForChild("RemoteEvents")
local v10 = v2:WaitForChild("Remotes")
local v11 = v9:FindFirstChild("NPCReward")
if v11 then
	v11.OnClientEvent:Connect(function(p12)
		-- upvalues: (copy) v_u_3, (copy) v_u_6
		local v13 = p12.boosts or {}
		if v_u_3:GetAttribute("DisableExpNotif") ~= true then
			if p12.xp and p12.xp > 0 then
				v_u_6:ShowXP(p12.xp, v13.xp and 2 or nil, p12.isMaxLevel)
			elseif p12.isMaxLevel then
				v_u_6:ShowXP(0, nil, true)
			end
		end
		if v_u_3:GetAttribute("DisableCoinsNotif") ~= true and (p12.money and p12.money > 0) then
			v_u_6:ShowMoney(p12.money, v13.money and 2 or nil)
		end
		if v_u_3:GetAttribute("DisableGemsNotif") ~= true and (p12.gems and p12.gems > 0) then
			v_u_6:ShowGems(p12.gems, v13.gems and 2 or nil)
		end
	end)
end
local v14 = v9:FindFirstChild("QuestComplete")
if v14 then
	v14.OnClientEvent:Connect(function(p15)
		-- upvalues: (copy) v_u_6, (copy) v_u_3, (copy) v_u_7, (copy) v_u_8
		v_u_6:ShowQuest(p15.questName or "Quest Completed!")
		local v16 = p15.boosts or {}
		if p15.rewards then
			if v_u_3:GetAttribute("DisableExpNotif") ~= true and (p15.rewards.xp and p15.rewards.xp > 0) then
				v_u_6:ShowXP(p15.rewards.xp, v16.xp and 2 or nil)
			end
			if v_u_3:GetAttribute("DisableCoinsNotif") ~= true and (p15.rewards.money and p15.rewards.money > 0) then
				v_u_6:ShowMoney(p15.rewards.money, v16.money and 2 or nil)
			end
			if v_u_3:GetAttribute("DisableGemsNotif") ~= true and (p15.rewards.gems and p15.rewards.gems > 0) then
				v_u_6:ShowGems(p15.rewards.gems, v16.gems and 2 or nil)
			end
		end
		if p15.items then
			for _, v17 in ipairs(p15.items) do
				local v18 = v_u_7:GetRarity(v17.name)
				local v19 = v_u_8[v18]
				local v20
				if v19 then
					v20 = v_u_3:GetAttribute(v19) == true
				else
					v20 = false
				end
				if not v20 then
					v_u_6:ShowItem(v17.name, v18, v17.quantity)
				end
			end
		end
		if p15.accessories then
			for _, v21 in ipairs(p15.accessories) do
				local v22 = v_u_7:GetRarity(v21.name)
				local v23 = v_u_8[v22]
				local v24
				if v23 then
					v24 = v_u_3:GetAttribute(v23) == true
				else
					v24 = false
				end
				if not v24 then
					v_u_6:ShowItem(v21.name, v22, 1)
				end
			end
		end
	end)
end
local v25 = v10:FindFirstChild("NotifyItemDrop")
if v25 then
	v25.OnClientEvent:Connect(function(p26)
		-- upvalues: (copy) v_u_7, (copy) v_u_8, (copy) v_u_3, (copy) v_u_6
		if p26.isBulk and p26.items then
			local v27 = {}
			for v28, v29 in pairs(p26.items) do
				local v30 = {
					["name"] = v28,
					["qty"] = v29,
					["rarity"] = v_u_7:GetRarity(v28)
				}
				table.insert(v27, v30)
			end
			local v_u_31 = {
				["Common"] = 1,
				["Uncommon"] = 2,
				["Rare"] = 3,
				["Epic"] = 4,
				["Legendary"] = 5,
				["Mythical"] = 6,
				["Secret"] = 7
			}
			table.sort(v27, function(p32, p33)
				-- upvalues: (copy) v_u_31
				local v34 = v_u_31[p32.rarity] or 0
				local v35 = v_u_31[p33.rarity] or 0
				if v34 == v35 then
					return p32.name < p33.name
				else
					return v35 < v34
				end
			end)
			for _, v36 in ipairs(v27) do
				local v37 = v_u_8[v36.rarity]
				local v38
				if v37 then
					v38 = v_u_3:GetAttribute(v37) == true
				else
					v38 = false
				end
				if not v38 then
					v_u_6:ShowItem(v36.name, v36.rarity, v36.qty)
				end
			end
		else
			local v39 = p26.name
			local v40 = p26.quantity or 1
			local v41 = p26.rarity or v_u_7:GetRarity(v39)
			local v42 = p26.doubled
			local v43 = p26.isPityReward
			local v44 = p26.pity
			local v45 = p26.pityMax
			local v46 = v_u_8[v41]
			local v47
			if v46 then
				v47 = v_u_3:GetAttribute(v46) == true
			else
				v47 = false
			end
			if not v47 then
				v_u_6:ShowItem(v39, v41, v40, v42, v43, v44, v45, p26.fastMode, p26.clanMode)
			end
		end
	end)
end
local v48 = v9:FindFirstChild("BountyTransfer")
if v48 then
	v48.OnClientEvent:Connect(function(p49)
		-- upvalues: (copy) v_u_6
		if p49.action == "gained" then
			v_u_6:ShowBounty(p49.amount, p49.from, "gained")
		end
	end)
end
local v50 = v10:FindFirstChild("ShowNotification")
if v50 then
	v50.OnClientEvent:Connect(function(p51, p52)
		-- upvalues: (copy) v_u_3, (copy) v_u_6, (copy) v_u_8
		if p51 == "XP" then
			if v_u_3:GetAttribute("DisableExpNotif") ~= true then
				v_u_6:ShowXP(p52.amount, p52.multiplier)
				return
			end
		elseif p51 == "Money" then
			if v_u_3:GetAttribute("DisableCoinsNotif") ~= true then
				v_u_6:ShowMoney(p52.amount, p52.multiplier)
				return
			end
		elseif p51 == "Gems" then
			if v_u_3:GetAttribute("DisableGemsNotif") ~= true then
				v_u_6:ShowGems(p52.amount, p52.multiplier)
				return
			end
		else
			if p51 == "Quest" then
				v_u_6:Show("Quest", p52)
				return
			end
			if p51 == "Item" then
				local v53 = v_u_8[p52.rarity]
				local v54
				if v53 then
					v54 = v_u_3:GetAttribute(v53) == true
				else
					v54 = false
				end
				if not v54 then
					v_u_6:ShowItem(p52.name, p52.rarity, p52.quantity)
					return
				end
			else
				if p51 == "Purchased" then
					v_u_6:ShowPurchased(p52.name, p52.rarity)
					return
				end
				if p51 == "Error" then
					v_u_6:Show("Quest", {
						["message"] = p52.message or "Error!"
					})
					return
				end
				if p51 == "Ally" then
					v_u_6:ShowAlly(p52.message)
					return
				end
				if p51 == "Info" then
					v_u_6:Show("Quest", {
						["message"] = p52.message or "Info"
					})
					return
				end
				if p51 == "Ability" then
					if p52.message then
						v_u_6:Show("Quest", {
							["message"] = p52.message,
							["longDuration"] = p52.longDuration
						})
					else
						v_u_6:Show("Quest", {
							["message"] = "Unlocked: " .. (p52.unlocked or "Ability")
						})
					end
				end
				v_u_6:Show(p51, p52)
			end
		end
	end)
end
local v55 = v9:FindFirstChild("SetSpawnEvent")
if v55 then
	v55.OnClientEvent:Connect(function(p56)
		-- upvalues: (copy) v_u_6
		if p56 then
			v_u_6:ShowSpawnSet()
		end
	end)
end
function _G.ShowNotification(p57, p58)
	-- upvalues: (copy) v_u_6
	v_u_6:Show(p57, p58)
end
function _G.ShowXPNotification(p59, p60)
	-- upvalues: (copy) v_u_3, (copy) v_u_6
	if v_u_3:GetAttribute("DisableExpNotif") ~= true then
		v_u_6:ShowXP(p59, p60)
	end
end
function _G.ShowMoneyNotification(p61, p62)
	-- upvalues: (copy) v_u_3, (copy) v_u_6
	if v_u_3:GetAttribute("DisableCoinsNotif") ~= true then
		v_u_6:ShowMoney(p61, p62)
	end
end
function _G.ShowGemsNotification(p63, p64)
	-- upvalues: (copy) v_u_3, (copy) v_u_6
	if v_u_3:GetAttribute("DisableGemsNotif") ~= true then
		v_u_6:ShowGems(p63, p64)
	end
end
function _G.ShowQuestNotification(p65)
	-- upvalues: (copy) v_u_6
	v_u_6:ShowQuest(p65)
end
function _G.ShowItemNotification(p66, p67, p68)
	-- upvalues: (copy) v_u_8, (copy) v_u_3, (copy) v_u_6
	local v69 = v_u_8[p67]
	local v70
	if v69 then
		v70 = v_u_3:GetAttribute(v69) == true
	else
		v70 = false
	end
	if not v70 then
		v_u_6:ShowItem(p66, p67, p68)
	end
end