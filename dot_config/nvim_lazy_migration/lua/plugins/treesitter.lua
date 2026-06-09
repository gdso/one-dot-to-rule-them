return {
	-- From https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#lazynvim
	{
		"nvim-treesitter/nvim-treesitter",
		-- lazy = false,
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })()
		end,
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				-- A list of parser names, or "all" (the listed parsers MUST always be installed)
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"markdown",
					"markdown_inline",
					-- my additions:
					"bash",
					"elixir",
					"heex",
					"eex",
					"typescript",
					"javascript",
					"css",
					"json",
					"jsonc",
					"python",
					"yaml",
					"zig",
					"rust",
					"python",
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = false,

				-- List of parsers to ignore installing (or "all")
				-- ignore_install = { "javascript" },

				---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
				-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

				highlight = {
					enable = true,

					-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
					-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
					-- the name of the parser)
					-- list of language that will be disabled
					-- disable = { "c", "rust" },
					-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
					-- disable = function(lang, buf)
					--     local max_filesize = 100 * 1024 -- 100 KB
					--     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					--     if ok and stats and stats.size > max_filesize then
					--         return true
					--     end
					-- end,

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
				indentation = {
					enable = true,
				},
				folding = {
					enable = true,
				},
			})

			-- -- From https://stackoverflow.com/questions/78077278/treesitter-and-syntax-folding
			-- vim.api.nvim_create_autocmd({ "FileType" }, {
			-- 	callback = function()
			-- 		-- check if treesitter has parser
			-- 		if require("nvim-treesitter.parsers").has_parser() then
			-- 			-- use treesitter folding
			-- 			vim.opt.foldmethod = "expr"
			-- 			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			-- 		else
			-- 			-- use alternative foldmethod
			-- 			vim.opt.foldmethod = "syntax"
			-- 		end
			-- 	end,
			-- })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		-- lazy = false,
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter" },
		},
		opts = {
			-- According to the docs (https://github.com/nvim-treesitter/nvim-treesitter-context?tab=readme-ov-file),
			-- it shouldn't be necessary to explicittely enable the context plugin, but with Lazy.nvim it seems to only
			-- work if enabled:
			enable = true,
		},
	},
}
