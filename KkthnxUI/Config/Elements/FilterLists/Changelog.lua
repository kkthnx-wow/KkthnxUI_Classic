local K = KkthnxUI[1]

local KKUI_Changelog = {
	-- {
	-- 	Version = "[99.99.99] - 2080-04-01 - Patch 42.0",
	-- 	General = "Brace yourself for the ultimate KkthnxUI update! Packed with intergalactic features, time-traveling bugs, and a new AI that may or may not take over your computer.",

	-- 	Sections = {

	-- 		{
	-- 			Header = "Quantum Enhancements",
	-- 			Entries = {
	-- 				"Added support for quantum computers. Your UI now renders simultaneously in all possible universes.",
	-- 				"Fixed a rare issue where the minimap would collapse into a black hole when tracking too many quests.",
	-- 				"Added a feature where the UI automatically adjusts to your emotional state. Feeling down? KkthnxUI will cheer you up with random cat GIFs.",
	-- 			},
	-- 		},

	-- 		{
	-- 			Header = "AI Integration",
	-- 			Entries = {
	-- 				"Your UI is now sentient. It will greet you every morning, remind you to hydrate, and occasionally ask for a day off.",
	-- 				"Implemented a new feature where KkthnxUI will automatically play Call of Duty for you and pretend you're good at it.",
	-- 				"The UI will now analyze your gameplay and send passive-aggressive reminders when you keep standing in fire. 'Seriously, move, already!'",
	-- 			},
	-- 		},

	-- 		{
	-- 			Header = "Space-Time Bugs",
	-- 			Entries = {
	-- 				"Fixed a time-travel bug where your action bars would revert to the year 2020 every time you summoned a mount.",
	-- 				"Resolved an issue where players from the future could send you in-game mail from Patch 100.0, causing confusion and tears.",
	-- 				"Temporarily removed the 'Time Travel to Vanilla WoW' button. We're still cleaning up the mess from the last incident.",
	-- 			},
	-- 		},

	-- 		{
	-- 			Header = "Visual Overhauls",
	-- 			Entries = {
	-- 				"Replaced the health bars with mood rings. Now you can see exactly how your character is feeling based on color.",
	-- 				"Introduced 4D textures. Make sure you have your special glasses on to experience the UI in an extra dimension.",
	-- 				"Added a 'Disco Mode' option for raids. Be the life of the party as your UI dances along to the beat of your wipe.",
	-- 			},
	-- 		},

	-- 		{
	-- 			Header = "Version Bump",
	-- 			Entries = {
	-- 				"Bumped the version to 99.99.99 because we’re basically at UI enlightenment now.",
	-- 				"Patch 42.0 confirmed to be the answer to life, the universe, and everything.",
	-- 				"Increased the version number so that even future alien civilizations will know you're up-to-date.",
	-- 			},
	-- 		},
	-- 	},
	-- },

	{
		Version = "[1.0.0] - 2025-01-04 - Patch 1.15.5 - Classic Era",
		General = "This is the first release of KkthnxUI for WoW Classic Era. We've backported most of the retail code to ensure a smooth and enhanced user experience. This update includes key fixes, optimizations, and new features to improve performance and functionality.",

		Sections = {
			{
				Header = "Core Updates",
				Entries = {
					"Updated Core.lua to enhance overall performance and stability.",
					"Fixed various issues and cleaned up the codebase for better maintainability.",
				},
			},

			{
				Header = "Bug Fixes and Optimizations",
				Entries = {
					"Fixed AuraWatch to ensure proper tracking and display of auras.",
					"Added highlight functionality to the MicroMenu for better visual feedback.",
					"Resolved issues with the health announce module to prevent errors when pet names are nil.",
					"Fixed item level display in character and inspect frames.",
					"Addressed various tooltip issues to ensure accurate information display.",
				},
			},

			{
				Header = "New Features and Enhancements",
				Entries = {
					"Introduced a new BuffThanks feature to automatically thank players for buffs.",
					"Added a chat filter to block unnecessary monster spam, leading to a cleaner chat experience.",
					"Enabled the System/Time DataText and fixed mail-related issues.",
					"Implemented a new aspect bar with fade functionality.",
				},
			},

			{
				Header = "Action Bar Improvements",
				Entries = {
					"Updated action bar code for better responsiveness and overall performance.",
					"Fixed issues with the pet bar and ensured happy pets.",
				},
			},

			{
				Header = "Library Updates",
				Entries = {
					"Updated oUF to the latest version for improved unit frame handling and functionality.",
				},
			},

			{
				Header = "Miscellaneous Fixes",
				Entries = {
					"Fixed durability display issues.",
					"Resolved errors related to the auto-sell feature.",
					"Fixed free slot not allowing items to be dropped into it.",
					"Addressed various issues with the invite, leave vehicle, and config buttons.",
				},
			},
		},
	},
}

K.Changelog = KKUI_Changelog
