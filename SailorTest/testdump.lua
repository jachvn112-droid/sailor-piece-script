local u1 = game:GetService("RunService")
local u2 = game:GetService("CollectionService")
local u3 = require(script.mod.logger)
local u4 = require(script.mod.utility)
local u5 = require(script.effects.beam)
local u6 = require(script.effects.spin)
local u7 = require(script.effects.mesh)
local u8 = require(script.effects.bezier)
local u9 = require(script.effects.screen)
local u10 = require(script.effects.particle)
local u11 = require(script.effects.camera_shake)
local u12 = require(script.effects.tween_property)
local u13 = require(script.effects.shockwave_ring)
local u14 = require(script.effects.shockwave_line)
local u15 = require(script.effects.shockwave_debris)
local u16 = require(script.pkg.Promise)
local u17 = require(script.obj.ObjectCache)
local u18 = script:FindFirstAncestorOfClass("Plugin")
local u19 = u1:IsServer() or u18
local u20 = {
    ["scope"] = {},
    ["setup"] = false
}
local function u30(p21, p22) --[[ Line: 116 ]]
    --[[
    Upvalues:
        [1] = u20
        [2] = u3
        [3] = u4
    --]]
    if not u20.setup then
        u3.error("API not initialized")
    end
    local u23 = u4.getRanomId()
    if not p21:IsA("Part") then
        local v24 = p21:Clone()
        v24.Archivable = false
        v24.Locked = true
        v24.Parent = workspace.Terrain
        table.insert(p22, v24)
        return v24
    end
    local v25 = u20.caches.shared_part:get(u23)
    v25.CFrame = p21.CFrame
    local v26 = v25._getReal()
    u4.copyProperties(p21, v26, u4.COPY_PART_PROPERTIES)
    u4.copyProperties(p21, v26, u4.COPY_EXTENDED_PART_PROPERTIES)
    local v27 = p21:Clone()
    for _, v28 in v27:GetChildren() do
        v28.Parent = v26
    end
    v27:Destroy()
    local function v29() --[[ Line: 140 ]]
        --[[
        Upvalues:
            [1] = u20
            [2] = u23
        --]]
        u20.caches.shared_part:free(u23)
    end
    table.insert(p22, v29)
    return v25
end
function u20.init(_) --[[ Line: 157 ]]
    --[[
    Upvalues:
        [1] = u20
        [2] = u19
        [3] = u4
        [4] = u3
        [5] = u1
        [6] = u18
        [7] = u17
        [8] = u11
        [9] = u8
        [10] = u13
        [11] = u14
        [12] = u15
        [13] = u2
        [14] = u7
        [15] = u30
    --]]
    if u20.setup then
        return
    else
        if u19 then
            task.spawn(function() --[[ Line: 163 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u3
                --]]
                local v31 = 0
                while true do
                    v31 = v31 + 1
                    local v32, v33 = pcall(u4.setCollisionGroups, u4.COLLISION_GROUPS)
                    if not v32 then
                        task.wait(v31)
                    end
                    if v32 or v31 >= 5 then
                        if not v32 then
                            u3.warn((("couldn\'t register necessary collision groups after %* tries with the last error being: %*"):format(v31, v33)))
                        end
                        return
                    end
                end
            end)
        end
        u20.setup = true
        if not u1:IsServer() or u18 then
            shared.vfx = u20
            local v34 = Instance.new("Part")
            v34.Transparency = 1
            v34.Anchored = true
            v34.CanCollide = false
            v34.CanQuery = false
            v34.Locked = true
            local v35 = Instance.new("Folder")
            v35.Name = "DO_NOT_REMOVE_ForgeSharedPartCache"
            v35.Archivable = false
            v35.Parent = workspace.Terrain
            u4.protectParent(u20.scope, v35)
            local u38 = u17.new(v34, v35, {
                ["size"] = 150,
                ["on_free"] = function(p36) --[[ Name: on_free, Line 217 ]]
                    local v37 = p36.value
                    v37.Transparency = 1
                    v37.Anchored = true
                    v37.CanQuery = false
                    v37.CanCollide = false
                    v37.CollisionGroup = "ForgeMouseIgnore"
                    v37.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    v37.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                    v37:ClearAllChildren()
                end
            })
            u20.caches = {
                ["shared_part"] = u38
            }
            local v39 = u20.scope
            local function v40() --[[ Line: 243 ]]
                --[[
                Upvalues:
                    [1] = u38
                --]]
                u38:destroy()
            end
            table.insert(v39, v40)
            u11.init()
            u8.init(u38)
            u13.init(u38)
            u14.init(u38)
            u15.init(u38)
            local v41 = Instance.new("Decal")
            local v42 = Instance.new("Part")
            v42.Name = "DO_NOT_REMOVE_ForgeTextureCache"
            v42.Transparency = 1
            v42.Size = Vector3.new(0, 0, 0)
            v42.Archivable = false
            v42.Anchored = true
            v42.CanCollide = false
            v42.CanQuery = false
            v42.Locked = true
            v42.Parent = workspace.Terrain
            u4.protectParent(u20.scope, v42)
            local u44 = u17.new(v41, v42, {
                ["size"] = 360,
                ["on_free"] = function(p43) --[[ Name: on_free, Line 272 ]]
                    p43.value.Texture = ""
                end
            })
            local u45 = {}
            local function v80(u46) --[[ Line: 279 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u44
                    [3] = u18
                    [4] = u2
                    [5] = u45
                --]]
                if u46:IsDescendantOf(workspace.Terrain) then
                    return
                elseif u4.isMeshVFX(u46) then
                    local u47 = u46:FindFirstChild("Start")
                    if u47 and u47:IsA("BasePart") then
                        local v48 = {}
                        local u49 = {}
                        table.insert(v48, u49)
                        local function v64() --[[ Line: 296 ]]
                            --[[
                            Upvalues:
                                [1] = u4
                                [2] = u49
                                [3] = u46
                                [4] = u47
                                [5] = u44
                                [6] = u18
                                [7] = u2
                            --]]
                            u4.cleanupScope(u49)
                            local v50, v51 = u4.getMeshDecals(u46, u47)
                            for _, u53 in v50 do
                                if typeof(u53) == "Instance" then
                                    local u53 = u53.Texture or u53
                                end
                                if u53 ~= "" then
                                    u44:get(u53).Texture = u53
                                    local v54 = u49
                                    local function v55() --[[ Line: 311 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u44
                                            [2] = u53
                                        --]]
                                        u44:free(u53)
                                    end
                                    table.insert(v54, v55)
                                end
                            end
                            for v56, v57 in v51 do
                                local v58 = false
                                if u18 then
                                    for _, v59 in u2:GetTags(v56) do
                                        if v59:match("^_local_flipbook_") then
                                            v58 = true
                                            break
                                        end
                                    end
                                end
                                for _, v60 in v57 do
                                    local u61 = ("%*%*"):format(v58 and "rbxtemp://" or "rbxassetid://", v60)
                                    if typeof(u61) == "Instance" then
                                        u61 = u61.Texture or u61
                                    end
                                    if u61 ~= "" then
                                        u44:get(u61).Texture = u61
                                        local v62 = u49
                                        local function v63() --[[ Line: 311 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u44
                                                [2] = u61
                                            --]]
                                            u44:free(u61)
                                        end
                                        table.insert(v62, v63)
                                    end
                                end
                            end
                        end
                        v64()
                        if u18 then
                            local v65 = u4.reboundfn(1, v64)
                            local v66 = u47.DescendantAdded
                            table.insert(v48, v66:Connect(v65))
                            local v67 = u47.DescendantRemoving
                            table.insert(v48, v67:Connect(v65))
                        end
                        u45[u46] = v48
                    end
                else
                    local v68 = {}
                    local u69 = {}
                    table.insert(v68, u69)
                    local function v76() --[[ Line: 354 ]]
                        --[[
                        Upvalues:
                            [1] = u4
                            [2] = u69
                            [3] = u44
                            [4] = u46
                        --]]
                        u4.cleanupScope(u69)
                        local function v74(p70) --[[ Line: 357 ]]
                            --[[
                            Upvalues:
                                [1] = u44
                                [2] = u69
                            --]]
                            if p70:IsA("ParticleEmitter") then
                                local u71 = p70.Texture
                                if u71 ~= "" then
                                    u44:get(u71).Texture = u71
                                    local v72 = u69
                                    local function v73() --[[ Line: 371 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u44
                                            [2] = u71
                                        --]]
                                        u44:free(u71)
                                    end
                                    table.insert(v72, v73)
                                end
                            else
                                return
                            end
                        end
                        v74(u46)
                        for _, v75 in u46:GetDescendants() do
                            v74(v75)
                        end
                    end
                    v76()
                    if u18 then
                        local v77 = u4.reboundfn(1, v76)
                        local v78 = u46.DescendantAdded
                        table.insert(v68, v78:Connect(v77))
                        local v79 = u46.DescendantRemoving
                        table.insert(v68, v79:Connect(v77))
                    end
                    u45[u46] = v68
                    return
                end
            end
            for _, v81 in u2:GetTagged(u4.TEXTURE_LOAD_TAG) do
                v80(v81)
            end
            u2:GetInstanceAddedSignal(u4.TEXTURE_LOAD_TAG):Connect(v80)
            u2:GetInstanceRemovedSignal(u4.TEXTURE_LOAD_TAG):Connect(function(p82) --[[ Line: 401 ]]
                --[[
                Upvalues:
                    [1] = u45
                    [2] = u4
                --]]
                local v83 = u45[p82]
                if v83 then
                    u4.cleanupScope(v83)
                    u45[p82] = nil
                end
            end)
            local v84 = u20.scope
            local function v86() --[[ Line: 410 ]]
                --[[
                Upvalues:
                    [1] = u44
                    [2] = u45
                    [3] = u4
                --]]
                u44:destroy()
                for _, v85 in u45 do
                    u4.cleanupScope(v85)
                end
            end
            table.insert(v84, v86)
            local u87 = {}
            local function v90(p88) --[[ Line: 422 ]]
                --[[
                Upvalues:
                    [1] = u87
                    [2] = u4
                --]]
                local v89 = u87[p88]
                if v89 then
                    u4.cleanupScope(v89)
                end
                u87[p88] = nil
            end
            local function u116(u91) --[[ Line: 432 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u87
                    [3] = u116
                    [4] = u1
                    [5] = u20
                    [6] = u7
                    [7] = u30
                    [8] = u8
                --]]
                local u92 = u4.isMeshVFX(u91)
                local u93 = u91:HasTag(u4.BEZIER_TAG)
                if u92 or u93 then
                    local v94 = {}
                    local u95 = {}
                    table.insert(v94, u95)
                    u87[u91] = v94
                    local v96 = u91.AncestryChanged
                    local function v99() --[[ Line: 449 ]]
                        --[[
                        Upvalues:
                            [1] = u91
                            [2] = u87
                            [3] = u116
                            [4] = u4
                        --]]
                        if u91:IsDescendantOf(workspace) or u91.Parent and u91.Parent:HasTag("AllowEmitting") then
                            if not u87[u91] then
                                u116(u91)
                                return
                            end
                        else
                            local v97 = u91
                            local v98 = u87[v97]
                            if v98 then
                                u4.cleanupScope(v98)
                            end
                            u87[v97] = nil
                        end
                    end
                    table.insert(v94, v96:Connect(v99))
                    if not u91:IsDescendantOf(workspace) then
                        local v100
                        if u91.Parent then
                            v100 = not u91.Parent:HasTag("AllowEmitting")
                        else
                            v100 = false
                        end
                        if v100 then
                            return
                        end
                    end
                    local function v114() --[[ Line: 466 ]]
                        --[[
                        Upvalues:
                            [1] = u4
                            [2] = u91
                            [3] = u95
                            [4] = u1
                            [5] = u20
                            [6] = u92
                            [7] = u7
                            [8] = u30
                            [9] = u93
                            [10] = u8
                        --]]
                        if u4.getAttribute(u91, "Enabled", true) then
                            local u101 = 0
                            local v102 = u95
                            local v103 = u1.RenderStepped
                            local function v113() --[[ Line: 474 ]]
                                --[[
                                Upvalues:
                                    [1] = u4
                                    [2] = u91
                                    [3] = u101
                                    [4] = u20
                                    [5] = u92
                                    [6] = u7
                                    [7] = u30
                                    [8] = u93
                                    [9] = u8
                                --]]
                                local v104 = u4.getAttribute(u91, "Rate", 5)
                                local v105 = u91:GetAttribute("SpeedOverride") or 1
                                if v105 == 0 then
                                    return
                                elseif os.clock() - u101 > 1 / v104 / v105 then
                                    local u106 = {
                                        ["depth"] = 0
                                    }
                                    local function v107() --[[ Line: 489 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u4
                                            [2] = u106
                                        --]]
                                        u4.cleanupScope(u106)
                                    end
                                    local v108 = u20.scope
                                    table.insert(v108, v107)
                                    if u92 then
                                        local v109 = u91:FindFirstChild("Start")
                                        if not v109 then
                                            u91:RemoveTag(u4.ENABLED_VFX_TAG)
                                            return
                                        end
                                        u101 = os.clock()
                                        for _ = 1, u4.getAttribute(u91, "EmitCount", 1) do
                                            u4.try(("failed to emit mesh \'%*\' with error: %%s"):format((u91:GetFullName())), u7.emit, u91, u30(v109, u106), u106, 1, true)
                                        end
                                    elseif u93 then
                                        local v110 = u91:FindFirstChildOfClass("Part")
                                        if not v110 then
                                            return
                                        end
                                        u101 = os.clock()
                                        local v111 = v110:Clone()
                                        v111.Locked = true
                                        table.insert(u106, v111)
                                        u4.try(("failed to emit bezier \'%*\' with error: %%s"):format((u91:GetFullName())), u8.emit, u91, v111, u106, true)
                                    end
                                    local v112 = table.find(u20.scope, v107)
                                    if v112 then
                                        table.remove(u20.scope, v112)
                                    end
                                    u4.cleanupScope(u106)
                                end
                            end
                            table.insert(v102, v103:Connect(v113))
                        else
                            u4.cleanupScope(u95)
                        end
                    end
                    local v115 = u91:GetAttributeChangedSignal("Enabled")
                    table.insert(v94, v115:Connect(v114))
                    v114()
                end
            end
            for _, v117 in u2:GetTagged(u4.ENABLED_VFX_TAG) do
                u116(v117)
            end
            u2:GetInstanceAddedSignal(u4.ENABLED_VFX_TAG):Connect(u116)
            u2:GetInstanceRemovedSignal(u4.ENABLED_VFX_TAG):Connect(v90)
            local v118 = u20.scope
            local function v120() --[[ Line: 566 ]]
                --[[
                Upvalues:
                    [1] = u87
                    [2] = u4
                --]]
                for _, v119 in u87 do
                    u4.cleanupScope(v119)
                end
            end
            table.insert(v118, v120)
        end
    end
end
function u20.deinit() --[[ Line: 574 ]]
    --[[
    Upvalues:
        [1] = u20
        [2] = u1
        [3] = u18
        [4] = u4
        [5] = u8
        [6] = u11
        [7] = u13
        [8] = u14
        [9] = u15
    --]]
    if u20.setup then
        u20.setup = false
        shared.vfx = nil
        if not u1:IsServer() or u18 then
            u4.cleanupScope(u20.scope)
            u8.deinit()
            u11.deinit()
            u13.deinit()
            u14.deinit()
            u15.deinit()
        end
    else
        return
    end
end
function u20.emit(p121, ...) --[[ Line: 596 ]]
    --[[
    Upvalues:
        [1] = u20
        [2] = u3
        [3] = u16
        [4] = u4
        [5] = u10
        [6] = u5
        [7] = u8
        [8] = u7
        [9] = u30
        [10] = u6
        [11] = u11
        [12] = u12
        [13] = u13
        [14] = u15
        [15] = u14
        [16] = u9
    --]]
    if not u20.setup then
        u3.error("not initialized")
    end
    local u122 = {}
    local u123 = {}
    local u124 = 1
    local function u144(u125, u126) --[[ Line: 606 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u4
            [3] = u123
            [4] = u122
            [5] = u10
            [6] = u124
            [7] = u5
            [8] = u8
            [9] = u7
            [10] = u30
            [11] = u6
            [12] = u11
            [13] = u12
            [14] = u13
            [15] = u15
            [16] = u14
        --]]
        return u16.new(function(p127) --[[ Line: 607 ]]
            --[[
            Upvalues:
                [1] = u126
                [2] = u125
                [3] = u4
                [4] = u123
                [5] = u122
                [6] = u10
                [7] = u124
                [8] = u5
                [9] = u8
                [10] = u16
                [11] = u7
                [12] = u30
                [13] = u6
                [14] = u11
                [15] = u12
                [16] = u13
                [17] = u15
                [18] = u14
            --]]
            (function() --[[ Name: run, Line 608 ]]
                --[[
                Upvalues:
                    [1] = u126
                    [2] = u125
                    [3] = u4
                    [4] = u123
                    [5] = u122
                    [6] = u10
                    [7] = u124
                    [8] = u5
                    [9] = u8
                    [10] = u16
                    [11] = u7
                    [12] = u30
                    [13] = u6
                    [14] = u11
                    [15] = u12
                    [16] = u13
                    [17] = u15
                    [18] = u14
                --]]
                local u128 = {
                    ["depth"] = u126
                }
                if u125:IsA("ParticleEmitter") then
                    if u125:IsDescendantOf(workspace) then
                        u4.try(("failed to emit particle \'%*\' with error: %%s"):format((u125:GetFullName())), u10.emit, u125, u125, u128, u124)
                        u4.cleanupScope(u128)
                    else
                        local v129, v130 = u4.cloneParticleAncestry(u125, u123)
                        if not v129 then
                            return
                        end
                        table.insert(u128, v130)
                        local v131 = u125:Clone()
                        v131.Archivable = false
                        v131.Parent = v129
                        if not u122[v130] then
                            v130.Parent = workspace.Terrain
                        end
                        if u122[v130] then
                            local v132 = u122
                            v132[v130] = v132[v130] + 1
                        else
                            u122[v130] = 1
                        end
                        u4.try(("failed to emit particle \'%*\' with error: %%s"):format((u125:GetFullName())), u10.emit, u125, v131, u128, u124)
                        local v133 = u122
                        v133[v130] = v133[v130] - 1
                        if u122[v130] <= 0 then
                            u4.cleanupScope(u128)
                        end
                    end
                elseif u125:IsA("Beam") then
                    local v134 = u125:Clone()
                    v134.Archivable = false
                    v134.Parent = workspace.Terrain
                    table.insert(u128, v134)
                    u4.try(("failed to emit beam \'%*\' with error: %%s"):format((u125:GetFullName())), u5.emit, u125, v134, u128, u124)
                    u4.cleanupScope(u128)
                elseif u125:IsA("Trail") then
                    u125.Enabled = true
                elseif u125:HasTag(u4.BEZIER_TAG) then
                    local v135 = u125:FindFirstChildOfClass("Part")
                    if not v135 then
                        return
                    end
                    if u125:GetAttribute("Enabled") then
                        u125:SetAttribute("Enabled", false)
                    end
                    local v136 = v135:Clone()
                    v136.Locked = true
                    table.insert(u128, v136)
                    u4.try(("failed to emit bezier \'%*\' with error: %%s"):format((u125:GetFullName())), u8.emit, u125, v136, u128)
                    u4.cleanupScope(u128)
                elseif u4.isMeshVFX(u125) then
                    local u137 = u125:FindFirstChild("Start")
                    if not u137 then
                        return
                    end
                    if u125:GetAttribute("Enabled") then
                        u125:SetAttribute("Enabled", false)
                    end
                    local v138 = {}
                    for _ = 1, u4.getAttribute(u125, "EmitCount", 1) do
                        local v139 = u16.new
                        local function v141(p140) --[[ Line: 714 ]]
                            --[[
                            Upvalues:
                                [1] = u4
                                [2] = u125
                                [3] = u7
                                [4] = u30
                                [5] = u137
                                [6] = u128
                                [7] = u124
                            --]]
                            u4.try(("failed to emit mesh \'%*\' with error: %%s"):format((u125:GetFullName())), u7.emit, u125, u30(u137, u128), u128, u124)
                            p140()
                        end
                        table.insert(v138, v139(v141))
                    end
                    u16.all(v138):await()
                    u4.cleanupScope(u128)
                elseif u125:IsA("Model") then
                    if u4.lock(u125) then
                        return
                    end
                    u4.try(("failed to emit spinning model \'%*\' with error: %%s"):format((u125:GetFullName())), u6.emit, u125, u128)
                    u4.cleanupScope(u128)
                    u4.unlock(u125)
                elseif u125:IsA("RayValue") then
                    if u125:HasTag(u4.SCREENSHAKE_TAG) then
                        u4.try(("failed to emit camera shake \'%*\' with error: %%s"):format((u125:GetFullName())), u11.emit, u125, u128)
                        u4.cleanupScope(u128)
                    else
                        if not u125.Parent or u4.lock(u125) then
                            return
                        end
                        u4.try(("failed to emit tween property \'%*\' with error: %%s"):format((u125:GetFullName())), u12.emit, u125.Parent, u125, u128)
                        u4.unlock(u125)
                        u4.cleanupScope(u128)
                    end
                end
                local v142 = u125:IsA("Part") and u4.findFirstClassWithTag(u125, "Attachment", u4.SHOCKWAVE_TAG)
                if v142 then
                    local v143 = u125.Parent.Name
                    if v143 == "Rings" then
                        u4.try(("failed to emit shockwave ring \'%*\' with error: %%s"):format((u125:GetFullName())), u13.emit, v142, u125, u128)
                        u4.cleanupScope(u128)
                        return
                    end
                    if v143 == "Debris" then
                        u4.try(("failed to emit shockwave debris \'%*\' with error: %%s"):format((u125:GetFullName())), u15.emit, v142, u125, u128)
                        u4.cleanupScope(u128)
                        return
                    end
                    if v143 == "Lines" then
                        u4.try(("failed to emit shockwave line \'%*\' with error: %%s"):format((u125:GetFullName())), u14.emit, v142, u125, u128)
                        u4.cleanupScope(u128)
                    end
                end
            end)()
            p127()
        end)
    end
    local v145 = { ... }
    if typeof(p121) == "number" then
        u124 = p121
    else
        table.insert(v145, p121)
    end
    local u146 = {}
    local function u159(p147, p148, p149) --[[ Line: 827 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u9
            [3] = u159
            [4] = u146
            [5] = u16
            [6] = u144
        --]]
        for _, u150 in p148 do
            if u150:IsA("BasePart") and (u150:GetAttribute("Enabled") and not u4.findFirstClassWithTag(u150, "Attachment", u4.SHOCKWAVE_TAG)) then
                if not u4.lock(u150) then
                    local v151 = u150:FindFirstAncestorOfClass("Model")
                    if not v151 or v151:GetAttribute("SpinRotation") == Vector3.new(0, 0, 0) and (v151:GetAttribute("Scale_Start") == 1 and v151:GetAttribute("Scale_End") == 1) then
                        local u152 = coroutine.running()
                        local u153 = {
                            ["depth"] = p147
                        }
                        if u4.try(("failed to emit screen effect \'%*\' with error: %%s"):format((u150:GetFullName())), u9.emit, u150, u153) then
                            if #u150:GetDescendants() == 0 then
                                u4.cleanupScope(u153)
                                return
                            end
                            local v154 = {}
                            u159(p147 + 1, u150:GetChildren(), v154)
                            local v155 = u146
                            local v156 = u16.all(v154)
                            local function v157() --[[ Line: 873 ]]
                                --[[
                                Upvalues:
                                    [1] = u4
                                    [2] = u150
                                    [3] = u152
                                    [4] = u153
                                --]]
                                u4.unlock(u150, u152)
                                u4.cleanupScope(u153)
                            end
                            table.insert(v155, v156:finally(v157))
                        end
                    end
                end
            else
                local v158 = u144
                table.insert(p149, v158(u150, p147))
                if not (u150:HasTag(u4.BEZIER_TAG) or (u4.isMeshVFX(u150) or u150:IsA("BasePart") and u4.findFirstClassWithTag(u150, "Attachment", u4.SHOCKWAVE_TAG))) then
                    u159(p147 + 1, u150:GetChildren(), p149)
                end
            end
        end
    end
    u159(0, v145, u146)
    return {
        ["Finished"] = u16.all(u146)
    }
end
return u20