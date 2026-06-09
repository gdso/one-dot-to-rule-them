return {
	{
		"stevearc/conform.nvim",
		lazy = false,
		dependencies = {
			-- This is NOT from the conform.nvim docs, but I'm wondering if this will
			-- alter the loading sequence s.t.
			"mason-org/mason.nvim",
		},
		opts = {
			formatters_by_ft = {
				-- Use a sub-list to run only the first available formatter
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				yaml = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				markdown = { "prettier" },
				lua = { "stylua" },
				python = { "ruff", lsp_format = "fallback" },
			},
			-- See config block and FormatDisable command:
			-- format_on_save = {
			-- 	-- These options will be passed to conform.format()
			-- 	timeout_ms = 500,
			-- 	lsp_format = "fallback",
			-- },
		},
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<space>F",
				-- Rely on user command Format, which will also format the range
				":Format<cr>",
				-- function()
				-- 	require("conform").format({ async = true })
				-- end,
				mode = "",
				desc = "Format buffer or selected range",
			},
		},
		config = function(_, opts)
			-- <format_command>
			-- See https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#format-command
			vim.api.nvim_create_user_command("Format", function(args)
				local range = nil
				if args.count ~= -1 then
					local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
					range = {
						start = { args.line1, 0 },
						["end"] = { args.line2, end_line:len() },
					}
				end
				require("conform").format({ async = true, lsp_format = "fallback", range = range })
			end, { range = true })
			-- </format_command>

			-- <toggle_format_on_save>
			-- See https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save

			vim.api.nvim_create_user_command("FormatDisable", function(args)
				if args.bang then
					-- FormatDisable! will disable formatting just for this buffer
					vim.b.disable_autoformat = true
				else
					vim.g.disable_autoformat = true
				end
			end, {
				desc = "Disable autoformat-on-save",
				bang = true,
			})
			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
			end, {
				desc = "Re-enable autoformat-on-save",
			})

			opts["format_on_save"] = function(bufnr)
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_format = "fallback" }
			end

			require("conform").setup(opts)

			-- </toggle_format_on_save>
		end,
	},
	{
		-- https://github.com/ntpeters/vim-better-whitespace
		"ntpeters/vim-better-whitespace",
		lazy = false,
		init = function()
			vim.g.better_whitespace_enabled = 1
			vim.g.strip_whitespace_on_save = 1
			vim.g.strip_whitespace_confirm = 0
		end,
	},
}
