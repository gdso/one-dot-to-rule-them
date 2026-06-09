-- local actions = require("fzf-lua").actions
-- local FzfLua = require("fzf-lua")

-- require("fzf-lua").register_ui_select()

return {
	-- {
	--   'junegunn/fzf.vim',
	--   dependencies = { 'junegunn/fzf' },
	--   keys = {
	--     -- { "<space>l", ":Lines<cr>", mode = "n" }
	--     -- { "<space>b", ":Lines<cr>", mode = "n" }
	--   }
	-- },
	{
		"ibhagwan/fzf-lua",
		-- enabled = false,
		-- Jun 1 2025
		-- https://github.com/ibhagwan/fzf-lua/commit/3de691fafd097177d10ebffb91dec5bec2cb30ed
		-- commit = "3de691fafd097177d10ebffb91dec5bec2cb30ed",
		-- commit = "70a1c1d266af2ea4d1d9c16e09c60d3fc8c5aa5f",
		lazy = false,
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- or if using mini.icons/mini.nvim
		-- dependencies = { "echasnovski/mini.icons" },
		init = function()
			local FzfLua = require("fzf-lua")
			FzfLua.register_ui_select()
		end,
		opts = function()
			local actions = require("fzf-lua").actions
			return {
				keymap = {
					fzf = {
						true, -- uncomment to inherit all the below in your custom config
						-- ["ctrl-z"]     = "abort",
						-- ["ctrl-u"]     = "unix-line-discard",
						-- ["ctrl-f"]     = "half-page-down",
						-- ["ctrl-b"]     = "half-page-up",
						-- ["ctrl-a"]     = "beginning-of-line",
						-- ["ctrl-e"]     = "end-of-line",
						-- ["alt-a"]      = "toggle-all",
						-- ["alt-g"]      = "first",
						-- ["alt-G"]      = "last",
						-- -- Only valid with fzf previewers (bat/cat/git/etc)
						-- ["f3"]         = "toggle-preview-wrap",
						-- ["f4"]         = "toggle-preview",
						-- ["shift-down"] = "preview-page-down",
						-- ["shift-up"]   = "preview-page-up",
						-- From https://www.reddit.com/r/neovim/comments/1c4vh51/fzflua_send_all_of_the_results_to_the_quickfix/
						-- which then makes `enter` keypress cause actions.file_edit_or_qf
						-- ["ctrl-shift-a"]     = "toggle-all",
						["ctrl-q"] = "toggle-all",
					},
				},
				actions = {
					-- Below are the default actions, setting any value in these tables will override
					-- the defaults, to inherit from the defaults change [1] from `false` to `true`
					files = {
						true, -- uncomment to inherit all the below in your custom config
						-- Pickers inheriting these actions:
						--   files, git_files, git_status, grep, lsp, oldfiles, quickfix, loclist,
						--   tags, btags, args, buffers, tabs, lines, blines
						-- `file_edit_or_qf` opens a single selection or sends multiple selection to quickfix
						-- replace `enter` with `file_edit` to open all files/bufs whether single or multiple
						-- replace `enter` with `file_switch_or_edit` to attempt a switch in current tab first
						-- ["enter"]  = actions.file_edit_or_qf,
						-- ["ctrl-s"] = actions.file_split,
						-- ["ctrl-v"] = actions.file_vsplit,
						-- ["ctrl-t"] = actions.file_tabedit,
						-- ["alt-q"]  = actions.file_sel_to_qf,
						-- ["alt-Q"]  = actions.file_sel_to_ll,
						-- ["alt-i"]  = actions.toggle_ignore,
						-- ["alt-h"]  = actions.toggle_hidden,
						-- ["alt-f"]  = actions.toggle_follow,
						-- ["ctrl-enter"] = actions.file_sel
						["ctrl-h"] = actions.toggle_hidden,
						["ctrl-i"] = actions.toggle_ignore,
						-- THINK ctrl+add (= key is shared +)
						-- ["ctrl-a"] = actions.toggle_all,
					},
				},
				grep = {
					-- The default is for hidden = false, but I want to be able
					-- to search .github/* files by default, especially actions,
					-- I'm going to explicitely add the `ctrl-h` shortcut below to hope it
					-- works, if not, I'll toggle hidden = true:
					-- hidden             = false,
					actions = {
						-- <custom_actions>
						["ctrl-g"] = false,
						["ctrl-l"] = { actions.grep_lgrep },
						-- uncomment to enable '.gitignore' toggle for grep
						-- ["ctrl-r"]   = { actions.toggle_ignore }
						["ctrl-i"] = { actions.toggle_ignore },
						["ctrl-h"] = { actions.toggle_hidden },
						-- </custom_actions>
					},
				},
			}
		end,
		keys = {
			{ "<space>Z", ":FzfLua<cr>" },
			{ "<space>f", ":FzfLua files<cr>" },
			{
				"<space>w",
				function()
					require("fzf-lua").files({
						cwd = vim.fn.expand("%:p:h"),
					})
				end,
				{ desc = "FzfLua files in current file directory" },
			},

			{ "B", ":FzfLua buffers<cr>" },
			{ "<space>bb", ":FzfLua buffers<cr>" },
			{ "<space>bd", ":bd<cr>" },

			{ "<space>l", ":FzfLua blines<cr>" },
			{ "<space>L", ":FzfLua lines<cr>" },
			{ "<space>O", "<cmd>FzfLua lsp_document_symbols<cr>" },
			{ "<space>of", ":FzfLua oldfiles<cr>" },

			{ "T", ":FzfLua tabs<cr>" },
			{ "<space>st", ":FzfLua tabs<cr>" },
			{ "<space>q", ":FzfLua quickfix<cr>" },

			{ "<space>m", ":FzfLua marks<cr>" },

			-- NOTE <space>rw, <space>ra are all search and replace keymaps
			{ "<space>rr", "<cmd>FzfLua resume<cr>" },

			{ "<space>zk", "<cmd>FzfLua keymaps<cr>" },
			{ "<space>zh", "<cmd>FzfLua help_tags<cr>" },
			{ "<space>zc", "<cmd>FzfLua commands<cr>" },

			{ "<space>gp", "<cmd>FzfLua live_grep<cr>" },
			-- 'live_grep_resume' is deprecated, use ':FzfLua live_grep resume=true' or ':lua FzfLua.live_grep({resume=true})' instead.
			{ "<space>gr", "<cmd>FzfLua live_grep resume=true<cr>" },
			{ "<space>gb", "<cmd>FzfLua lgrep_curbuf<cr>" },
			{ "<space>gf", "<cmd>FzfLua lgrep_quickfix<cr>" },
			-- I don't know why we would use grep instead of livegrep, perf maybe?
			-- { "<space>gb", "<cmd>FzfLua grep_curbuf<cr>" },

			-- { "<space>sw", "<cmd>FzfLua grep_cword<cr>" },
			{ "<space>gw", "<cmd>FzfLua grep_cword<cr>" },
			{ "<space>gv", "<cmd>FzfLua grep_visual<cr>", mode = "v" },

			{ "<space>zs", "<cmd>FzfLua lsp_document_symbols<cr>" },

			-- { '<space>sy', "<cmd>FzfLua grep search=<C-R>0<CR>" },
			-- See global defaults for neovim's LSP: https://neovim.io/doc/user/lsp.html#_global-defaults
			-- => grn for rename
			-- => Ctrl-] for go-to-definition
			{ "<space>gd", "<cmd>FzfLua lsp_definitions<cr>" },
			{ "<space>rf", "<cmd>FzfLua lsp_references<cr>" },
			{ "<space>rn", vim.lsp.buf.rename },
			-- { '<space>F', vim.lsp.buf.for },

			{ "<space>d", "<cmd>FzfLua diagnostics_document<cr>" },
			{ "<space>D", "<cmd>FzfLua diagnostics_workspace<cr>" },

			-- { "<space>gs", "<cmd>FzfLua git_status<cr>" },
			-- { "<space>gc", "<cmd>FzfLua git_commits<cr>" },
			-- { "<space>gb", "<cmd>FzfLua git_blame<cr>" },
			-- { '<space>gd', "<cmd>FzfLua git_diff<cr>" },
		},
	},
}
