game:GetService("ReplicatedStorage").Modules.QuestConfig

local u1 = {}
local v2 = {}
local v3 = {
    ["id"] = "thief_hunt_1",
    ["title"] = "Thief Hunter",
    ["description"] = "Defeat the thieves terrorizing the area!",
    ["recommendedLevel"] = 0,
    ["requirements"] = {
        {
            ["npcType"] = "Thief",
            ["amount"] = 5
        }
    },
    ["rewards"] = {
        ["money"] = 250,
        ["gems"] = 0,
        ["xp"] = 187869
    },
    ["itemDrops"] = {
        {
            ["name"] = "Boss Key",
            ["chance"] = 1.625,
            ["quantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Common Chest",
            ["chance"] = 0.9,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Rare Chest",
            ["chance"] = 0.4,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Epic Chest",
            ["chance"] = 0.2,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Legendary Chest",
            ["chance"] = 0.08,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Mythical Chest",
            ["chance"] = 0.02,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        }
    },
    ["accessoryDrops"] = {}
}
v2.QuestNPC1 = v3
local v4 = {
    ["id"] = "boss_hunt_1",
    ["title"] = "Thief Boss",
    ["description"] = "The Thief Boss threatens the village!",
    ["recommendedLevel"] = 100,
    ["requirements"] = {
        {
            ["npcType"] = "ThiefBoss",
            ["amount"] = 1
        }
    },
    ["rewards"] = {
        ["money"] = 400,
        ["gems"] = 0,
        ["xp"] = 376313
    },
    ["itemDrops"] = {
        {
            ["name"] = "Boss Key",
            ["chance"] = 2.275,
            ["quantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Common Chest",
            ["chance"] = 1.25,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Rare Chest",
            ["chance"] = 0.65,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Epic Chest",
            ["chance"] = 0.35,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Legendary Chest",
            ["chance"] = 0.17,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Mythical Chest",
            ["chance"] = 0.04,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        }
    },
    ["accessoryDrops"] = {}
}
v2.QuestNPC2 = v4
local v5 = {
    ["id"] = "monkey_hunt_1",
    ["title"] = "Monkey Hunter",
    ["description"] = "Defeat the monkeys terrorizing the area!",
    ["recommendedLevel"] = 250,
    ["requirements"] = {
        {
            ["npcType"] = "Monkey",
            ["amount"] = 5
        }
    },
    ["rewards"] = {
        ["money"] = 1250,
        ["gems"] = 0,
        ["xp"] = 7868470
    },
    ["itemDrops"] = {
        {
            ["name"] = "Boss Key",
            ["chance"] = 2.275,
            ["quantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Common Chest",
            ["chance"] = 1,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Rare Chest",
            ["chance"] = 0.55,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Epic Chest",
            ["chance"] = 0.3,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Legendary Chest",
            ["chance"] = 0.13,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Mythical Chest",
            ["chance"] = 0.03,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        }
    },
    ["accessoryDrops"] = {}
}
v2.QuestNPC3 = v5
local v6 = {
    ["id"] = "monkey_hunt_2",
    ["title"] = "Monkey Boss",
    ["description"] = "Defeat the Monkey Boss terrorizing the area!",
    ["recommendedLevel"] = 500,
    ["requirements"] = {
        {
            ["npcType"] = "MonkeyBoss",
            ["amount"] = 1
        }
    },
    ["rewards"] = {
        ["money"] = 2000,
        ["gems"] = 0,
        ["xp"] = 15759094
    },
    ["itemDrops"] = {
        {
            ["name"] = "Boss Key",
            ["chance"] = 2.6,
            ["quantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Common Chest",
            ["chance"] = 1.5,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Rare Chest",
            ["chance"] = 0.75,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Epic Chest",
            ["chance"] = 0.42,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Legendary Chest",
            ["chance"] = 0.2,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Mythical Chest",
            ["chance"] = 0.05,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        }
    },
    ["accessoryDrops"] = {}
}
v2.QuestNPC4 = v6
local v7 = {
    ["id"] = "desert_hunt_1",
    ["title"] = "Desert Bandit Hunter",
    ["description"] = "Defeat the Desert Bandits terrorizing the area!",
    ["recommendedLevel"] = 750,
    ["requirements"] = {
        {
            ["npcType"] = "DesertBandit",
            ["amount"] = 5
        }
    },
    ["rewards"] = {
        ["money"] = 3000,
        ["gems"] = 5,
        ["xp"] = 49820625
    },
    ["itemDrops"] = {
        {
            ["name"] = "Boss Key",
            ["chance"] = 2.925,
            ["quantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Common Chest",
            ["chance"] = 1.25,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Rare Chest",
            ["chance"] = 0.65,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Epic Chest",
            ["chance"] = 0.35,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Legendary Chest",
            ["chance"] = 0.16,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Mythical Chest",
            ["chance"] = 0.04,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        }
    },
    ["accessoryDrops"] = {}
}
v2.QuestNPC5 = v7
local v8 = {
    ["id"] = "desert_hunt_2",
    ["title"] = "Desert Bandit Boss",
    ["description"] = "Defeat the Desert Bandit Boss terrorizing the area!",
    ["recommendedLevel"] = 1000,
    ["requirements"] = {
        {
            ["npcType"] = "DesertBoss",
            ["amount"] = 1
        }
    },
    ["rewards"] = {
        ["money"] = 4250,
        ["gems"] = 7,
        ["xp"] = 85095625
    },
    ["itemDrops"] = {
        {
            ["name"] = "Boss Key",
            ["chance"] = 3.25,
            ["quantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Common Chest",
            ["chance"] = 2,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Rare Chest",
            ["chance"] = 0.9,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Epic Chest",
            ["chance"] = 0.55,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Legendary Chest",
            ["chance"] = 0.27,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Mythical Chest",
            ["chance"] = 0.06,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        }
    },
    ["accessoryDrops"] = {}
}
v2.QuestNPC6 = v8
local v9 = {
    ["id"] = "snow_hunt_1",
    ["title"] = "Frost Rogue Hunter",
    ["description"] = "Defeat the Frost Rogues terrorizing the area!",
    ["recommendedLevel"] = 1500,
    ["requirements"] = {
        {
            ["npcType"] = "FrostRogue",
            ["amount"] = 5
        }
    },
    ["rewards"] = {
        ["money"] = 6000,
        ["gems"] = 10,
        ["xp"] = 164394610
    },
    ["itemDrops"] = {
        {
            ["name"] = "Boss Key",
            ["chance"] = 3.25,
            ["quantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Common Chest",
            ["chance"] = 1.85,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Rare Chest",
            ["chance"] = 0.75,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Epic Chest",
            ["chance"] = 0.45,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Legendary Chest",
            ["chance"] = 0.22,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Mythical Chest",
            ["chance"] = 0.05,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        }
    },
    ["accessoryDrops"] = {}
}
v2.QuestNPC7 = v9
local v10 = {
    ["id"] = "snow_hunt_2",
    ["title"] = "Winter Warden Boss",
    ["description"] = "Defeat the Winter Warden terrorizing the area!",
    ["recommendedLevel"] = 2000,
    ["requirements"] = {
        {
            ["npcType"] = "SnowBoss",
            ["amount"] = 1
        }
    },
    ["rewards"] = {
        ["money"] = 9000,
        ["gems"] = 14,
        ["xp"] = 276288360
    },
    ["itemDrops"] = {
        {
            ["name"] = "Boss Key",
            ["chance"] = 3.575,
            ["quantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Common Chest",
            ["chance"] = 2.75,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Rare Chest",
            ["chance"] = 1.1,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Epic Chest",
            ["chance"] = 0.65,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Legendary Chest",
            ["chance"] = 0.35,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Mythical Chest",
            ["chance"] = 0.075,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        }
    },
    ["accessoryDrops"] = {}
}
v2.QuestNPC8 = v10
local v11 = {
    ["id"] = "jjk_hunt_1",
    ["title"] = "Sorcerer Hunter",
    ["description"] = "Defeat the Sorcerer Students terrorizing the area!",
    ["recommendedLevel"] = 3000,
    ["requirements"] = {
        {
            ["npcType"] = "Sorcerer",
            ["amount"] = 5
        }
    },
    ["rewards"] = {
        ["money"] = 12500,
        ["gems"] = 16,
        ["xp"] = 475808102
    },
    ["itemDrops"] = {
        {
            ["name"] = "Boss Key",
            ["chance"] = 3.9,
            ["quantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Common Chest",
            ["chance"] = 2.15,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Rare Chest",
            ["chance"] = 1,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Epic Chest",
            ["chance"] = 0.55,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Legendary Chest",
            ["chance"] = 0.3,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Mythical Chest",
            ["chance"] = 0.065,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        }
    },
    ["accessoryDrops"] = {}
}
v2.QuestNPC9 = v11
local v12 = {
    ["id"] = "jjk_hunt_2",
    ["title"] = "Panda Sorcerer Boss",
    ["description"] = "Defeat the Panda Sorcerer terrorizing the area!",
    ["recommendedLevel"] = 4000,
    ["requirements"] = {
        {
            ["npcType"] = "PandaMiniBoss",
            ["amount"] = 1
        }
    },
    ["rewards"] = {
        ["money"] = 17500,
        ["gems"] = 24,
        ["xp"] = 740641852
    },
    ["itemDrops"] = {
        {
            ["name"] = "Boss Key",
            ["chance"] = 4.55,
            ["quantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Common Chest",
            ["chance"] = 3.25,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Rare Chest",
            ["chance"] = 1.15,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Epic Chest",
            ["chance"] = 0.65,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Legendary Chest",
            ["chance"] = 0.4,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Mythical Chest",
            ["chance"] = 0.08,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        }
    },
    ["accessoryDrops"] = {}
}
v2.QuestNPC10 = v12
local v13 = {
    ["id"] = "hollow_hunt_1",
    ["title"] = "Hollow Hunter",
    ["description"] = "Defeat the Hollows terrorizing the area!",
    ["recommendedLevel"] = 5000,
    ["requirements"] = {
        {
            ["npcType"] = "Hollow",
            ["amount"] = 5
        }
    },
    ["rewards"] = {
        ["money"] = 20000,
        ["gems"] = 22,
        ["xp"] = 1350641852
    },
    ["itemDrops"] = {
        {
            ["name"] = "Boss Key",
            ["chance"] = 5.2,
            ["quantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Common Chest",
            ["chance"] = 3.25,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Rare Chest",
            ["chance"] = 1.25,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Epic Chest",
            ["chance"] = 0.75,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Legendary Chest",
            ["chance"] = 0.45,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Mythical Chest",
            ["chance"] = 0.08,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        }
    },
    ["accessoryDrops"] = {}
}
v2.QuestNPC11 = v13
local v14 = {
    ["id"] = "strong_sorcerer_hunt_1",
    ["title"] = "Strong Sorcerer Hunter",
    ["description"] = "Defeat the Strong Sorcerers terrorizing the area!",
    ["recommendedLevel"] = 6250,
    ["requirements"] = {
        {
            ["npcType"] = "StrongSorcerer",
            ["amount"] = 5
        }
    },
    ["rewards"] = {
        ["money"] = 25000,
        ["gems"] = 25,
        ["xp"] = 1750641852
    },
    ["itemDrops"] = {
        {
            ["name"] = "Boss Key",
            ["chance"] = 5.5,
            ["quantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Common Chest",
            ["chance"] = 3.45,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Rare Chest",
            ["chance"] = 1.35,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Epic Chest",
            ["chance"] = 0.85,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Legendary Chest",
            ["chance"] = 0.5,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Mythical Chest",
            ["chance"] = 0.085,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        }
    },
    ["accessoryDrops"] = {}
}
v2.QuestNPC12 = v14
local v15 = {
    ["id"] = "curse_hunt_1",
    ["title"] = "Curse Hunter",
    ["description"] = "Defeat the Curses terrorizing the area!",
    ["recommendedLevel"] = 7000,
    ["requirements"] = {
        {
            ["npcType"] = "Curse",
            ["amount"] = 5
        }
    },
    ["rewards"] = {
        ["money"] = 30000,
        ["gems"] = 30,
        ["xp"] = 2250641852
    },
    ["itemDrops"] = {
        {
            ["name"] = "Boss Key",
            ["chance"] = 6,
            ["quantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Common Chest",
            ["chance"] = 3.65,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Rare Chest",
            ["chance"] = 1.5,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Epic Chest",
            ["chance"] = 0.925,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Legendary Chest",
            ["chance"] = 0.55,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Mythical Chest",
            ["chance"] = 0.0925,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        }
    },
    ["accessoryDrops"] = {}
}
v2.QuestNPC13 = v15
local v16 = {
    ["id"] = "slime_warrior_hunt_1",
    ["title"] = "Slime Warrior Hunter",
    ["description"] = "Defeat the Slime Warriors terrorizing the area!",
    ["recommendedLevel"] = 8000,
    ["requirements"] = {
        {
            ["npcType"] = "SlimeWarrior",
            ["amount"] = 5
        }
    },
    ["rewards"] = {
        ["money"] = 37500,
        ["gems"] = 38,
        ["xp"] = 2950641852
    },
    ["itemDrops"] = {
        {
            ["name"] = "Boss Key",
            ["chance"] = 6.5,
            ["quantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Common Chest",
            ["chance"] = 4,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Rare Chest",
            ["chance"] = 1.75,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Epic Chest",
            ["chance"] = 1,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Legendary Chest",
            ["chance"] = 0.6,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Mythical Chest",
            ["chance"] = 0.1,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        }
    },
    ["accessoryDrops"] = {}
}
v2.QuestNPC14 = v16
local v17 = {
    ["id"] = "academy_teacher_hunt_1",
    ["title"] = "Academy Challenge",
    ["description"] = "Defeat the Academy Teachers terrorizing the area!",
    ["recommendedLevel"] = 9000,
    ["requirements"] = {
        {
            ["npcType"] = "AcademyTeacher",
            ["amount"] = 5
        }
    },
    ["rewards"] = {
        ["money"] = 45000,
        ["gems"] = 45,
        ["xp"] = 3800000000
    },
    ["itemDrops"] = {
        {
            ["name"] = "Boss Key",
            ["chance"] = 7,
            ["quantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Common Chest",
            ["chance"] = 4.25,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Rare Chest",
            ["chance"] = 2,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Epic Chest",
            ["chance"] = 1.1,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Legendary Chest",
            ["chance"] = 0.65,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Mythical Chest",
            ["chance"] = 0.12,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        }
    },
    ["accessoryDrops"] = {}
}
v2.QuestNPC15 = v17
local v18 = {
    ["id"] = "swordman_hunt_1",
    ["title"] = "Blade Masters",
    ["description"] = "Defeat the Swordsmen terrorizing the area!",
    ["recommendedLevel"] = 10000,
    ["requirements"] = {
        {
            ["npcType"] = "Swordsman",
            ["amount"] = 5
        }
    },
    ["rewards"] = {
        ["money"] = 52500,
        ["gems"] = 50,
        ["xp"] = 4600000000
    },
    ["itemDrops"] = {
        {
            ["name"] = "Boss Key",
            ["chance"] = 7.5,
            ["quantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Common Chest",
            ["chance"] = 4.5,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Rare Chest",
            ["chance"] = 2.15,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Epic Chest",
            ["chance"] = 1.2,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Legendary Chest",
            ["chance"] = 0.7,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Mythical Chest",
            ["chance"] = 0.13,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        }
    },
    ["accessoryDrops"] = {}
}
v2.QuestNPC16 = v18
local v19 = {
    ["id"] = "quincy_hunt_1",
    ["title"] = "Quincy Purge",
    ["description"] = "Defeat the Quincy terrorizing the area!",
    ["recommendedLevel"] = 10750,
    ["requirements"] = {
        {
            ["npcType"] = "Quincy",
            ["amount"] = 5
        }
    },
    ["rewards"] = {
        ["money"] = 61500,
        ["gems"] = 56,
        ["xp"] = 5350000000
    },
    ["itemDrops"] = {
        {
            ["name"] = "Boss Key",
            ["chance"] = 8,
            ["quantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Common Chest",
            ["chance"] = 4.75,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Rare Chest",
            ["chance"] = 2.3,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Epic Chest",
            ["chance"] = 1.3,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Legendary Chest",
            ["chance"] = 0.75,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        },
        {
            ["name"] = "Mythical Chest",
            ["chance"] = 0.14,
            ["minQuantity"] = 1,
            ["maxQuantity"] = 1,
            ["image"] = "rbxassetid://0"
        }
    },
    ["accessoryDrops"] = {}
}
v2.QuestNPC17 = v19
u1.RepeatableQuests = v2
local v20 = {}
local v21 = {
    ["npcName"] = "DungeonPortalsNPC",
    ["unlocks"] = "DungeonAccess",
    ["category"] = "Dungeon"
}
local v22 = {}
local v23 = {
    ["title"] = "Dungeon Discovery",
    ["description"] = "Find 6 ancient pieces across the islands (in order)",
    ["trackingType"] = "DungeonPuzzlePieces",
    ["goal"] = 6,
    ["stageRewards"] = {
        ["money"] = 50000,
        ["gems"] = 100,
        ["xp"] = 100000
    }
}
local v24 = {
    ["title"] = "Prove Your Strength",
    ["description"] = "Defeat 25 bosses to prove you\'re ready",
    ["trackingType"] = "AnyBossKills",
    ["goal"] = 25,
    ["stageRewards"] = {
        ["money"] = 100000,
        ["gems"] = 200,
        ["xp"] = 250000
    }
}
__set_list(v22, 1, {v23, v24})
v21.stages = v22
v21.rewards = {
    ["money"] = 0,
    ["gems"] = 0,
    ["xp"] = 0
}
v20.DungeonUnlock = v21
local v25 = {
    ["npcName"] = "HakiQuestNPC",
    ["unlocks"] = "Haki"
}
local v26 = {
    {
        ["title"] = "Path to Haki 1",
        ["description"] = "Kill 150 NPCs using Combat.",
        ["goal"] = 150,
        ["trackingType"] = "CombatNPCKills"
    },
    {
        ["title"] = "Path to Haki 2",
        ["description"] = "Use Z ability of Combat 65 times.",
        ["goal"] = 65,
        ["trackingType"] = "GroundSmashUses"
    },
    {
        ["title"] = "Path to Haki Final",
        ["description"] = "Punch 750 times using Combat",
        ["goal"] = 750,
        ["trackingType"] = "CombatPunches"
    }
}
v25.stages = v26
v25.rewards = {
    ["money"] = 0,
    ["gems"] = 0,
    ["xp"] = 0
}
v20.Haki = v25
local v27 = {
    ["npcName"] = "GojoMovesetNPC",
    ["unlocks"] = "Gojo",
    ["category"] = "Melee"
}
local v28 = {
    {
        ["title"] = "Gojo Training 1",
        ["description"] = "Kill 350 NPCs",
        ["goal"] = 350,
        ["trackingType"] = "AnyNPCKills"
    },
    {
        ["title"] = "Gojo Training 2",
        ["description"] = "Use any ability 350 times",
        ["goal"] = 350,
        ["trackingType"] = "AnyAbilityUses"
    },
    {
        ["title"] = "Gojo Training Final",
        ["description"] = "Kill Gojo Boss 10 times",
        ["goal"] = 10,
        ["trackingType"] = "GojoBossKills"
    }
}
v27.stages = v28
local v29 = {
    ["Money"] = 750000,
    ["Gems"] = 4000,
    ["Items"] = {
        {
            ["name"] = "Void Fragment",
            ["quantity"] = 6
        },
        {
            ["name"] = "Limitless Ring",
            ["quantity"] = 3
        },
        {
            ["name"] = "Infinity Core",
            ["quantity"] = 1
        }
    }
}
v27.cost = v29
v27.rewards = {
    ["money"] = 0,
    ["gems"] = 0,
    ["xp"] = 0
}
v20.Gojo = v27
local v30 = {
    ["npcName"] = "AizenQuestlineBuff",
    ["unlocks"] = "AizenDamageBuff",
    ["category"] = "Buff",
    ["requiresItem"] = "Aizen",
    ["requiresItemMessage"] = "Own Aizen Sword first!"
}
local v31 = {}
local v32 = {
    ["title"] = "Aizen Mastery 1",
    ["description"] = "Deal 750M Damage",
    ["goal"] = 750000000,
    ["trackingType"] = "DamageDealt"
}
local v33 = {
    ["money"] = 500000,
    ["gems"] = 500,
    ["items"] = {
        {
            ["name"] = "Trait Reroll",
            ["quantity"] = 10
        },
        {
            ["name"] = "Race Reroll",
            ["quantity"] = 15
        }
    }
}
v32.stageRewards = v33
v31[1] = v32
local v34 = {
    ["title"] = "Aizen Mastery 2",
    ["description"] = "Defeat 10 Players",
    ["goal"] = 10,
    ["trackingType"] = "PlayerKills"
}
local v35 = {
    ["money"] = 750000,
    ["gems"] = 750,
    ["items"] = {
        {
            ["name"] = "Trait Reroll",
            ["quantity"] = 15
        },
        {
            ["name"] = "Race Reroll",
            ["quantity"] = 20
        },
        {
            ["name"] = "Legendary Chest",
            ["quantity"] = 1
        }
    }
}
v34.stageRewards = v35
v31[2] = v34
local v36 = {
    ["title"] = "Aizen Mastery 3",
    ["description"] = "Kill 1000 Hollows",
    ["goal"] = 1000,
    ["trackingType"] = "HollowKills"
}
local v37 = {
    ["money"] = 1500000,
    ["gems"] = 1250,
    ["items"] = {
        {
            ["name"] = "Trait Reroll",
            ["quantity"] = 20
        },
        {
            ["name"] = "Race Reroll",
            ["quantity"] = 25
        },
        {
            ["name"] = "Legendary Chest",
            ["quantity"] = 1
        }
    }
}
v36.stageRewards = v37
v31[3] = v36
local v38 = {
    ["title"] = "Aizen Mastery 4",
    ["description"] = "Defeat 75 Bosses",
    ["goal"] = 75,
    ["trackingType"] = "AnyBossKills"
}
local v39 = {
    ["money"] = 2500000,
    ["gems"] = 2000,
    ["items"] = {
        {
            ["name"] = "Trait Reroll",
            ["quantity"] = 20
        },
        {
            ["name"] = "Race Reroll",
            ["quantity"] = 25
        },
        {
            ["name"] = "Legendary Chest",
            ["quantity"] = 2
        }
    }
}
v38.stageRewards = v39
v31[4] = v38
local v40 = {
    ["title"] = "Aizen Mastery Final",
    ["description"] = "Defeat Aizen Boss 20 times",
    ["goal"] = 20,
    ["trackingType"] = "AizenBossKills"
}
local v41 = {
    ["money"] = 3500000,
    ["gems"] = 3500,
    ["items"] = {
        {
            ["name"] = "Trait Reroll",
            ["quantity"] = 30
        },
        {
            ["name"] = "Race Reroll",
            ["quantity"] = 35
        },
        {
            ["name"] = "Mythical Chest",
            ["quantity"] = 1
        }
    }
}
v40.stageRewards = v41
v31[5] = v40
v30.stages = v31
v30.cost = nil
v30.rewards = {
    ["money"] = 0,
    ["gems"] = 0,
    ["xp"] = 0
}
v20.AizenQuestline = v30
local v42 = {
    ["npcName"] = "SukunaMovesetNPC",
    ["unlocks"] = "Sukuna",
    ["category"] = "Melee"
}
local v43 = {
    {
        ["title"] = "Sukuna Training 1",
        ["description"] = "Deal 35M damage",
        ["goal"] = 35000000,
        ["trackingType"] = "DamageDealt"
    },
    {
        ["title"] = "Sukuna Training 2",
        ["description"] = "Kill 10 players",
        ["goal"] = 10,
        ["trackingType"] = "PlayerKills"
    },
    {
        ["title"] = "Sukuna Training Final",
        ["description"] = "Kill Sukuna Boss 15 times",
        ["goal"] = 15,
        ["trackingType"] = "SukunaBossKills"
    }
}
v42.stages = v43
local v44 = {
    ["Money"] = 1250000,
    ["Gems"] = 5000,
    ["Items"] = {
        {
            ["name"] = "Cursed Finger",
            ["quantity"] = 6
        },
        {
            ["name"] = "Dismantle Fang",
            ["quantity"] = 3
        },
        {
            ["name"] = "Crimson Heart",
            ["quantity"] = 1
        }
    }
}
v42.cost = v44
v42.rewards = {
    ["money"] = 0,
    ["gems"] = 0,
    ["xp"] = 0
}
v20.Sukuna = v42
local v45 = {
    ["npcName"] = "JinwooMovesetNPC",
    ["unlocks"] = "Jinwoo",
    ["category"] = "Sword"
}
local v46 = {
    {
        ["title"] = "Jinwoo Training 1",
        ["description"] = "Take 15M damage",
        ["goal"] = 15000000,
        ["trackingType"] = "DamageTaken"
    },
    {
        ["title"] = "Jinwoo Training 2",
        ["description"] = "Kill 750 NPCs",
        ["goal"] = 750,
        ["trackingType"] = "AnyNPCKills"
    },
    {
        ["title"] = "Jinwoo Training 3",
        ["description"] = "Deal 100M damage",
        ["goal"] = 100000000,
        ["trackingType"] = "DamageDealt"
    },
    {
        ["title"] = "Jinwoo Training 4",
        ["description"] = "Kill 10 players",
        ["goal"] = 10,
        ["trackingType"] = "PlayerKills"
    },
    {
        ["title"] = "Jinwoo Training Final",
        ["description"] = "Kill Jinwoo Boss 15 times",
        ["goal"] = 15,
        ["trackingType"] = "JinwooBossKills"
    }
}
v45.stages = v46
local v47 = {
    ["Money"] = 2500000,
    ["Gems"] = 7500,
    ["Items"] = {
        {
            ["name"] = "Abyss Edge",
            ["quantity"] = 6
        },
        {
            ["name"] = "Dark Ring",
            ["quantity"] = 3
        },
        {
            ["name"] = "Shadow Heart",
            ["quantity"] = 1
        }
    }
}
v45.cost = v47
v45.rewards = {
    ["money"] = 0,
    ["gems"] = 0,
    ["xp"] = 0
}
v20.Jinwoo = v45
local v48 = {
    ["npcName"] = "Santa",
    ["unlocks"] = "Santa Hat",
    ["category"] = "Accessory"
}
local v49 = {
    {
        ["title"] = "Holiday Spirit 1",
        ["description"] = "Play the game for 30 minutes.",
        ["goal"] = 1800,
        ["trackingType"] = "PlayTime"
    },
    {
        ["title"] = "Holiday Spirit 2",
        ["description"] = "Defeat 125 NPCs.",
        ["goal"] = 125,
        ["trackingType"] = "AnyNPCKills"
    },
    {
        ["title"] = "Holiday Spirit Final",
        ["description"] = "Find 2 Gingerbread hidden around Christmas Island.",
        ["goal"] = 2,
        ["trackingType"] = "GingerbreadFound"
    }
}
v48.stages = v49
v48.cost = nil
v48.rewards = {
    ["money"] = 0,
    ["gems"] = 0,
    ["xp"] = 0
}
v20.Christmas = v48
local v50 = {
    ["npcName"] = "RagnaQuestlineBuff",
    ["unlocks"] = "RagnaDamageBuff",
    ["category"] = "Buff",
    ["requiresItem"] = "Ragna",
    ["requiresItemMessage"] = "Own Ragna Sword first!"
}
local v51 = {}
local v52 = {
    ["title"] = "Ragna Mastery 1",
    ["description"] = "Kill 750 NPCs",
    ["goal"] = 750,
    ["trackingType"] = "AnyNPCKills"
}
local v53 = {
    ["money"] = 250000,
    ["gems"] = 250,
    ["items"] = {
        {
            ["name"] = "Trait Reroll",
            ["quantity"] = 5
        },
        {
            ["name"] = "Race Reroll",
            ["quantity"] = 10
        }
    }
}
v52.stageRewards = v53
v51[1] = v52
local v54 = {
    ["title"] = "Ragna Mastery 2",
    ["description"] = "Deal 400M damage",
    ["goal"] = 400000000,
    ["trackingType"] = "DamageDealt"
}
local v55 = {
    ["money"] = 500000,
    ["gems"] = 500,
    ["items"] = {
        {
            ["name"] = "Trait Reroll",
            ["quantity"] = 7
        },
        {
            ["name"] = "Race Reroll",
            ["quantity"] = 12
        }
    }
}
v54.stageRewards = v55
v51[2] = v54
local v56 = {
    ["title"] = "Ragna Mastery 3",
    ["description"] = "Kill 15 Players",
    ["goal"] = 15,
    ["trackingType"] = "PlayerKills"
}
local v57 = {
    ["money"] = 1000000,
    ["gems"] = 750,
    ["items"] = {
        {
            ["name"] = "Trait Reroll",
            ["quantity"] = 10
        },
        {
            ["name"] = "Race Reroll",
            ["quantity"] = 15
        },
        {
            ["name"] = "Legendary Chest",
            ["quantity"] = 1
        }
    }
}
v56.stageRewards = v57
v51[3] = v56
local v58 = {
    ["title"] = "Ragna Mastery 4",
    ["description"] = "Take 85M damage",
    ["goal"] = 85000000,
    ["trackingType"] = "DamageTaken"
}
local v59 = {
    ["money"] = 1500000,
    ["gems"] = 1000,
    ["items"] = {
        {
            ["name"] = "Trait Reroll",
            ["quantity"] = 15
        },
        {
            ["name"] = "Race Reroll",
            ["quantity"] = 15
        },
        {
            ["name"] = "Legendary Chest",
            ["quantity"] = 1
        }
    }
}
v58.stageRewards = v59
v51[4] = v58
local v60 = {
    ["title"] = "Ragna Mastery Final",
    ["description"] = "Kill 100 Bosses",
    ["goal"] = 100,
    ["trackingType"] = "AnyBossKills"
}
local v61 = {
    ["money"] = 2000000,
    ["gems"] = 1500,
    ["items"] = {
        {
            ["name"] = "Trait Reroll",
            ["quantity"] = 20
        },
        {
            ["name"] = "Race Reroll",
            ["quantity"] = 20
        },
        {
            ["name"] = "Legendary Chest",
            ["quantity"] = 2
        }
    }
}
v60.stageRewards = v61
v51[5] = v60
v50.stages = v51
v50.cost = nil
v50.rewards = {
    ["money"] = 0,
    ["gems"] = 0,
    ["xp"] = 0
}
v20.RagnaQuestline = v50
local v62 = {
    ["npcName"] = "AizenMovesetNPC",
    ["unlocks"] = "Aizen",
    ["category"] = "Sword"
}
local v63 = {
    {
        ["title"] = "Aizen Training 1",
        ["description"] = "Kill 250 Hollows",
        ["goal"] = 250,
        ["trackingType"] = "HollowKills"
    },
    {
        ["title"] = "Aizen Training 2",
        ["description"] = "Obtain the Shinigami race",
        ["goal"] = 1,
        ["trackingType"] = "HasShinigamiRace"
    },
    {
        ["title"] = "Aizen Training 3",
        ["description"] = "Be deemed worthy by the Worthiness Fragment",
        ["goal"] = 1,
        ["trackingType"] = "DeemedWorthy"
    },
    {
        ["title"] = "Aizen Training 4",
        ["description"] = "Deal 350M damage",
        ["goal"] = 350000000,
        ["trackingType"] = "DamageDealt"
    },
    {
        ["title"] = "Aizen Training Final",
        ["description"] = "Kill Aizen Boss 15 times",
        ["goal"] = 15,
        ["trackingType"] = "AizenBossKills"
    }
}
v62.stages = v63
local v64 = {
    ["Money"] = 5000000,
    ["Gems"] = 10000,
    ["Items"] = {
        {
            ["name"] = "H\197\141gyoku Fragment",
            ["quantity"] = 1
        },
        {
            ["name"] = "Reiatsu Core",
            ["quantity"] = 3
        },
        {
            ["name"] = "Illusion Prism",
            ["quantity"] = 6
        },
        {
            ["name"] = "Mirage Pendant",
            ["quantity"] = 10
        }
    }
}
v62.cost = v64
v62.rewards = {
    ["money"] = 0,
    ["gems"] = 0,
    ["xp"] = 0
}
v20.Aizen = v62
local v65 = {
    ["npcName"] = "ShadowQuestlineBuff",
    ["unlocks"] = "ShadowDamageBuff",
    ["category"] = "Buff",
    ["requiresItem"] = "Shadow",
    ["requiresItemMessage"] = "Own Shadow Sword first!"
}
local v66 = {}
local v67 = {
    ["title"] = "Shadow Mastery 1",
    ["description"] = "Deal 1B Damage",
    ["goal"] = 1000000000,
    ["trackingType"] = "DamageDealt"
}
local v68 = {
    ["money"] = 750000,
    ["gems"] = 750,
    ["items"] = {
        {
            ["name"] = "Trait Reroll",
            ["quantity"] = 15
        },
        {
            ["name"] = "Race Reroll",
            ["quantity"] = 20
        }
    }
}
v67.stageRewards = v68
v66[1] = v67
local v69 = {
    ["title"] = "Shadow Mastery 2",
    ["description"] = "Defeat 1250 NPCs",
    ["goal"] = 1250,
    ["trackingType"] = "AnyNPCKills"
}
local v70 = {
    ["money"] = 1000000,
    ["gems"] = 1000,
    ["items"] = {
        {
            ["name"] = "Trait Reroll",
            ["quantity"] = 20
        },
        {
            ["name"] = "Race Reroll",
            ["quantity"] = 25
        },
        {
            ["name"] = "Legendary Chest",
            ["quantity"] = 1
        }
    }
}
v69.stageRewards = v70
v66[2] = v69
local v71 = {
    ["title"] = "Shadow Mastery 3",
    ["description"] = "Kill 150 Bosses",
    ["goal"] = 150,
    ["trackingType"] = "AnyBossKills"
}
local v72 = {
    ["money"] = 1500000,
    ["gems"] = 1500,
    ["items"] = {
        {
            ["name"] = "Trait Reroll",
            ["quantity"] = 25
        },
        {
            ["name"] = "Race Reroll",
            ["quantity"] = 30
        },
        {
            ["name"] = "Legendary Chest",
            ["quantity"] = 2
        }
    }
}
v71.stageRewards = v72
v66[3] = v71
local v73 = {
    ["title"] = "Shadow Mastery 4",
    ["description"] = "Beat Easy Shadow Dungeon 10 times",
    ["goal"] = 10,
    ["trackingType"] = "EasyCIDClears"
}
local v74 = {
    ["money"] = 2000000,
    ["gems"] = 2000,
    ["items"] = {
        {
            ["name"] = "Trait Reroll",
            ["quantity"] = 30
        },
        {
            ["name"] = "Race Reroll",
            ["quantity"] = 35
        },
        {
            ["name"] = "Legendary Chest",
            ["quantity"] = 2
        }
    }
}
v73.stageRewards = v74
v66[4] = v73
local v75 = {
    ["title"] = "Shadow Mastery 5",
    ["description"] = "Beat Medium Shadow Dungeon 10 times",
    ["goal"] = 10,
    ["trackingType"] = "MediumCIDClears"
}
local v76 = {
    ["money"] = 2500000,
    ["gems"] = 2500,
    ["items"] = {
        {
            ["name"] = "Trait Reroll",
            ["quantity"] = 35
        },
        {
            ["name"] = "Race Reroll",
            ["quantity"] = 40
        },
        {
            ["name"] = "Legendary Chest",
            ["quantity"] = 3
        }
    }
}
v75.stageRewards = v76
v66[5] = v75
local v77 = {
    ["title"] = "Shadow Mastery Final",
    ["description"] = "Beat Hard Shadow Dungeon 10 times",
    ["goal"] = 10,
    ["trackingType"] = "HardCIDClears"
}
local v78 = {
    ["money"] = 5000000,
    ["gems"] = 5000,
    ["items"] = {
        {
            ["name"] = "Trait Reroll",
            ["quantity"] = 50
        },
        {
            ["name"] = "Race Reroll",
            ["quantity"] = 50
        },
        {
            ["name"] = "Mythical Chest",
            ["quantity"] = 2
        }
    }
}
v77.stageRewards = v78
v66[6] = v77
v65.stages = v66
v65.cost = nil
v65.rewards = {
    ["money"] = 0,
    ["gems"] = 0,
    ["xp"] = 0
}
v20.ShadowQuestline = v65
local v79 = {
    ["npcName"] = "RimuruMasteryNPC",
    ["unlocks"] = "RimuruDamageBuff",
    ["category"] = "Buff",
    ["requiresItem"] = "Rimuru",
    ["requiresItemMessage"] = "Own Rimuru Sword first!"
}
local v80 = {}
local v81 = {
    ["title"] = "Demon Lord Evolution 1",
    ["description"] = "Defeat Rimuru Boss on Hard or Extreme 15 times",
    ["goal"] = 15,
    ["trackingType"] = "HardRimuruBossKills"
}
local v82 = {
    ["money"] = 1000000,
    ["gems"] = 1000,
    ["items"] = {
        {
            ["name"] = "Trait Reroll",
            ["quantity"] = 20
        },
        {
            ["name"] = "Race Reroll",
            ["quantity"] = 25
        }
    }
}
v81.stageRewards = v82
v80[1] = v81
local v83 = {
    ["title"] = "Demon Lord Evolution 2",
    ["description"] = "Obtain the Slime race",
    ["goal"] = 1,
    ["trackingType"] = "HasSlimeRace"
}
local v84 = {
    ["money"] = 2000000,
    ["gems"] = 2000,
    ["items"] = {
        {
            ["name"] = "Trait Reroll",
            ["quantity"] = 30
        },
        {
            ["name"] = "Race Reroll",
            ["quantity"] = 35
        },
        {
            ["name"] = "Legendary Chest",
            ["quantity"] = 2
        }
    }
}
v83.stageRewards = v84
v80[2] = v83
local v85 = {
    ["title"] = "Demon Lord Evolution Final",
    ["description"] = "Kill 10,000 NPCs",
    ["goal"] = 10000,
    ["trackingType"] = "AnyNPCKills"
}
local v86 = {
    ["money"] = 5000000,
    ["gems"] = 5000,
    ["items"] = {
        {
            ["name"] = "Trait Reroll",
            ["quantity"] = 50
        },
        {
            ["name"] = "Race Reroll",
            ["quantity"] = 50
        },
        {
            ["name"] = "Mythical Chest",
            ["quantity"] = 2
        }
    }
}
v85.stageRewards = v86
v80[3] = v85
v79.stages = v80
v79.cost = nil
v79.rewards = {
    ["money"] = 0,
    ["gems"] = 0,
    ["xp"] = 0
}
v20.RimuruQuestline = v79
local v87 = {
    ["npcName"] = "ConquerorHakiNPC",
    ["unlocks"] = "ConquerorHaki",
    ["category"] = "Ability",
    ["prerequisites"] = {
        {
            ["type"] = "Level",
            ["value"] = 7500,
            ["message"] = "Requires Level 7,500!"
        },
        {
            ["type"] = "AscensionLevel",
            ["value"] = 5,
            ["message"] = "Requires Ascension Level 5!"
        },
        {
            ["type"] = "HakiLevel",
            ["value"] = 25,
            ["message"] = "Requires Armament Haki Level 25!"
        },
        {
            ["type"] = "ObsHakiLevel",
            ["value"] = 25,
            ["message"] = "Requires Observation Haki Level 25!"
        }
    },
    ["requiresItem"] = "Conqueror Fragment",
    ["requiresItemMessage"] = "You need Conqueror Fragment to start the quest!"
}
local v88 = {
    {
        ["title"] = "Conqueror\'s Will 1",
        ["description"] = "Kill 500 NPCs with Armament Haki active",
        ["goal"] = 500,
        ["trackingType"] = "HakiNPCKills"
    },
    {
        ["title"] = "Conqueror\'s Will 2",
        ["description"] = "Dodge 500 attacks with Observation Haki",
        ["goal"] = 500,
        ["trackingType"] = "ObsHakiDodges"
    },
    {
        ["title"] = "Conqueror\'s Will 3",
        ["description"] = "Defeat 200 Bosses",
        ["goal"] = 200,
        ["trackingType"] = "AnyBossKills"
    },
    {
        ["title"] = "Conqueror\'s Will Final",
        ["description"] = "Beat 25 Dungeons",
        ["goal"] = 25,
        ["trackingType"] = "AnyDungeonClears"
    }
}
v87.stages = v88
v87.cost = nil
v87.rewards = {
    ["money"] = 0,
    ["gems"] = 0,
    ["xp"] = 0
}
v20.ConquerorHaki = v87
local v89 = {
    ["npcName"] = "SlimeCraftNPC",
    ["unlocks"] = "SlimeCraftAccess",
    ["category"] = "SlimeCraft"
}
local v90 = {}
local v91 = {
    ["title"] = "Slime Collection",
    ["description"] = "Find 7 Slime Pieces across the islands (in order)",
    ["trackingType"] = "SlimePuzzlePieces",
    ["goal"] = 7,
    ["stageRewards"] = {
        ["money"] = 75000,
        ["gems"] = 150,
        ["xp"] = 150000
    }
}
__set_list(v90, 1, {v91})
v89.stages = v90
v89.cost = nil
v89.rewards = {
    ["money"] = 0,
    ["gems"] = 0,
    ["xp"] = 0
}
v20.SlimeCraftUnlock = v89
local v92 = {
    ["npcName"] = "AnosQuestNPC",
    ["unlocks"] = "DemoniteCoreDrops",
    ["category"] = "DemoniteCore"
}
local v93 = {}
local v94 = {
    ["title"] = "Demonite Fragments",
    ["description"] = "Find 2 Demonite Fragments hidden in the world",
    ["trackingType"] = "DemonitePieces",
    ["goal"] = 2,
    ["stageRewards"] = {
        ["money"] = 50000,
        ["gems"] = 100,
        ["xp"] = 100000
    }
}
__set_list(v93, 1, {v94})
v92.stages = v93
v92.cost = nil
v92.rewards = {
    ["money"] = 0,
    ["gems"] = 0,
    ["xp"] = 0
}
v20.DemoniteCoreUnlock = v92
local v95 = {
    ["npcName"] = "HogyokuQuestNPC",
    ["unlocks"] = "SoulSocietyAccess",
    ["category"] = "SoulSociety",
    ["prerequisites"] = {
        {
            ["type"] = "Level",
            ["value"] = 8500,
            ["message"] = "Requires Level 8,500!"
        }
    }
}
local v96 = {}
local v97 = {
    ["title"] = "Hogyoku Fragments",
    ["description"] = "Find 6 Hogyoku Fragments hidden in the world",
    ["trackingType"] = "HogyokuPieces",
    ["goal"] = 6,
    ["stageRewards"] = {
        ["money"] = 100000,
        ["gems"] = 200,
        ["xp"] = 500000
    }
}
__set_list(v96, 1, {v97})
v95.stages = v96
v95.cost = nil
v95.rewards = {
    ["money"] = 0,
    ["gems"] = 0,
    ["xp"] = 0
}
v20.HogyokuUnlock = v95
local v98 = {
    ["npcName"] = "ShadowMonarchQuestlineBuff",
    ["unlocks"] = "ShadowMonarchDamageBuff",
    ["category"] = "Buff",
    ["requiresItem"] = "Shadow Monarch",
    ["requiresItemMessage"] = "Own Shadow Monarch Sword first!"
}
local v99 = {}
local v100 = {
    ["title"] = "Dungeon Master",
    ["description"] = "Win 10 Double Dungeons on Hard or Extreme difficulty.",
    ["goal"] = 10,
    ["trackingType"] = "DungeonHardExtremeWins",
    ["stageRewards"] = {
        ["money"] = 100000,
        ["gems"] = 200,
        ["xp"] = 500000
    }
}
v99[1] = v100
local v101 = {
    ["title"] = "Monarch\'s Blood",
    ["description"] = "Obtain and equip the Monarch clan.",
    ["goal"] = 1,
    ["trackingType"] = "MonarchClanCheck",
    ["stageRewards"] = {
        ["money"] = 50000,
        ["gems"] = 100,
        ["xp"] = 250000
    }
}
v99[2] = v101
local v102 = {
    ["title"] = "Shadow Army",
    ["description"] = "Defeat 25 Shadow Soldiers in the dungeon.",
    ["goal"] = 25,
    ["trackingType"] = "ShadowSoldierKills",
    ["stageRewards"] = {
        ["money"] = 200000,
        ["gems"] = 500,
        ["xp"] = 1000000
    }
}
v99[3] = v102
v98.stages = v99
v98.cost = nil
v98.rewards = {
    ["money"] = 0,
    ["gems"] = 0,
    ["xp"] = 0
}
v20.ShadowMonarchUnlock = v98
local v103 = {
    ["npcName"] = "TrueAizenFUnlockNPC",
    ["unlocks"] = "AizenFMoveBuff",
    ["category"] = "Buff",
    ["requiresItem"] = "True Aizen",
    ["requiresItemMessage"] = "Own True Aizen Sword first!"
}
local v104 = {
    {
        ["title"] = "True Aizen F Mastery 1",
        ["description"] = "Defeat True Aizen Boss on Hard or Extreme 15 times",
        ["goal"] = 15,
        ["trackingType"] = "HardAizenBossKills"
    },
    {
        ["title"] = "True Aizen F Mastery 2",
        ["description"] = "Obtain the Espada clan",
        ["goal"] = 1,
        ["trackingType"] = "EspadaClanCheck"
    },
    {
        ["title"] = "True Aizen F Mastery Final",
        ["description"] = "Consume 5 Transmutation Shard",
        ["goal"] = 5,
        ["trackingType"] = "HogyokuShardCollect"
    }
}
v103.stages = v104
v103.cost = nil
v103.rewards = {
    ["money"] = 0,
    ["gems"] = 0,
    ["xp"] = 0
}
v20.TrueAizenFUnlock = v103
u1.Questlines = v20
u1.Settings = {
    ["maxRepeatableQuests"] = 1,
    ["maxQuestlineQuests"] = 1,
    ["buttonCooldown"] = 0.5,
    ["promptCooldown"] = 1,
    ["promptMaxDistance"] = 8,
    ["promptHoldDuration"] = 0
}
function u1.GetRepeatableQuest(p105) --[[ Line: 1338 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    return u1.RepeatableQuests[p105]
end
function u1.GetQuestline(p106) --[[ Line: 1343 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    return u1.Questlines[p106]
end
function u1.GetQuestlineStage(p107, p108) --[[ Line: 1348 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v109 = u1.Questlines[p107]
    if v109 then
        return v109.stages[p108]
    else
        return nil
    end
end
function u1.GetQuestlineTotalStages(p110) --[[ Line: 1355 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v111 = u1.Questlines[p110]
    return v111 and #v111.stages or 0
end
function u1.IsRepeatableQuestNPC(p112) --[[ Line: 1362 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    return u1.RepeatableQuests[p112] ~= nil
end
function u1.GetQuestlineForNPC(p113) --[[ Line: 1367 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    for v114, v115 in pairs(u1.Questlines) do
        if v115.npcName == p113 then
            return v114
        end
    end
    return nil
end
function u1.GetQuestType(p116) --[[ Line: 1377 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if u1.RepeatableQuests[p116] then
        return "repeatable", p116
    else
        local v117 = u1.GetQuestlineForNPC(p116)
        if v117 then
            return "questline", v117
        else
            return nil, nil
        end
    end
end
function u1.GetTotalKillsRequired(p118) --[[ Line: 1389 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v119 = u1.RepeatableQuests[p118]
    if not v119 then
        return 0
    end
    local v120 = 0
    for _, v121 in ipairs(v119.requirements) do
        v120 = v120 + v121.amount
    end
    return v120
end
function u1.RollQuestDrops(p122, p123) --[[ Line: 1404 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v124 = u1.RepeatableQuests[p122]
    if not v124 then
        return {}, {}
    end
    local v125 = {}
    local v126 = {}
    local v127 = 1
    local v128 = 1
    if p123 then
        v127 = _G.HasBoost and _G.HasBoost(p123, "2xLuck") and 2 or v127
        if _G.HasBoost and _G.HasBoost(p123, "2xDrop") then
            v128 = 2
        end
    end
    if v124.itemDrops then
        for _, v129 in ipairs(v124.itemDrops) do
            local v130 = v129.chance * v127
            if math.min(v130, 100) >= math.random() * 100 then
                local v131 = (v129.quantity or 1) * v128
                local v132 = {
                    ["name"] = v129.name,
                    ["quantity"] = v131,
                    ["image"] = v129.image or "rbxassetid://0",
                    ["doubled"] = v128 > 1
                }
                table.insert(v125, v132)
            end
        end
    end
    if v124.accessoryDrops then
        for _, v133 in ipairs(v124.accessoryDrops) do
            local v134 = v133.chance * v127
            if math.min(v134, 100) >= math.random() * 100 then
                for _ = 1, v128 do
                    local v135 = {
                        ["name"] = v133.name,
                        ["quantity"] = 1,
                        ["image"] = v133.image or "rbxassetid://0",
                        ["doubled"] = v128 > 1
                    }
                    table.insert(v126, v135)
                end
            end
        end
    end
    return v125, v126
end
function u1.GetQuestlineCost(p136) --[[ Line: 1458 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v137 = u1.Questlines[p136]
    if v137 then
        return v137.cost
    else
        return nil
    end
end
function u1.GetCostString(p138) --[[ Line: 1465 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v139 = u1.Questlines[p138]
    if not (v139 and v139.cost) then
        return ""
    end
    local v140 = {}
    local v141 = v139.cost
    if v141.Money and v141.Money > 0 then
        local v142 = v141.Money
        local v143 = "$" .. tostring(v142)
        table.insert(v140, v143)
    end
    if v141.Gems and v141.Gems > 0 then
        local v144 = v141.Gems
        local v145 = tostring(v144) .. " Gems"
        table.insert(v140, v145)
    end
    for _, v146 in ipairs(v141.Items or {}) do
        local v147 = v146.quantity
        local v148 = tostring(v147) .. "x " .. v146.name
        table.insert(v140, v148)
    end
    return table.concat(v140, " + ")
end
return u1