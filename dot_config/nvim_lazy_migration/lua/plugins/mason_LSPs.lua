return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		-- mason-lspconfig.nvim bridges mason.nvim and nvim-lspconfig,
		-- by automatically enabling LSP servers I've installed via mason.nvim:
		-- NOTE, with the introduction of vim.lsp.config in v0.11 of nvim,
		-- `mason-lspconfig`'s feature set has been reduced in scope to
		-- focus on auto-installing and auto-enabling servers.
		"mason-org/mason-lspconfig.nvim",
		opts = {
			-- ensure_installed = {
			--   "pyright",
			-- },
			automatic_enable = {
				exclude = {
					-- e.g.
					-- "rust_analyzer",
					-- "ts_ls"
				},
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{ "neovim/nvim-lspconfig" },
}
