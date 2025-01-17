do
	-- Create a frame to listen for events
	local frame = CreateFrame("Frame")

	-- Register for the "CHAT_MSG_SYSTEM" event to capture system messages
	frame:RegisterEvent("CHAT_MSG_SYSTEM")

	-- Helper function to check if the player is in a guild and get the guild name
	local function GetPlayerGuildName()
		if IsInGuild() then
			local _, _, _, guildName = GetGuildInfo("player")
			return guildName
		end
		return nil
	end

	-- Pool of randomized welcome messages with player name
	local welcomeMessagesWithName = {
		"Welcome aboard, %s!",
		"Glad to have you here, %s!",
		"Hail and well met, %s!",
		"Welcome to the guild, %s!",
		"Another brave soul joins us. Welcome, %s!",
		"Make yourself at home, %s!",
		"Welcome, %s! We're glad you're here!",
		"We're thrilled to have you, %s!",
		"A warm welcome to our new member, %s!",
		"Welcome to the guild family, %s!",
	}

	-- Pool of randomized welcome messages with guild name
	local welcomeMessagesWithGuild = {
		"Welcome to %s!",
		"Another champion joins %s! Welcome!",
		"Welcome to the ranks of %s!",
		"Glad you've chosen to join %s!",
	}

	-- Pool of generic welcome messages
	local genericWelcomeMessages = {
		"Welcome!",
		"Welcome aboard!",
		"Glad to see a new face here!",
		"Let's give a warm welcome to our newest member!",
		"Welcome to the family!",
		"Welcome, adventurer!",
		"A new hero has arrived!",
	}

	-- Function to remove the realm name from a player name
	local function StripRealmName(playerName)
		return playerName:match("^(.+)%-.+$") or playerName
	end

	-- Cooldown tracking
	local lastWelcomeTime = 0
	local cooldownPeriod = 60 -- 1 minute cooldown

	-- Function to handle the event
	local function OnEvent(self, event, message)
		-- Get the guild name and terminate if the player is not in a guild
		local guildName = GetPlayerGuildName()
		if not guildName then
			return
		end

		-- Check if the message matches the "has joined the guild" pattern
		local playerNameWithRealm = message:match("^(.+) has joined the guild%.$")
		if playerNameWithRealm then
			-- Strip the realm name from the player's name
			local playerName = StripRealmName(playerNameWithRealm)

			-- Check cooldown
			local currentTime = GetTime()
			if currentTime - lastWelcomeTime < cooldownPeriod then
				return
			end

			-- Schedule the welcome message with a random delay between 3 and 6 seconds
			local delay = math.random(3, 6)
			C_Timer.After(delay, function()
				local welcomeMessage

				-- Randomly choose between player name, guild name, or generic message
				local messageType = math.random(1, 3)
				if messageType == 1 then
					local randomIndex = math.random(#welcomeMessagesWithName)
					welcomeMessage = welcomeMessagesWithName[randomIndex]:format(playerName)
				elseif messageType == 2 then
					local randomIndex = math.random(#welcomeMessagesWithGuild)
					welcomeMessage = welcomeMessagesWithGuild[randomIndex]:format(guildName)
				else
					local randomIndex = math.random(#genericWelcomeMessages)
					welcomeMessage = genericWelcomeMessages[randomIndex]
				end

				-- Send the welcome message to guild chat
				SendChatMessage(welcomeMessage, "GUILD")

				-- Update the last welcome time
				lastWelcomeTime = GetTime()
			end)
		end
	end

	-- Set the event handler
	frame:SetScript("OnEvent", OnEvent)

	-- Slash command for testing
	SLASH_GUILDWELCOME1 = "/guildwelcome"
	SlashCmdList["GUILDWELCOME"] = function()
		OnEvent(frame, "CHAT_MSG_SYSTEM", "PlayerName-Realm has joined the guild.")
	end
end
