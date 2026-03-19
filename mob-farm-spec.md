# Sailor Piece — MOB FARM SPEC (Tài liệu tham khảo)

> **Mục đích**: File này ghi rõ toàn bộ thông tin để remake auto farm theo MOB (không auto level).  
> Khi quên, hãy đọc file này lại để làm đúng y như thiết kế.

---

## 1. NGUYÊN TẮC HOẠT ĐỘNG

### 1.1 Farm theo MOB (không theo level)
- Người dùng **chọn tên mob** trong danh sách (ví dụ: "Thief", "Monkey", "DesertBandit"...).
- Script sẽ:
  1. **Teleport đến đảo** chứa mob đó (dùng `TeleportToPortal` remote).
  2. **Nhận quest** tương ứng (dùng `QuestAccept` remote).
  3. **Teleport đến sau lưng / phía trên mob** (có thanh điều chỉnh khoảng cách).
  4. **Đánh mob** bằng `RequestHit` remote cho đến khi hoàn thành quest.
  5. **Lặp lại**: nhận quest → đánh → hoàn thành → nhận lại.

### 1.2 Anti-Teleport của game
- Game có hệ thống **anti-teleport**: nếu teleport đến 1 chỗ quá xa sẽ bị đá về (rubber-band).
- Giải pháp: Dùng remote `TeleportToPortal` để di chuyển hợp lệ đến đảo, sau đó mới tween/teleport đến mob.

### 1.3 Gộp mob cùng loại
- Trong game có Thief1, Thief2, Thief3, Thief4, Thief5 → **gộp thành 1 mục "Thief"** trong UI.
- Script tự tìm con Thief gần nhất trong `workspace.NPCs` mà tên bắt đầu bằng "Thief" (và không phải "ThiefBoss").

---

## 2. REMOTES QUAN TRỌNG

### 2.1 Nhận Quest
```lua
local args = { "QuestNPC1" }  -- thay QuestNPC1 bằng tên quest NPC tương ứng
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("QuestAccept"):FireServer(unpack(args))
```

### 2.2 Teleport đến đảo (hợp lệ, không bị anti-tp)
```lua
local args = { "Starter" }  -- thay "Starter" bằng tên đảo tương ứng
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TeleportToPortal"):FireServer(unpack(args))
```

### 2.3 Đánh mob (Hit Remote)
```lua
game:GetService("ReplicatedStorage"):WaitForChild("CombatSystem"):WaitForChild("Remotes"):WaitForChild("RequestHit"):FireServer()
```

### 2.4 Vị trí mob trong workspace
```lua
workspace.NPCs  -- Tất cả mob/NPC nằm trong đây
-- Ví dụ: workspace.NPCs.Thief1, workspace.NPCs.MonkeyBoss, workspace.NPCs.DesertBandit3...
```

---

## 3. DANH SÁCH MOB ĐẦY ĐỦ (sắp xếp theo Level)

| # | QuestNPC | Tên hiển thị UI | npcType (trong game) | Level | Đảo (TeleportToPortal) | Số lượng kill | Loại |
|---|----------|-----------------|---------------------|-------|----------------------|---------------|------|
| 1 | QuestNPC1 | Thief | Thief | 0 | Starter | 5 | Mob |
| 2 | QuestNPC2 | Thief Boss | ThiefBoss | 100 | Starter | 1 | Boss |
| 3 | QuestNPC3 | Monkey | Monkey | 250 | Jungle | 5 | Mob |
| 4 | QuestNPC4 | Monkey Boss | MonkeyBoss | 500 | Jungle | 1 | Boss |
| 5 | QuestNPC5 | Desert Bandit | DesertBandit | 750 | Desert | 5 | Mob |
| 6 | QuestNPC6 | Desert Boss | DesertBoss | 1000 | Desert | 1 | Boss |
| 7 | QuestNPC7 | Frost Rogue | FrostRogue | 1500 | Snow | 5 | Mob |
| 8 | QuestNPC8 | Winter Warden (Snow Boss) | SnowBoss | 2000 | Snow | 1 | Boss |
| 9 | QuestNPC9 | Sorcerer | Sorcerer | 3000 | JJK | 5 | Mob |
| 10 | QuestNPC10 | Panda Sorcerer Boss | PandaMiniBoss | 4000 | JJK | 1 | Boss |
| 11 | QuestNPC11 | Hollow | Hollow | 5000 | Hollow | 5 | Mob |
| 12 | QuestNPC12 | Strong Sorcerer | StrongSorcerer | 6250 | JJK2 | 5 | Mob |
| 13 | QuestNPC13 | Curse | Curse | 7000 | Curse | 5 | Mob |
| 14 | QuestNPC14 | Slime Warrior | SlimeWarrior | 8000 | Slime | 5 | Mob |
| 15 | QuestNPC15 | Academy Teacher | AcademyTeacher | 9000 | Academy | 5 | Mob |
| 16 | QuestNPC16 | Swordsman | Swordsman | 10000 | Swordsman | 5 | Mob |
| 17 | QuestNPC17 | Quincy | Quincy | 10750 | Quincy | 5 | Mob |

> **LƯU Ý**: Cột "Đảo" là giá trị truyền vào `TeleportToPortal`.  
> Các tên đảo cần kiểm tra lại chính xác trong `TravelConfig` module.  
> Nếu đảo sai, mob sẽ không tìm thấy.

---

## 4. CÁCH TÌM MOB TRONG WORKSPACE

```lua
-- Hàm tìm mob gần nhất theo npcType
local function findNearestMob(npcType)
    local npcs = workspace:FindFirstChild("NPCs")
    if not npcs then return nil end
    
    local player = game.Players.LocalPlayer
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    
    local myPos = char.HumanoidRootPart.Position
    local nearest = nil
    local nearestDist = math.huge
    
    for _, npc in pairs(npcs:GetChildren()) do
        -- Gộp mob: Thief1, Thief2... → tất cả match "Thief"
        -- Nhưng KHÔNG match ThiefBoss nếu đang tìm Thief
        local npcName = npc.Name
        local isMatch = false
        
        if npcName == npcType then
            isMatch = true
        elseif npcName:match("^" .. npcType .. "%d+$") then
            -- Thief1, Thief2, Thief3... match "Thief"
            isMatch = true
        end
        
        if isMatch then
            local hrp = npc:FindFirstChild("HumanoidRootPart")
            local hum = npc:FindFirstChild("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local dist = (hrp.Position - myPos).Magnitude
                if dist < nearestDist then
                    nearestDist = dist
                    nearest = npc
                end
            end
        end
    end
    
    return nearest
end
```

---

## 5. HỆ THỐNG VỊ TRÍ FARM (Sau lưng / Phía trên)

### 5.1 Hai chế độ farm
- **Sau lưng mob (Behind)**: Teleport ra sau lưng mob, an toàn hơn.
- **Phía trên mob (Above)**: Teleport lên trên đầu mob, tránh skill mob.

### 5.2 Thanh điều chỉnh khoảng cách
- Slider từ **5** đến **50** studs (mặc định 15).
- Giá trị này quyết định xa/gần mob bao nhiêu khi farm.

### 5.3 Code tính vị trí farm
```lua
local FarmDistance = 15     -- Thanh slider điều chỉnh (5-50)
local FarmMode = "Behind"   -- "Behind" hoặc "Above"

local function getFarmPosition(mob)
    local mobHRP = mob:FindFirstChild("HumanoidRootPart")
    if not mobHRP then return nil end
    
    if FarmMode == "Behind" then
        -- Sau lưng mob: lấy hướng mob đang nhìn, đi ngược lại
        local lookVector = mobHRP.CFrame.LookVector
        return mobHRP.CFrame * CFrame.new(0, 0, FarmDistance)
        -- Hoặc đơn giản: mobHRP.Position - lookVector * FarmDistance
    elseif FarmMode == "Above" then
        -- Phía trên mob
        return mobHRP.CFrame * CFrame.new(0, FarmDistance, 0)
    end
end
```

---

## 6. FLOW CHÍNH CỦA AUTO FARM

```
[BẮT ĐẦU]
   │
   ▼
[Người dùng chọn mob từ dropdown] ← VD: "Thief" (Lv 0)
   │
   ▼
[Lấy thông tin mob từ bảng MOB_DATA]
   → questNPC = "QuestNPC1"
   → island = "Starter"  
   → npcType = "Thief"
   │
   ▼
[Teleport đến đảo] ← TeleportToPortal:FireServer("Starter")
   │ (chờ 2-3s cho load)
   ▼
[Nhận quest] ← QuestAccept:FireServer("QuestNPC1")
   │
   ▼
[Tìm mob gần nhất] ← findNearestMob("Thief")
   │
   ▼
[Teleport đến vị trí farm] ← Behind/Above + Distance slider
   │
   ▼
[Spam RequestHit] ← Lặp mỗi 0.3s (AttackCooldown)
   │
   ├── Mob chết → Tìm mob tiếp theo
   │                 └── Không còn mob → Chờ respawn
   │
   └── Quest hoàn thành → Nhận quest lại → Lặp lại
```

---

## 7. CẤU TRÚC DATA TRONG SCRIPT

```lua
-- Bảng dữ liệu mob cho script
local MOB_DATA = {
    -- Tên hiện UI       npcType           QuestNPC      Đảo          Level   Kill  Loại
    { "Thief",          "Thief",          "QuestNPC1",  "Starter",    0,     5,   "Mob"  },
    { "Thief Boss",     "ThiefBoss",      "QuestNPC2",  "Starter",    100,   1,   "Boss" },
    { "Monkey",         "Monkey",         "QuestNPC3",  "Jungle",     250,   5,   "Mob"  },
    { "Monkey Boss",    "MonkeyBoss",     "QuestNPC4",  "Jungle",     500,   1,   "Boss" },
    { "Desert Bandit",  "DesertBandit",   "QuestNPC5",  "Desert",     750,   5,   "Mob"  },
    { "Desert Boss",    "DesertBoss",     "QuestNPC6",  "Desert",     1000,  1,   "Boss" },
    { "Frost Rogue",    "FrostRogue",     "QuestNPC7",  "Snow",       1500,  5,   "Mob"  },
    { "Snow Boss",      "SnowBoss",       "QuestNPC8",  "Snow",       2000,  1,   "Boss" },
    { "Sorcerer",       "Sorcerer",       "QuestNPC9",  "JJK",        3000,  5,   "Mob"  },
    { "Panda Boss",     "PandaMiniBoss",  "QuestNPC10", "JJK",        4000,  1,   "Boss" },
    { "Hollow",         "Hollow",         "QuestNPC11", "Hollow",     5000,  5,   "Mob"  },
    { "Strong Sorcerer","StrongSorcerer", "QuestNPC12", "JJK2",       6250,  5,   "Mob"  },
    { "Curse",          "Curse",          "QuestNPC13", "Curse",      7000,  5,   "Mob"  },
    { "Slime Warrior",  "SlimeWarrior",   "QuestNPC14", "Slime",      8000,  5,   "Mob"  },
    { "Academy Teacher","AcademyTeacher", "QuestNPC15", "Academy",    9000,  5,   "Mob"  },
    { "Swordsman",      "Swordsman",      "QuestNPC16", "Swordsman",  10000, 5,   "Mob"  },
    { "Quincy",         "Quincy",         "QuestNPC17", "Quincy",     10750, 5,   "Mob"  },
}
```

---

## 8. UI DROPDOWN HIỂN THỊ

Dropdown sẽ hiển thị theo format:  
**`[Lv XXX] Tên Mob`**

Ví dụ:
```
[Lv 0] Thief
[Lv 100] Thief Boss ⭐
[Lv 250] Monkey
[Lv 500] Monkey Boss ⭐
[Lv 750] Desert Bandit
[Lv 1000] Desert Boss ⭐
[Lv 1500] Frost Rogue
[Lv 2000] Snow Boss ⭐
[Lv 3000] Sorcerer
[Lv 4000] Panda Boss ⭐
[Lv 5000] Hollow
[Lv 6250] Strong Sorcerer
[Lv 7000] Curse
[Lv 8000] Slime Warrior
[Lv 9000] Academy Teacher
[Lv 10000] Swordsman
[Lv 10750] Quincy
```
> Boss có ⭐ để phân biệt.

---

## 9. CÁC SETTINGS CẦN CÓ TRONG UI

| Setting | Kiểu | Mặc định | Mô tả |
|---------|-------|----------|-------|
| Mob Selector | Dropdown | (trống) | Chọn mob cần farm |
| Farm Position | Toggle | Behind | "Behind" (sau lưng) / "Above" (phía trên) |
| Farm Distance | Slider (5-50) | 15 | Khoảng cách đến mob |
| Attack Cooldown | Slider (0.1-1.0) | 0.3 | Tốc độ spam hit |
| Auto Quest | Toggle | true | Tự động nhận lại quest khi hoàn thành |

---

## 10. LƯU Ý QUAN TRỌNG

1. **Tên đảo trong TeleportToPortal** cần kiểm tra chính xác trong `TravelConfig` module.  
   File: `game:GetService("ReplicatedStorage").TravelConfig`

2. **Mob gộp tên**: Thief1-5 → "Thief", DesertBandit1-5 → "DesertBandit". Dùng pattern match `^npcType%d+$`.

3. **Anti-teleport**: LUÔN dùng `TeleportToPortal` remote trước, rồi mới tween đến mob. Không teleport trực tiếp đến mob ở đảo khác.

4. **RequestHit** không cần truyền target — game tự detect mob gần nhất trong range.

5. **Quest check**: Kiểm tra quest hiện tại qua `player.QuestData` hoặc tương đương trước khi nhận quest mới.

---

## 11. TÓM TẮT REMOTES

| Remote | Path | Mục đích |
|--------|------|----------|
| QuestAccept | `ReplicatedStorage.RemoteEvents.QuestAccept` | Nhận quest |
| TeleportToPortal | `ReplicatedStorage.Remotes.TeleportToPortal` | Teleport hợp lệ đến đảo |
| RequestHit | `ReplicatedStorage.CombatSystem.Remotes.RequestHit` | Đánh mob |
