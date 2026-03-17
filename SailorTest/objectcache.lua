local u1 = require("../mod/utility")
local u2 = {}
u2.__index = u2
local u3 = table.create(10000)
local u4 = table.create(10000)
local u5 = false
local u6 = coroutine.create(function() --[[ Line: 54 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u5
    --]]
    while true do
        workspace:BulkMoveTo(u3, u4, Enum.BulkMoveMode.FireCFrameChanged)
        table.clear(u3)
        table.clear(u4)
        u5 = false
        coroutine.yield()
    end
end)
function u2.new(p7, p8, p9) --[[ Line: 67 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v10 = u2
    local u11 = setmetatable({}, v10)
    u11.ref = p7
    u11.parent = p8
    u11.amount = 0
    u11.restore_amount = 0
    local v12 = p9 or {}
    for v13, v14 in {
        ["size"] = 100,
        ["excess_lifetime"] = 30
    } do
        if v12[v13] == nil then
            v12[v13] = v14
        end
    end
    u11.params = v12
    u11.scope = { p7, p8 }
    u11.unused = table.create(u11.params.size)
    u11.item_map = {}
    u11.part_mode = p7:IsA("BasePart")
    for _ = 1, u11.params.size do
        u11:_add()
    end
    local v15 = u11.scope
    local v16 = task.spawn
    table.insert(v15, v16(function() --[[ Line: 93 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        while true do
            if not task.wait(15) then
                return
            end
            if u11.restore_amount > 0 then
                for _ = 1, u11.restore_amount do
                    u11:_add()
                    local v17 = u11
                    v17.restore_amount = v17.restore_amount - 1
                end
            end
            if u11.amount > u11.params.size then
                local v18 = 0
                for v19 = 1, #u11.unused do
                    if u11.amount <= u11.params.size then
                        break
                    end
                    local v20 = v19 - v18
                    local v21 = u11.unused[v20]
                    if v21.dependents == 0 and os.clock() - v21.added <= u11.params.excess_lifetime then
                        v21:destroy()
                        table.remove(u11.unused, v20)
                        u11.item_map[v21.key] = nil
                        local v22 = u11
                        v22.amount = v22.amount - 1
                        v18 = v18 + 1
                    end
                end
            end
        end
    end))
    return u11
end
function u2._add(u23, p24, p25) --[[ Line: 137 ]]
    local u26 = u23.ref:Clone()
    u26.Archivable = false
    u26.Parent = u23.parent
    local u27 = {
        ["key"] = p24,
        ["value"] = u26,
        ["added"] = os.clock(),
        ["dependents"] = 1
    }
    local u28 = false
    function u27.destroy(_) --[[ Line: 152 ]]
        --[[
        Upvalues:
            [1] = u28
            [2] = u26
        --]]
        u28 = true
        u26:Destroy()
    end
    u23.amount = u23.amount + 1
    u26.Destroying:Connect(function() --[[ Line: 159 ]]
        --[[
        Upvalues:
            [1] = u28
            [2] = u23
            [3] = u27
        --]]
        if not u28 then
            local v29 = table.find(u23.unused, u27)
            if v29 then
                table.remove(u23.unused, v29)
            end
            if u27.key then
                u23.item_map[u27.key] = nil
            end
            local v30 = u23
            v30.amount = v30.amount - 1
            local v31 = u23
            v31.restore_amount = v31.restore_amount + 1
        end
    end)
    if p24 then
        u23.item_map[p24] = u27
    end
    if not p25 then
        local v32 = u23.unused
        table.insert(v32, u27)
    end
    return u27
end
function u2.has(p33, p34) --[[ Line: 189 ]]
    return p33.item_map[p34] and true or false
end
function u2.peek(p35, p36) --[[ Line: 193 ]]
    return p35.item_map[p36]
end
function u2.get(p37, p38) --[[ Line: 197 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u5
        [4] = u6
    --]]
    if p37:has(p38) then
        local v39 = p37:peek(p38)
        if v39 then
            v39.dependents = v39.dependents + 1
        end
        return v39.value
    end
    local u40 = table.remove(p37.unused)
    if u40 then
        u40.key = p38
        u40.added = os.clock()
        p37.item_map[p38] = u40
    else
        u40 = p37:_add(p38, true)
    end
    if not p37.part_mode then
        return u40.value
    end
    local v48 = {
        ["__newindex"] = function(_, p41, p42) --[[ Name: __newindex, Line 222 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u40
                [3] = u4
                [4] = u5
                [5] = u6
            --]]
            if p41 == "CFrame" then
                local v43 = u3
                local v44 = u40.value
                table.insert(v43, v44)
                local v45 = u4
                table.insert(v45, p42)
                if not u5 then
                    u5 = true
                    task.defer(u6)
                    return
                end
            else
                u40.value[p41] = p42
            end
        end,
        ["__index"] = function(_, p46) --[[ Name: __index, Line 236 ]]
            --[[
            Upvalues:
                [1] = u40
            --]]
            local u47 = u40.value[p46]
            return typeof(u47) == "function" and function(_, ...) --[[ Line: 240 ]]
                --[[
                Upvalues:
                    [1] = u47
                    [2] = u40
                --]]
                return u47(u40.value, ...)
            end or u47
        end
    }
    return setmetatable({
        ["_getReal"] = function() --[[ Name: _getReal, Line 249 ]]
            --[[
            Upvalues:
                [1] = u40
            --]]
            return u40.value
        end
    }, v48)
end
function u2.free(p49, p50) --[[ Line: 258 ]]
    local v51 = p49.item_map[p50]
    if v51 then
        local v52 = v51.dependents - 1
        v51.dependents = math.max(v52, 0)
        if v51.dependents == 0 then
            v51.added = os.clock()
            if p49.params.on_free then
                task.spawn(p49.params.on_free, v51)
            end
            local v53 = p49.unused
            table.insert(v53, v51)
        end
    end
end
function u2.destroy(p54) --[[ Line: 278 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1.cleanupScope(p54.scope)
    for _, v55 in p54.item_map do
        v55.value:Destroy()
    end
    table.clear(p54.unused)
    table.clear(p54.item_map)
end
return u2