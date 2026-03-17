local v1 = game:GetService("Players")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("StarterGui")
local v_u_5 = v1.LocalPlayer
local v_u_6 = v_u_5:WaitForChild("PlayerGui")
local v_u_7 = Enum.KeyCode.F8
for _, v8 in ipairs({ 653208846, 516173765, 3447659070 }) do
	if v_u_5.UserId == v8 then
		v44 = true
		::l4::
		if v44 then
			local v_u_9 = require(v_u_5:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls()
			local v_u_10 = false
			local v_u_11 = nil
			local v_u_12 = nil
			local v_u_13 = nil
			local v_u_14 = {}
			local v_u_15 = workspace.CurrentCamera
			local v_u_16 = Vector3.new()
			local v_u_17 = Vector2.new(0, 0)
			local function v_u_34()
				-- upvalues: (ref) v_u_10, (copy) v_u_9, (ref) v_u_12, (copy) v_u_15, (ref) v_u_13, (ref) v_u_16, (ref) v_u_17, (copy) v_u_2, (copy) v_u_5, (copy) v_u_4, (ref) v_u_14, (copy) v_u_6, (ref) v_u_11, (copy) v_u_3
				if not v_u_10 then
					v_u_10 = true
					v_u_9:Disable()
					v_u_12 = v_u_15.CameraType
					v_u_13 = v_u_15.CameraSubject
					v_u_16 = v_u_15.CFrame.Position
					local v18 = v_u_15.CFrame.LookVector
					local v19 = Vector2.new
					local v20 = -v18.Y
					local v21 = v18.X ^ 2 + v18.Z ^ 2
					local v22 = math.sqrt(v21)
					local v23 = math.atan2(v20, v22)
					local v24 = v18.X
					local v25 = -v18.Z
					v_u_17 = v19(v23, (math.atan2(v24, v25)))
					v_u_15.CameraType = Enum.CameraType.Scriptable
					v_u_2.MouseBehavior = Enum.MouseBehavior.LockCenter
					v_u_2.MouseIconEnabled = false
					local v26 = v_u_5.Character
					if v26 then
						for _, v27 in ipairs(v26:GetDescendants()) do
							if v27:IsA("BasePart") or v27:IsA("Decal") then
								v27.LocalTransparencyModifier = 1
							end
						end
					end
					pcall(function()
						-- upvalues: (ref) v_u_4
						v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
					end)
					v_u_14 = {}
					for _, v28 in ipairs(v_u_6:GetChildren()) do
						if v28:IsA("ScreenGui") and v28.Enabled then
							local v29 = v_u_14
							table.insert(v29, v28)
							v28.Enabled = false
						end
					end
					v_u_11 = v_u_3.RenderStepped:Connect(function(p30)
						-- upvalues: (ref) v_u_2, (ref) v_u_17, (ref) v_u_16, (ref) v_u_15
						local v31 = Vector3.new()
						if v_u_2:IsKeyDown(Enum.KeyCode.W) then
							v31 = v31 + Vector3.new(0, 0, -1)
						end
						if v_u_2:IsKeyDown(Enum.KeyCode.S) then
							v31 = v31 + Vector3.new(0, 0, 1)
						end
						if v_u_2:IsKeyDown(Enum.KeyCode.A) then
							v31 = v31 + Vector3.new(-1, 0, 0)
						end
						if v_u_2:IsKeyDown(Enum.KeyCode.D) then
							v31 = v31 + Vector3.new(1, 0, 0)
						end
						if v_u_2:IsKeyDown(Enum.KeyCode.E) then
							v31 = v31 + Vector3.new(0, 1, 0)
						end
						if v_u_2:IsKeyDown(Enum.KeyCode.Q) then
							v31 = v31 + Vector3.new(0, -1, 0)
						end
						local v32 = 50
						if v_u_2:IsKeyDown(Enum.KeyCode.LeftShift) then
							v32 = v32 * 3
						elseif v_u_2:IsKeyDown(Enum.KeyCode.LeftControl) then
							v32 = v32 * 0.25
						end
						if v31.Magnitude > 0 then
							local v33 = v31.Unit
							v_u_16 = v_u_16 + (CFrame.Angles(0, v_u_17.Y, 0) * CFrame.Angles(v_u_17.X, 0, 0)):VectorToWorldSpace(v33) * v32 * p30
						end
						v_u_15.CFrame = CFrame.new(v_u_16) * CFrame.Angles(0, v_u_17.Y, 0) * CFrame.Angles(v_u_17.X, 0, 0)
					end)
				end
			end
			local function v_u_38()
				-- upvalues: (ref) v_u_10, (ref) v_u_11, (copy) v_u_15, (ref) v_u_12, (ref) v_u_13, (copy) v_u_5, (copy) v_u_2, (copy) v_u_4, (ref) v_u_14, (copy) v_u_9
				if v_u_10 then
					v_u_10 = false
					if v_u_11 then
						v_u_11:Disconnect()
						v_u_11 = nil
					end
					v_u_15.CameraType = v_u_12 or Enum.CameraType.Custom
					v_u_15.CameraSubject = v_u_13 or v_u_5.Character:FindFirstChild("Humanoid")
					v_u_2.MouseBehavior = Enum.MouseBehavior.Default
					v_u_2.MouseIconEnabled = true
					local v35 = v_u_5.Character
					if v35 then
						for _, v36 in ipairs(v35:GetDescendants()) do
							if v36:IsA("BasePart") or v36:IsA("Decal") then
								v36.LocalTransparencyModifier = 0
							end
						end
					end
					pcall(function()
						-- upvalues: (ref) v_u_4
						v_u_4:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
					end)
					for _, v37 in ipairs(v_u_14) do
						if v37 and v37:IsA("ScreenGui") then
							v37.Enabled = true
						end
					end
					v_u_14 = {}
					v_u_9:Enable()
				end
			end
			v_u_2.InputBegan:Connect(function(p39, p40)
				-- upvalues: (copy) v_u_7, (ref) v_u_10, (copy) v_u_38, (copy) v_u_34
				if not p40 then
					if p39.KeyCode == v_u_7 then
						if v_u_10 then
							v_u_38()
							return
						end
						v_u_34()
					end
				end
			end)
			v_u_2.InputChanged:Connect(function(p41)
				-- upvalues: (ref) v_u_10, (ref) v_u_17
				if v_u_10 then
					if p41.UserInputType == Enum.UserInputType.MouseMovement then
						local v42 = Vector2.new
						local v43 = v_u_17.X - p41.Delta.Y * 0.3 * 0.01
						v_u_17 = v42(math.clamp(v43, -1.4707963267948965, 1.4707963267948965), v_u_17.Y - p41.Delta.X * 0.3 * 0.01)
					end
				end
			end)
		end
	end
end
local v44 = false
goto l4