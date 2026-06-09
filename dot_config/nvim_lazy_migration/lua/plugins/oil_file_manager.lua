local detail = false

return {
	"stevearc/oil.nvim",
	-- Optional dependencies
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		-- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
		-- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
		default_file_explorer = true,
		-- <columns>
		-- DISABLING columns, since the `detail` flag and the "gd" keymap will
		-- dynamically define columns when the detail view is asked for:
		-- columns = {
		-- 	"icon",
		-- 	"permissions",
		-- 	"size",
		-- 	"mtime",
		-- },
		-- </columns>
		win_options = {
			-- Along with global `get_oil_winbar`, this is from the following recipe:
			-- https://github.com/stevearc/oil.nvim/blob/master/doc/recipes.md#show-cwd-in-the-winbar
			winbar = "%!v:lua.get_oil_winbar()",
		},
		view_options = {
			-- Show files and directories that start with "."
			show_hidden = true,
		},
		float = {
			preview_split = "right",
			max_width = 0.8,
		},
		keymaps = {
			["gd"] = {
				desc = "Toggle file detail view",
				callback = function()
					detail = not detail
					if detail then
						require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
					else
						require("oil").set_columns({ "icon" })
					end
				end,
			},
		},
	},
	keys = {
		--  vim.keymap.set("n", "<space>W", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
		{ "<space>W", "<cmd>Oil --float --preview<cr>", mode = "n", desc = "Open parent directory" },
		-- { "<leader>e", "<cmd>Oil<cr>", desc = "Open Oil" },
		-- { "<leader>o", "<cmd>Oil<cr>", desc = "Open Oil" },
		-- { "<leader>O", "<cmd>Oil -float<cr>", desc = "Open Oil in float" },
	},
	config = function(_, opts)
		-- Declare a global function to retrieve the current directory
		function _G.get_oil_winbar()
			local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
			local dir = require("oil").get_current_dir(bufnr)
			if dir then
				return vim.fn.fnamemodify(dir, ":~")
			else
				-- If there is no current directory (e.g. over ssh), just show the buffer name
				return vim.api.nvim_buf_get_name(0)
			end
		end

		require("oil").setup(opts)
	end,
}
