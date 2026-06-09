return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		--- @module 'render-markdown'
		--- @type render.md.UserConfig
		ft = { "markdown", "codecompanion" },
		opts = {
			heading = {
				position = "inline",
				border = true,
				-- icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
				-- icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
				-- icons = { " 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 " },
				-- icons = { " 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 " },
				-- icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉯 " },
				-- I believe I found these in https://www.nerdfonts.com/cheat-sheet
				-- which mini.icons uses:
				icons = { "󰉫 # ", "󰉬 ## ", "󰉭 ### ", "󰉮 #### ", "󰉯 ##### ", "###### " },
			},
		},
		keys = {
			{ "<space>rm", ":RenderMarkdown toggle<cr>", mode = "n" },
		},
	},
	{
		-- NOTe epwalsh's original, but there's an active fork:
		-- "epwalsh/obsidian.nvim", -- https://github.com/epwalsh/obsidian.nvim?tab=readme-ov-file#configuration-options
		"obsidian-nvim/obsidian.nvim", -- https://github.com/obsidian-nvim/obsidian.nvim
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		-- 	-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		-- 	-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
		-- 	-- refer to `:h file-pattern` for more examples
		-- 	"BufReadPre /Users/gdso/Library/Mobile Documents/iCloud~md~obsidian/Documents/notebook/*.md",
		-- 	"BufNewFile /Users/gdso/Library/Mobile Documents/iCloud~md~obsidian/Documents/notebook/*.md",
		-- },
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
		opts = {
			-- NEW for obsidian-nvim/obsidian.nvim fork:
			legacy_commands = false, -- this will be removed in the next major release

			-- https://github.com/MeanderingProgrammer/render-markdown.nvim?tab=readme-ov-file#obsidiannvim
			-- Disabling the obsidian.nvim's UI so it doesn't clash with render-markdown.nvim
			ui = { enable = false },
			workspaces = {
				{
					name = "personal",
					path = "/Users/gdso/Library/Mobile Documents/iCloud~md~obsidian/Documents/notebook",
					-- unfortunately, it doesn't appear the obsidian.nvim reads
					-- the config in
					overrides = {
						daily_notes = {
							folder = "daily-notes",
							-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
							template = "daily.md",
						},
						-- Optional, for templates (see below).
						templates = {
							folder = "templates",
							date_format = "%Y-%m-%d",
							time_format = "%H:%M",
							-- A map for custom variables, the key should be the variable and the value a function
							substitutions = {
								week = function(ctx, suffix)
									-- %w	weekday (3) [0-6 = Sunday-Saturday]
									-- See https://www.lua.org/pil/22.1.html
									weekday_rel_sunday = os.date("%w")
									if weekday_rel_sunday == 0 then
										weekdays_since_mon = 6 - 1
									else
										weekdays_since_mon = weekday_rel_sunday - 1
									end
									-- NOTE os.time() returns a unix timestamp, an integer, seconds since 1970;
									-- and 60*60*24 = 86400 secconds/day:
									nearest_monday = os.time() - 86400 * weekdays_since_mon
									return os.date("%Y-%m-%d", nearest_monday)
								end,
							},
							customizations = {
								weekly = {
									notes_subdir = "log/weekly",
									note_id_func = function(title)
										-- %w	weekday (3) [0-6 = Sunday-Saturday]
										-- See https://www.lua.org/pil/22.1.html
										weekday_rel_sunday = os.date("%w")
										if weekday_rel_sunday == 0 then
											weekdays_since_mon = 6 - 1
										else
											weekdays_since_mon = weekday_rel_sunday - 1
										end
										-- NOTE os.time() returns a unix timestamp, an integer, seconds since 1970;
										-- and 60*60*24 = 86400 secconds/day:
										nearest_monday = os.time() - 86400 * weekdays_since_mon
										return os.date("%Y-%m-%d", nearest_monday) .. "-week"
									end,
								},
								ph_meetings = {
									notes_subdir = "perpetuum_health/meetings",
									-- This function currently only receives the note title as an input
									note_id_func = function(title)
										if title == nil then
											return nil
										end

										local name = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
										return os.date("%Y-%m-%d") .. "-" .. name -- "Hulk Hogan" → "2026-03-17-hulk-hogan"
									end,
								},
								ph_work_items = {
									notes_subdir = "perpetuum_health/work_items",
									-- This function currently only receives the note title as an input
									note_id_func = function(title)
										if title == nil then
											return nil
										end

										local name = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
										return os.date("%Y-%m-%d") .. "-" .. name -- "Hulk Hogan" → "2026-03-17-hulk-hogan"
									end,
								},
							},
						},
					},
				},
				-- {
				-- 	name = "work",
				-- 	path = "~/vaults/work",
				-- },
			},

			-- see below for full list of options 👇
			--
			---@class obsidian.config.CheckboxOpts
			---
			---@field enabled? boolean
			---
			---Order of checkbox state chars, e.g. { " ", "x" }
			---@field order? string[]
			---
			---Whether to create new checkbox on paragraphs
			---@field create_new? boolean
			checkbox = {
				enabled = true,
				create_new = false,
				order = { " ", "-", "x" },
			},
		},
		config = function(_, opts)
			-- Remember config is called with the default `opts` merged with
			-- the `opts` we've defined above and we must call the `setup` function
			-- if we define a function on `config`:
			require("obsidian").setup(opts)
		end,
		keys = {
			{ "<space>ob", "<cmd>Obsidian<cr>" },
			{ "<space>or", "<cmd>Obsidian rename<cr>" },
			{ "<space>ot", "<cmd>Obsidian today<cr>" },
			{ "<space>on", "<cmd>Obsidian new_from_template<cr>" },
			{ "<space>opw", "<cmd>Obsidian new_from_template w ph_work_items<cr>" },
			{ "<space>opm", "<cmd>Obsidian new_from_template m ph_meetings<cr>" },
		},
	},
}
