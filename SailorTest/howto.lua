local questcheck = require(game:GetService("ReplicatedStorage").Modules.QuestConfig)
local checkmap = require(game:GetService("ReplicatedStorage").TravelConfig)
local player = game:GetService("Players").LocalPlayer
local tween_s = game:GetService("TweenService")
local info = TweenInfo.new(0.5)

getgenv().IsFarm = true

-- ==========================================
-- 1. BỘ NHỚ LƯU TRỮ LEVEL VÀ ISLAND (TỰ HỌC)
-- ==========================================
local autoLevelRanges = {}
local hasLearned = true

local function autoLearnIslandLevels()
    if hasLearned then return end
    print("[AutoFarm] Đang quét và học bản đồ...")
    
    for npcName, questData in pairs(questcheck.RepeatableQuests) do
        local reqLevel = tonumber(questData.recommendedLevel) or 0
        local minReq = questData.requirements and questData.requirements[1]
        if minReq and minReq.npcType then
            local mobType = minReq.npcType
            
            -- Thử dò tìm con quái này ở Workspace
            for _, obj in pairs(game.workspace.NPCs:GetChildren()) do
                if string.find(obj.Name, mobType) and obj:FindFirstChild("HumanoidRootPart") then
                    local mobPos = obj.HumanoidRootPart.Position
                    local zoneId, _ = checkmap.GetZoneAt(mobPos)
                    
                    if zoneId then
                        if not autoLevelRanges[zoneId] then
                            autoLevelRanges[zoneId] = { MinLevel = reqLevel, MaxLevel = reqLevel, PortalKey = zoneId }
                        else
                            if reqLevel < autoLevelRanges[zoneId].MinLevel then
                                autoLevelRanges[zoneId].MinLevel = reqLevel
                            end
                            if reqLevel > autoLevelRanges[zoneId].MaxLevel then
                                autoLevelRanges[zoneId].MaxLevel = reqLevel
                            end
                        end
                    end
                    break -- Đã tìm thấy vị trí của loại quái này, check quái tiếp theo
                end
            end
        end
    end
    hasLearned = true
    print("[AutoFarm] Đã học xong dữ liệu Map!")
end

local function getPortalForLevel(lvl)
    local bestPortal = "StarterIsland" -- Tên mặc định của đảo đầu
    for zoneId, rangeData in pairs(autoLevelRanges) do
        if lvl >= rangeData.MinLevel and lvl <= rangeData.MaxLevel then
            return rangeData.PortalKey
        end
    end
    return bestPortal
end

-- ==========================================
-- 2. TÌM NHIỆM VỤ THEO LEVEL HIỆN TẠI
-- ==========================================
local function getTargetQuest()
    local level = player.Data.Level.Value
    local bestNPC = nil
    local maxLevelFound = -1
    local choosenpc = nil
    
    for npcName, data in pairs(questcheck.RepeatableQuests) do
        local req = tonumber(data.recommendedLevel) or 0
        if level >= req and req > maxLevelFound then
            maxLevelFound = req
            bestNPC = npcName
            if data.requirements and data.requirements[1] then
                choosenpc = data.requirements[1].npcType
            end
        end
    end
    return bestNPC, maxLevelFound, choosenpc
end

-- ==========================================
-- 3. VÒNG LẶP FARM CHÍNH
-- ==========================================
task.spawn(function()
    -- Cố gắng học map một lần trước khi chạy
    autoLearnIslandLevels()

    while getgenv().IsFarm do
        task.wait()
        
        -- Cập nhật nhiệm vụ liên tục (đề phòng vừa lên cấp)
        local targetNPC, reqLevel, choosenpc = getTargetQuest()
        local currentLevel = player.Data.Level.Value
        
        if targetNPC and choosenpc then
            -- 3.1. Nhận nhiệm vụ
            game:GetService("ReplicatedStorage").RemoteEvents.QuestAccept:FireServer(targetNPC)
            
            -- 3.2. Kiểm tra xem trên map hiện tại CÓ quái của nhiệm vụ không?
            local foundMob = false
            for _, v in pairs(game.workspace.NPCs:GetChildren()) do
                if string.find(v.Name, choosenpc) and v:FindFirstChild("HumanoidRootPart") then
                    foundMob = true
                    
                    -- Nếu có quái, Tween tới đánh
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local cframe = CFrame.new(v.HumanoidRootPart.Position + Vector3.new(0, 0, 5))
                        local tween = tween_s:Create(player.Character.HumanoidRootPart, info, {CFrame = cframe})
                        tween:Play()
                    end
                    break -- Chỉ bay đến 1 con trước
                end
            end
            
            -- 3.3. NẾU KHÔNG CÓ QUÁI (Tức là đang ở sai đảo) -> Dịch chuyển
            if not foundMob then
                print("[AutoFarm] Không tìm thấy " .. choosenpc .. " ở đảo này. Chuẩn bị chạy cổng dịch chuyển...")
                
                -- Tìm ra cái cổng Dịch Chuyển chuẩn dựa vào Cấp độ
                local targetPortal = getPortalForLevel(currentLevel)
                
                -- Do Portals Config của bạn có tên kiểu "Jungle", "Desert", nhưng cái PortalKey 
                -- thu thập được từ TravelConfig là "JungleIsland", "DesertIsland".
                -- Đoạn này gọt chữ "Island" và khoảng trắng đi để hợp với arg của TeleportToPortal
                local portalArg = string.gsub(targetPortal, "Island", "")
                portalArg = string.gsub(portalArg, " ", "")
                
                local args = {
                    [1] = portalArg
                }
                
                -- Bắn sự kiện dịch chuyển (Lấy chính xác từ test1quest.lua)
                local success, _ = pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TeleportToPortal"):FireServer(unpack(args))
                end)
                
                if success then
                    print("[AutoFarm] Đã dịch chuyển sang: " .. portalArg)
                    task.wait(2) -- Chờ load map sau khi dịch chuyển
                    
                    -- Học lại map một lần nữa phòng trường hợp đảo cũ ko load hết quái
                    autoLearnIslandLevels() 
                end
            end
        end
    end
end)
