-- DONE
return {
	{
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed.
			-- "nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
			-- "nvim-mini/mini.pick", -- optional
			-- "folke/snacks.nvim", -- optional
		},
		cmd = "Neogit",
		opts = {
			mappings = {
				popup = {
					-- ["t"] = "TagPopup",
					["t"] = false,
				},
			},
		},
		keys = {
			{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		opts = {
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end)

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end)

				-- Actions
				map("n", "<leader>hs", gitsigns.stage_hunk)
				map("n", "<leader>hr", gitsigns.reset_hunk)

				map("v", "<leader>hs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)

				map("v", "<leader>hr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)

				map("n", "<leader>hS", gitsigns.stage_buffer)
				map("n", "<leader>hR", gitsigns.reset_buffer)
				map("n", "<leader>hp", gitsigns.preview_hunk)
				map("n", "<leader>hi", gitsigns.preview_hunk_inline)

				map("n", "<leader>hb", function()
					gitsigns.blame_line({ full = true })
				end)

				map("n", "<leader>hd", gitsigns.diffthis)

				vim.api.nvim_create_user_command("DiffBufferEdits", function()
					gitsigns.diffthis()
				end, {})

				map("n", "<leader>hD", function()
					gitsigns.diffthis("~")
				end)

				map("n", "<leader>hQ", function()
					gitsigns.setqflist("all")
				end)
				map("n", "<leader>hq", gitsigns.setqflist)

				-- Toggles
				map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
				map("n", "<leader>tw", gitsigns.toggle_word_diff)

				-- Text object
				map({ "o", "x" }, "ih", gitsigns.select_hunk)
			end,
		},
	},
	-- Disabing in favor of neogit:
	-- { "tpope/vim-fugitive" },
	-- Disabling vim-gitgutter in favor of gitsigns:
	-- Shows a git diff in the sign column, also adds [c, ]c to jump to next
	-- change, can also be used to stage one hunk at a time
	-- {
	-- 	"airblade/vim-gitgutter",
	-- 	init = function()
	-- 		vim.g.gitgutter_signs = 1
	-- 		vim.g.gitgutter_highlight_lines = 1
	-- 		vim.g.gitgutter_highlight_linenrs = 0
	-- 	end,
	-- },
	{
		"sindrets/diffview.nvim",
		lazy = false,
		-- See https://github.com/sindrets/diffview.nvim#configuration for exampl config,
		-- I've only added a small slice of it to widen the file panel's width:
		opts = {
			file_panel = {

				listing_style = "tree", -- One of 'list' or 'tree', default is "tree"

				win_config = { -- See |diffview-config-win_config|
					position = "left",

					-- width = 35, -- < default
					width = 60,

					win_opts = {},
				},
			},
		},
	},
}
