local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local v_u_3 = v1:WaitForChild("Remotes"):WaitForChild("RequestOpenUIFromInventory")
local v4 = v2:WaitForChild("InventoryPanelUI"):WaitForChild("MainFrame").Frame.Content:WaitForChild("TabsHolder")
local v5 = {
	{
		["button"] = v4:WaitForChild("Titles"),
		["uiId"] = "Titles"
	},
	{
		["button"] = v4:WaitForChild("Capsules"),
		["uiId"] = "Storage"
	}
}
local v6 = false
local v_u_7 = v6
for _, v_u_8 in ipairs(v5) do
	v_u_8.button.MouseButton1Click:Connect(function()
		-- upvalues: (copy) v_u_8, (ref) v_u_7, (copy) v_u_3
		local v9 = v_u_8.uiId
		if not v_u_7 then
			v_u_7 = true
			v_u_3:FireServer(v9)
			task.wait(0.5)
			v_u_7 = false
		end
	end)
end