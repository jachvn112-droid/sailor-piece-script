local u1 = require(script.Graph)
local u2 = require(script.Range)
local u3 = require(script.Particles)
local u4 = require(script.Flipbook)
local u5 = script.Parent.Parent
local u6 = game:GetService("RunService")
local u7 = {
    ["Beam"] = {},
    ["EnabledParts"] = {}
}
_G.Part_Icles = _G.Part_Icles or {}
_G.Part_Icles.EnableAllowed = _G.Part_Icles.EnableAllowed or true
local u8 = u7.Beam
local u9 = {
    [Enum.NormalId.Top] = {
        ["vector"] = "UpVector",
        ["multiplier"] = 1
    },
    [Enum.NormalId.Bottom] = {
        ["vector"] = "UpVector",
        ["multiplier"] = -1
    },
    [Enum.NormalId.Front] = {
        ["vector"] = "LookVector",
        ["multiplier"] = 1
    },
    [Enum.NormalId.Back] = {
        ["vector"] = "LookVector",
        ["multiplier"] = -1
    },
    [Enum.NormalId.Left] = {
        ["vector"] = "RightVector",
        ["multiplier"] = -1
    },
    [Enum.NormalId.Right] = {
        ["vector"] = "RightVector",
        ["multiplier"] = 1
    }
}
local u51 = {
    [Enum.ParticleEmitterShape.Box] = function(p10, _) --[[ Line: 44 ]]
        local v11 = (math.random() * 2 - 1) * p10.Size.X / 2
        local v12 = (math.random() * 2 - 1) * p10.Size.Y / 2
        local v13 = (math.random() * 2 - 1) * p10.Size.Z / 2
        return Vector3.new(v11, v12, v13)
    end,
    [Enum.ParticleEmitterShape.Sphere] = function(p14, p15) --[[ Line: 50 ]]
        local v16 = p14.Size.X / 2
        local v17 = v16 * p15.ShapePartial
        local v18 = (math.random() * (v16 ^ 3 - v17 ^ 3) + v17 ^ 3) ^ 0.3333333333333333
        local v19 = math.random() * 2 * 3.141592653589793
        local v20 = math.random() * 2 - 1
        local v21 = math.acos(v20)
        local v22 = math.sin(v21) * math.cos(v19)
        local v23 = math.sin(v21) * math.sin(v19)
        local v24 = math.cos(v21)
        local v25 = Vector3.new(v22, v23, v24)
        return v25 * v18, CFrame.lookAt(Vector3.new(), -v25)
    end,
    [Enum.ParticleEmitterShape.Cylinder] = function(p26, p27) --[[ Line: 65 ]]
        local v28 = p26.Size.X / 2
        local v29 = p26.Size.Y
        local v30 = p27.ShapePartial
        local v31 = math.random()
        local v32 = math.sqrt(v31) * (1 - v30) + v30
        local v33 = math.random() * 2 * 3.141592653589793
        local v34 = v32 * v28 * math.cos(v33)
        local v35 = (math.random() * 2 - 1) * (v29 / 2)
        local v36 = v32 * v28 * math.sin(v33)
        local v37 = Vector3.new(v34, v35, v36)
        local v38
        if math.abs(v35) > v29 / 2 - 0.01 then
            local v39 = math.sign(v35)
            v38 = Vector3.new(0, v39, 0)
        else
            v38 = Vector3.new(v34, 0, v36).Unit
        end
        return v37, CFrame.lookAt(Vector3.new(), -v38)
    end,
    [Enum.ParticleEmitterShape.Disc] = function(p40, p41) --[[ Line: 84 ]]
        local v42 = p40.Size.X / 2
        local v43 = p41.ShapePartial
        local v44 = math.random()
        local v45 = math.sqrt(v44) * (1 - v43) + v43
        local v46 = math.random() * 2 * 3.141592653589793
        local v47 = v45 * v42 * math.cos(v46)
        local v48 = v45 * v42 * math.sin(v46)
        local v49 = Vector3.new(v47, 0, v48)
        local v50 = v49.Unit
        return v49, CFrame.lookAt(Vector3.new(), -v50)
    end
}
function u7.GetFolder(_) --[[ Line: 98 ]]
    if workspace.Terrain:FindFirstChild("EmittedPartsUsingPart_icle") then
        return workspace.Terrain.EmittedPartsUsingPart_icle
    end
    local v52 = Instance.new("Folder")
    v52.Name = "EmittedPartsUsingPart_icle"
    v52.Parent = workspace.Terrain
    return v52
end
function u8.Emit(_, p53) --[[ Line: 109 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u6
    --]]
    if p53:IsA("Beam") and p53:GetAttribute("Transformed") then
        local v54 = p53:FindFirstChild("Factors")
        if not v54 then
            return
        end
        local v55
        if workspace.Terrain:FindFirstChild("EmittedPartsUsingPart_icle") then
            v55 = workspace.Terrain.EmittedPartsUsingPart_icle
        else
            v55 = Instance.new("Folder")
            v55.Name = "EmittedPartsUsingPart_icle"
            v55.Parent = workspace.Terrain
        end
        local v56 = v54:FindFirstChild("Properties")
        local v57 = v54:FindFirstChild("GraphBlender")
        local u58 = v54:FindFirstChild("TotalKeyFrames")
        local v59 = v54:FindFirstChild("LifeTime")
        local u60 = p53:Clone()
        local v61 = {
            ["Brightness"] = v56:FindFirstChild("Brightness"),
            ["CurveSize0"] = v56:FindFirstChild("CurveSize0"),
            ["CurveSize1"] = v56:FindFirstChild("CurveSize1"),
            ["Width0"] = v56:FindFirstChild("Width0"),
            ["Width1"] = v56:FindFirstChild("Width1"),
            ["LightEmission"] = v56:FindFirstChild("LightEmission"),
            ["Segments"] = v56:FindFirstChild("Segments"),
            ["TextureLength"] = v56:FindFirstChild("TextureLength"),
            ["TextureSpeed"] = v56:FindFirstChild("TextureSpeed")
        }
        local u62 = {}
        for v63, v64 in pairs(v61) do
            if v64 then
                local v65 = v64.Size
                if not v65 or #v65.Keypoints <= 1 then
                    local v66 = u60[v63]
                    if v65 and #v65.Keypoints ~= 0 then
                        v66 = v65.Keypoints[1].Value
                    end
                    u60[v63] = v66
                else
                    u62[v63] = {
                        ["Sequence"] = v65,
                        ["Seed"] = u1.GenerateSeeds(v65, 20)[math.random(1, 20)]
                    }
                end
            end
        end
        local v67 = v57:FindFirstChild("ColorGraphs")
        local v68 = v57:FindFirstChild("TransparencyGraphs")
        local u69 = u2.RandomValueFromRange(v59.Lifetime)
        local u70 = {}
        local u71 = {}
        for _, v72 in pairs(v68:GetChildren()) do
            table.insert(u70, v72)
        end
        for _, v73 in pairs(v67:GetChildren()) do
            table.insert(u71, v73)
        end
        table.sort(u70, function(p74, p75) --[[ Line: 191 ]]
            return p74.Name < p75.Name
        end)
        table.sort(u71, function(p76, p77) --[[ Line: 192 ]]
            return p76.Name < p77.Name
        end)
        local u78 = 1
        local u79 = u71[u78]
        local u80 = 1
        local u81 = u70[u80]
        u60.Enabled = true
        u60.Parent = v55
        task.spawn(function() --[[ Line: 207 ]]
            --[[
            Upvalues:
                [1] = u58
                [2] = u6
                [3] = u69
                [4] = u60
                [5] = u81
                [6] = u70
                [7] = u80
                [8] = u79
                [9] = u71
                [10] = u78
                [11] = u1
                [12] = u62
            --]]
            local u82 = tick()
            local u83 = 0
            local u84 = 0
            local u85 = 0
            local u86 = (not u58 or u58.Value <= 0) and 100 or u58.Value
            local u87 = nil
            u87 = u6.Heartbeat:Connect(function() --[[ Line: 220 ]]
                --[[
                Upvalues:
                    [1] = u82
                    [2] = u69
                    [3] = u60
                    [4] = u87
                    [5] = u86
                    [6] = u83
                    [7] = u81
                    [8] = u85
                    [9] = u70
                    [10] = u80
                    [11] = u79
                    [12] = u84
                    [13] = u71
                    [14] = u78
                    [15] = u1
                    [16] = u62
                --]]
                local v88 = tick() - u82
                local v89 = v88 / u69
                if v89 > 1 or not u60.Parent then
                    u87:Disconnect()
                    if u60 and u60.Parent then
                        u60:Destroy()
                    end
                else
                    local v90 = v89 * u86
                    local v91 = math.floor(v90)
                    if u83 < v91 then
                        u83 = v91
                        local v92 = u83 / u86
                        if u81 and u81.DurationOfBlend then
                            local v93 = u81.DurationOfBlend.Value
                            if u85 + v93 < v88 and u70[u80 + 1] then
                                u85 = u85 + v93
                                u80 = u80 + 1
                                u81 = u70[u80]
                            end
                            local v94 = u79.DurationOfBlend.Value
                            if u84 + v94 < v88 and u71[u78 + 1] then
                                u84 = u84 + v94
                                u78 = u78 + 1
                                u79 = u71[u78]
                            end
                            local v95 = u81.Transparency.Transparency
                            local v96 = u81.BlendSpeed.Transparency
                            u60.Transparency = u1.BlendGraphWithTime(u60.Transparency, v95, v96, v92)
                            local v97 = u79.Color.Color
                            local v98 = u79.BlendSpeed.Transparency
                            u60.Color = u1.BlendColorGraphWithTime(u60.Color, v97, v98, v92)
                        end
                        for v99, v100 in pairs(u62) do
                            u60[v99] = u1.QueryPointsWithTime(v92, v100.Sequence, v100.Seed)
                        end
                    end
                end
            end)
        end)
    end
end
function u8.EnableEmit(_, u101) --[[ Line: 277 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    if u101:IsA("Beam") and u101:GetAttribute("EmitDelay") then
        task.delay(u101:GetAttribute("EmitDelay"), function() --[[ Line: 280 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u101
            --]]
            u8:Emit(u101)
        end)
    end
end
function u7.Transform(_, p102) --[[ Line: 286 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    if p102:IsA("Beam") then
        u5.Layouts.Beam.Factors:Clone().Parent = p102
        p102:SetAttribute("Transformed", true)
        p102:SetAttribute("EmitCount", 1)
        p102:SetAttribute("EmitDuration", 0)
        p102:SetAttribute("EmitDelay", 0)
        p102:SetAttribute("IsEmitter", true)
    elseif p102:IsA("Part") or p102:IsA("MeshPart") then
        u5.Layouts.Part.Factors:Clone().Parent = p102
        p102:SetAttribute("Transformed", true)
        p102:SetAttribute("EmitCount", 0)
        p102:SetAttribute("EmitDuration", 0)
        p102:SetAttribute("EmitDelay", 0)
        p102:SetAttribute("IsEmitter", true)
    end
end
function u7.Emit(_, u103, u104) --[[ Line: 305 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u4
        [5] = u51
        [6] = u9
        [7] = u6
    --]]
    if u103:FindFirstChild("Factors") then
        local v105 = {
            [Enum.NormalId.Top] = u103.CFrame.UpVector,
            [Enum.NormalId.Bottom] = -u103.CFrame.UpVector,
            [Enum.NormalId.Front] = u103.CFrame.LookVector,
            [Enum.NormalId.Back] = -u103.CFrame.LookVector,
            [Enum.NormalId.Left] = -u103.CFrame.RightVector,
            [Enum.NormalId.Right] = u103.CFrame.RightVector
        }
        local u106 = u103:FindFirstChildOfClass("SpecialMesh")
        local u107 = u103:FindFirstChildOfClass("Decal")
        local u108 = u103:FindFirstChild("Factors")
        local u109 = u108:FindFirstChild("TotalKeyFrames")
        local v110 = u108:FindFirstChild("MeshFlipbooks")
        local u111 = u108:FindFirstChild("Main")
        local u112 = u108:FindFirstChild("VelocityVectored")
        local u113 = u108:FindFirstChild("Main")
        local v114 = u108:FindFirstChild("Size")
        local u115 = v114:FindFirstChild("X")
        local u116 = v114:FindFirstChild("Y")
        local u117 = v114:FindFirstChild("Z")
        local v118 = u108:FindFirstChild("Rotation")
        local v119 = v118:FindFirstChild("X")
        local v120 = v118:FindFirstChild("Y")
        local v121 = v118:FindFirstChild("Z")
        local v122 = u108:FindFirstChild("RotationSpeed")
        local u123 = v122:FindFirstChild("X")
        local u124 = v122:FindFirstChild("Y")
        local u125 = v122:FindFirstChild("Z")
        local u126 = u108:FindFirstChild("Main")
        local v127 = u1.GenerateSeeds(u113.Size, 20)
        local v128 = u1.GenerateSeeds(u115.Size, 20)
        local v129 = u1.GenerateSeeds(u116.Size, 20)
        local v130 = u1.GenerateSeeds(u117.Size, 20)
        local v131 = u1.GenerateSeeds(u123.Squash, 20)
        local v132 = u1.GenerateSeeds(u124.Squash, 20)
        local v133 = u1.GenerateSeeds(u125.Squash, 20)
        local v134 = u1.GenerateSeeds(u126.Squash, 20)
        local v135 = u1.GenerateSeeds(u111.Transparency, 20)
        local v136 = math.random(1, 20)
        local u137 = v127[v136]
        local u138 = v128[v136]
        local u139 = v129[v136]
        local u140 = v130[v136]
        local u141 = v131[v136]
        local u142 = v132[v136]
        local u143 = v133[v136]
        local u144 = v134[v136]
        local u145 = v135[v136]
        local u146 = u2.RandomValueFromRange(u111.Lifetime)
        local v147 = u2.RandomValueFromRange(v119.Rotation)
        local v148 = u2.RandomValueFromRange(v120.Rotation)
        local v149 = u2.RandomValueFromRange(v121.Rotation)
        u103.Locked = true
        u103:SetAttribute("IsEmitter", false)
        for _, v150 in u103:GetDescendants() do
            if v150:IsA("ParticleEmitter") then
                v150.Enabled = false
            end
        end
        for _, v151 in u103:GetChildren() do
            if v151:IsA("Attachment") then
                u3.EnableEmitChildrenAndRepeatForAttachments(v151)
            end
            u3.EnableEmitSingle(v151)
        end
        if u107 then
            u4.Flip(u111, v110, u107, u146)
        end
        local v152 = u111.ShapeInOut == Enum.ParticleEmitterShapeInOut.InAndOut and u51[u111.Shape]
        if v152 then
            local v153, v154 = v152(u103, u111)
            if typeof(v154) == "CFrame" and u111.ShapeStyle == Enum.ParticleEmitterShapeStyle.Surface then
                local v155, v156, v157 = u103.CFrame:ToEulerAnglesXYZ()
                u103:PivotTo(CFrame.new((u103.CFrame * CFrame.new(v153)).Position) * v154 * CFrame.Angles(v155, v156, v157))
            else
                u103:PivotTo(CFrame.new((u103.CFrame * CFrame.new(v153)).Position) * u103.CFrame.Rotation)
            end
        end
        if u106 then
            u106.Scale = Vector3.new(0, 0, 0)
        else
            u103.Size = Vector3.new(0, 0, 0)
        end
        u103.CFrame = u103.CFrame * CFrame.Angles(math.rad(v147), math.rad(v148), (math.rad(v149)))
        local u158 = u103.Position
        local u159 = u111.EmissionDirection
        local u160
        if u112.Value == false then
            u160 = v105[u159]
        else
            local v161 = u9[u159] or u9[Enum.NormalId.Top]
            u160 = u103.CFrame[v161.vector] * v161.multiplier
        end
        local v162 = u111.SpreadAngle
        local v163, v164
        if v162.X > 0 or v162.Y > 0 then
            v163 = (math.random() * 2 - 1) * v162.X
            v164 = (math.random() * 2 - 1) * v162.Y
            u160 = (CFrame.lookAt(Vector3.new(), u160) * CFrame.Angles(math.rad(v163), math.rad(v164), 0)).LookVector
        else
            v164 = 0
            v163 = 0
        end
        local u165 = CFrame.Angles(math.rad(v163), math.rad(v164), 0)
        local _ = u160 * u1.QueryPointsWithTime(0.1, u126.Squash, u144)
        local u166 = u111.Acceleration
        local u167 = u104 and (u104 and u104.CFrame or CFrame.new()):ToObjectSpace(u103.CFrame) or u103.CFrame
        task.spawn(function() --[[ Line: 457 ]]
            --[[
            Upvalues:
                [1] = u109
                [2] = u6
                [3] = u146
                [4] = u108
                [5] = u103
                [6] = u1
                [7] = u113
                [8] = u137
                [9] = u115
                [10] = u138
                [11] = u116
                [12] = u139
                [13] = u117
                [14] = u140
                [15] = u123
                [16] = u141
                [17] = u124
                [18] = u142
                [19] = u125
                [20] = u143
                [21] = u126
                [22] = u144
                [23] = u111
                [24] = u145
                [25] = u166
                [26] = u158
                [27] = u160
                [28] = u104
                [29] = u167
                [30] = u106
                [31] = u107
                [32] = u112
                [33] = u165
                [34] = u9
                [35] = u159
            --]]
            local u168 = tick()
            local u169 = 0
            local u170 = (not u109 or (not u109.Value or u109.Value <= 0)) and 100 or u109.Value
            local u171 = nil
            u171 = u6.Heartbeat:Connect(function(u172) --[[ Line: 466 ]]
                --[[
                Upvalues:
                    [1] = u168
                    [2] = u146
                    [3] = u169
                    [4] = u170
                    [5] = u108
                    [6] = u103
                    [7] = u171
                    [8] = u1
                    [9] = u113
                    [10] = u137
                    [11] = u115
                    [12] = u138
                    [13] = u116
                    [14] = u139
                    [15] = u117
                    [16] = u140
                    [17] = u123
                    [18] = u141
                    [19] = u124
                    [20] = u142
                    [21] = u125
                    [22] = u143
                    [23] = u126
                    [24] = u144
                    [25] = u111
                    [26] = u145
                    [27] = u166
                    [28] = u158
                    [29] = u160
                    [30] = u104
                    [31] = u167
                    [32] = u106
                    [33] = u107
                    [34] = u112
                    [35] = u165
                    [36] = u9
                    [37] = u159
                --]]
                local u173 = (tick() - u168) / u146
                if u173 >= 1 or u170 <= u169 then
                    if u108:FindFirstChild("PartLife") == nil then
                        u103:Destroy()
                    else
                        task.delay(u108.PartLife.Value or 0, function() --[[ Line: 473 ]]
                            --[[
                            Upvalues:
                                [1] = u103
                            --]]
                            u103:Destroy()
                        end)
                    end
                    u171:Disconnect()
                else
                    local v174 = u173 * u170
                    local v175 = math.floor(v174)
                    if u169 < v175 then
                        u169 = v175
                        task.spawn(function() --[[ Line: 486 ]]
                            --[[
                            Upvalues:
                                [1] = u1
                                [2] = u173
                                [3] = u113
                                [4] = u137
                                [5] = u115
                                [6] = u138
                                [7] = u116
                                [8] = u139
                                [9] = u117
                                [10] = u140
                                [11] = u123
                                [12] = u141
                                [13] = u124
                                [14] = u142
                                [15] = u125
                                [16] = u143
                                [17] = u126
                                [18] = u144
                                [19] = u111
                                [20] = u145
                                [21] = u166
                                [22] = u158
                                [23] = u160
                                [24] = u172
                                [25] = u104
                                [26] = u167
                                [27] = u103
                                [28] = u106
                                [29] = u107
                                [30] = u112
                                [31] = u165
                                [32] = u9
                                [33] = u159
                            --]]
                            local v176 = u1.QueryPointsWithTime(u173, u113.Size, u137)
                            local v177 = u1.QueryPointsWithTime(u173, u115.Size, u138)
                            local v178 = u1.QueryPointsWithTime(u173, u116.Size, u139)
                            local v179 = u1.QueryPointsWithTime(u173, u117.Size, u140)
                            local v180 = u1.QueryPointsWithTime(u173, u123.Squash, u141)
                            local v181 = u1.QueryPointsWithTime(u173, u124.Squash, u142)
                            local v182 = u1.QueryPointsWithTime(u173, u125.Squash, u143)
                            local v183 = u1.QueryPointsWithTime(u173, u126.Squash, u144)
                            local v184 = u1.QueryPointsWithTime(u173, u111.Transparency, u145)
                            local v185 = u1.QueryColorPointWithTime(u173, u111.Color)
                            local v186 = u173
                            local v187 = u166 * v186
                            local v188 = -u111.Drag * v186
                            local v189 = u158 + u160 * (v183 * math.exp(v188)) * (u172 * 10) + v187 * (u172 * 10)
                            local v190 = CFrame.Angles(math.rad(v180), math.rad(v181), (math.rad(v182)))
                            local v191 = v189 - u158
                            local v192 = u104 and u104.CFrame or CFrame.new()
                            local v193 = v192:VectorToObjectSpace(v191)
                            u167 = CFrame.new(v193) * u167
                            u103.CFrame = v192 * u167
                            u103.CFrame = u103.CFrame * v190
                            u158 = u103.Position
                            if u106 then
                                u106.Scale = Vector3.new(v177, v178, v179)
                            else
                                u103.Size = Vector3.new(v177, v178, v179)
                            end
                            if u107 then
                                u107.Transparency = v184
                                u107.Color3 = Color3.fromRGB(v185.R * 255 * v176, v185.G * 255 * v176, v185.B * 255 * v176)
                            else
                                u103.Transparency = v184
                                u103.Color = v185
                            end
                            if u112.Value == true then
                                local v194 = u103.CFrame * u165
                                local v195 = u9[u159] or u9[Enum.NormalId.Top]
                                u160 = v194[v195.vector] * v195.multiplier
                            end
                        end)
                    end
                end
            end)
        end)
    end
end
function u7.Enable(u196, u197, u198) --[[ Line: 565 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    if u197:FindFirstChild("Factors") then
        _G.Part_Icles.EnableAllowed = false
        local v199 = u197:FindFirstChild("Factors")
        local u200 = v199:FindFirstChild("Main")
        local u201 = v199:FindFirstChild("Enabled")
        local u202 = v199:FindFirstChild("EnableWithRespectToEnable")
        local u203 = u7:GetFolder()
        if u196.EnabledParts[u197] then
            task.cancel(u196.EnabledParts[u197])
            u196.EnabledParts[u197] = nil
        end
        u196.EnabledParts[u197] = task.spawn(function() --[[ Line: 581 ]]
            --[[
            Upvalues:
                [1] = u196
                [2] = u197
                [3] = u201
                [4] = u202
                [5] = u198
                [6] = u203
                [7] = u200
            --]]
            if u201.Value then
                if u202 and u202.Value == true then
                    while u201.Value == true do
                        u197 = u197:Clone()
                        u196:Emit(u197, u198)
                        u197.Parent = u203
                        task.wait(1 / u200.Rate)
                    end
                    _G.Part_Icles.EnableAllowed = true
                else
                    while u201.Value == true do
                        local v204 = u197:Clone()
                        u196:Emit(v204, u198)
                        v204.Parent = u203
                        task.wait(1 / u200.Rate)
                    end
                    _G.Part_Icles.EnableAllowed = true
                end
                _G.Part_Icles.EnableAllowed = true
                u196.EnabledParts[u197] = nil
            else
                _G.Part_Icles.EnableAllowed = true
                u196.EnabledParts[u197] = nil
            end
        end)
    else
        warn(u197.Name .. "- is not Transformed")
    end
end
function u7.EnableEmit(u205, u206) --[[ Line: 616 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    local v207 = u206:FindFirstChild("Factors")
    if v207 then
        if u206:IsA("Beam") then
            u8:EnableEmit(u206)
            return
        end
        local v208 = u206:GetAttribute("EmitCount") or 0
        local v209 = u206:GetAttribute("EmitDelay") or 0
        local u210 = u206:GetAttribute("EmitDuration") or 0
        local u211 = v207:FindFirstChild("Enabled")
        local u212 = u205:GetFolder()
        local u213 = {}
        for v214 = 1, v208 do
            u213[v214] = u206:Clone()
        end
        task.delay(v209, function() --[[ Line: 632 ]]
            --[[
            Upvalues:
                [1] = u213
                [2] = u205
                [3] = u212
                [4] = u210
                [5] = u211
                [6] = u206
            --]]
            for _, v215 in u213 do
                u205:Emit(v215)
                v215.Parent = u212
                u205:EnableEmitChildren(v215)
            end
            if u210 > 0 then
                u211.Value = true
                u205:Enable(u206)
                task.wait(u210)
                u211.Value = false
            end
        end)
    end
end
function u7.EnableEmitChildren(u216, u217) --[[ Line: 648 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    for _, u218 in u217:GetChildren() do
        if u218:GetAttribute("Transformed") then
            local v219 = u218:FindFirstChild("Factors")
            if v219 then
                if u218:IsA("Beam") then
                    u8:EnableEmit(u218)
                else
                    local v220 = u218:GetAttribute("EmitCount") or 0
                    local v221 = u218:GetAttribute("EmitDelay") or 0
                    local u222 = u218:GetAttribute("EmitDuration") or 0
                    local u223 = v219:FindFirstChild("Enabled")
                    local u224 = u216:GetFolder()
                    local u225 = {}
                    for v226 = 1, v220 do
                        u225[v226] = u218:Clone()
                    end
                    task.delay(v221, function() --[[ Line: 667 ]]
                        --[[
                        Upvalues:
                            [1] = u225
                            [2] = u216
                            [3] = u217
                            [4] = u218
                            [5] = u224
                            [6] = u222
                            [7] = u223
                            [8] = u218
                        --]]
                        for _, v227 in u225 do
                            u216:Emit(v227, u217)
                            u216:EnableEmitChildren(v227, u218)
                            v227.Parent = u224
                        end
                        if u222 > 0 then
                            u223.Value = true
                            u216:Enable(u218, u217)
                            task.wait(u222)
                            u223.Value = false
                        end
                    end)
                end
            end
        end
    end
end
function u7._RecurCheck(p228, p229) --[[ Line: 685 ]]
    for _, v230 in p229:GetChildren() do
        if v230:GetAttribute("Transformed") then
            p228:EnableEmit(v230)
        else
            p228:_RecurCheck(v230)
        end
    end
end
function u7.AbsoluteEmit(p231, p232) --[[ Line: 694 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    if p232:GetAttribute("Transformed") then
        p231:EnableEmit(p232)
    else
        p231:_RecurCheck(p232)
        for _, v233 in p232:GetChildren() do
            if v233:IsA("BasePart") and v233:GetAttribute("Transformed") == nil then
                u3.EnableEmit(v233)
            end
        end
    end
end
return u7