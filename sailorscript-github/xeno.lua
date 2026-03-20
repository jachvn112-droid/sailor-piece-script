-- ==========================================
-- || INITIALIZATION
-- ==========================================
repeat task.wait() until game:IsLoaded()

local Players     = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

repeat task.wait()
until LocalPlayer
  and LocalPlayer.Character
  and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

-- ==========================================
-- || CONFIGURATION (Linked to _G)
-- ==========================================
local Config = {
	LoopFarm              = false,
	AutoRejoin            = false,
	TimedRejoin           = false,
	RejoinDelay           = 10,
	FriendOnly            = false,
	WhiteScreen           = false,
	FPSLock               = 240,
	Webhook               = { Enabled = false, URL = "" },
	TpTime                = 0.1,
	NPCAttackThreshold    = 5,
	AutoEquip             = false,
	SelectedWeapon_NPC    = "None",
	SelectedWeapon_Boss   = "None",
	AutoHaki              = false,
	AutoObservationHaki   = false,
	IgnoredEntities = {
		Hollow             = true,
		Quincy             = true,
		Swordsman          = true,
		AcademyTeacher     = true,
		Slime              = true,
		StrongSorcerer     = true,
		Curse              = true,
		Gojo               = true,
		Yuji               = true,
		Sukuna             = true,
		Jinwoo             = true,
		Alucard            = true,
		Aizen              = true,
		Yamato             = true,
		Saber              = true,
		Ichigo             = true,
		QinShi             = true,
		Gilgamesh          = true,
		BlessedMaiden      = true,
		SaberAlter         = true,
		StrongestinHistory = true,
		StrongestofToday   = true,
		Rimuru             = true,
		Anos               = true,
		TrueAizen          = true,
	},
	Boss = {
		AutoSpawn  = false,
		Selected   = {}, -- Fluent multi-select populates this as { BossName = true, ... }
		Difficulty = "Normal",
	},
	Specials = {
		TrueAizen = { Auto = false, Diff = "Normal" },
		Sukuna    = { Auto = false, Diff = "Normal" },
		Gojo      = { Auto = false, Diff = "Normal" },
		Rimuru    = { Auto = false, Diff = "Normal" },
		Anos      = { Auto = false, Diff = "Normal" },
	},
	AutoSkill = {
		Bosses     = false,
		NPCs       = false,
		BossSkills = {},
		NPCSkills  = {},
		SkillIds   = { Z = 1, X = 2, C = 3, V = 4, F = 5 },
	},
	AutoQuest = {
		SelectedNPC = "None",
	},
	AutoCraft = {
		SlimeKey = false,
		DivineGrail = false,
	},
	DungeonFarm = {
		Enabled      = false,
		TweenSpeed   = 0.1,   -- seconds per tween step
		FarmPosition = "Top", -- "Top" | "Behind"
		Distance     = 5,     -- Studs away
		AutoReplay   = false,
		AutoVote     = false,
		VoteDiff     = "Easy",
	},
}

_G.FarmConfig = Config

-- ==========================================
-- || CONSTANTS
-- ==========================================
local CONSTANTS = {
	HakiBlack = BrickColor.new("Really black"),

	Locations = {
		Hollow             = CFrame.new(-365,    0,    1094),
		Quincy             = CFrame.new(-1350, 1604,   1595),
		Swordsman          = CFrame.new(-1271,   1,   -1193),
		AcademyTeacher     = CFrame.new( 1081,   2,    1279),
		Slime              = CFrame.new(-1123,  14,     366),
		StrongSorcerer     = CFrame.new(  664,   2,   -1697),
		Curse              = CFrame.new(  -16,   2,   -1845),
		Gojo               = CFrame.new( 1858.32, 12.98,  338.14),
		Yuji               = CFrame.new( 1537.92,  9.98,  226.10),
		Sukuna             = CFrame.new( 1571.26, 77.22,  -34.11),
		Jinwoo             = CFrame.new(  248.74, 12.09,  927.54),
		Alucard            = CFrame.new(  248.74, 12.09,  927.54),
		Aizen              = CFrame.new( -567.22, -0.42, 1228.49),
		Yamato             = CFrame.new(-1422.68, 24.42,-1383.46),
		Saber              = CFrame.new(  770,   -1,   -1086),
		Ichigo             = CFrame.new(  770,   -1,   -1086),
		QinShi             = CFrame.new(  770,   -1,   -1086),
		Gilgamesh          = CFrame.new(  770,   -1,   -1086),
		BlessedMaiden      = CFrame.new(  770,   -1,   -1086),
		SaberAlter         = CFrame.new(  770,   -1,   -1086),
		StrongestinHistory = CFrame.new(  604,    3,   -2314),
		StrongestofToday   = CFrame.new(  139,    3,   -2432),
		Rimuru             = CFrame.new(-1358,   19,     219),
		Anos               = CFrame.new(  949,    1,    1370),
		TrueAizen          = CFrame.new(-1205, 1604,    1774),
	},

	FarmOrder = {
		{ Name = "Swordsman",          Remote = "Judgement",   IsBossType = false },
		{ Name = "Quincy",             Remote = "HuecoMundo",  IsBossType = false },
		{ Name = "AcademyTeacher",     Remote = "Academy",     IsBossType = false },
		{ Name = "Slime",              Remote = "Slime",       IsBossType = false },
		{ Name = "StrongSorcerer",     Remote = "Shinjuku",    IsBossType = false },
		{ Name = "Hollow",             Remote = "HuecoMundo",  IsBossType = false },
		{ Name = "Curse",              Remote = "Shinjuku",    IsBossType = false },
		{ Name = "Gojo",               Remote = "Shibuya",     IsBossType = true  },
		{ Name = "Yuji",               Remote = "Shibuya",     IsBossType = true  },
		{ Name = "Sukuna",             Remote = "Shibuya",     IsBossType = true  },
		{ Name = "Jinwoo",             Remote = "Sailor",      IsBossType = true  },
		{ Name = "Alucard",            Remote = "Sailor",      IsBossType = true  },
		{ Name = "Aizen",              Remote = "HuecoMundo",  IsBossType = true  },
		{ Name = "Yamato",             Remote = "Judgement",   IsBossType = true  },
		{ Name = "Saber",              Remote = "Boss",        IsBossType = true  }, 	
		{ Name = "Ichigo",             Remote = "Boss",        IsBossType = true  },
		{ Name = "QinShi",             Remote = "Boss",        IsBossType = true  },
		{ Name = "Gilgamesh",          Remote = "Boss",        IsBossType = true  },
		{ Name = "BlessedMaiden",      Remote = "Boss",        IsBossType = true  },
		{ Name = "SaberAlter",         Remote = "Boss",        IsBossType = true  },
		{ Name = "StrongestinHistory", Remote = "Shinjuku",    IsBossType = true  },
		{ Name = "StrongestofToday",   Remote = "Shinjuku",    IsBossType = true  },
		{ Name = "Rimuru",             Remote = "Slime",       IsBossType = true  },
		{ Name = "Anos",               Remote = "Academy",     IsBossType = true  },
		{ Name = "TrueAizen",          Remote = "HuecoMundo",  IsBossType = true  },
	},

	CraftingSets = {
		StrongestinHistory = {
			Items = {
				{"Malevolent Soul", 3},
				{"Awakened Cursed Finger", 20},
				{"Cursed Flesh", 1},
				{"Vessel Ring", 7}
			},
			SkillUnlock = {
				{"Shrine Domain Shard", 1},
				{"Malevolent Soul", 3}
			}
		},

		TrueAizen = {
			Items = {
				{"Evolution Fragment", 1},
				{"Transcendent Core", 3},
				{"Divinity Essence", 8},
				{"Fusion Ring", 15},
				{"Chrysalis Sigil", 75}
			},
			SkillUnlock = {
				{"Transmutation Shard", 5}
			}
		},

		StrongestofToday = {
			Items = {
				{"Reversal Pulse", 9},
				{"Blue Singularity", 3},
				{"Infinity Essence", 1},
				{"Six Eye", 6}
			},
			SkillUnlock = {
				{"Blue Singularity", 3},
				{"Infinity Domain Shard", 1}
			}
		},

		BlessedMaiden = {
			Items = {
				{"Celestial Mark", 1},
				{"Aero Core", 3},
				{"Gale Essence", 8},
				{"Tide Remnant", 14},
				{"Tempest Relic", 25}
			},
			SkillUnlock = {
				{"Celestial Mark", 2},
				{"Aero Core", 8},
				{"Tempest Relic", 75}
			}
		},

		Aizen = {
			Items = {
				{"Hōgyoku Fragment", 1},
				{"Reiatsu Core", 3},
				{"Illusion Prism", 6},
				{"Mirage Pendant", 10}
			}
		},

		SaberAlter = {
			Items = {
				{"Corrupt Crown", 1},
				{"Corruption Core", 3},
				{"Alter Essence", 8},
				{"Morgan Remnant", 15},
				{"Dark Grail", 25}
			},
			SkillUnlock = {
				{"Corrupt Crown", 2},
				{"Corruption Core", 9},
				{"Dark Grail", 85}
			}
		},

		Anos = {
			Items = {
				{"Calamity Seal", 65},
				{"Demonic Fragment", 12},
				{"Demonic Shard", 6},
				{"Destruction Eye", 2},
				{"Imperial Mark", 1}
			}
		},

		Yamato = {
			Items = {
				{"Azure Heart", 1},
				{"Silent Storm", 3},
				{"Yamato Essence", 7},
				{"Frozen Will", 14}
			}
		},

		Gilgamesh = {
			Items = {
				{"Throne Remnant", 12},
				{"Ancient Shard", 6},
				{"Golden Essence", 3},
				{"Phantasm Core", 1}
			}
		},

		ShadowMonarch = {
			Items = {
				{"Monarch Core", 10},
				{"Monarch Essence", 5},
				{"Kamish Dagger", 2},
				{"Shadow Crystal", 1}
			}
		},

		Gryphon = {
			Items = {}
		}
	}
}

-- ==========================================
-- || CLASS: Entity Tracker
-- ==========================================
local EntityTracker = {}
EntityTracker.__index = EntityTracker

function EntityTracker.new(npcsFolder)
	local self = setmetatable({
		Folder      = npcsFolder,
		Active      = {},
		Connections = {},
		NPCConns    = {},
	}, EntityTracker)
	self:Init()
	return self
end

function EntityTracker:Register(npc)
	task.spawn(function()
		local humanoid = npc:WaitForChild("Humanoid", 3)
		if not humanoid or humanoid.Health <= 0 then return end

		self.Active[npc] = true

		local deathConn, removeConn

		deathConn = humanoid.Died:Connect(function()
			self.Active[npc]   = nil
			self.NPCConns[npc] = nil
			deathConn:Disconnect()
			removeConn:Disconnect()
		end)

		removeConn = npc.AncestryChanged:Connect(function(_, parent)
			if not parent then
				self.Active[npc]   = nil
				self.NPCConns[npc] = nil
				removeConn:Disconnect()
				deathConn:Disconnect()
			end
		end)

		self.NPCConns[npc] = { deathConn, removeConn }
	end)
end

function EntityTracker:Init()
	for _, child in ipairs(self.Folder:GetChildren()) do
		self:Register(child)
	end
	local conn = self.Folder.ChildAdded:Connect(function(child)
		self:Register(child)
	end)
	table.insert(self.Connections, conn)
end

function EntityTracker:Destroy()
	for _, conn in ipairs(self.Connections) do
		conn:Disconnect()
	end
	self.Connections = {}

	for _, conns in pairs(self.NPCConns) do
		for _, c in ipairs(conns) do
			c:Disconnect()
		end
	end
	self.NPCConns = {}
	self.Active   = {}
end

function EntityTracker:IsAlive(queryName, isBossType, requiredCount)
	requiredCount = requiredCount or 5
	local currentCount = 0

	for npc in next, self.Active do
		if not (npc and npc.Parent) then
			self.Active[npc]   = nil
			self.NPCConns[npc] = nil
		end
	end

	for npc in next, self.Active do
		if isBossType then
			if npc.Name:find("^" .. queryName) then
				return true
			end
		else
			if npc.Name:find(queryName) then
				currentCount += 1
				if currentCount >= requiredCount then
					return true
				end
			end
		end
	end

	return false
end

-- ==========================================
-- || CLASS: Boss Spawner
-- ==========================================
local BossSpawner = {}
BossSpawner.__index = BossSpawner

function BossSpawner.new(tracker, remotes)
	return setmetatable({
		Tracker  = tracker,
		Remotes  = remotes,
		_running = false,
	}, BossSpawner)
end

function BossSpawner:Stop()
	self._running = false
end

function BossSpawner:Start()
	if self._running then return end
	self._running = true

	task.spawn(function()
		while self._running and task.wait(0.5) do
			local cfg = _G.FarmConfig

			-- ── Multi-select Standard Boss spawning ──────────────────────────
			-- Fluent multi-select returns a dict: { BossName = true, ... }
			-- We iterate with pairs() and only act on entries where value == true
			if cfg.Boss.AutoSpawn then
				local selected = cfg.Boss.Selected
				if type(selected) == "table" then
					for bName, enabled in pairs(selected) do
						if enabled == true and not self.Tracker:IsAlive(bName, true) then
							self.Remotes.SummonBoss:FireServer(bName .. "Boss", cfg.Boss.Difficulty)
							task.wait(0.3)
						end
					end
				end
			end

			-- ── Special Bosses ───────────────────────────────────────────────
			local specs = cfg.Specials
			if specs.TrueAizen.Auto and not self.Tracker:IsAlive("TrueAizen", true) then
				self.Remotes.TrueAizen:FireServer(specs.TrueAizen.Diff)
			end
			if specs.Sukuna.Auto and not self.Tracker:IsAlive("StrongestinHistory", true) then
				self.Remotes.SpawnStrongest:FireServer("StrongestHistory", specs.Sukuna.Diff)
			end
			if specs.Gojo.Auto and not self.Tracker:IsAlive("StrongestofToday", true) then
				self.Remotes.SpawnStrongest:FireServer("StrongestToday", specs.Gojo.Diff)
			end
			if specs.Rimuru.Auto and not self.Tracker:IsAlive("Rimuru", true) then
				self.Remotes.Rimuru:FireServer(specs.Rimuru.Diff)
			end
			if specs.Anos.Auto and not self.Tracker:IsAlive("Anos", true) then
				self.Remotes.Anos:FireServer("Anos", specs.Anos.Diff)
			end
		end
	end)
end

-- ==========================================
-- || CLASS: Farmer
-- ==========================================
local Farmer = {}
Farmer.__index = Farmer

function Farmer.new(tracker, tpRemote, abilityRemote, obsHakiRemote, hakiRemote)
	return setmetatable({
		Tracker            = tracker,
		TpRemote           = tpRemote,
		AbilityRemote      = abilityRemote,
		ObsHakiRemote      = obsHakiRemote,
		HakiRemote         = hakiRemote,
		LastSkillTime      = 0,
		LastEquipTime_NPC  = 0,
		LastEquipTime_Boss = 0,
		LastArmamentToggle = 0,
		LastObsToggle      = 0,
		_running           = false,
	}, Farmer)
end

function Farmer:Stop()
	self._running = false
end

function Farmer:EquipWeapon(isBoss)
	local cfg = _G.FarmConfig
	if not cfg.AutoEquip then return end

	local now = tick()
	if isBoss then
		if now - self.LastEquipTime_Boss < 1 then return end
		self.LastEquipTime_Boss = now
	else
		if now - self.LastEquipTime_NPC < 1 then return end
		self.LastEquipTime_NPC = now
	end

	local weaponName = isBoss and cfg.SelectedWeapon_Boss or cfg.SelectedWeapon_NPC
	local dropdownId = isBoss and "Dropdown_WeaponBoss" or "Dropdown_WeaponNPC"

	local char = LocalPlayer.Character
	if not char then return end

	local hum     = char:FindFirstChild("Humanoid")
	local backpack = LocalPlayer:FindFirstChild("Backpack")
	if not hum or hum.Health <= 0 or not backpack then return end

	if weaponName == "None" or weaponName == "" then
		local equippedTool = char:FindFirstChildOfClass("Tool")
		if equippedTool then
			if isBoss then cfg.SelectedWeapon_Boss = equippedTool.Name
			else            cfg.SelectedWeapon_NPC  = equippedTool.Name end
			pcall(function() Fluent.Options[dropdownId]:SetValue(equippedTool.Name) end)
			return
		end

		local firstTool = backpack:FindFirstChildOfClass("Tool")
		if not firstTool then return end
		hum:EquipTool(firstTool)

		if isBoss then cfg.SelectedWeapon_Boss = firstTool.Name
		else            cfg.SelectedWeapon_NPC  = firstTool.Name end
		pcall(function() Fluent.Options[dropdownId]:SetValue(firstTool.Name) end)
		return
	end

	if char:FindFirstChild(weaponName) then return end
	local tool = backpack:FindFirstChild(weaponName)
	if tool then hum:EquipTool(tool) end
end

function Farmer:CheckArmamentHaki()
	local cfg = _G.FarmConfig
	if not cfg.AutoHaki then return end

	local now = tick()
	if now - self.LastArmamentToggle < 3 then return end

	local char = LocalPlayer.Character
	if not char then return end

	local rightArm     = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightHand")
	local isHakiActive = rightArm and rightArm.BrickColor == CONSTANTS.HakiBlack

	if not isHakiActive then
		self.LastArmamentToggle = now
		pcall(function() self.HakiRemote:FireServer("Toggle") end)
	end
end

function Farmer:CheckObservationHaki()
	local cfg = _G.FarmConfig
	if not cfg.AutoObservationHaki then return end
	if tick() - self.LastObsToggle < 3 then return end

	local playerGui  = LocalPlayer:FindFirstChild("PlayerGui")
	local dodgeUI    = playerGui and playerGui:FindFirstChild("DodgeCounterUI")
	local isVisible  = dodgeUI
		and dodgeUI:FindFirstChild("MainFrame")
		and dodgeUI.MainFrame.Visible

	local cdUI       = playerGui and playerGui:FindFirstChild("CooldownUI")
	local onCooldown = cdUI
		and cdUI:FindFirstChild("MainFrame")
		and cdUI.MainFrame:FindFirstChild("Cooldown_ObsHaki_Observation") ~= nil

	if not isVisible and not onCooldown then
		self.LastObsToggle = tick()
		pcall(function() self.ObsHakiRemote:FireServer("Toggle") end)
	end
end

function Farmer:CastSkills(isBoss)
	local cfg = _G.FarmConfig
	local shouldCast = isBoss and cfg.AutoSkill.Bosses or (not isBoss and cfg.AutoSkill.NPCs)
	if not shouldCast then return end

	if tick() - self.LastSkillTime <= 0.3 then return end
	self.LastSkillTime = tick()

	local activeSkills = isBoss and cfg.AutoSkill.BossSkills or cfg.AutoSkill.NPCSkills
	for skillName, isEnabled in pairs(activeSkills) do
		if isEnabled then
			local skillId = cfg.AutoSkill.SkillIds[skillName]
			if skillId then
				pcall(function() self.AbilityRemote:FireServer(skillId) end)
			end
		end
	end
end

function Farmer:Start()
	if self._running then return end
	self._running = true

	task.spawn(function()
		while self._running and task.wait(0.1) do
			local cfg = _G.FarmConfig
			if not cfg.LoopFarm then self.CurrentTarget = nil continue end
			if game.PlaceId ~= 77747658251236 then self.CurrentTarget = nil continue end

			self:CheckObservationHaki()
			self:CheckArmamentHaki()
			self:EquipWeapon(false)

			local char = LocalPlayer.Character
			local hrp  = char and char:FindFirstChild("HumanoidRootPart")
			if not hrp then continue end

			self.CurrentTarget = nil  -- reset so UI shows 🟡 scanning between cycles
			for _, target in ipairs(CONSTANTS.FarmOrder) do
				if not self._running or not cfg.LoopFarm then break end
				if cfg.IgnoredEntities[target.Name] then continue end

				local requiredToStart = target.IsBossType and 1 or cfg.NPCAttackThreshold
				if not self.Tracker:IsAlive(target.Name, target.IsBossType, requiredToStart) then
					continue
				end

				local spawnCF = CONSTANTS.Locations[target.Name]
				if not spawnCF then continue end
				
				self.CurrentTarget = target.Name

				-- ── BOSS LOOP ──────────────────────────────────────────────────
				if target.IsBossType then
					if target.Remote then
						self.TpRemote:FireServer(target.Remote)
						task.wait()
					end

					while
						self._running
						and cfg.LoopFarm
						and not cfg.IgnoredEntities[target.Name]
						and self.Tracker:IsAlive(target.Name, true)
					do
						cfg = _G.FarmConfig

						self:CheckObservationHaki()
						self:CheckArmamentHaki()
						self:EquipWeapon(true)
						self:CastSkills(true)

						local curChar = LocalPlayer.Character
						local curHrp  = curChar and curChar:FindFirstChild("HumanoidRootPart")
						if not curHrp then task.wait(1) continue end

						local liveBoss = nil
						for npc in next, self.Tracker.Active do
							if npc.Name:find("^" .. target.Name) and npc:FindFirstChild("HumanoidRootPart") then
								liveBoss = npc.HumanoidRootPart
								break
							end
						end

						local targetGoal = liveBoss and liveBoss.CFrame or spawnCF
						local lookAtPos  = targetGoal.Position
						local distance   = (curHrp.Position - lookAtPos).Magnitude

						if distance > 20 then
							if distance > 150 and target.Remote then
								self.TpRemote:FireServer(target.Remote)
								task.wait(0.5)
							end
							curHrp.CFrame = CFrame.lookAt(
								targetGoal.Position + Vector3.new(0, 0, 3),
								lookAtPos
							)
						else
							curHrp.CFrame = CFrame.lookAt(curHrp.Position, lookAtPos)
						end

						task.wait(cfg.TpTime)
					end
					self.CurrentTarget = nil  -- boss died, back to scanning

				-- ── NPC LOOP ───────────────────────────────────────────────────
				else
					if target.Remote then
						self.TpRemote:FireServer(target.Remote)
						task.wait()
					end

					while
						self._running
						and cfg.LoopFarm
						and not cfg.IgnoredEntities[target.Name]
						and self.Tracker:IsAlive(target.Name, false, 1)
					do
						cfg = _G.FarmConfig

						local curChar = LocalPlayer.Character
						local curHrp  = curChar and curChar:FindFirstChild("HumanoidRootPart")
						if not curHrp then task.wait(1) continue end

						self:CheckObservationHaki()
						self:CheckArmamentHaki()
						self:EquipWeapon(false)
						self:CastSkills(false)

						local distance = (curHrp.Position - spawnCF.Position).Magnitude
						if distance > 10 then
							curHrp.CFrame = spawnCF
						end

						task.wait(cfg.TpTime)
					end
					self.CurrentTarget = nil  -- npcs cleared, back to scanning
				end
			end
		end
	end)
end

-- ==========================================
-- || CLASS: Dungeon Farmer
-- ==========================================
local DungeonFarmer = {}
DungeonFarmer.__index = DungeonFarmer

function DungeonFarmer.new()
	return setmetatable({ _running = false }, DungeonFarmer)
end

function DungeonFarmer:Stop()
	self._running = false
end

-- Adds BodyMovers to make the character feel "anchored" in the air without actually anchoring them
function DungeonFarmer:_stabilize(hrp, goalCF)
	local bv = hrp:FindFirstChild("DungeonStabilizer_BV")
	if not bv then
		bv = Instance.new("BodyVelocity")
		bv.Name = "DungeonStabilizer_BV"
		bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		bv.Parent = hrp
	end
	bv.Velocity = Vector3.new(0, 0, 0)
	
	local bg = hrp:FindFirstChild("DungeonStabilizer_BG")
	if not bg then
		bg = Instance.new("BodyGyro")
		bg.Name = "DungeonStabilizer_BG"
		bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		bg.P = 3000
		bg.D = 500
		bg.Parent = hrp
	end
	bg.CFrame = goalCF
end

function DungeonFarmer:_destabilize(hrp)
	local bv = hrp:FindFirstChild("DungeonStabilizer_BV")
	if bv then bv:Destroy() end
	local bg = hrp:FindFirstChild("DungeonStabilizer_BG")
	if bg then bg:Destroy() end
end

-- Returns a goal CFrame next to the NPC's HumanoidRootPart
function DungeonFarmer:_getGoal(npcHRP, position)
	local pos = npcHRP.Position
	local cf  = npcHRP.CFrame
	local dist = _G.FarmConfig.DungeonFarm.Distance or 5
	
	if position == "Top" then
		return CFrame.new(pos + Vector3.new(0, dist, 0), pos)
	else -- Behind
		return cf * CFrame.new(0, 2, dist)
	end
end

function DungeonFarmer:Start()
	if self._running then return end
	self._running = true

	task.spawn(function()
		while self._running do
			task.wait(0.05)
			local cfg = _G.FarmConfig
			if not cfg.DungeonFarm.Enabled then self.CurrentTarget = nil task.wait(0.5) continue end

			local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
			if playerGui and playerGui:FindFirstChild("DungeonUI") then
				local dungeonUI = playerGui.DungeonUI
				
				if cfg.DungeonFarm.AutoReplay then
					local replayFrame = dungeonUI:FindFirstChild("ReplayDungeonFrameVisibleOnlyWhenClearingDungeon")
					if replayFrame and replayFrame.Visible then
						pcall(function()
							game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("DungeonWaveReplayVote"):FireServer("sponsor")
						end)
						task.wait(1)
					end
				end
				
				if cfg.DungeonFarm.AutoVote then
					local contentFrame = dungeonUI:FindFirstChild("ContentFrame")
					if contentFrame then
						local actions = contentFrame:FindFirstChild("Actions")
						if actions then
							local diffFrame = actions:FindFirstChild(cfg.DungeonFarm.VoteDiff .. "DifficultyFrame")
							if diffFrame and diffFrame.Visible then
								pcall(function()
									game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("DungeonWaveVote"):FireServer(cfg.DungeonFarm.VoteDiff)
								end)
								task.wait(1)
							end
						end
					end
				end
			end

			local char = LocalPlayer.Character
			local hrp  = char and char:FindFirstChild("HumanoidRootPart")
			if not hrp then task.wait(1) continue end

			local npcsFolder = workspace:FindFirstChild("NPCs")
			if not npcsFolder then task.wait(1) continue end

			local targets = npcsFolder:GetChildren()
			if #targets == 0 then task.wait(0.5) continue end

			for _, model in ipairs(targets) do
				if not self._running or not cfg.DungeonFarm.Enabled then break end

				local hum    = model:FindFirstChildOfClass("Humanoid")
				local npcHRP = model:FindFirstChild("HumanoidRootPart")
				if not hum or not npcHRP then continue end
				if hum.Health <= 0 then continue end
				
				self.CurrentTarget = model.Name

				local isBoss = model.Name:find("Boss") ~= nil
				local speed  = cfg.DungeonFarm.TweenSpeed
				local pos    = cfg.DungeonFarm.FarmPosition

				if isBoss then
					-- Stay on boss until it dies
					while self._running and cfg.DungeonFarm.Enabled do
						cfg = _G.FarmConfig
						speed = cfg.DungeonFarm.TweenSpeed
						pos   = cfg.DungeonFarm.FarmPosition

						if _G.ArcX_Farmer then
							_G.ArcX_Farmer:CheckObservationHaki()
							_G.ArcX_Farmer:CheckArmamentHaki()
							_G.ArcX_Farmer:EquipWeapon(true)
							_G.ArcX_Farmer:CastSkills(true)
						end

						local curChar = LocalPlayer.Character
						local curHrp  = curChar and curChar:FindFirstChild("HumanoidRootPart")
						if not curHrp then task.wait(1) break end

						local liveHum = model:FindFirstChildOfClass("Humanoid")
						if not model.Parent or not liveHum or liveHum.Health <= 0 then break end

						local liveHRP = model:FindFirstChild("HumanoidRootPart")
						if not liveHRP then break end

						local goal = self:_getGoal(liveHRP, pos)
						self:_stabilize(curHrp, goal)
						curHrp.CFrame = goal
						task.wait(speed)
					end
				else
					-- Fast single-pass TP, don't care if it dies
					local curChar = LocalPlayer.Character
					local curHrp  = curChar and curChar:FindFirstChild("HumanoidRootPart")
					if not curHrp then continue end
					
					if _G.ArcX_Farmer then
						_G.ArcX_Farmer:CheckObservationHaki()
						_G.ArcX_Farmer:CheckArmamentHaki()
						_G.ArcX_Farmer:EquipWeapon(false)
						_G.ArcX_Farmer:CastSkills(false)
					end
					
					local goal = self:_getGoal(npcHRP, pos)
					
					self:_stabilize(curHrp, goal)
					curHrp.CFrame = goal
					task.wait(speed)
				end
				
				-- Destabilize when moving to next target
				local curChar = LocalPlayer.Character
				local curHrp  = curChar and curChar:FindFirstChild("HumanoidRootPart")
				if curHrp then self:_destabilize(curHrp) end
			end
		end
	end)
end

-- ==========================================
-- || CLASS: Utility / Character Manager
-- ==========================================
local Utility = {}

local _utilityConnections = {}

function Utility.EnableAntiAFK()
	local VirtualUser = game:GetService("VirtualUser")
	local conn = LocalPlayer.Idled:Connect(function()
		VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
		task.wait(1)
		VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	end)
	table.insert(_utilityConnections, conn)
end

function Utility.EnableAutoRejoin()
	local TeleportService = game:GetService("TeleportService")
	local GuiService      = game:GetService("GuiService")

	local conn = GuiService.ErrorMessageChanged:Connect(function()
		local cfg = _G.FarmConfig
		if not cfg.AutoRejoin then return end

		local lastError = GuiService:GetErrorMessage()
		if lastError:find("ArcX Security") then
			warn("Auto-Rejoin blocked: Security Kick.")
			return
		end

		task.spawn(function()
			while task.wait(5) do
				if pcall(function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end) then
					break
				end
				task.wait(10)
			end
		end)
	end)

	table.insert(_utilityConnections, conn)
end

-- ── Timed rejoin ──────────────────────────────────────────────────────────────
local _timedRejoinRunning = false

function Utility.EnableTimedRejoin()
	_timedRejoinRunning = false
	task.wait()
	_timedRejoinRunning = true

	local TeleportService = game:GetService("TeleportService")

	task.spawn(function()
		local elapsed = 0
		while _timedRejoinRunning and task.wait(1) do
			local cfg = _G.FarmConfig

			if not cfg.TimedRejoin then
				elapsed = 0
				continue
			end

			elapsed += 1
			local target = (cfg.RejoinDelay or 10) * 60
			if elapsed > target then elapsed = target end

			if elapsed >= target then
				elapsed = 0

				pcall(function()
					Fluent:Notify({
						Title    = "ArcX Timed Rejoin",
						Content  = "Rejoining now (" .. (cfg.RejoinDelay or 10) .. " min timer)...",
						Duration = 5,
					})
				end)
				task.wait(5)

				for _ = 1, 10 do
					if pcall(function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end) then
						break
					end
					task.wait(10)
				end
			end
		end
	end)
end

function Utility.EnableFriendCheck()
	local function checkAndKick(player)
		if not _G.FarmConfig.FriendOnly or player == LocalPlayer then return end

		local isFriend = false
		local ok, result = pcall(function() return LocalPlayer:IsFriendsWith(player.UserId) end)
		if ok then isFriend = result end

		if not isFriend then
			LocalPlayer:Kick(
				"\n[ArcX Security]\nStranger Detected: " .. player.Name
				.. "\nAuto-Rejoin disabled to prevent looping."
			)
		end
	end

	for _, player in ipairs(Players:GetPlayers()) do
		checkAndKick(player)
	end

	local conn = Players.PlayerAdded:Connect(checkAndKick)
	table.insert(_utilityConnections, conn)
end

function Utility.SetupCharacterEvents(hakiRemote, obsHakiRemote)
	local function onCharacterAdded(char)
		char:WaitForChild("HumanoidRootPart", 5)
		task.wait(1)
		local cfg = _G.FarmConfig

		if cfg.AutoHaki then
			pcall(function() hakiRemote:FireServer("Toggle") end)
		end

		if cfg.AutoObservationHaki then
			local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
			if playerGui then
				local cdUI    = playerGui:FindFirstChild("CooldownUI")
				local hasCD   = cdUI
					and cdUI:FindFirstChild("MainFrame")
					and cdUI.MainFrame:FindFirstChild("Cooldown_ObsHaki_Observation") ~= nil

				local dodgeUI   = playerGui:FindFirstChild("DodgeCounterUI")
				local isVisible = dodgeUI
					and dodgeUI:FindFirstChild("MainFrame")
					and dodgeUI.MainFrame.Visible

				if not hasCD and not isVisible then
					pcall(function() obsHakiRemote:FireServer("Toggle") end)
				end
			end
		end
	end

	local conn = LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
	table.insert(_utilityConnections, conn)

	if LocalPlayer.Character then
		task.spawn(onCharacterAdded, LocalPlayer.Character)
	end
end

function Utility.Cleanup()
	_timedRejoinRunning = false

	for _, conn in ipairs(_utilityConnections) do
		conn:Disconnect()
	end
	_utilityConnections = {}
end

function Utility.GetWeapons()
	local weapons = {}
	local char = LocalPlayer.Character
	if char then
		for _, v in ipairs(char:GetChildren()) do
			if v:IsA("Tool") then table.insert(weapons, v.Name) end
		end
	end
	for _, v in ipairs(LocalPlayer.Backpack:GetChildren()) do
		if v:IsA("Tool") then table.insert(weapons, v.Name) end
	end
	return #weapons > 0 and weapons or { "None" }
end

-- ==========================================
-- || CODE REDEEMER
-- ==========================================
local _codeRedeemDone = false

local function RedeemCodes()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local ok, CodesConfig = pcall(function()
		return require(ReplicatedStorage:WaitForChild("CodesConfig", 5))
	end)

	if not ok or not CodesConfig then
		warn("[ArcX] Code Redeemer: CodesConfig module not found.")
		return
	end

	local CodeRedeem = ReplicatedStorage
		:WaitForChild("RemoteEvents", 5)
		:FindFirstChild("CodeRedeem")

	if not CodeRedeem then
		warn("[ArcX] Code Redeemer: CodeRedeem remote not found.")
		return
	end

	print("[ArcX] Starting code auto-redeem...")

	for codeName, _ in pairs(CodesConfig.Codes) do
		if CodesConfig.IsValid(codeName) then
			print("[ArcX] Redeeming: " .. codeName)

			local success, serverResponse = pcall(function()
				return CodeRedeem:InvokeServer(codeName)
			end)

			if success then
				print("[ArcX] Response for " .. codeName .. ":", serverResponse)
			else
				warn("[ArcX] Error redeeming " .. codeName .. ":", serverResponse)
			end

			task.wait(0.5)
		end
	end

	print("[ArcX] Code auto-redeem finished.")
end

-- ==========================================
-- || QUEST MANAGER
-- ==========================================
local QuestManager = {}
QuestManager.__index = QuestManager

function QuestManager.new()
	return setmetatable({ _remote = nil }, QuestManager)
end

function QuestManager.GetQuestNPCs()
	local found = {}
	local serviceNPCs = workspace:FindFirstChild("ServiceNPCs")
	if not serviceNPCs then return { "None" } end

	for _, child in ipairs(serviceNPCs:GetChildren()) do
		if child.Name:match("^QuestNPC") then
			table.insert(found, child.Name)
		end
	end

	table.sort(found, function(a, b)
		local na = tonumber(a:match("%d+$")) or 0
		local nb = tonumber(b:match("%d+$")) or 0
		return na < nb
	end)

	return #found > 0 and found or { "None" }
end

function QuestManager:AcceptOnce(npcName)
	if not npcName or npcName == "None" or npcName == "" then
		warn("[ArcX] AcceptOnce: No Quest NPC selected.")
		return false
	end

	if not self._remote then
		local re = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvents")
		self._remote = re and re:FindFirstChild("QuestAccept")
	end

	if not self._remote then
		warn("[ArcX] QuestAccept remote not found.")
		return false
	end

	local ok, err = pcall(function()
		self._remote:FireServer(npcName)
	end)

	if ok then
		print("[ArcX] Quest accepted from " .. npcName)
		return true
	else
		warn("[ArcX] Quest accept failed:", err)
		return false
	end
end

-- ==========================================
-- || CLEANUP PREVIOUS INSTANCES
-- ==========================================
if _G.ArcX_Spawner       then _G.ArcX_Spawner:Stop()             end
if _G.ArcX_Farmer        then _G.ArcX_Farmer:Stop()              end
if _G.ArcX_DungeonFarmer then _G.ArcX_DungeonFarmer:Stop()       end
if _G.ArcX_Tracker       then _G.ArcX_Tracker:Destroy()          end
Utility.Cleanup()

if _G.ArcX_Window then
	pcall(function() _G.ArcX_Window:Destroy() end)
	_G.ArcX_Window = nil
end

-- ==========================================
-- || REMOTE SETUP
-- ==========================================
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes           = ReplicatedStorage:WaitForChild("Remotes")
local RemoteEvents      = ReplicatedStorage:WaitForChild("RemoteEvents")
local AbilityRemote     = ReplicatedStorage
	:WaitForChild("AbilitySystem")
	:WaitForChild("Remotes")
	:WaitForChild("RequestAbility")

local GameRemotes = {
	Teleport        = Remotes:WaitForChild("TeleportToPortal"),
	SummonBoss      = Remotes:WaitForChild("RequestSummonBoss"),
	SpawnStrongest  = Remotes:WaitForChild("RequestSpawnStrongestBoss"),
	Anos            = Remotes:WaitForChild("RequestSpawnAnosBoss"),
	TrueAizen       = RemoteEvents:WaitForChild("RequestSpawnTrueAizen"),
	Rimuru          = RemoteEvents:WaitForChild("RequestSpawnRimuru"),
	Haki            = RemoteEvents:WaitForChild("HakiRemote"),
	ObservationHaki = RemoteEvents:WaitForChild("ObservationHakiRemote"),
}

local Tracker   = EntityTracker.new(workspace:WaitForChild("NPCs"))
local Spawner   = BossSpawner.new(Tracker, GameRemotes)
local AutoFarm  = Farmer.new(
	Tracker,
	GameRemotes.Teleport,
	AbilityRemote,
	GameRemotes.ObservationHaki,
	GameRemotes.Haki
)
local AutoQuest     = QuestManager.new()
local DungeonFarm   = DungeonFarmer.new()

_G.ArcX_Tracker       = Tracker
_G.ArcX_Spawner       = Spawner
_G.ArcX_Farmer        = AutoFarm
_G.ArcX_DungeonFarmer = DungeonFarm

Utility.EnableAntiAFK()
Utility.EnableAutoRejoin()
Utility.EnableTimedRejoin()
Utility.EnableFriendCheck()
Utility.SetupCharacterEvents(GameRemotes.Haki, GameRemotes.ObservationHaki)

print("ArcX AutoFarm Initialized Successfully.")

local _lastWebhookTime = 0
local function SendWebhook(title, description, color)
	local url = Config.Webhook.URL
	if not Config.Webhook.Enabled or not url or url == "" then return end
	if tick() - _lastWebhookTime < 3 then return end
	_lastWebhookTime = tick()

	local data = {
		content = "",
		embeds = {{
			title = title,
			description = description,
			color = color or 5814783,
			footer = { text = "ArcX Notifier | " .. os.date("%X") }
		}}
	}
	
	local req = (request or http_request or (syn and syn.request))
	if req then
		pcall(function()
			req({
				Url = url,
				Method = "POST",
				Headers = { ["Content-Type"] = "application/json" },
				Body = game:GetService("HttpService"):JSONEncode(data)
			})
		end)
	end
end

-- ==========================================
-- || UI INTEGRATION (FLUENT & SAVEMANAGER)
-- ==========================================
_G.ArcX_UI_RunID = (_G.ArcX_UI_RunID or 0) + 1
local currentRunID = _G.ArcX_UI_RunID

local Fluent = loadstring(
	game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua")
)()
local SaveManager = loadstring(
	game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua")
)()
local InterfaceManager = loadstring(
	game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua")
)()

local Window = Fluent:CreateWindow({
	Title       = "Sailor Piece ⛵",
	SubTitle    = "| ArcX",
	TabWidth    = 160,
	Size        = UDim2.fromOffset(580, 460),
	Acrylic     = true,
	Theme       = "Dark",
	MinimizeKey = Enum.KeyCode.LeftControl,
})

_G.ArcX_Window = Window

local Tabs = {
	Main     = Window:AddTab({ Title = "Main",            Icon = "home"     }),
	Mobs     = Window:AddTab({ Title = "Entities",        Icon = "ghost"    }),
	Bosses   = Window:AddTab({ Title = "Standard Bosses", Icon = "skull"    }),
	Specials = Window:AddTab({ Title = "Special Bosses",  Icon = "star"     }),
	Dungeon  = Window:AddTab({ Title = "Dungeon",         Icon = "swords"   }),
	Crafting = Window:AddTab({ Title = "Crafting",        Icon = "hammer"   }),
	Misc     = Window:AddTab({ Title = "Misc",            Icon = "gift"     }),
	Settings = Window:AddTab({ Title = "Settings",        Icon = "settings" }),
}
_G.ArcX_StatusParagraph = Tabs.Main:AddParagraph({
	Title   = "📊 Live Status",
	Content = "Initializing..."
})

Tabs.Main:AddSection("🔁 Farm Control")

Tabs.Main:AddToggle("Toggle_LoopFarm", {
	Title       = "Enable Auto Farm",
	Default     = Config.LoopFarm,
}):OnChanged(function(v)
	if v and game.PlaceId ~= 77747658251236 then
		Fluent:Notify({
			Title    = "🚫 Wrong Game",
			Content  = "Main Auto Farm only runs in Sailor Piece!\nPlease join the main game first.",
			Duration = 5,
		})
		task.spawn(function()
			task.wait()
			pcall(function() Fluent.Options.Toggle_LoopFarm:SetValue(false) end)
		end)
		Config.LoopFarm = false
		return
	end
	Config.LoopFarm = v
	Fluent:Notify({
		Title    = v and "✅ Auto Farm ON" or "⏹️ Auto Farm OFF",
		Content  = v and "Farming started. Happy grinding!" or "Farming paused.",
		Duration = 3,
	})
end)

Tabs.Main:AddSlider("Slider_TpTime", {
	Title       = "⚡ Teleport Delay",
	Default     = Config.TpTime,
	Min = 0, Max = 1, Rounding = 1,
	Callback = function(v) Config.TpTime = v end,
})

Tabs.Main:AddSection("🥷 Haki Buffs")

Tabs.Main:AddToggle("Toggle_AutoHaki", {
	Title       = "Auto Armament Haki",
	Default     = Config.AutoHaki,
}):OnChanged(function(v) Config.AutoHaki = v end)

Tabs.Main:AddToggle("Toggle_AutoObsHaki", {
	Title       = "Auto Observation Haki",
	Default     = Config.AutoObservationHaki,
}):OnChanged(function(v) Config.AutoObservationHaki = v end)

Tabs.Main:AddSection("🗡️ Weapon Management")

Tabs.Main:AddToggle("Toggle_AutoEquip", {
	Title       = "Auto Equip Weapon",
	Default     = Config.AutoEquip,
}):OnChanged(function(v) Config.AutoEquip = v end)

Tabs.Main:AddDropdown("Dropdown_WeaponNPC", {
	Title       = "NPC Weapon",
	Values      = Utility.GetWeapons(),
	Multi       = false,
	Default     = Config.SelectedWeapon_NPC,
}):OnChanged(function(v) Config.SelectedWeapon_NPC = v end)

Tabs.Main:AddDropdown("Dropdown_WeaponBoss", {
	Title       = "Boss Weapon",
	Values      = Utility.GetWeapons(),
	Multi       = false,
	Default     = Config.SelectedWeapon_Boss,
}):OnChanged(function(v) Config.SelectedWeapon_Boss = v end)

Tabs.Main:AddButton({
	Title       = "🔄 Refresh Weapon List",
	Callback    = function()
		local weapons = Utility.GetWeapons()
		Fluent.Options["Dropdown_WeaponNPC"]:SetValues(weapons)
		Fluent.Options["Dropdown_WeaponBoss"]:SetValues(weapons)
		Fluent:Notify({ Title = "🔄 Refreshed", Content = "Found " .. #weapons .. " weapon(s) in your backpack.", Duration = 3 })
	end,
})

Tabs.Main:AddSection("✨ Auto Skills")

Tabs.Main:AddToggle("Toggle_AutoSkillBoss", {
	Title       = "Use Skills on Bosses",
	Default     = Config.AutoSkill.Bosses,
}):OnChanged(function(v) Config.AutoSkill.Bosses = v end)

Tabs.Main:AddDropdown("Dropdown_BossSkills", {
	Title       = "Boss Skill Keys",
	Values      = { "Z", "X", "C", "V", "F" },
	Multi       = true,
	Default     = Config.AutoSkill.BossSkills,
}):OnChanged(function(v) Config.AutoSkill.BossSkills = v end)

Tabs.Main:AddToggle("Toggle_AutoSkillNPC", {
	Title       = "Use Skills on NPCs",
	Default     = Config.AutoSkill.NPCs,
}):OnChanged(function(v) Config.AutoSkill.NPCs = v end)

Tabs.Main:AddDropdown("Dropdown_NPCSkills", {
	Title       = "NPC Skill Keys",
	Values      = { "Z", "X", "C", "V", "F" },
	Multi       = true,
	Default     = Config.AutoSkill.NPCSkills,
}):OnChanged(function(v) Config.AutoSkill.NPCSkills = v end)

Tabs.Mobs:AddSection("⚡ Attack Threshold")

Tabs.Mobs:AddSlider("Slider_NPCThreshold", {
	Title    = "Min NPC Count",
	Default  = Config.NPCAttackThreshold,
	Min = 1, Max = 5, Rounding = 0,
}):OnChanged(function(v) Config.NPCAttackThreshold = v end)

local EntityCategories = {
	{
		Name = "🐾 Regular NPCs",
		List = { "Hollow", "Quincy", "Swordsman", "AcademyTeacher", "Slime", "StrongSorcerer", "Curse" },
	},
	{
		Name = "⏱️ Timed Bosses",
		List = { "Gojo", "Yuji", "Sukuna", "Jinwoo", "Alucard", "Aizen", "Yamato" },
	},
	{
		Name = "💀 Summon Bosses",
		List = { "Saber", "Ichigo", "QinShi", "Gilgamesh", "BlessedMaiden", "SaberAlter", "StrongestinHistory", "StrongestofToday", "Rimuru", "Anos", "TrueAizen" },
	},
}

for _, category in ipairs(EntityCategories) do
	Tabs.Mobs:AddSection(category.Name)
	for _, entityName in ipairs(category.List) do
		Tabs.Mobs:AddToggle("Mob_" .. entityName, {
			Title   = "Farm " .. entityName,
			Default = not Config.IgnoredEntities[entityName],
		}):OnChanged(function(v) Config.IgnoredEntities[entityName] = not v end)
	end
end

-- ══════════════════════════════════════════════════════════════
-- 💀  STANDARD BOSSES TAB
-- ══════════════════════════════════════════════════════════════
Tabs.Bosses:AddSection("⚙️ Spawn Settings")

Tabs.Bosses:AddToggle("Toggle_AutoSpawn", {
	Title       = "Auto-Spawn Bosses",
	Default     = Config.Boss.AutoSpawn,
}):OnChanged(function(v) Config.Boss.AutoSpawn = v end)

Tabs.Bosses:AddDropdown("Dropdown_SelectedBoss", {
	Title   = "Select Bosses",
	Values  = { "Saber", "Ichigo", "QinShi", "Gilgamesh", "BlessedMaiden", "SaberAlter" },
	Multi   = true,
	Default = {},
}):OnChanged(function(v) Config.Boss.Selected = v end)

Tabs.Bosses:AddDropdown("Dropdown_BossDifficulty", {
	Title   = "Difficulty",
	Values  = { "Normal", "Medium", "Hard", "Extreme" },
	Multi   = false,
	Default = 1,
}):OnChanged(function(v) Config.Boss.Difficulty = v end)

-- ══════════════════════════════════════════════════════════════
-- ⭐  SPECIAL BOSSES TAB
-- ══════════════════════════════════════════════════════════════
local difficultyLevels = { "Normal", "Medium", "Hard", "Extreme" }

local specialOrder = { "TrueAizen", "Sukuna", "Gojo", "Rimuru", "Anos" }
local specialLabels = {
	TrueAizen = "👁️ True Aizen",
	Sukuna    = "🩸 Strongest in History",
	Gojo      = "✨ Strongest of Today",
	Rimuru    = "🟦 Rimuru",
	Anos      = "⚫ Anos",
}

for _, bossName in ipairs(specialOrder) do
	local bossData = Config.Specials[bossName]
	if not bossData then continue end
	Tabs.Specials:AddSection(specialLabels[bossName] or bossName)
	Tabs.Specials:AddToggle("Special_" .. bossName, {
		Title   = "Auto Spawn",
		Default = bossData.Auto,
	}):OnChanged(function(v) Config.Specials[bossName].Auto = v end)
	Tabs.Specials:AddDropdown("SpecialDiff_" .. bossName, {
		Title   = "Difficulty",
		Values  = difficultyLevels,
		Multi   = false,
		Default = 1,
	}):OnChanged(function(v) Config.Specials[bossName].Diff = v end)
end

-- ══════════════════════════════════════════════════════════════
-- 🏰  DUNGEON TAB
-- ══════════════════════════════════════════════════════════════
Tabs.Dungeon:AddSection("🎮 Farm Settings")

Tabs.Dungeon:AddToggle("Toggle_DungeonFarm", {
	Title   = "Enable Dungeon Auto Farm",
	Default = Config.DungeonFarm.Enabled,
}):OnChanged(function(v)
	Config.DungeonFarm.Enabled = v
end)

Tabs.Dungeon:AddSlider("Slider_DungeonTweenSpeed", {
	Title    = "TP Delay",
	Default  = Config.DungeonFarm.TweenSpeed,
	Min      = 0.05,
	Max      = 2,
	Rounding = 2,
	Callback = function(v) Config.DungeonFarm.TweenSpeed = v end,
})

Tabs.Dungeon:AddSection("📍 Position")

Tabs.Dungeon:AddDropdown("Dropdown_DungeonPosition", {
	Title   = "Farm Position",
	Values  = { "Top", "Behind" },
	Multi   = false,
	Default = Config.DungeonFarm.FarmPosition,
}):OnChanged(function(v) Config.DungeonFarm.FarmPosition = v end)

Tabs.Dungeon:AddSlider("Slider_DungeonDistance", {
	Title    = "Distance (studs)",
	Default  = Config.DungeonFarm.Distance or 5,
	Min      = 0,
	Max      = 20,
	Rounding = 1,
	Callback = function(v) Config.DungeonFarm.Distance = v end,
})

Tabs.Dungeon:AddSection("🔁 Auto Run")

Tabs.Dungeon:AddToggle("Toggle_DungeonAutoReplay", {
	Title   = "Auto Replay",
	Default = Config.DungeonFarm.AutoReplay,
}):OnChanged(function(v) Config.DungeonFarm.AutoReplay = v end)

Tabs.Dungeon:AddToggle("Toggle_DungeonAutoVote", {
	Title   = "Auto Vote Difficulty",
	Default = Config.DungeonFarm.AutoVote,
}):OnChanged(function(v) Config.DungeonFarm.AutoVote = v end)

Tabs.Dungeon:AddDropdown("Dropdown_DungeonVoteDiff", {
	Title   = "Vote Difficulty",
	Values  = { "Easy", "Medium", "Hard", "Extreme" },
	Multi   = false,
	Default = Config.DungeonFarm.VoteDiff,
}):OnChanged(function(v) Config.DungeonFarm.VoteDiff = v end)

-- ── Crafting Tab ──────────────────────────────────────────────────────────────

local function GetItemQuantity(itemName)
	local player = game:GetService("Players").LocalPlayer
	local playerGui = player:FindFirstChild("PlayerGui")
	if not playerGui then return 0 end
	
	local inventoryUI = playerGui:FindFirstChild("InventoryPanelUI")
	if not inventoryUI then return 0 end
	
	local storage = inventoryUI:FindFirstChild("MainFrame")
		and inventoryUI.MainFrame:FindFirstChild("Frame")
		and inventoryUI.MainFrame.Frame:FindFirstChild("Content")
		and inventoryUI.MainFrame.Frame.Content:FindFirstChild("Holder")
		and inventoryUI.MainFrame.Frame.Content.Holder:FindFirstChild("StorageHolder")
		and inventoryUI.MainFrame.Frame.Content.Holder.StorageHolder:FindFirstChild("Storage")
		
	if not storage then return 0 end

	local itemFrame = storage:FindFirstChild("Item_" .. itemName)
	if not itemFrame then return 0 end

	local quantityText = itemFrame:FindFirstChild("Slot")
		and itemFrame.Slot:FindFirstChild("Holder")
		and itemFrame.Slot.Holder:FindFirstChild("Quantity")
		
	if quantityText and (quantityText:IsA("TextLabel") or quantityText:IsA("TextBox")) then
		local text = quantityText.Text
		local num = text:match("x(%d+)") or text:match("%d+")
		return tonumber(num) or 0
	end
	return 0
end

local function CheckSetAmount(setName)
	local setInfo = CONSTANTS.CraftingSets[setName]
	if not setInfo then return 0, 0, 0 end

	local normalReqs = {}
	local skillReqs = {}
	local combinedReqs = {}
	
	if setInfo.Items then
		for _, req in ipairs(setInfo.Items) do
			local itemName = req[1]
			local requiredAmt = req[2]
			normalReqs[itemName] = (normalReqs[itemName] or 0) + requiredAmt
			combinedReqs[itemName] = (combinedReqs[itemName] or 0) + requiredAmt
		end
	end
	
	if setInfo.SkillUnlock then
		if type(setInfo.SkillUnlock[1]) == "table" then
			for _, req in ipairs(setInfo.SkillUnlock) do
				local itemName = req[1]
				local requiredAmt = req[2]
				skillReqs[itemName] = (skillReqs[itemName] or 0) + requiredAmt
				combinedReqs[itemName] = (combinedReqs[itemName] or 0) + requiredAmt
			end
		else
			local itemName = setInfo.SkillUnlock[1]
			local requiredAmt = setInfo.SkillUnlock[2]
			skillReqs[itemName] = (skillReqs[itemName] or 0) + requiredAmt
			combinedReqs[itemName] = (combinedReqs[itemName] or 0) + requiredAmt
		end
	end

	local function calcMaxSets(reqsDict)
		local maxSets = math.huge
		local hasReqs = false
		for itemName, requiredAmt in pairs(reqsDict) do
			hasReqs = true
			local hasAmt = GetItemQuantity(itemName)
			local canMake = math.floor(hasAmt / requiredAmt)
			if canMake < maxSets then
				maxSets = canMake
			end
		end
		return hasReqs and (maxSets == math.huge and 0 or maxSets) or 0
	end

	local normalSets = calcMaxSets(normalReqs)
	local skillSets = calcMaxSets(skillReqs)
	local combinedSets = calcMaxSets(combinedReqs)

	return normalSets, skillSets, combinedSets
end

Tabs.Crafting:AddParagraph({ Title = "Crafting Calculator", Content = "⚠️ You must open inventory in items tabs only. And make every materials visible." })

local craftingSetKeys = {}
for k, _ in pairs(CONSTANTS.CraftingSets) do table.insert(craftingSetKeys, k) end

local selectedSet = "StrongestinHistory"
Tabs.Crafting:AddDropdown("Dropdown_CraftingSet", {
	Title = "Select Set",
	Values = craftingSetKeys,
	Multi = false,
	Default = selectedSet,
}):OnChanged(function(v)
	selectedSet = v
end)

local setAmountParagraph = Tabs.Crafting:AddParagraph({
	Title = "Craftable Amount",
	Content = "Can create: 0 sets\n(Select a set and check amount)"
})

Tabs.Crafting:AddButton({
	Title = "Check Amount",
	Callback = function()
		local setInfo = CONSTANTS.CraftingSets[selectedSet]
		if not setInfo then return end

		local normalSets, skillSets, combinedSets = CheckSetAmount(selectedSet)
		local details = ""
		
		if setInfo.SkillUnlock then
			details = "Can create:\n- Normal Sets: " .. normalSets .. "\n- SkillUnlock Sets: " .. skillSets .. "\n- Combined Sets: " .. combinedSets .. "\n"
		else
			details = "Can create:\n- Normal Sets: " .. normalSets .. "\n"
		end
		
		if setInfo.Items then
			details = details .. "\nNormal Items:"
			for _, req in ipairs(setInfo.Items) do
				local itemName = req[1]
				local requiredAmt = req[2]
				local hasAmt = GetItemQuantity(itemName)
				details = details .. "\n- " .. itemName .. ": " .. hasAmt .. " / " .. requiredAmt
			end
		end

		if setInfo.SkillUnlock then
			details = details .. "\n\nSkill Unlock:"
			
			-- Check if SkillUnlock is a list of lists (multiple items) or a single item list
			if type(setInfo.SkillUnlock[1]) == "table" then
				for _, unlockReq in ipairs(setInfo.SkillUnlock) do
					local unlockItem = unlockReq[1]
					local unlockReqAmt = unlockReq[2]
					local unlockHasAmt = GetItemQuantity(unlockItem)
					local status = unlockHasAmt >= unlockReqAmt and "✅" or "❌"
					details = details .. "\n- " .. unlockItem .. ": " .. unlockHasAmt .. " / " .. unlockReqAmt .. " " .. status
				end
			else
				local unlockItem = setInfo.SkillUnlock[1]
				local unlockReqAmt = setInfo.SkillUnlock[2]
				local unlockHasAmt = GetItemQuantity(unlockItem)
				local status = unlockHasAmt >= unlockReqAmt and "✅ (Unlocked)" or "❌ (Locked)"
				details = details .. "\n- " .. unlockItem .. ": " .. unlockHasAmt .. " / " .. unlockReqAmt .. " " .. status
			end
		end
		
		if setAmountParagraph.SetDesc then
			setAmountParagraph:SetDesc(details)
		end
		
		local notifyText = "Normal: " .. normalSets
		if setInfo.SkillUnlock then
			notifyText = notifyText .. " | Combined: " .. combinedSets
		end

		Fluent:Notify({
			Title = "Crafting Check",
			Content = notifyText,
			Duration = 3,
		})
	end
})

Tabs.Crafting:AddSection("Craft Items")

local craftAmount = 1
Tabs.Crafting:AddInput("Input_CraftAmount", {
	Title = "Amount to Craft",
	Default = "1",
	Numeric = true,
	Finished = false,
	Callback = function(v)
		local num = tonumber(v)
		if num and num > 0 then
			craftAmount = num
		else
			craftAmount = 1
		end
	end
})

Tabs.Crafting:AddButton({
	Title       = "🍃 Craft Slime Key",
	Callback = function()
		task.spawn(function()
			local args = { "SlimeKey", craftAmount }
			local ok, err = pcall(function()
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RequestSlimeCraft"):InvokeServer(unpack(args))
			end)
			if ok then
				Fluent:Notify({ Title = "🍃 Slime Key", Content = "Crafted " .. craftAmount .. "x Slime Key!", Duration = 3 })
			else
				warn("[ArcX] SlimeKey Craft Error:", err)
			end
		end)
	end
})

Tabs.Crafting:AddButton({
	Title       = "🏆 Craft Divine Grail",
	Callback = function()
		task.spawn(function()
			local args = { "DivineGrail", craftAmount }
			local ok, err = pcall(function()
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RequestGrailCraft"):InvokeServer(unpack(args))
			end)
			if ok then
				Fluent:Notify({ Title = "🏆 Divine Grail", Content = "Crafted " .. craftAmount .. "x Divine Grail!", Duration = 3 })
			else
				warn("[ArcX] Divine Grail Craft Error:", err)
			end
		end)
	end
})

Tabs.Crafting:AddSection("🤖 Auto Crafting")

Tabs.Crafting:AddToggle("Toggle_AutoCraftSlimeKey", {
	Title       = "Auto Craft Slime Key",
	Default     = Config.AutoCraft.SlimeKey,
}):OnChanged(function(v)
	Config.AutoCraft.SlimeKey = v
end)

Tabs.Crafting:AddToggle("Toggle_AutoCraftDivineGrail", {
	Title       = "Auto Craft Divine Grail",
	Default     = Config.AutoCraft.DivineGrail,
}):OnChanged(function(v)
	Config.AutoCraft.DivineGrail = v
end)

task.spawn(function()
	while task.wait(5) do
		if _G.ArcX_UI_RunID ~= currentRunID then break end
		if Config.AutoCraft.SlimeKey then
			pcall(function()
				local args = { "SlimeKey", 1 }
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RequestSlimeCraft"):InvokeServer(unpack(args))
			end)
		end
		if Config.AutoCraft.DivineGrail then
			pcall(function()
				local args = { "DivineGrail", 1 }
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RequestGrailCraft"):InvokeServer(unpack(args))
			end)
		end
	end
end)

-- ══════════════════════════════════════════════════════════════
-- 🎁  MISC TAB  —  Codes, Quests, and Utilities
-- ══════════════════════════════════════════════════════════════
Tabs.Misc:AddParagraph({
	Title   = "🛠️ Miscellaneous Tools",
	Content = "Quick-access utilities: redeem codes, grab quests, and more.",
})

Tabs.Misc:AddSection("🎟️ Code Redeemer")

Tabs.Misc:AddButton({
	Title       = "✨ Redeem All Active Codes",
	Callback    = function()
		task.spawn(RedeemCodes)
		Fluent:Notify({ Title = "🎟️ Code Redeemer", Content = "Scanning and redeeming all active codes...", Duration = 3 })
	end,
})

Tabs.Misc:AddSection("📜 Quest Manager")

local questNPCList = QuestManager.GetQuestNPCs()

Tabs.Misc:AddDropdown("Dropdown_QuestNPC", {
	Title       = "Quest NPC",
	Values      = questNPCList,
	Multi       = false,
	Default     = questNPCList[1],
}):OnChanged(function(v)
	Config.AutoQuest.SelectedNPC = v
end)
Config.AutoQuest.SelectedNPC = questNPCList[1]

Tabs.Misc:AddButton({
	Title       = "🔄 Refresh NPC List",
	Callback    = function()
		local fresh = QuestManager.GetQuestNPCs()
		pcall(function() Fluent.Options["Dropdown_QuestNPC"]:SetValues(fresh) end)
		Fluent:Notify({
			Title    = "📜 Quest NPCs",
			Content  = "Found " .. #fresh .. " Quest NPC(s) in the world.",
			Duration = 3,
		})
	end,
})

Tabs.Misc:AddButton({
	Title       = "📥 Accept Quest",
	Callback    = function()
		task.spawn(function()
			AutoQuest:AcceptOnce(Config.AutoQuest.SelectedNPC)
		end)
	end,
})

-- ══════════════════════════════════════════════════════════════
-- ⚙️  SETTINGS TAB  —  Script configuration and security
-- ══════════════════════════════════════════════════════════════
Tabs.Settings:AddParagraph({
	Title   = "🔧 Script Settings",
	Content = "Fine-tune ArcX's behavior, performance, and security features.",
})

_G.ArcX_SessionParagraph = Tabs.Settings:AddParagraph({
	Title   = "⏱️ Session Uptime",
	Content = "00:00:00",
})

Tabs.Settings:AddSection("🖥️ Performance")

Tabs.Settings:AddToggle("Toggle_WhiteScreen", {
	Title       = "WhiteScreen Mode (Perf Boost)",
	Default     = Config.WhiteScreen,
}):OnChanged(function(v)
	Config.WhiteScreen = v
	game:GetService("RunService"):Set3dRenderingEnabled(not v)
	Fluent:Notify({
		Title   = v and "🖥️ WhiteScreen ON" or "🖥️ WhiteScreen OFF",
		Content = v and "Rendering disabled. CPU/GPU usage reduced." or "Rendering re-enabled.",
		Duration = 3,
	})
end)

Tabs.Settings:AddInput("Input_FPSLock", {
	Title = "Lock FPS",
	Default = tostring(Config.FPSLock),
	Numeric = true,
	Finished = true,
	Placeholder = "Enter FPS (0 for uncapped)",
	Callback = function(v)
		local fps = tonumber(v) or 0
		Config.FPSLock = fps
		pcall(function() setfpscap(fps) end)
	end
})

Tabs.Settings:AddSection("📡 Webhook Notifications")

Tabs.Settings:AddToggle("Toggle_Webhook", {
	Title       = "Enable Webhooks",
	Default     = Config.Webhook.Enabled,
}):OnChanged(function(v) Config.Webhook.Enabled = v end)

Tabs.Settings:AddInput("Input_WebhookURL", {
	Title = "Webhook URL",
	Default = Config.Webhook.URL,
	Numeric = false,
	Finished = true,
	Placeholder = "Enter Discord Webhook URL",
	Callback = function(v) Config.Webhook.URL = v end
})

Tabs.Settings:AddButton({
	Title = "Test Webhook",
	Callback = function()
		if Config.Webhook.Enabled and Config.Webhook.URL ~= "" then
			SendWebhook("🔔 Test Notification", "This is a test message from ArcX.", 0x5865F2)
			Fluent:Notify({ Title = "Webhook", Content = "Test payload sent!", Duration = 3 })
		else
			Fluent:Notify({ Title = "Webhook", Content = "Please enable webhooks and set a valid URL first.", Duration = 3 })
		end
	end
})

Tabs.Settings:AddSection("🔄 Auto Rejoin")

Tabs.Settings:AddToggle("Toggle_AutoRejoin", {
	Title       = "Auto Rejoin on Disconnect",
	Default     = Config.AutoRejoin,
}):OnChanged(function(v) Config.AutoRejoin = v end)

Tabs.Settings:AddToggle("Toggle_TimedRejoin", {
	Title       = "Timed Auto Rejoin",
	Default     = Config.TimedRejoin,
}):OnChanged(function(v) Config.TimedRejoin = v end)

Tabs.Settings:AddSlider("Slider_RejoinDelay", {
	Title       = "⏱️ Rejoin Interval (minutes)",
	Default     = Config.RejoinDelay,
	Min = 1, Max = 120, Rounding = 0,
}):OnChanged(function(v) Config.RejoinDelay = v end)

Tabs.Settings:AddSection("🛡️ Server Security")

Tabs.Settings:AddToggle("Toggle_FriendOnly", {
	Title       = "Friend-Only Mode",
	Default     = Config.FriendOnly,
}):OnChanged(function(v)
	Config.FriendOnly = v
	if v then
		for _, player in ipairs(game.Players:GetPlayers()) do
			if player ~= LocalPlayer then
				local isFriend = false
				pcall(function() isFriend = LocalPlayer:IsFriendsWith(player.UserId) end)
				if not isFriend then
					LocalPlayer:Kick("[ArcX Security] Friend-Only Mode Enabled: Stranger found.")
				end
			end
		end
		Fluent:Notify({ Title = "🛡️ Friend-Only ON", Content = "Server is now locked to friends only.", Duration = 3 })
	end
end)

-- ── SaveManager / InterfaceManager ────────────────────────────────────────────
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
InterfaceManager:SetFolder("ArcX")
SaveManager:SetFolder("ArcX/configs")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
SaveManager:LoadAutoloadConfig()

Window:SelectTab(1)

-- Start loops AFTER Fluent is loaded so Fluent.Options is never nil
Spawner:Start()
AutoFarm:Start()
DungeonFarm:Start()

-- ── Live UI Status Updater ────────────────────────────────────────────────────
task.spawn(function()
	local startTime = tick()

	while task.wait(0.25) do
		if _G.ArcX_UI_RunID ~= currentRunID then break end

		-- ── Status line ──────────────────────────────────────────────
		local p = _G.ArcX_StatusParagraph
		if p then
			local cfg    = _G.FarmConfig
			local dot    = "🔴"
			local label  = "Idle"

			if cfg.LoopFarm then
				local tName = _G.ArcX_Farmer and _G.ArcX_Farmer.CurrentTarget
				if tName then
					dot   = "🟢"
					label = "Farming:  " .. tName
				else
					dot   = "🟡"
					label = "Scanning entities..."
				end
			elseif cfg.DungeonFarm.Enabled then
				local tName = _G.ArcX_DungeonFarmer and _G.ArcX_DungeonFarmer.CurrentTarget
				if tName then
					dot   = "🟢"
					label = "Dungeon:  " .. tName
				else
					dot   = "🟡"
					label = "Scanning dungeon..."
				end
			end

			pcall(function() p:SetDesc(dot .. "  " .. label) end)
		end

		-- ── Session uptime ───────────────────────────────────────────
		local sp = _G.ArcX_SessionParagraph
		if sp then
			local uptime = math.floor(tick() - startTime)
			local h = math.floor(uptime / 3600)
			local m = math.floor((uptime % 3600) / 60)
			local s = uptime % 60
			pcall(function()
				sp:SetDesc(string.format("Running for: %02d:%02d:%02d", h, m, s))
			end)
		end
	end
end)

-- ── Auto-redeem on load (once per session) ────────────────────────────────────
if not _codeRedeemDone then
	_codeRedeemDone = true
	task.spawn(function()
		task.wait(2)
		RedeemCodes()
	end)
end

Fluent:Notify({
	Title    = "ArcX Loaded!",
	Content  = "All systems online. Tabs ready.\nTip: Refresh weapon list before farming!",
	Duration = 6,
})

if Config.Webhook.Enabled then
	SendWebhook("🟢 ArcX Started", "Player **" .. LocalPlayer.Name .. "** is now playing Sailor Piece.", 0x00FF00)
end

game:GetService("GuiService").ErrorMessageChanged:Connect(function(msg)
	if Config.Webhook.Enabled then
		SendWebhook("🔴 Disconnected", "Player **" .. LocalPlayer.Name .. "** disconnected.\nReason: " .. tostring(msg), 0xFF0000)
	end
end)