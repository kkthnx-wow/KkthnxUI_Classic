local C = KkthnxUI[2]

local DISABLE = DISABLE
local EMOTE = EMOTE
local GUILD = GUILD
local NONE = NONE
local PARTY = PARTY
local PLAYER = PLAYER
local RAID = RAID
local SAY = SAY
local YELL = YELL

-- Actionbar
C["ActionBar"] = {
	Enable = true,
	Hotkeys = true,
	Macro = true,
	Grid = true,
	Cooldown = true,
	MmssTH = 60,
	TenthTH = 3,
	OverrideWA = false,
	MicroMenu = true,
	FadeMicroMenu = false,
	ShowStance = true,
	EquipColor = false,
	KeyDown = true,
	ButtonLock = true,
	VehButtonSize = 34,

	Bar1 = true,
	Bar1Size = 38,
	Bar1Font = 12,
	Bar1Num = 12,
	Bar1PerRow = 12,
	Bar1Fade = false,

	Bar2 = true,
	Bar2Size = 38,
	Bar2Font = 12,
	Bar2Num = 12,
	Bar2PerRow = 12,
	Bar2Fade = false,

	Bar3 = true,
	Bar3Size = 38,
	Bar3Font = 12,
	Bar3Num = 12,
	Bar3PerRow = 12,
	Bar3Fade = false,

	Bar4 = true,
	Bar4Size = 38,
	Bar4Font = 12,
	Bar4Num = 12,
	Bar4PerRow = 1,
	Bar4Fade = true,

	Bar5 = true,
	Bar5Size = 38,
	Bar5Font = 12,
	Bar5Num = 12,
	Bar5PerRow = 1,
	Bar5Fade = false,

	BarPetSize = 28,
	BarPetFont = 12,
	BarPetPerRow = 10,
	BarPetFade = false,

	BarStanceSize = 30,
	BarStanceFont = 12,
	BarStancePerRow = 10,
	BarStanceFade = false,

	Bar6 = false,
	Bar6Size = 34,
	Bar6Font = 12,
	Bar6Num = 12,
	Bar6PerRow = 12,
	Bar6Fade = false,

	Bar7 = false,
	Bar7Size = 34,
	Bar7Font = 12,
	Bar7Num = 12,
	Bar7PerRow = 12,
	Bar7Fade = false,

	Bar8 = false,
	Bar8Size = 34,
	Bar8Font = 12,
	Bar8Num = 12,
	Bar8PerRow = 12,
	Bar8Fade = false,

	BarAspect = true,
	BarAspectSize = 25,
	BarAspectVerticle = true,
	BarAspectFade = true,
	BarAspectGrowUp = true, -- Change to false for downward growth

	BarFadeGlobal = true,
	BarFadeAlpha = 0.1,
	BarFadeDelay = 0,
	BarFadeCombat = true,
	BarFadeTarget = true,
	BarFadeCasting = true,
	BarFadeHealth = true,
	BarFadeVehicle = true,
}

-- Announcements
C["Announcements"] = {
	BrokenAlert = false,
	DispellAlert = false,
	HealthAlert = false,
	InstAlertOnly = true,
	InterruptAlert = false,
	ItemAlert = false,
	OnlyCompleteRing = false,
	OwnDispell = true,
	OwnInterrupt = true,
	PullCountdown = true,
	PvPEmote = false,
	QuestNotifier = false,
	QuestProgress = false,
	ResetInstance = true,
	SaySapped = false,
	AlertChannel = {
		Options = {
			[EMOTE] = 6,
			[PARTY .. " / " .. RAID] = 2,
			[PARTY] = 1,
			[RAID] = 3,
			[SAY] = 4,
			[YELL] = 5,
		},
		Value = 2,
	},
}

-- Automation
C["Automation"] = {
	-- AutoCollapse = false,
	-- AutoGoodbye = false,
	-- AutoSetRole = false,
	AutoDeclineDuels = false,
	AutoDismountTaxi = false,
	AutoInvite = false,
	AutoOpenItems = false,
	AutoQuest = false,
	AutoRelease = false,
	AutoResurrect = false,
	AutoResurrectThank = false,
	AutoReward = false,
	AutoSummon = false,
	BuffThanks = false,
	NoBadBuffs = false,
	WhisperInvite = "inv+",
	WhisperInviteRestriction = true, -- Missing in GUI.lua
}

C["Inventory"] = {
	AutoSell = true,
	BagBar = true,
	BagBarMouseover = false,
	BagBarSize = 32,
	BagsBindOnEquip = false,
	BagsItemLevel = false,
	BagsPerRow = 6,
	BagsWidth = 10,
	BankPerRow = 10,
	BankWidth = 12,
	DeleteButton = true,
	Enable = true,
	FilterJunk = true,
	FilterAmmo = true,
	FilterConsumable = true,
	FilterEquipment = true,
	FilterLegendary = true,
	FilterFavourite = true,
	FilterGoods = false,
	FilterQuest = false,
	GatherEmpty = false,
	IconSize = 36,
	ItemFilter = true,
	JustBackpack = false,
	-- BagSortMode = 1, -- Missing in GUI.lua
	ShowNewItem = true,
	SpecialBagsColor = true,
	UpgradeIcon = true,
	iLvlToShow = 1,
	GrowthDirection = {
		Options = {
			["Horizontal"] = "HORIZONTAL",
			["Vertical"] = "VERTICAL",
		},
		Value = "HORIZONTAL",
	},
	SortDirection = {
		Options = {
			["Ascending"] = "ASCENDING",
			["Descending"] = "DESCENDING",
		},
		Value = "DESCENDING",
	},
	AutoRepair = {
		Options = {
			[NONE] = 0,
			[GUILD] = 1,
			[PLAYER] = 2,
		},
		Value = 2,
	},
}

-- Buffs & Debuffs
C["Auras"] = {
	BuffSize = 32,
	BuffsPerRow = 16,
	DebuffSize = 34,
	DebuffsPerRow = 16,
	Enable = true,
	HideBlizBuff = false,
	Reminder = false,
	ReverseBuffs = false,
	ReverseDebuffs = false,
	TotemSize = 32,
	Totems = true,
	VerticalTotems = false,
}

-- Chat
C["Chat"] = {
	Background = true,
	ChatItemLevel = true,
	ChatMenu = true,
	ConfigButton = true,
	CopyButton = true,
	Emojis = false,
	Enable = true,
	Fading = true,
	FadingTimeVisible = 100,
	Freedom = true,
	Height = 170,
	Lock = true,
	LogMax = 0,
	OldChatNames = false,
	RollButton = true,
	Sticky = false,
	WhisperColor = true,
	Width = 400,
	TimestampFormat = {
		Options = {
			["Disable"] = 1,
			["03:27 PM"] = 2,
			["03:27:32 PM"] = 3,
			["15:27"] = 4,
			["15:27:32"] = 5,
		},
		Value = 1,
	},
}

-- Datatext
C["DataText"] = {
	Coords = false,
	Friends = false,
	Gold = false,
	Guild = false,
	GuildSortBy = 1,
	GuildSortOrder = true,
	HideText = false,
	IconColor = { 102 / 255, 157 / 255, 255 / 255 },
	Latency = true,
	Location = true,
	Spec = false,
	System = true,
	Time = true,
}

C["AuraWatch"] = {
	Enable = true,
	ClickThrough = false,
	IconScale = 1,
	MinCD = 3,
}

-- General
C["General"] = {
	AutoScale = true,
	ColorTextures = false,
	MinimapIcon = false,
	MoveBlizzardFrames = false,
	CombatErrors = false,
	TexturesColor = { 1, 1, 1 },
	UIScale = 0.71,
	Texture = "KkthnxUI",
	SmoothAmount = 0.25,
	BorderStyle = {
		Options = {
			["KkthnxUI"] = "KkthnxUI",
			["AzeriteUI"] = "AzeriteUI",
			["KkthnxUI_Pixel"] = "KkthnxUI_Pixel",
			["KkthnxUI_Blank"] = "KkthnxUI_Blank",
		},
		Value = "KkthnxUI",
	},
	NumberPrefixStyle = {
		Options = {
			["Standard: b/m/k"] = 1,
			["Asian: y/w"] = 2,
			["Full Digits"] = 3,
		},
		Value = 1,
	},
	Profiles = {
		Options = {},
	},
	GlowMode = {
		Options = {
			["Pixel"] = 1,
			["Autocast"] = 2,
			["Action Button"] = 3,
			["Proc Glow"] = 4,
		},
		Value = 3,
	},
}

-- Loot
C["Loot"] = {
	AutoConfirm = false,
	AutoGreed = false,
	Enable = true,
	FastLoot = false,
	GroupLoot = true,
}

-- Minimap
C["Minimap"] = {
	Calendar = true,
	EasyVolume = false,
	Enable = true,
	MailPulse = true,
	ShowRecycleBin = true,
	Size = 210,
	RecycleBinPosition = {
		Options = {
			["BottomLeft"] = 1,
			["BottomRight"] = 2,
			["TopLeft"] = 3,
			["TopRight"] = 4,
		},
		Value = "BottomLeft",
	},
	LocationText = {
		Options = {
			["Always Display"] = "SHOW",
			["Hide"] = "Hide",
			["Minimap Mouseover"] = "MOUSEOVER",
		},
		Value = "MOUSEOVER",
	},
}

-- Miscellaneous
C["Misc"] = {
	AFKCamera = false,
	AlreadyKnown = false,
	AutoBubbles = false,
	ClassColorPlus = false,
	ColorPicker = false,
	DBMCount = "10",
	EasyMarking = false,
	EnhancedFriends = false,
	EnhancedMail = false,
	ExpRep = true,
	GemEnchantInfo = false,
	HelmCloakToggle = false,
	ItemLevel = false,
	MaxCameraZoom = 2.6,
	MuteSounds = true,
	PetHappiness = true,
	RaidTool = true,
	ShowWowHeadLinks = false,
	SlotDurability = false,
	SlotDurabilityWarning = false,
	StatExpand = false,
	StatOrder = "12345",
	TradeTabs = false,
	TrainAll = false,
	EasyMarkKey = {
		Options = {
			["CTRL"] = 1,
			["ALT"] = 2,
			["SHIFT"] = 3,
			["DISABLE"] = 4,
		},
		Value = 1,
	},
}

C["Nameplate"] = {
	ColorByDot = false, -- This is not ready
	DotColor = { 1, 0.5, 0.2 },
	DotSpellList = {
		Spells = {},
	},
	AuraSize = 28,
	CastTarget = false,
	CastbarGlow = true,
	ClassAuras = true,
	ClassIcon = false,
	ColoredTarget = true,
	CustomColor = { 0, 0.8, 0.3 },
	CustomUnitColor = true,
	CustomUnitList = "",
	-- DPSRevertThreat = false,
	-- Distance = 42,
	Enable = true,
	ExecuteRatio = 0,
	FriendPlate = false,
	FriendlyCC = false,
	FullHealth = false,
	HealthTextSize = 13,
	HostileCC = true,
	InsecureColor = { 1, 0, 0 },
	InsideView = true,
	MaxAuras = 5,
	MinAlpha = 0.6,
	MinScale = 1,
	CVarOnlyNames = false,
	CVarShowNPCs = false,
	NameOnly = true,
	NameTextSize = 13,
	NameplateClassPower = true,
	PPGCDTicker = true,
	HarmWidth = 200,
	HarmHeight = 62,
	EnemyThru = false,
	FriendlyThru = false,
	HelpWidth = 200,
	HelpHeight = 62,
	PPHeight = 10,
	PPHideOOC = true,
	PPIconSize = 32,
	PPOnFire = false,
	PPPHeight = 8,
	PPPowerText = true,
	PPWidth = 200,
	PlateAuras = true,
	PlateHeight = 18,
	PlateWidth = 200,
	PowerUnitList = "",
	QuestIndicator = true,
	SecureColor = { 1, 0, 1 },
	SelectedScale = 1.1,
	ShowPlayerPlate = false,
	Smooth = false,
	TankMode = false,
	TargetColor = { 0, 0.6, 1 },
	TargetIndicatorColor = { 1, 1, 0 },
	TransColor = { 1, 0.8, 0 },
	VerticalSpacing = 0.7,
	AuraFilter = {
		Options = {
			["White & Black List"] = 1,
			["List & Player"] = 2,
			["List & Player & CCs"] = 3,
		},
		Value = 3,
	},
	TargetIndicator = {
		Options = {
			["Disable"] = 1,
			["Top Arrow"] = 2,
			["Right Arrow"] = 3,
			["Border Glow"] = 4,
			["Top Arrow + Glow"] = 5,
			["Right Arrow + Glow"] = 6,
		},
		Value = 4,
	},
	TargetIndicatorTexture = {
		Options = {
			["Blue Arrow 2" .. "|TInterface\\Addons\\KkthnxUI\\Media\\Nameplates\\BlueArrow2:0|t"] = [[Interface\AddOns\KkthnxUI\Media\Nameplates\BlueArrow2]],
			["Blue Arrow" .. "|TInterface\\Addons\\KkthnxUI\\Media\\Nameplates\\BlueArrow:0|t"] = [[Interface\AddOns\KkthnxUI\Media\Nameplates\BlueArrow]],
			["Neon Blue Arrow" .. "|TInterface\\Addons\\KkthnxUI\\Media\\Nameplates\\NeonBlueArrow:0|t"] = [[Interface\AddOns\KkthnxUI\Media\Nameplates\NeonBlueArrow]],
			["Neon Green Arrow" .. "|TInterface\\Addons\\KkthnxUI\\Media\\Nameplates\\NeonGreenArrow:0|t"] = [[Interface\AddOns\KkthnxUI\Media\Nameplates\NeonGreenArrow]],
			["Neon Pink Arrow" .. "|TInterface\\Addons\\KkthnxUI\\Media\\Nameplates\\NeonPinkArrow:0|t"] = [[Interface\AddOns\KkthnxUI\Media\Nameplates\NeonPinkArrow]],
			["Neon Red Arrow" .. "|TInterface\\Addons\\KkthnxUI\\Media\\Nameplates\\NeonRedArrow:0|t"] = [[Interface\AddOns\KkthnxUI\Media\Nameplates\NeonRedArrow]],
			["Neon Purple Arrow" .. "|TInterface\\Addons\\KkthnxUI\\Media\\Nameplates\\NeonPurpleArrow:0|t"] = [[Interface\AddOns\KkthnxUI\Media\Nameplates\NeonPurpleArrow]],
			["Purple Arrow" .. "|TInterface\\Addons\\KkthnxUI\\Media\\Nameplates\\PurpleArrow:0|t"] = [[Interface\AddOns\KkthnxUI\Media\Nameplates\PurpleArrow]],
			["Red Arrow 2" .. "|TInterface\\Addons\\KkthnxUI\\Media\\Nameplates\\RedArrow2.tga:0|t"] = [[Interface\AddOns\KkthnxUI\Media\Nameplates\RedArrow2]],
			["Red Arrow" .. "|TInterface\\Addons\\KkthnxUI\\Media\\Nameplates\\RedArrow:0|t"] = [[Interface\AddOns\KkthnxUI\Media\Nameplates\RedArrow]],
			["Red Chevron Arrow" .. "|TInterface\\Addons\\KkthnxUI\\Media\\Nameplates\\RedChevronArrow:0|t"] = [[Interface\AddOns\KkthnxUI\Media\Nameplates\RedChevronArrow]],
			["Red Chevron Arrow2" .. "|TInterface\\Addons\\KkthnxUI\\Media\\Nameplates\\RedChevronArrow2:0|t"] = [[Interface\AddOns\KkthnxUI\Media\Nameplates\RedChevronArrow2]],
		},
		Value = [[Interface\AddOns\KkthnxUI\Media\Nameplates\NeonBlueArrow]],
	},
}

-- Skins
C["Skins"] = {
	BlizzardFrames = true,
	ChatBubbleAlpha = 0.9,
	ChatBubbles = true,
	DeadlyBossMods = false,
	Details = false,
	ImproveTradeSkill = false,
	QuestDifficulty = false,
	QuestLevels = false,
	QuestLog = false,
	QuestTracker = false,

	-- Bartender4 = false,
	-- BigWigs = false,
	-- ButtonForge = false,
	-- ChocolateBar = false,
	-- Dominos = false,
	-- Hekili = false,
	-- RareScanner = false,
	-- Skada = false,
	-- Spy = false,
	-- TellMeWhen = false,
	-- TitanPanel = false,
	-- WeakAuras = false,
	-- ObjectiveFontSize = 12,
	-- QuestFontSize = 11,
}

-- Tooltip
C["Tooltip"] = {
	ClassColor = false,
	CombatHide = false,
	Cursor = false,
	Enable = true,
	FactionIcon = false,
	HideJunkGuild = true,
	HideRank = true,
	HideRealm = true,
	HideTitle = true,
	Icons = true,
	LFDRole = false,
	ShowIDs = false,
	ShowNodeInfo = false,
	TargetBy = true,
	CursorMode = {
		Options = {
			[DISABLE] = 1,
			["LEFT"] = 2,
			["TOP"] = 3,
			["RIGHT"] = 4,
		},
		Value = 1,
	},
	TipAnchor = {
		Options = {
			["TOPLEFT"] = 1,
			["TOPRIGHT"] = 2,
			["BOTTOMLEFT"] = 3,
			["BOTTOMRIGHT"] = 4,
		},
		Value = 4,
	},
}

-- Unitframe
C["Unitframe"] = {
	AdditionalPower = false,
	AllTextScale = 1, -- Testing
	AutoAttack = true,
	CastClassColor = false,
	CastReactionColor = false,
	CastbarLatency = true,
	ClassResources = true,
	CombatFade = false,
	CombatText = false,
	DebuffHighlight = true,
	Enable = true,
	FCTOverHealing = false,
	GlobalCooldown = true,
	HotsDots = true,
	OnlyShowPlayerDebuff = false,
	Range = true,

	-- Player
	PlayerBuffs = false,
	PlayerBuffsPerRow = 6,
	PlayerCastbar = true,
	PlayerCastbarHeight = 28,
	PlayerCastbarIcon = true,
	PlayerCastbarWidth = 268,
	PlayerDebuffs = false,
	PlayerDebuffsPerRow = 7,
	PlayerHealthHeight = 34,
	PlayerHealthWidth = 200,
	PlayerPowerHeight = 16,

	PvPIndicator = true,
	ResurrectSound = false,
	ShowHealPrediction = true,
	ShowPlayerLevel = true,
	Smooth = false,
	EnergyManaRegen = true,

	SwingBar = false,
	SwingWidth = 274,
	SwingHeight = 14,
	SwingTimer = true,
	OffOnTop = false,

	-- Target
	TargetHealthHeight = 34,
	TargetHealthWidth = 200,
	TargetPowerHeight = 16,
	TargetBuffs = true,
	TargetBuffsPerRow = 7,
	TargetCastbar = true,
	TargetCastbarIcon = true,
	TargetCastbarHeight = 34,
	TargetCastbarWidth = 268,
	TargetDebuffs = true,
	TargetDebuffsPerRow = 6,

	-- TargetOfTarget
	TargetTargetHealthHeight = 18,
	TargetTargetHealthWidth = 100,
	TargetTargetPowerHeight = 10,
	HideTargetOfTargetLevel = false,
	HideTargetOfTargetName = false,
	HideTargetofTarget = false,

	-- Pet
	PetHealthHeight = 18,
	PetHealthWidth = 100,
	PetPowerHeight = 10,
	HidePetLevel = false,
	HidePetName = false,
	HidePet = false,

	HealthbarColor = {
		Options = {
			["Dark"] = "Dark",
			["Value"] = "Value",
			["Class"] = "Class",
		},
		Value = "Class",
	},
	PortraitStyle = {
		Options = {
			["Overlay Portrait"] = "OverlayPortrait",
			["3D Portraits"] = "ThreeDPortraits",
			["Class Portraits"] = "ClassPortraits",
			["New Class Portraits"] = "NewClassPortraits",
			["Default Portraits"] = "DefaultPortraits",
			["No Portraits"] = "NoPortraits",
		},
		Value = "DefaultPortraits",
	},
}

C["Party"] = {
	CastbarIcon = false,
	Castbars = false,
	Enable = true,
	HealthHeight = 22,
	HealthWidth = 150,
	PortraitTimers = false,
	PowerHeight = 12,
	ShowBuffs = false,
	ShowHealPrediction = true,
	ShowPartySolo = false,
	ShowPet = false,
	ShowPlayer = true,
	Smooth = false,
	TargetHighlight = false,
	HealthbarColor = {
		Options = {
			["Dark"] = "Dark",
			["Value"] = "Value",
			["Class"] = "Class",
		},
		Value = "Class",
	},
}

-- Raidframe
C["Raid"] = {
	DebuffWatch = true,
	DebuffWatchDefault = true,
	Enable = true,
	Height = 44,
	HorizonRaid = false,
	MainTankFrames = true,
	PowerBarShow = false,
	ManabarShow = false,
	NumGroups = 6,
	RaidUtility = true,
	ReverseRaid = false,
	ShowHealPrediction = true,
	ShowNotHereTimer = true,
	ShowRaidSolo = false,
	ShowTeamIndex = false,
	Smooth = false,
	TargetHighlight = false,
	Width = 70,
	RaidBuffsStyle = {
		Options = {
			["Aura Track"] = "Aura Track",
			["Standard"] = "Standard",
			["None"] = "None",
		},
		Value = "Aura Track",
	},
	RaidBuffs = {
		Options = {
			["Only my buffs"] = "Self",
			["Only castable buffs"] = "Castable",
			["All buffs"] = "All",
		},
		Value = "Self",
	},
	AuraTrack = true,
	AuraTrackIcons = true,
	AuraTrackSpellTextures = true,
	AuraTrackThickness = 5,

	HealthbarColor = {
		Options = {
			["Dark"] = "Dark",
			["Value"] = "Value",
			["Class"] = "Class",
		},
		Value = "Class",
	},
	HealthFormat = {
		Options = {
			["Disable HP"] = 1,
			["Health Percentage"] = 2,
			["Health Remaining"] = 3,
			["Health Lost"] = 4,
		},
		Value = 1,
	},
}

-- Worldmap
C["WorldMap"] = {
	Enable = true,
	-- AlphaWhenMoving = 0.35,
	Coordinates = true,
	FadeWhenMoving = true,
	MapRevealGlow = true,
	-- SmallWorldMap = true,
}
