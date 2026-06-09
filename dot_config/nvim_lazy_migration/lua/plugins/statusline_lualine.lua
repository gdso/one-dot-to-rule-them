local function active_tab_color()
	local ok, highlight = pcall(require, "lualine.highlight")
	local mode_suffix = ok and highlight.get_mode_suffix() or "_normal"
	local mode_hl = vim.api.nvim_get_hl(0, { name = "lualine_a" .. mode_suffix, link = false })

	if mode_hl.bg then
		return {
			fg = "#000000",
			bg = string.format("#%06x", mode_hl.bg),
			gui = mode_hl.bold and "bold" or nil,
		}
	end

	-- Fallback: link directly to lualine's mode-pill highlight.
	return "lualine_a" .. mode_suffix
end

return {
	{
		-- https://github.com/nvim-lualine/lualine.nvim
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			sections = {
				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},
				-- 	-- lualine_z = {
				-- 	-- 	{
				-- 	-- 		require("opencode").statusline,
				-- 	-- 	},
				-- 	-- },
			},
			tabline = {
				lualine_a = {
					{ "filetype", icon_only = true },
				},
				lualine_b = {
					{
						"tabs",
						mode = 1, -- 0: Shows tab_nr
						-- 1: Shows tab_name
						-- 2: Shows tab_nr + tab_name
						max_length = vim.o.columns,
						use_mode_colors = true,
						tabs_color = {
							active = active_tab_color,
						},
						padding = { left = 1, right = 1 },
					},
				},
			},
		},
	},
}
