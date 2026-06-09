return {
	{
		lazy = false,
		-- https://github.com/MagicDuck/grug-far.nvim
		-- :h grug-far
		"MagicDuck/grug-far.nvim",
		-- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
		-- additional lazy config to defer loading is not really needed...
		config = function()
			-- optional setup call to override plugin options
			-- alternatively you can set options with vim.g.grug_far = { ... }
			require("grug-far").setup({

				-- windowCreationCommand = "vsplit",
				-- windowCreationCommand = "right vsplit",
				-- windowCreationCommand = "vnew",
				windowCreationCommand = "rightbelow vertical sb",

				-- prefills = {
				-- 	filesFilter = "!.git/",
				-- 	flags = "--hidden --no-ignore", -- --no-ignore
				-- },

				-- options, see Configuration section below
				-- there are no required options atm
				keymaps = {
					-- See :h grug_far.defaultOptions
					openNextLocation = { n = "<C-n>" },
					openPrevLocation = { n = "<C-p>" },
				},
				openTargetWindow = {
					preferredLocation = "left",
				},
			})
		end,
		keys = {
			{
				"<space>sa",
				desc = "[s]earch (and replace) [a]ll via :GrugFar",
				mode = "n",
				function()
					require("grug-far").open({
						prefills = {
							filesFilter = "!.git/",
							flags = "--hidden --no-ignore", -- --no-ignore
						},
					})
				end,
			},
			{
				"<space>sp",
				desc = "[s]earch (and replace) [p]roject via :GrugFar",
				mode = "n",
				function()
					require("grug-far").open({
						prefills = {},
					})
				end,
			},
			{
				"<space>sw",
				desc = "[s]earch for the current [w]ord under the cursor",
				mode = "n",
				function()
					require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
				end,
			},
			{
				"<space>sb",
				desc = "[s]earch (and replace) current word in the current [b]uffer",
				mode = "n",
				function()
					require("grug-far").open({
						prefills = {
							paths = vim.fn.expand("%"),
							search = vim.fn.expand("<cword>"),
						},
					})
				end,
			},
		},
	},
	-- {
	-- 	lazy = false,
	-- 	"nvim-pack/nvim-spectre",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- 	opts = {
	-- 		replace_engine = {
	-- 			["sed"] = {
	-- 				cmd = "gsed",
	-- 				args = nil,
	-- 				options = {
	-- 					["ignore-case"] = {
	-- 						value = "--ignore-case",
	-- 						icon = "[I]",
	-- 						desc = "ignore case",
	-- 					},
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- 	-- config = function(_, opts)
	-- 	--   require("spectre").setup(opts)
	-- 	--   return
	-- 	keys = {
	-- 		{
	-- 			-- vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
	-- 			-- desc = "Toggle Spectre"
	-- 			-- })
	-- 			"<space>S",
	-- 			function()
	-- 				require("spectre").toggle()
	-- 			end,
	-- 			mode = "n",
	-- 			desc = "Toggle Spectre",
	-- 		},
	-- 		{
	-- 			-- vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
	-- 			-- desc = "Search current word"
	-- 			-- })
	-- 			"<space>sw",
	-- 			mode = "n",
	-- 			function()
	-- 				require("spectre").open_visual({ select_word = true })
	-- 			end,
	-- 			desc = "Search current word",
	-- 		},
	-- 		{
	--
	-- 			"<space>sw",
	-- 			mode = "v",
	-- 			function()
	-- 				require("spectre").open_visual()
	-- 			end,
	-- 			desc = "Search current word (visual mode)",
	-- 			-- vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
	-- 			-- desc = "Search current word"
	-- 			-- })
	-- 		},
	-- 		{
	-- 			-- vim.keymap.set(
	-- 			-- 	"n",
	-- 			-- 	"<leader>sp",
	-- 			-- 	'<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
	-- 			-- 	{
	-- 			-- 		desc = "Search on current file",
	-- 			-- 	}
	-- 			-- ),
	-- 			"<space>s%",
	-- 			desc = "Search on current file",
	-- 			mode = "n",
	-- 			function()
	-- 				require("spectre").open_file_search({ select_word = true })
	-- 			end,
	-- 		},
	-- 	},
	-- },
}
