local u1 = game:GetService("Players")
local u2 = require(script.Parent:WaitForChild("KnockbackModule"))
local u3 = script.Parent:WaitForChild("RemoteEvents"):FindFirstChild("NPCCombatVFX")
local u4 = require(script.Parent:WaitForChild("SlowManager"))
local u5 = require(script.Parent:WaitForChild("NPCDashModule"))
local u6 = require(script.Parent:WaitForChild("NPCAbilityConfig"))
local u7 = require(script.Parent:WaitForChild("NPCAbilityEngine"))
local u8 = require(script.Parent:WaitForChild("NPCSeparation"))
local u9 = {}
u9.__index = u9
local u10 = {
    ["attacksDealt"] = {},
    ["cleanupTime"] = {}
}
local u11 = 0
local function u22() --[[ Line: 46 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    local v12 = tick()
    for v13, v14 in pairs(u10.cleanupTime) do
        if v12 - v14 > 5 then
            u10.attacksDealt[v13] = nil
            u10.cleanupTime[v13] = nil
        else
            local v15 = u10.attacksDealt[v13]
            if v15 then
                for _, v16 in pairs(v15) do
                    local v17 = 0
                    local v18 = (1 / 0)
                    for v19 in pairs(v16) do
                        v17 = v17 + 1
                        v18 = math.min(v18, v19)
                    end
                    if v17 > 50 then
                        local v20 = v18 + v17 - 50
                        for v21 in pairs(v16) do
                            if v21 < v20 then
                                v16[v21] = nil
                            end
                        end
                    end
                end
            end
        end
    end
end
function u10.ApplyCappedM1Damage(p23, p24, p25, p26, p27, p28, p29) --[[ Line: 79 ]]
    --[[
    Upvalues:
        [1] = u22
    --]]
    if not p24 or (not p25 or (not p26 or (not p27 or p28 <= 0))) then
        return 0
    end
    p23.attacksDealt[p24] = p23.attacksDealt[p24] or {}
    p23.attacksDealt[p24][p25] = p23.attacksDealt[p24][p25] or {}
    p23.cleanupTime[p24] = tick()
    if p23.attacksDealt[p24][p25][p26] then
        return 0
    end
    if p29 and _G.ApplyDamageReductionIfPlayer then
        p28 = _G.ApplyDamageReductionIfPlayer(p29, p28)
    end
    if p29 then
        local v30 = game:GetService("Players"):GetPlayerFromCharacter(p29)
        if v30 and (_G.ObsHaki_TryDodge and _G.ObsHaki_TryDodge(v30)) then
            return 0
        end
    end
    local v31 = math.max(p28, 1)
    if v31 > 0 then
        p27:TakeDamage(v31)
        p23.attacksDealt[p24][p25][p26] = v31
        local v32 = p29 and _G.QuestlineSystem_OnDamageTaken and game:GetService("Players"):GetPlayerFromCharacter(p29)
        if v32 then
            _G.QuestlineSystem_OnDamageTaken(v32, v31)
        end
    end
    if math.random(1, 10) == 1 then
        u22()
    end
    return v31
end
function u10.ClearOldAttacks(p33, p34, p35) --[[ Line: 136 ]]
    if p33.attacksDealt[p34] then
        for _, v36 in pairs(p33.attacksDealt[p34]) do
            for v37 in pairs(v36) do
                if v37 < p35 - 10 then
                    v36[v37] = nil
                end
            end
        end
    end
end
local u38 = {
    ["Idle"] = "Idle",
    ["Chasing"] = "Chasing",
    ["Attacking"] = "Attacking",
    ["UsingAbility"] = "UsingAbility",
    ["Returning"] = "Returning"
}
local u46 = {
    ["lastAttackTime"] = {},
    ["attackingNow"] = {},
    ["MIN_ATTACK_INTERVAL"] = 0.45,
    ["CanAttack"] = function(p39, p40) --[[ Name: CanAttack, Line 165 ]]
        if p39.attackingNow[p40] then
            return false
        end
        local v41 = p39.lastAttackTime[p40] or 0
        return tick() - v41 >= p39.MIN_ATTACK_INTERVAL
    end,
    ["Lock"] = function(p42, p43) --[[ Name: Lock, Line 172 ]]
        p42.attackingNow[p43] = true
        p42.lastAttackTime[p43] = tick()
    end,
    ["Unlock"] = function(p44, p45) --[[ Name: Unlock, Line 177 ]]
        p44.attackingNow[p45] = false
    end
}
local u47 = {}
local u48 = 0
function u9.new(p49, p50) --[[ Line: 186 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u38
        [3] = u11
        [4] = u6
        [5] = u7
        [6] = u8
    --]]
    local v51 = u9
    local v52 = setmetatable({}, v51)
    v52.npcModel = p49
    v52.config = p50
    v52.humanoidRootPart = p49:WaitForChild("HumanoidRootPart")
    v52.humanoid = p49:WaitForChild("Humanoid")
    v52.animator = v52.humanoid:WaitForChild("Animator")
    v52.spawnPosition = v52.humanoidRootPart.Position
    v52.spawnCFrame = v52.humanoidRootPart.CFrame
    v52.currentState = u38.Idle
    v52.targetPlayer = nil
    v52.lastAttackTime = 0
    v52.loadedAnimations = {}
    v52.currentAnimationTrack = nil
    v52.humanoid.WalkSpeed = p50.walkSpeed or 16
    v52.originalNPCSpeed = v52.humanoid.WalkSpeed
    v52.npcModel:SetAttribute("OriginalWalkSpeed", v52.originalNPCSpeed)
    v52.isNPCSlowed = false
    v52.npcSlowEndTime = 0
    v52.isAttackSlowed = false
    v52.lastPlayerDetectedTime = tick()
    v52.lastReturnCheck = 0
    v52.returnStartTime = nil
    v52.returnDelay = p50.returnDelay or 3
    v52.forceTeleportDistance = p50.teleportBackDistanceStuds or 80
    v52.returnTriggerDistance = p50.returnTriggerDistanceStuds or 15
    v52.comboIndex = 1
    v52.lastComboTime = 0
    v52.lastPlayedComboIndex = 0
    v52.isAttacking = false
    v52.lastAttackId = 0
    u11 = u11 + 1
    v52.uniqueNPCId = "NPC_" .. u11 .. "_" .. tick()
    v52.lastVFXFireTime = 0
    v52.lastHandUsed = "right"
    v52.handComboMapping = {
        "left",
        "right",
        "left",
        "right"
    }
    v52.lastInAttackRangeTime = 0
    v52.lastAttacker = nil
    v52.lastAttackedTime = 0
    v52.hasBeenAggro = not p50.requireHitToAggro
    v52.abilityEngine = nil
    v52.lastAbilityCheckTime = 0
    v52.lastAbilityAttemptTick = 0
    if u6.HasAbilities(p49.Name) then
        v52.abilityEngine = u7.new(p49, p49.Name)
    end
    u8:Register(p49, v52.humanoidRootPart)
    return v52
end
function u9.start(p53) --[[ Line: 258 ]]
    p53:setupPlayerCleanup()
    p53:setupNPCSlowAndKnockbackOnHit()
    while p53.humanoid.Health > 0 do
        p53:checkForceTeleportBack()
        p53:checkSeaTeleport()
        p53:updateNPCSlow()
        p53:updateComboReset()
        p53:updateState()
        p53:executeState()
        task.wait(0.1)
    end
    p53:cleanup()
end
function u9.updateComboReset(p54) --[[ Line: 275 ]]
    if tick() - p54.lastComboTime > p54.config.comboResetTime and p54.comboIndex ~= 1 then
        p54.comboIndex = 1
        p54.lastPlayedComboIndex = 0
    end
end
function u9.getComboAnimationId(p55) --[[ Line: 283 ]]
    if p55.comboIndex == 1 then
        return p55.config.animationCombo1Id
    elseif p55.comboIndex == 2 then
        return p55.config.animationCombo2Id
    elseif p55.comboIndex == 3 then
        return p55.config.animationCombo3Id
    elseif p55.comboIndex == 4 then
        return p55.config.animationCombo4Id
    else
        return p55.config.animationCombo1Id
    end
end
function u9.advanceCombo(p56) --[[ Line: 292 ]]
    p56.comboIndex = p56.comboIndex + 1
    if p56.comboIndex > 4 then
        p56.comboIndex = 1
    end
    p56.lastComboTime = tick()
end
function u9.checkForceTeleportBack(p57) --[[ Line: 299 ]]
    if (p57.humanoidRootPart.Position - p57.spawnPosition).Magnitude > p57.forceTeleportDistance then
        p57:teleportToSpawn(true)
    end
end
function u9.shouldStartReturning(p58) --[[ Line: 307 ]]
    local v59 = (p58.humanoidRootPart.Position - p58.spawnPosition).Magnitude
    local v60 = tick() - p58.lastPlayerDetectedTime
    local v61 = p58.config.idleTeleportTimeoutSeconds or 8
    local v62
    if p58.returnTriggerDistance < v59 then
        v62 = v61 < v60
    else
        v62 = false
    end
    return v62
end
function u9.checkSeaTeleport(p63) --[[ Line: 317 ]]
    if p63.humanoidRootPart.Position.Y < -10 then
        p63:teleportToSpawn(true)
    end
end
function u9.teleportToSpawn(p64, p65) --[[ Line: 324 ]]
    --[[
    Upvalues:
        [1] = u38
    --]]
    local v66 = p64.humanoidRootPart.Position
    if _G.TriggerDespawnVFX then
        _G.TriggerDespawnVFX(v66)
    end
    if not p65 then
        task.wait(0.15)
    end
    p64.humanoidRootPart.CFrame = p64.spawnCFrame
    p64.targetPlayer = nil
    p64.returnStartTime = nil
    p64:setState(u38.Idle)
    p64.lastPlayerDetectedTime = tick()
    p64.comboIndex = 1
    p64.lastPlayedComboIndex = 0
    if p64.config.requireHitToAggro then
        p64.hasBeenAggro = false
        p64.lastAttacker = nil
    end
end
function u9.setupPlayerCleanup(u67) --[[ Line: 353 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1.PlayerRemoving:Connect(function(p68) --[[ Line: 354 ]]
        --[[
        Upvalues:
            [1] = u67
        --]]
        if u67.targetPlayer == p68 then
            u67.targetPlayer = nil
        end
    end)
end
function u9.setupNPCSlowAndKnockbackOnHit(u69) --[[ Line: 361 ]]
    --[[
    Upvalues:
        [1] = u38
    --]]
    local u70 = u69.humanoid.Health
    u69.humanoid.HealthChanged:Connect(function(p71) --[[ Line: 363 ]]
        --[[
        Upvalues:
            [1] = u70
            [2] = u69
            [3] = u38
        --]]
        if p71 < u70 then
            if not u69.hasBeenAggro then
                u69.hasBeenAggro = true
            end
            u69:applySlowToNPC()
            u69:applyKnockbackToNPC()
            local v72 = u69:findNearestPlayer()
            if v72 then
                u69.lastAttacker = v72
                u69.lastAttackedTime = tick()
                if _G.BreakPlayerInvisibility then
                    _G.BreakPlayerInvisibility(v72)
                end
            end
            if u69.currentState == u38.Returning then
                u69.returnStartTime = nil
                u69.lastPlayerDetectedTime = tick()
            end
        end
        u70 = p71
    end)
end
function u9.applyKnockbackToNPC(p73) --[[ Line: 393 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v74 = p73:findNearestPlayer()
    if v74 and v74.Character then
        u2:applyKnockbackBetween(v74.Character, p73.npcModel, p73.config.knockbackPower, p73.config.knockbackDuration)
    end
end
function u9.applySlowToNPC(p75) --[[ Line: 400 ]]
    if not p75.isNPCSlowed then
        p75.isNPCSlowed = true
        p75.npcSlowEndTime = tick() + p75.config.slowDurationSeconds
        local v76 = p75.config.slowSpeedReductionPercent / 100
        p75.humanoid.WalkSpeed = p75.originalNPCSpeed * (1 - v76)
    end
end
function u9.updateNPCSlow(p77) --[[ Line: 408 ]]
    if p77.isNPCSlowed and tick() >= p77.npcSlowEndTime then
        if not p77.isAttackSlowed then
            p77.humanoid.WalkSpeed = p77.originalNPCSpeed
        end
        p77.isNPCSlowed = false
    end
end
function u9.applyAttackSelfSlow(p78) --[[ Line: 417 ]]
    if p78.config.attackSelfSlowEnabled then
        if p78.isAttackSlowed then
            return
        else
            p78.isAttackSlowed = true
            local v79 = p78.config.attackSelfSlowPercent / 100
            local v80 = p78.originalNPCSpeed * (1 - v79)
            if p78.isNPCSlowed then
                local v81 = p78.config.slowSpeedReductionPercent / 100
                local v82 = p78.originalNPCSpeed * (1 - v81)
                p78.humanoid.WalkSpeed = math.min(v80, v82)
            else
                p78.humanoid.WalkSpeed = v80
            end
        end
    else
        return
    end
end
function u9.removeAttackSelfSlow(p83) --[[ Line: 432 ]]
    if p83.isAttackSlowed then
        p83.isAttackSlowed = false
        if p83.isNPCSlowed then
            local v84 = p83.config.slowSpeedReductionPercent / 100
            p83.humanoid.WalkSpeed = p83.originalNPCSpeed * (1 - v84)
        else
            p83.humanoid.WalkSpeed = p83.originalNPCSpeed
        end
    else
        return
    end
end
function u9.updateState(p85) --[[ Line: 443 ]]
    --[[
    Upvalues:
        [1] = u38
    --]]
    if p85.currentState == u38.Returning then
        local v86 = p85:findNearestPlayer()
        if v86 then
            local v87 = (p85.humanoidRootPart.Position - v86.Character.HumanoidRootPart.Position).Magnitude
            if v87 <= p85.config.detectionRangeStuds then
                p85.returnStartTime = nil
                p85.lastPlayerDetectedTime = tick()
                p85.targetPlayer = v86
                if v87 <= p85.config.attackRangeStuds then
                    p85:setState(u38.Attacking)
                else
                    p85:setState(u38.Chasing)
                end
            end
        end
        if p85.returnStartTime and tick() - p85.returnStartTime >= p85.returnDelay then
            p85:teleportToSpawn(false)
        end
        return
    elseif p85.currentState == u38.UsingAbility then
        if not (p85.abilityEngine and p85.abilityEngine:isBusy()) then
            p85:setState(u38.Idle)
        end
    else
        local v88 = p85:findNearestPlayer()
        if p85.humanoid.Health <= 0 then
            p85:setState(u38.Idle)
            return
        elseif v88 then
            p85.lastPlayerDetectedTime = tick()
            local v89 = (p85.humanoidRootPart.Position - v88.Character.HumanoidRootPart.Position).Magnitude
            local v90 = v89 <= p85.config.attackRangeStuds
            if v90 then
                p85.lastInAttackRangeTime = tick()
            end
            local v91
            if p85.currentState == u38.Attacking then
                v91 = tick() - p85.lastInAttackRangeTime <= (p85.config.attackExitGraceSeconds or 0.2)
            else
                v91 = false
            end
            if v90 or v91 then
                p85:setState(u38.Attacking)
                p85.targetPlayer = v88
                return
            elseif v89 <= p85.config.detectionRangeStuds then
                p85:setState(u38.Chasing)
                p85.targetPlayer = v88
                return
            elseif p85:shouldStartReturning() then
                p85:setState(u38.Returning)
                if not p85.returnStartTime then
                    p85.returnStartTime = tick()
                end
            else
                p85:setState(u38.Idle)
                p85.targetPlayer = nil
            end
        elseif p85:shouldStartReturning() then
            p85:setState(u38.Returning)
            if not p85.returnStartTime then
                p85.returnStartTime = tick()
            end
        else
            p85:setState(u38.Idle)
            p85.targetPlayer = nil
        end
    end
end
function u9.setState(p92, p93) --[[ Line: 531 ]]
    --[[
    Upvalues:
        [1] = u38
    --]]
    if p92.currentState ~= p93 then
        local v94 = p92.currentState
        p92.currentState = p93
        if p93 ~= u38.Attacking then
            p92.lastPlayedComboIndex = 0
        end
        if p93 == u38.Attacking then
            p92:applyAttackSelfSlow()
        elseif v94 == u38.Attacking then
            p92:removeAttackSelfSlow()
        end
        if v94 == u38.Returning and p93 ~= u38.Returning then
            p92.returnStartTime = nil
        end
    end
end
function u9.executeState(p95) --[[ Line: 552 ]]
    --[[
    Upvalues:
        [1] = u38
        [2] = u5
        [3] = u8
    --]]
    if p95.currentState == u38.Idle then
        p95:playAnimation(p95.config.animationIdleId, p95.config.idleAnimationSpeed)
        p95.humanoid:MoveTo(p95.humanoidRootPart.Position)
        return
    elseif p95.currentState == u38.Chasing then
        p95:playAnimation(p95.config.animationRunId, p95.config.runAnimationSpeed)
        if p95.targetPlayer and p95.targetPlayer.Character then
            local v96 = p95.targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            if v96 then
                local v97 = v96.Position
                if not p95:tryUseAbility() then
                    if u5.ShouldDash(p95.npcModel, p95.targetPlayer) then
                        u5.TryDash(p95.npcModel, p95.targetPlayer)
                    end
                    u8:SetTarget(p95.npcModel, p95.targetPlayer)
                    local v98 = u8:GetAdjustedPosition(p95.npcModel, p95.targetPlayer, v97)
                    p95.humanoid:MoveTo(v98)
                end
            else
                p95.humanoid:MoveTo(p95.humanoidRootPart.Position)
                return
            end
        else
            p95.humanoid:MoveTo(p95.humanoidRootPart.Position)
            return
        end
    elseif p95.currentState == u38.Attacking then
        if p95.targetPlayer and p95.targetPlayer.Character then
            local v99 = p95.targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            if v99 then
                local v100 = v99.Position
                u8:SetTarget(p95.npcModel, p95.targetPlayer)
                local v101 = u8:GetAdjustedPosition(p95.npcModel, p95.targetPlayer, v100)
                p95.humanoid:MoveTo(v101)
                if p95:tryUseAbility() then
                    return
                elseif not (p95.abilityEngine and p95.abilityEngine:isBusy()) then
                    p95:attemptAttack()
                end
            else
                p95.humanoid:MoveTo(p95.humanoidRootPart.Position)
                return
            end
        else
            p95.humanoid:MoveTo(p95.humanoidRootPart.Position)
            return
        end
    else
        if p95.currentState == u38.UsingAbility then
            if p95.npcModel:GetAttribute("IsDashing") then
                return
            end
            if not (p95.abilityEngine and (p95.abilityEngine:allowsMovement() and (p95.targetPlayer and p95.targetPlayer.Character))) then
                p95.humanoid:MoveTo(p95.humanoidRootPart.Position)
                return
            end
            local v102 = p95.targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            if v102 then
                p95:playAnimation(p95.config.animationRunId, p95.config.runAnimationSpeed)
                u8:SetTarget(p95.npcModel, p95.targetPlayer)
                local v103 = u8:GetAdjustedPosition(p95.npcModel, p95.targetPlayer, v102.Position)
                p95.humanoid:MoveTo(v103)
                return
            end
        elseif p95.currentState == u38.Returning then
            p95:playAnimation(p95.config.animationIdleId, p95.config.idleAnimationSpeed)
            p95.humanoid:MoveTo(p95.humanoidRootPart.Position)
        end
        return
    end
end
function u9.tryUseAbility(p104) --[[ Line: 629 ]]
    --[[
    Upvalues:
        [1] = u38
    --]]
    if not p104.abilityEngine then
        return false
    end
    if not (p104.targetPlayer and p104.targetPlayer.Character) then
        return false
    end
    if p104.currentState == u38.UsingAbility then
        return false
    end
    if p104.abilityEngine:isBusy() then
        return false
    end
    local v105 = os.clock()
    local v106 = v105 - p104.lastAbilityAttemptTick
    if math.abs(v106) < 0.05 then
        return false
    end
    p104.lastAbilityAttemptTick = v105
    if ((p104.abilityEngine.npcSettings or {}).AbilityCheckInterval or 0.5) > tick() - p104.lastAbilityCheckTime then
        return false
    end
    p104.lastAbilityCheckTime = tick()
    if not p104.abilityEngine:tryUseAbility(p104.targetPlayer.Character) then
        return false
    end
    p104:setState(u38.UsingAbility)
    return true
end
function u9.playAnimation(u107, u108, u109) --[[ Line: 660 ]]
    if u108 and u108 ~= 0 then
        pcall(function() --[[ Line: 669 ]]
            --[[
            Upvalues:
                [1] = u107
                [2] = u108
                [3] = u109
            --]]
            if not u107.loadedAnimations[u108] then
                local u110 = Instance.new("Animation")
                u110.AnimationId = "rbxassetid://" .. u108
                local u111 = (u108 == u107.config.animationCombo1Id or (u108 == u107.config.animationCombo2Id or u108 == u107.config.animationCombo3Id)) and true or u108 == u107.config.animationCombo4Id
                pcall(function() --[[ Line: 679 ]]
                    --[[
                    Upvalues:
                        [1] = u111
                        [2] = u110
                    --]]
                    if u111 then
                        u110.Priority = Enum.AnimationPriority.Action4
                    else
                        u110.Priority = Enum.AnimationPriority.Movement
                    end
                end)
                local u112 = u107.animator:LoadAnimation(u110)
                pcall(function() --[[ Line: 685 ]]
                    --[[
                    Upvalues:
                        [1] = u111
                        [2] = u112
                    --]]
                    if u111 then
                        u112.Priority = Enum.AnimationPriority.Action4
                    end
                end)
                if u111 then
                    u112.Looped = false
                end
                u107.loadedAnimations[u108] = u112
            end
            local v113 = u107.loadedAnimations[u108]
            if u107.currentAnimationTrack == v113 then
                if not v113.IsPlaying then
                    v113:Play(0.12)
                end
            else
                if u107.currentAnimationTrack then
                    u107.currentAnimationTrack:Stop(0.12)
                end
                u107.currentAnimationTrack = v113
                v113:Play(0.12)
            end
            v113:AdjustSpeed(u109 or 1)
        end)
    elseif u107.currentAnimationTrack then
        pcall(function() --[[ Line: 663 ]]
            --[[
            Upvalues:
                [1] = u107
            --]]
            u107.currentAnimationTrack:Stop(0.12)
        end)
        u107.currentAnimationTrack = nil
    end
end
function u9.attemptAttack(u114) --[[ Line: 702 ]]
    --[[
    Upvalues:
        [1] = u46
        [2] = u38
        [3] = u10
        [4] = u3
        [5] = u2
    --]]
    local v115 = tick()
    if u46:CanAttack(u114.uniqueNPCId) then
        if u114.isAttacking then
            if not u114.lastAttackTime or v115 - u114.lastAttackTime <= 1 then
                return
            end
            u114.isAttacking = false
        end
        if u114.abilityEngine and u114.abilityEngine:isBusy() then
            return
        elseif u114.currentState == u38.UsingAbility then
            return
        elseif u114.npcModel:GetAttribute("IsDashing") or u114.npcModel:GetAttribute("InAbility") then
            return
        elseif v115 - u114.lastAttackTime < 0.4 then
            return
        elseif v115 - u114.lastAttackTime < u114.config.attackCooldownSeconds then
            return
        elseif u114.targetPlayer and u114.targetPlayer.Character then
            local v116 = u114.targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            if v116 then
                if (u114.humanoidRootPart.Position - v116.Position).Magnitude > (u114.config.attackRangeStuds or 8) + 0.5 then
                    return
                else
                    u46:Lock(u114.uniqueNPCId)
                    u114.isAttacking = true
                    u114.lastAttackTime = v115
                    u114.lastAttackId = u114.lastAttackId + 1
                    local u117 = u114.lastAttackId
                    local v118 = u114.targetPlayer
                    if v118 then
                        v118 = u114.targetPlayer.Character
                    end
                    if v118 then
                        local v119 = v118:FindFirstChild("Humanoid")
                        if v119 and v119.Health > 0 then
                            u114:playAnimation(u114:getComboAnimationId(), u114.config.comboAnimationSpeed)
                            local v120 = v118:FindFirstChildOfClass("ForceField") == nil
                            if v120 then
                                u10:ApplyCappedM1Damage(u114.uniqueNPCId, u114.targetPlayer.UserId, u117, v119, u114.config.attackDamage, u114.targetPlayer.Character)
                            end
                            local v121 = u114.config.combatVFXWeapon or "Combat"
                            if v115 - u114.lastVFXFireTime >= 0.35 then
                                u114.lastVFXFireTime = v115
                                if u3 then
                                    u3:FireAllClients({
                                        ["NPCModel"] = u114.npcModel.Name,
                                        ["WeaponName"] = v121,
                                        ["ComboIndex"] = u114.comboIndex,
                                        ["Position"] = u114.humanoidRootPart.Position,
                                        ["DidHit"] = v120
                                    })
                                end
                            end
                            if v120 then
                                u114:applySlowToPlayer(u114.targetPlayer)
                                u2:applyKnockbackBetween(u114.npcModel, u114.targetPlayer.Character, u114.config.knockbackPower, u114.config.knockbackDuration)
                            end
                            if u114.abilityEngine then
                                u114.abilityEngine:onMeleeAttack()
                            end
                            local v122 = u114.handComboMapping[u114.comboIndex]
                            u114:advanceCombo()
                            u114.lastComboTime = v115
                            u114.lastHandUsed = v122
                            task.delay(0.4, function() --[[ Line: 828 ]]
                                --[[
                                Upvalues:
                                    [1] = u114
                                    [2] = u117
                                    [3] = u46
                                --]]
                                if u114.lastAttackId == u117 then
                                    u114.isAttacking = false
                                    u46:Unlock(u114.uniqueNPCId)
                                end
                            end)
                        else
                            u114.isAttacking = false
                            u46:Unlock(u114.uniqueNPCId)
                        end
                    else
                        u114.isAttacking = false
                        return
                    end
                end
            else
                return
            end
        else
            return
        end
    else
        return
    end
end
function u9.applySlowToPlayer(p123, p124) --[[ Line: 841 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    if p124 and p124.Character then
        local v125 = p123.npcModel
        local v126 = tostring(v125)
        u4:applySlow(p124, p123.config.slowDurationSeconds, p123.config.slowSpeedReductionPercent, v126)
    end
end
function u9.findNearestPlayer(p127) --[[ Line: 847 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u47
        [3] = u1
    --]]
    if not p127.hasBeenAggro then
        return nil
    end
    local v128 = tick()
    if v128 - u48 > 2 then
        u47 = u1:GetPlayers()
        u48 = v128
    end
    local v129 = v128 - (p127.lastAttackedTime or 0)
    local v130 = (v129 < 5 and 150 or p127.config.detectionRangeStuds) + 1
    local v131 = nil
    for _, v132 in u47 do
        if v132.Character then
            local v133 = v132.Character:FindFirstChild("Humanoid")
            local v134 = v132.Character:FindFirstChild("HumanoidRootPart")
            if v133 and (v133.Health > 0 and (v134 and (not _G.IsPlayerInvisible or (not _G.IsPlayerInvisible(v132) or p127.lastAttacker and (p127.lastAttacker == v132 and v129 < 5))))) then
                local v135 = (p127.humanoidRootPart.Position - v134.Position).Magnitude
                if v135 < v130 then
                    v131 = v132
                    v130 = v135
                end
            end
        end
    end
    return v131
end
function u9.cleanup(u136) --[[ Line: 891 ]]
    --[[
    Upvalues:
        [1] = u46
        [2] = u10
        [3] = u8
    --]]
    if u136.uniqueNPCId then
        u46:Unlock(u136.uniqueNPCId)
        u46.lastAttackTime[u136.uniqueNPCId] = nil
        u46.attackingNow[u136.uniqueNPCId] = nil
    end
    if u136.uniqueNPCId and u10.attacksDealt[u136.uniqueNPCId] then
        u10.attacksDealt[u136.uniqueNPCId] = nil
        u10.cleanupTime[u136.uniqueNPCId] = nil
    end
    u8:Unregister(u136.npcModel)
    u136:removeAttackSelfSlow()
    if u136.isNPCSlowed then
        u136.humanoid.WalkSpeed = u136.originalNPCSpeed
    end
    if u136.currentAnimationTrack then
        pcall(function() --[[ Line: 908 ]]
            --[[
            Upvalues:
                [1] = u136
            --]]
            u136.currentAnimationTrack:Stop(0.12)
        end)
    end
    for _, u137 in u136.loadedAnimations do
        pcall(function() --[[ Line: 909 ]]
            --[[
            Upvalues:
                [1] = u137
            --]]
            u137:Stop(0.12)
        end)
    end
    if u136.abilityEngine then
        u136.abilityEngine:cleanup()
    end
end
return u9