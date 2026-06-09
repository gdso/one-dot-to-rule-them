# Plan

- [x] Setup nvim_lazy
- [ ] > Test nvim_lazy by updating ~/.tool-versions 
- [ ] Update default ~/.config/nvim/ to use new config found at ~/.config/nvim_lazy_migration/
- [ ] Remove ~/src/nvim_lazy_migration/bin/nvim_lazy/ from $PATH (see ~/.zshrc)

# TODOs

From the init.vim and init.lua files, we will migrate the following:

- [x] <git_plugins> like vim-gitgutter
- [x] Keymaps for vim-fugitive and vim-gutter like DiffGit 
- [x] Install `delta` to get better diffs 

- [x] tpope's vim-unimpaired, 
- [x] vim-surround, 
- [x] vim-repeat

- [x] fzf 
    - [x] Q: Should we use fzf anymore? Do we need it? 
          A: Yes, helpful at the CLI at least for Ctrl-r command history
    - [x] Install it via asdf, but skip in neovim plugins

- [x] telescope-related plugins
- [x] telescope file browser
    - [x] telescope keyboard shortcuts for file browser
    - [x] telescope for pickers (find files, etc)
    

- [x] treesitter

- [x] marks.nvim

- [x] render-markdown.nvim

- [x] commenting tomtom/tcomment_vim

- [x] fzf-lua
- [x] Mason
    - [x] Added mson.nvim to Lazy plugins folder (./lua/plugins/mason_LSPs.lua)
    - [x] Q: Do we need another plugin? Mason's lsp plugin?
          A: I don't think so
    
- [x] LSP keymaps
    - NOTE thanks to fzf-lua, most are handled except, rename, and ...
    - See 'LspAttach' in old ini.lua to find more

- [-] cmp-nvim-* 
- [x] install blink.nvim instead -- faster and easier installation

- [x] clipboard (smartyank)
    - [x] Find the remap of x for cutting

- [ ] HTML commenting:
    - [x] vnoremap gch :TCommentAs html<CR>
    - [x] noremap gch :TCommentAs html<CR>

- [x] Port indent-blankline.nvim
- custom commands
    - [x] YankPL => YankPathLineNum
    - [x] CommentJSConsoleCalls

# Plugins and Things To Add

- [x] sindrets/diffview.nvim
