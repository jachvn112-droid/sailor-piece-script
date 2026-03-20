-- ═══════════════════════════════════════
-- HITBOX EXPANDER - Phóng to HitboxVisual_Box
-- Part nằm trong workspace
-- ═══════════════════════════════════════

local HITBOX_SIZE_MULTIPLIER = 10000  -- Nhân size lên x5 (chỉnh tùy ý)

local expanded = {}

-- Expand 1 part
local function tryExpand(part)
    if part:IsA("BasePart") and part.Name == "HitboxVisual_Box" and not expanded[part] then
        part.Size = part.Size * HITBOX_SIZE_MULTIPLIER
        part.Transparency = 1
        part.CanCollide = false
        expanded[part] = true
        print("✅ Expanded: " .. tostring(part.Size))
    end
end

-- Expand tất cả đang có
for _, obj in pairs(workspace:GetDescendants()) do
    tryExpand(obj)
end

-- Bắt mọi HitboxVisual_Box mới xuất hiện
workspace.DescendantAdded:Connect(function(obj)
    tryExpand(obj)
end)

-- Dọn tracking khi part bị xóa
workspace.DescendantRemoving:Connect(function(obj)
    if expanded[obj] then
        expanded[obj] = nil
    end
end)

print("🎯 Hitbox Expander loaded! Multiplier: x" .. HITBOX_SIZE_MULTIPLIER)
