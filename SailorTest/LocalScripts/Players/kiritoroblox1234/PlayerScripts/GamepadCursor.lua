local v1 = game:GetService("Players")
local v2 = game:GetService("GuiService")
game:GetService("UserInputService")
local v3 = v1.LocalPlayer:WaitForChild("PlayerGui")
v2.AutoSelectGuiEnabled = true
task.wait(1)
local function v5(p4)
	if p4:IsA("GuiButton") or p4:IsA("TextBox") then
		p4.Selectable = true
	end
end
for _, v6 in ipairs(v3:GetChildren()) do
	if v6:IsA("ScreenGui") then
		for _, v7 in ipairs(v6:GetDescendants()) do
			if v7:IsA("GuiButton") or v7:IsA("TextBox") then
				v7.Selectable = true
			end
		end
	end
end
v3.DescendantAdded:Connect(v5)