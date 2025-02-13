local K = KkthnxUI[1]
local C = KkthnxUI[2]
local L = KkthnxUI[3]
local Module = K:NewModule("Miscellaneous")

-- Localizing Lua built-in functions
local select = select
local tonumber = tonumber
local next = next
local type = type
local ipairs = ipairs
local pcall = pcall
local error = error

-- Localizing WoW API functions
local CreateFrame = CreateFrame
local PlaySound = PlaySound
local StaticPopup_Show = StaticPopup_Show
local hooksecurefunc = hooksecurefunc
local UIParent = UIParent
local UnitXP = UnitXP
local UnitXPMax = UnitXPMax
local UnitGUID = UnitGUID
local GetMerchantItemLink = GetMerchantItemLink
local GetMerchantItemMaxStack = GetMerchantItemMaxStack
local GetRewardXP = GetRewardXP
local GetQuestLogRewardXP = GetQuestLogRewardXP
local IsAltKeyDown = IsAltKeyDown
local InCombatLockdown = InCombatLockdown
local C_BattleNet_GetGameAccountInfoByGUID = C_BattleNet.GetGameAccountInfoByGUID
local C_FriendList_IsFriend = C_FriendList.IsFriend
local C_QuestLog_GetSelectedQuest = C_QuestLog.GetSelectedQuest
local C_QuestLog_ShouldShowQuestRewards = C_QuestLog.ShouldShowQuestRewards
local C_Item_GetItemInfo = C_Item.GetItemInfo
local C_Item_GetItemQualityColor = C_Item.GetItemQualityColor
local StaticPopupDialogs = StaticPopupDialogs
local IsGuildMember = IsGuildMember

-- Localizing WoW UI constants
local FRIEND = FRIEND
local GUILD = GUILD
local NO = NO
local YES = YES

-- Miscellaneous Module Registry
local KKUI_MISC_MODULE = {}

-- Register Miscellaneous Modules
function Module:RegisterMisc(name, func)
	if not KKUI_MISC_MODULE[name] then
		KKUI_MISC_MODULE[name] = func
	end
end

-- Enable Module and Initialize Miscellaneous Modules
function Module:OnEnable()
	for name, func in next, KKUI_MISC_MODULE do
		if name and type(func) == "function" then
			func()
		end
	end

	local loadMiscModules = {
		"CreateAutoBubbles",
		"CreateBossEmote",
		"CreateDurabilityFrameMove",
		"CreateGUIGameMenuButton",
		"CreateMinimapButton",
		"CreateQuickDeleteDialog",
		"CreateQuickMenuButton",
		"CreateTicketStatusFrameMove",
		"CreateTradeTargetInfo",
		"TogglePetHappiness",
		"ToggleTaxiDismount",
		"UpdateErrorBlockerState",
		"UpdateMaxCameraZoom",

		-- "CreateObjectiveSizeUpdate",
		-- "CreateQuestSizeUpdate",
	}

	for _, funcName in ipairs(loadMiscModules) do
		local func = self[funcName]
		if type(func) == "function" then
			local success, err = pcall(func, self)
			if not success then
				error("Error in " .. funcName .. ": " .. tostring(err), 2)
			end
		end
	end

	hooksecurefunc("QuestInfo_Display", Module.CreateQuestXPPercent)
end

-- Enable Auto Chat Bubbles
function Module:CreateAutoBubbles()
	if C["Misc"].AutoBubbles then
		local function updateBubble()
			local name, instType = GetInstanceInfo()
			SetCVar("chatBubbles", (name and instType == "raid") and 1 or 0)
		end
		K:RegisterEvent("PLAYER_ENTERING_WORLD", updateBubble)
	end
end

-- Readycheck sound on master channel
K:RegisterEvent("READY_CHECK", function()
	PlaySound(8960, "master")
end)

-- Modify Delete Dialog
function Module:CreateQuickDeleteDialog()
	local confirmationText = DELETE_GOOD_ITEM:gsub("[\r\n]", "@")
	local _, confirmationType = strsplit("@", confirmationText, 2)

	local function setHyperlinkHandlers(dialog)
		dialog.OnHyperlinkEnter = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkEnter
		dialog.OnHyperlinkLeave = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkLeave
	end

	setHyperlinkHandlers(StaticPopupDialogs["DELETE_ITEM"])
	setHyperlinkHandlers(StaticPopupDialogs["DELETE_QUEST_ITEM"])
	setHyperlinkHandlers(StaticPopupDialogs["DELETE_GOOD_QUEST_ITEM"])

	local deleteConfirmationFrame = CreateFrame("FRAME")
	deleteConfirmationFrame:RegisterEvent("DELETE_ITEM_CONFIRM")
	deleteConfirmationFrame:SetScript("OnEvent", function()
		local staticPopup = StaticPopup1
		local editBox = StaticPopup1EditBox
		local button = StaticPopup1Button1
		local popupText = StaticPopup1Text

		if editBox:IsShown() then
			staticPopup:SetHeight(staticPopup:GetHeight() - 14)
			editBox:Hide()
			button:Enable()
			local link = select(3, GetCursorInfo())

			if link then
				local linkType, linkOptions, name = LinkUtil.ExtractLink(link)
				if linkType == "battlepet" then
					local _, level, breedQuality = strsplit(":", linkOptions)
					local qualityColor = BAG_ITEM_QUALITY_COLORS[tonumber(breedQuality)]
					link = qualityColor:WrapTextInColorCode(name .. " |n" .. "Level" .. " " .. level .. "Battle Pet")
				end
				popupText:SetText(popupText:GetText():gsub(confirmationType, "") .. "|n|n" .. link)
			end
		else
			staticPopup:SetHeight(staticPopup:GetHeight() + 40)
			editBox:Hide()
			button:Enable()
			local link = select(3, GetCursorInfo())

			if link then
				local linkType, linkOptions, name = LinkUtil.ExtractLink(link)
				if linkType == "battlepet" then
					local _, level, breedQuality = strsplit(":", linkOptions)
					local qualityColor = BAG_ITEM_QUALITY_COLORS[tonumber(breedQuality)]
					link = qualityColor:WrapTextInColorCode(name .. " |n" .. "Level" .. " " .. level .. "Battle Pet")
				end
				popupText:SetText(popupText:GetText():gsub(confirmationType, "") .. "|n|n" .. link)
			end
		end
	end)
end

-- Update Drag Cursor for Minimap
local function UpdateDragCursor(self)
	local minimapCenterX, minimapCenterY = Minimap:GetCenter()
	local cursorX, cursorY = GetCursorPosition()
	local scale = Minimap:GetEffectiveScale()
	cursorX, cursorY = cursorX / scale, cursorY / scale

	local angle = atan2(cursorY - minimapCenterY, cursorX - minimapCenterX)
	local x, y, quadrant = cos(angle), sin(angle), 1
	if x < 0 then
		quadrant = quadrant + 1
	end
	if y > 0 then
		quadrant = quadrant + 2
	end

	local width = (Minimap:GetWidth() / 2) + 5
	local height = (Minimap:GetHeight() / 2) + 5
	local diagRadiusW = sqrt(2 * width ^ 2) - 10
	local diagRadiusH = sqrt(2 * height ^ 2) - 10
	x = max(-width, min(x * diagRadiusW, width))
	y = max(-height, min(y * diagRadiusH, height))

	self:ClearAllPoints()
	self:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

-- Click Minimap Button Functionality
local function OnMinimapButtonClick(_, button)
	if button == "LeftButton" then
		if SettingsPanel:IsShown() or ChatConfigFrame:IsShown() then
			return
		end
		if InCombatLockdown() then
			UIErrorsFrame:AddMessage(K.InfoColor .. ERR_NOT_IN_COMBAT)
			return
		end
		K.GUI:Toggle()
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION, "SFX")
	end
end

-- Create Minimap Button
function Module:CreateMinimapButton()
	local minimapButton = CreateFrame("Button", "KKUI_MinimapButton", Minimap)
	minimapButton:SetFrameStrata("MEDIUM")
	minimapButton:SetPoint("BOTTOMLEFT", -15, 20)
	minimapButton:SetSize(32, 32)
	minimapButton:SetMovable(true)
	minimapButton:SetUserPlaced(true)
	minimapButton:RegisterForDrag("LeftButton")

	local overlay = minimapButton:CreateTexture(nil, "OVERLAY")
	overlay:SetSize(53, 53)
	overlay:SetTexture(136430)
	overlay:SetPoint("TOPLEFT")

	local background = minimapButton:CreateTexture(nil, "BACKGROUND")
	background:SetSize(20, 20)
	background:SetTexture(136467)
	background:SetPoint("TOPLEFT", 7, -5)

	local icon = minimapButton:CreateTexture(nil, "ARTWORK")
	icon:SetSize(16, 16)
	icon:SetPoint("CENTER")
	icon:SetTexture(C["Media"].Textures.LogoSmallTexture)

	minimapButton:SetScript("OnEnter", function()
		GameTooltip:SetOwner(minimapButton, "ANCHOR_LEFT")
		GameTooltip:ClearLines()
		GameTooltip:AddLine(K.Title, 1, 0.8, 0)
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("|cff00ff00Left Click:|r Open Configuration", 0.8, 0.8, 0.8)
		GameTooltip:Show()
	end)

	minimapButton:SetScript("OnLeave", GameTooltip_Hide)
	minimapButton:RegisterForClicks("AnyUp")
	minimapButton:SetScript("OnClick", OnMinimapButtonClick)
	minimapButton:SetScript("OnDragStart", function(self)
		self:SetScript("OnUpdate", UpdateDragCursor)
	end)
	minimapButton:SetScript("OnDragStop", function(self)
		self:SetScript("OnUpdate", nil)
	end)

	function Module:ToggleMinimapButton()
		if C.General.MinimapIcon then
			minimapButton:Show()
		else
			minimapButton:Hide()
		end
	end

	Module:ToggleMinimapButton()
end

-- Game Menu Setup
function Module:CreateGUIGameMenuButton()
	local gameMenuButton = CreateFrame("Button", "KKUI_GameMenuFrame", GameMenuFrame, "GameMenuButtonTemplate")
	gameMenuButton:SetHeight(26)
	gameMenuButton:SetText(K.Title)
	gameMenuButton:SetPoint("TOP", GameMenuButtonAddons, "BOTTOM", 0, -21)

	gameMenuButton.Left:SetDesaturated(1)
	gameMenuButton.Middle:SetDesaturated(1)
	gameMenuButton.Right:SetDesaturated(1)

	GameMenuFrame:HookScript("OnShow", function(self)
		GameMenuButtonLogout:SetPoint("TOP", gameMenuButton, "BOTTOM", 0, -21)
		self:SetHeight(self:GetHeight() + gameMenuButton:GetHeight() + 22)
		if self:GetScale() ~= 1.2 then
			self:SetScale(1.2)
		end
	end)

	gameMenuButton:SetScript("OnClick", function()
		if InCombatLockdown() then
			UIErrorsFrame:AddMessage(K.InfoColor .. ERR_NOT_IN_COMBAT)
			return
		end
		K["GUI"]:Toggle()
		HideUIPanel(GameMenuFrame)
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION)
	end)
end

-- Create Quest XP Percent Display
function Module:CreateQuestXPPercent()
	local playerCurrentXP = UnitXP("player")
	local playerMaxXP = UnitXPMax("player")
	local questXP
	local xpText
	local xpFrame

	if _G.QuestInfoFrame.questLog then
		local selectedQuest = C_QuestLog_GetSelectedQuest()
		if C_QuestLog_ShouldShowQuestRewards(selectedQuest) then
			questXP = GetQuestLogRewardXP()
			xpText = MapQuestInfoRewardsFrame.XPFrame.Name:GetText()
			xpFrame = _G.MapQuestInfoRewardsFrame.XPFrame.Name
		end
	else
		questXP = GetRewardXP()
		xpText = QuestInfoXPFrame.ValueText:GetText()
		xpFrame = _G.QuestInfoXPFrame.ValueText
	end

	if questXP and questXP > 0 and xpText then
		local xpPercentageIncrease = (((playerCurrentXP + questXP) / playerMaxXP) - (playerCurrentXP / playerMaxXP)) * 100
		xpFrame:SetFormattedText("%s (|cff4beb2c+%.2f%%|r)", xpText, xpPercentageIncrease)
	end
end

-- Reanchor Durability Frame
function Module:CreateDurabilityFrameMove()
	-- Create a new frame to hold the DurabilityFrame
	local durabilityHolder = CreateFrame("Frame", "KKUI_DurabilityHolder", UIParent)
	durabilityHolder:SetSize(DurabilityFrame:GetSize())
	durabilityHolder:SetPoint("TOPLEFT", Minimap, "BOTTOMLEFT", -40, -50)

	-- Create a mover for the new frame
	K.Mover(durabilityHolder, "DurabilityFrameMover", "Durability Frame", { "TOPLEFT", Minimap, "BOTTOMLEFT", -40, -50 })

	-- Reanchor the DurabilityFrame to the new frame
	DurabilityFrame:ClearAllPoints()
	DurabilityFrame:SetPoint("CENTER", durabilityHolder, "CENTER")
	DurabilityFrame:SetParent(durabilityHolder)

	-- Hook the SetPoint function to prevent it from being moved by other addons
	hooksecurefunc(DurabilityFrame, "SetPoint", function(self, _, parent)
		if parent == "MinimapCluster" or parent == MinimapCluster then
			self:ClearAllPoints()
			self:SetPoint("CENTER", durabilityHolder, "CENTER")
			self:SetParent(durabilityHolder)
		end
	end)
end

-- Reanchor Ticket Status Frame
function Module:CreateTicketStatusFrameMove()
	hooksecurefunc(TicketStatusFrame, "SetPoint", function(self, relF)
		if relF == "TOPRIGHT" then
			self:ClearAllPoints()
			self:SetPoint("TOP", UIParent, "TOP", -400, -20)
		end
	end)
end

-- Hide Boss Emote
function Module:CreateBossEmote()
	if C["Misc"].HideBossEmote then
		RaidBossEmoteFrame:UnregisterAllEvents()
	else
		RaidBossEmoteFrame:RegisterEvent("RAID_BOSS_EMOTE")
		RaidBossEmoteFrame:RegisterEvent("RAID_BOSS_WHISPER")
		RaidBossEmoteFrame:RegisterEvent("CLEAR_BOSS_EMOTES")
	end
end

-- TradeFrame Hook
function Module:CreateTradeTargetInfo()
	local infoText = K.CreateFontString(TradeFrame, 16, "", "")
	infoText:SetPoint("TOP", TradeFrameRecipientNameText, "BOTTOM", 0, -8)

	local function updateColor()
		local r, g, b = K.UnitColor("NPC")
		TradeFrameRecipientNameText:SetTextColor(r, g, b)
		local guid = UnitGUID("NPC")
		if not guid then
			return
		end
		local text = "|cffff0000" .. L["Stranger"]
		if C_BattleNet_GetGameAccountInfoByGUID(guid) or C_FriendList_IsFriend(guid) then
			text = "|cffffff00" .. FRIEND
		elseif IsGuildMember(guid) then
			text = "|cff00ff00" .. GUILD
		end
		infoText:SetText(text)
	end

	updateColor()
	TradeFrame:HookScript("OnShow", updateColor)
end

-- ALT + Right Click to Buy a Stack
do
	local cache = {}
	local itemLink, id

	StaticPopupDialogs["BUY_STACK"] = {
		text = L["Stack Buying Check"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			if not itemLink then
				return
			end
			BuyMerchantItem(id, GetMerchantItemMaxStack(id))
			cache[itemLink] = true
			itemLink = nil
		end,
		hideOnEscape = 1,
		hasItemFrame = 1,
	}

	local _MerchantItemButton_OnModifiedClick = MerchantItemButton_OnModifiedClick
	function MerchantItemButton_OnModifiedClick(self, ...)
		if IsAltKeyDown() then
			id = self:GetID()
			itemLink = GetMerchantItemLink(id)
			if not itemLink then
				return
			end

			local name, _, quality, _, _, _, _, maxStack, _, texture = C_Item_GetItemInfo(itemLink)
			if maxStack and maxStack > 1 then
				if not cache[itemLink] then
					local r, g, b = C_Item_GetItemQualityColor(quality or 1)
					StaticPopup_Show("BUY_STACK", " ", " ", {
						["texture"] = texture,
						["name"] = name,
						["color"] = { r, g, b, 1 },
						["link"] = itemLink,
						["index"] = id,
						["count"] = maxStack,
					})
				else
					BuyMerchantItem(id, GetMerchantItemMaxStack(id))
				end
			end
		end
		_MerchantItemButton_OnModifiedClick(self, ...)
	end
end

-- Resurrect Sound on Request
do
	local function soundOnResurrect()
		if C["Misc"].ResurrectSound then
			PlaySoundFile("Interface\\AddOns\\KkthnxUI\\Media\\Sounds\\Resurrect.ogg", "Master")
		end
	end
	K:RegisterEvent("RESURRECT_REQUEST", soundOnResurrect)
end

local blockedErrorMessages = {
	[ERR_ABILITY_COOLDOWN] = true,
	[ERR_ATTACK_MOUNTED] = true,
	[ERR_OUT_OF_ENERGY] = true,
	[ERR_OUT_OF_FOCUS] = true,
	[ERR_OUT_OF_HEALTH] = true,
	[ERR_OUT_OF_MANA] = true,
	[ERR_OUT_OF_RAGE] = true,
	[ERR_OUT_OF_RANGE] = true,
	[ERR_OUT_OF_RUNES] = true,
	[ERR_OUT_OF_HOLY_POWER] = true,
	[ERR_OUT_OF_RUNIC_POWER] = true,
	[ERR_OUT_OF_SOUL_SHARDS] = true,
	[ERR_OUT_OF_ARCANE_CHARGES] = true,
	[ERR_OUT_OF_COMBO_POINTS] = true,
	[ERR_OUT_OF_CHI] = true,
	[ERR_OUT_OF_POWER_DISPLAY] = true,
	[ERR_SPELL_COOLDOWN] = true,
	[ERR_ITEM_COOLDOWN] = true,
	[SPELL_FAILED_BAD_IMPLICIT_TARGETS] = true,
	[SPELL_FAILED_BAD_TARGETS] = true,
	[SPELL_FAILED_CASTER_AURASTATE] = true,
	[SPELL_FAILED_NO_COMBO_POINTS] = true,
	[SPELL_FAILED_SPELL_IN_PROGRESS] = true,
	[SPELL_FAILED_TARGET_AURASTATE] = true,
	[ERR_NO_ATTACK_TARGET] = true,
}

local isErrorFrameRegistered = true
function Module:HandleCombatErrors(_, errorText)
	if InCombatLockdown() and blockedErrorMessages[errorText] then
		if isErrorFrameRegistered then
			UIErrorsFrame:UnregisterEvent(self)
			isErrorFrameRegistered = false
		end
	else
		if not isErrorFrameRegistered then
			UIErrorsFrame:RegisterEvent(self)
			isErrorFrameRegistered = true
		end
	end
end

function Module:UpdateErrorBlockerState()
	if C["General"].CombatErrors then
		K:RegisterEvent("UI_ERROR_MESSAGE", Module.HandleCombatErrors)
	else
		isErrorFrameRegistered = true
		UIErrorsFrame:RegisterEvent("UI_ERROR_MESSAGE")
		K:UnregisterEvent("UI_ERROR_MESSAGE", Module.HandleCombatErrors)
	end
end

-- Auto dismount on Taxi
function Module:ToggleTaxiDismount()
	local lastTaxiIndex

	local function retryTaxi()
		if InCombatLockdown() then
			return
		end
		if lastTaxiIndex then
			TakeTaxiNode(lastTaxiIndex)
			lastTaxiIndex = nil
		end
	end

	hooksecurefunc("TakeTaxiNode", function(index)
		if not C["Automation"].AutoDismountTaxi then
			return
		end

		if not IsMounted() then
			return
		end

		Dismount()
		lastTaxiIndex = index
		C_Timer.After(0.5, retryTaxi)
	end)
end

local emotionsIcons = {
	[[|TInterface\PetPaperDollFrame\UI-PetHappiness:16:16:2:0:128:64:48:72:0:23|t]],
	[[|TInterface\PetPaperDollFrame\UI-PetHappiness:16:16:2:0:128:64:24:48:0:23|t]],
	[[|TInterface\PetPaperDollFrame\UI-PetHappiness:16:16:2:0:128:64:0:24:0:23|t]],
}

local happinessMessages = {
	[1] = "Your pet %s is very unhappy",
	[2] = "Your pet %s is content",
	[3] = "Your pet %s is very happy",
}

local happinessColors = {
	[1] = { 1, 0, 0 }, -- Red for unhappy
	[2] = { 1, 0.8, 0 }, -- Orange for content
	[3] = { 0, 1, 0 }, -- Green for happy
}

local function CreatePetHappinessFrame()
	local frame = CreateFrame("Frame", "KKUI_PetHappiness", UIParent)
	frame:SetSize(400, 50)
	frame:SetPoint("CENTER", 0, 400)
	frame:EnableMouse(false)
	frame:SetFrameStrata("HIGH")
	frame:Hide()

	frame.text = frame:CreateFontString(nil, "OVERLAY")
	frame.text:SetFontObject(K.UIFontOutline)
	frame.text:SetFont(select(1, frame.text:GetFont()), 26, select(3, frame.text:GetFont()))
	frame.text:SetPoint("CENTER")

	local fadeGroup = frame:CreateAnimationGroup()
	local fadeIn = fadeGroup:CreateAnimation("Alpha")
	fadeIn:SetFromAlpha(0)
	fadeIn:SetToAlpha(1)
	fadeIn:SetDuration(0.3)
	fadeIn:SetOrder(1)

	local fadeOut = fadeGroup:CreateAnimation("Alpha")
	fadeOut:SetFromAlpha(1)
	fadeOut:SetToAlpha(0)
	fadeOut:SetDuration(0.7)
	fadeOut:SetOrder(2)
	fadeOut:SetStartDelay(3)

	fadeGroup:SetScript("OnFinished", function()
		frame:Hide()
	end)

	frame.FadeGroup = fadeGroup
	return frame
end

local happinessFrame
local lastHappiness
local function CheckPetHappiness(_, unit)
	if unit ~= "pet" then
		return
	end

	if not happinessFrame then
		happinessFrame = CreatePetHappinessFrame()
	end

	local happiness = GetPetHappiness()
	if not happiness or not happinessMessages[happiness] then
		-- Exit gracefully if happiness is invalid
		return
	end

	if not lastHappiness or lastHappiness ~= happiness then
		local color = happinessColors[happiness] or { 1, 1, 1 } -- Default to white color
		local petName = UnitName("pet") or PET -- Use "pet" as fallback
		local messageTemplate = happinessMessages[happiness] .. emotionsIcons[happiness]

		-- Format the pet name with white color
		local petNameColored = "|cffffffff" .. petName .. "|r"

		-- Format the full message with happiness color
		local colorCode = string.format("|cff%02x%02x%02x", color[1] * 255, color[2] * 255, color[3] * 255)
		local fullMessage = string.format(messageTemplate, petNameColored)
		local chatMessage = colorCode .. fullMessage .. "|r"

		-- Set up the frame text with white-colored pet name
		happinessFrame.text:SetText(colorCode .. string.format(messageTemplate, petNameColored) .. "|r")
		happinessFrame.text:SetTextColor(1, 1, 1) -- Use white text color for the frame overall

		-- Show the frame
		happinessFrame:Show()
		happinessFrame.FadeGroup:Play()

		-- Print to chat with color
		K.Print(chatMessage)

		lastHappiness = happiness
	end
end

function Module:TogglePetHappiness()
	if K.Class ~= "HUNTER" then
		return
	end

	if C["Misc"].PetHappiness then
		K:RegisterEvent("UNIT_HAPPINESS", CheckPetHappiness)
	else
		K:UnregisterEvent("UNIT_HAPPINESS", CheckPetHappiness)
		if happinessFrame then
			happinessFrame:Hide()
		end
	end
end

-- Buttons to enhance popup menu
function Module:CustomMenu_AddFriend(rootDescription, data, name)
	rootDescription:CreateButton(K.InfoColor .. ADD_CHARACTER_FRIEND, function()
		local fullName = data.server and data.name .. "-" .. data.server or data.name
		C_FriendList.AddFriend(name or fullName)
	end)
end

local guildInviteString = gsub(CHAT_GUILD_INVITE_SEND, HEADER_COLON, "")
function Module:CustomMenu_GuildInvite(rootDescription, data, name)
	rootDescription:CreateButton(K.InfoColor .. guildInviteString, function()
		local fullName = data.server and data.name .. "-" .. data.server or data.name
		C_GuildInfo.Invite(name or fullName)
	end)
end

function Module:CustomMenu_CopyName(rootDescription, data, name)
	rootDescription:CreateButton(K.InfoColor .. COPY_NAME, function()
		local editBox = ChatEdit_ChooseBoxForSend()
		local hasText = (editBox:GetText() ~= "")
		ChatEdit_ActivateChat(editBox)
		editBox:Insert(name or data.name)
		if not hasText then
			editBox:HighlightText()
		end
	end)
end

function Module:CustomMenu_Whisper(rootDescription, data)
	rootDescription:CreateButton(K.InfoColor .. WHISPER, function()
		ChatFrame_SendTell(data.name)
	end)
end

function Module:CreateQuickMenuButton()
	-- if not C["Misc"].MenuButton then
	-- 	return
	-- end

	--hooksecurefunc(UnitPopupManager, "OpenMenu", function(_, which)
	--	print("MENU_UNIT_"..which)
	--end)

	Menu.ModifyMenu("MENU_UNIT_SELF", function(_, rootDescription, data)
		Module:CustomMenu_CopyName(rootDescription, data)
		Module:CustomMenu_Whisper(rootDescription, data)
	end)

	Menu.ModifyMenu("MENU_UNIT_TARGET", function(_, rootDescription, data)
		Module:CustomMenu_CopyName(rootDescription, data)
	end)

	Menu.ModifyMenu("MENU_UNIT_PLAYER", function(_, rootDescription, data)
		Module:CustomMenu_GuildInvite(rootDescription, data)
	end)

	Menu.ModifyMenu("MENU_UNIT_FRIEND", function(_, rootDescription, data)
		Module:CustomMenu_AddFriend(rootDescription, data)
		Module:CustomMenu_GuildInvite(rootDescription, data)
	end)

	Menu.ModifyMenu("MENU_UNIT_BN_FRIEND", function(_, rootDescription, data)
		local fullName
		local gameAccountInfo = data.accountInfo and data.accountInfo.gameAccountInfo
		if gameAccountInfo then
			local characterName = gameAccountInfo.characterName
			local realmName = gameAccountInfo.realmName
			if characterName and realmName then
				fullName = characterName .. "-" .. realmName
			end
		end

		Module:CustomMenu_AddFriend(rootDescription, data, fullName)
		Module:CustomMenu_GuildInvite(rootDescription, data, fullName)
		Module:CustomMenu_CopyName(rootDescription, data, fullName)
	end)

	Menu.ModifyMenu("MENU_UNIT_PARTY", function(_, rootDescription, data)
		Module:CustomMenu_GuildInvite(rootDescription, data)
	end)

	Menu.ModifyMenu("MENU_UNIT_RAID", function(_, rootDescription, data)
		Module:CustomMenu_AddFriend(rootDescription, data)
		Module:CustomMenu_GuildInvite(rootDescription, data)
		Module:CustomMenu_CopyName(rootDescription, data)
		Module:CustomMenu_Whisper(rootDescription, data)
	end)

	Menu.ModifyMenu("MENU_UNIT_RAID_PLAYER", function(_, rootDescription, data)
		Module:CustomMenu_GuildInvite(rootDescription, data)
	end)
end

-- Update Max Camera Zoom
function Module:UpdateMaxCameraZoom()
	SetCVar("cameraDistanceMaxZoomFactor", C["Misc"].MaxCameraZoom)
end
