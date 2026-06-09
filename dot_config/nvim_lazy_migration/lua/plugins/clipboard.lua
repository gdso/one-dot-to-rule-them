return {
	-- Lua
	{
		"gbprod/cutlass.nvim",
		opts = {
			cut_key = "x",
			-- your configuration comes here
			-- or don't set opts to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"ibhagwan/smartyank.nvim",
		lazy = false, -- This should be ready to work on load ...
		opts = {
			osc52 = {
				enabled = true,
				-- escseq = 'tmux',     -- use tmux escape sequence, only enable if
				-- you're using tmux and have issues (see #4)

				-- default ssh_only = true
				ssh_only = false, -- false to OSC52 yank also in local sessions

				silent = false, -- true to disable the "n chars copied" echo
				echo_hl = "Directory", -- highlight group of the OSC52 echo message
			},
			highlight = {
				enabled = true, -- highlight yanked text
				higroup = "IncSearch", -- highlight group of yanked text
				timeout = 250, -- timeout for clearing the highlight
			},
		},
		keys = {
			-- " https://stackoverflow.com/questions/11993851/how-to-delete-not-cut-in-vim
			-- nnoremap x "_x
			-- { "x", '"_x', mode = "n" },
			-- " Personal opinion, but p in visual mode should NEVER yank the selection
			-- " that will be overwritten by the paste/put:
			-- vnoremap p P
			{ "p", "P", mode = "v" },
		},
	},
}
