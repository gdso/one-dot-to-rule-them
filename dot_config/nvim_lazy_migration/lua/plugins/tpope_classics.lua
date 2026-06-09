return {

	-- https://github.com/tpope/vim-unimpaired
	-- " ]q is :cnext. [q is :cprevious. ]a is :next. [b is :bprevious.
	-- See the documentation for the full set of 20 mappings and mnemonics. All of them take a count.
	{ "tpope/vim-unimpaired" },

	-- https://github.com/tpope/vim-surround
	-- cs'" to change surrounding quotes, ds" to delete surrounding quotes,
	{ "tpope/vim-surround" },
	-- https://github.com/tpope/vim-repeat?tab=readme-ov-file
	-- vim-repeat allows you to repeat the last change made by vim-surround
	-- with a . command, and it works with other tpope plugins as well
	{ "tpope/vim-repeat", lazy = false },
}
