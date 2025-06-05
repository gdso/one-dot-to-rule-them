call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" On-demand loading
" <tree_view_plugins>
" Plug 'nvim-tree/nvim-web-devicons' " optional
" Plug 'nvim-tree/nvim-tree.lua'

" Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
"
" </tree_view_plugins>

" <git_plugins>
Plug 'tpope/vim-fugitive'
" Shows a git diff in the sign column, also adds [c, ]c to jump to next
" change, can also be used to stage one hunk at a time
Plug 'airblade/vim-gitgutter'
" </git_plugins>

" Quickfix mappings [q, ]q
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" Plug 'andymass/vim-matchup'


" Plugin outside ~/.vim/plugged with post-update hook
" Buffer and File explorers
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'


" <telescope>
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
" or                                , { 'branch': '0.1.x' }
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-tree/nvim-web-devicons'
" </telescope>
"
" <telescope_tabs>
Plug 'LukasPietzschmann/telescope-tabs'
" </telescope_tabs>
"
" <marks>
Plug 'chentoast/marks.nvim'
" </marks>

" <treesitter>
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'echasnovski/mini.nvim'
Plug 'MeanderingProgrammer/render-markdown.nvim'
" </treesitter>
"
" <treesitter_plugins>
Plug 'nvim-treesitter/nvim-treesitter-context'
" </treesitter_plugins>

" <nvim_scrolling>
Plug 'karb94/neoscroll.nvim'
" </nvim_scrolling>

" cursor movement plugins
" Plug 'edluffy/specs.nvim'

" <LSP_plugins>
"
" LSP package manager for nvim
Plug 'williamboman/mason.nvim'
" NOTE mason.nvim recommends we install mason-lspconfig along with neovim/nvim-lspconfig:
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
" mason.nvim also recommends formatter.nvim along with mason.nvim, but
" conform.nvim has a fallback to use the LSP format, which just makes 
" life easier in cases where the LSP actually has a decent formatter:
" Plug 'mhartington/formatter.nvim' " <- code_formatter
Plug 'stevearc/conform.nvim' " code formatter, augments LSP formatter and replaces formatter.nvim


" All of these nvim-cmp sources are necessary for nvim-cmp (see https://github.com/hrsh7th/nvim-cmp README.md)
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'


" <llm_tools>
Plug 'github/copilot.vim'
" </llm_tools>

" <code_formatter>
" Plug 'sbdchd/neoformat'
" </code_formatter>

" code outline:
Plug 'simrat39/symbols-outline.nvim'
" </LSP_plugins>

" Elixir
Plug 'elixir-editors/vim-elixir'


" Comment plugins
Plug 'tomtom/tcomment_vim'

" https://github.com/simeji/winresizer
Plug 'simeji/winresizer'


" Themes
Plug 'aonemd/kuroi.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'tomasr/molokai'
Plug 'fxn/vim-monochrome'
Plug 'nightsense/snow'
Plug 'rebelot/kanagawa.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'tinted-theming/base16-vim'

" <terminal_plugins>
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'ryanmsnyder/toggleterm-manager.nvim'

" Plug 'voldikss/vim-floaterm'
" Plug 'voldikss/fzf-floaterm'
" </terminal_plugins>

" <clipboard>

" For simplifying vim's terrible approach to copy/paste/cut:
" Plug 'svermeulen/vim-cutlass'
Plug 'gbprod/cutlass.nvim'

" <remote_clipboard_plugins>
" Plug 'ojroques/vim-oscyank', {'branch': 'main'}
" Plug 'machakann/vim-hilghlightedyank'
" https://github.com/ibhagwan/smartyank.nvim
Plug 'ibhagwan/smartyank.nvim'
" </remote_clipboard_plugins>

" </clipboard>
"
" Search plugins
" Loupe enhances Vim's search-commands in few ways:
" 1) Sets 'very magic' /\v as default to searches
" 2) Default behaviours when searching 
" 3) <Leader>n to remove current highlighted search
Plug 'wincent/loupe' 


" Status bar
Plug 'nvim-lualine/lualine.nvim'

" <markdown_preview_plugin>
" glow: markdown preview plugin
Plug 'ellisonleao/glow.nvim'

" For Dockerfile syntax support
Plug 'ekalinin/Dockerfile.vim'


" NOTE  'nathanaelkane/vim-indent-guides' seems to be defunct as of  Jan 2025:
" Plug 'nathanaelkane/vim-indent-guides'
Plug 'lukas-reineke/indent-blankline.nvim'

" IndentWise is a Vim plugin that provides for motions based on indent depths or levels in normal, visual, and operator-pending modes.
" e.g. '[=', or ']='  to navigate to previous or next line of the same
" indentation, see help for more ...
Plug 'jeetsukumaran/vim-indentwise'

" <log_highlight_plugin>
" For syntax highlighting of log files:
" https://github.com/fei6409/log-highlight.nvim
Plug 'fei6409/log-highlight.nvim'
" </log_highlight_plugin>

" Plug 'sheerun/vim-polyglot'

" lua << EOF
" require('glow').setup()
" EOF
" </markdown_preview_plugin>

"" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'
	
" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()

" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting
"   https://github.com/ibhagwan/smartyank.nvim

filetype plugin indent on
set number
autocmd filetype elixir,javascript,typescript,dockerfile,markdown setlocal number
" autocmd filetype typescriptreact set foldmethod=indent
set colorcolumn=80

" Theme
set background=dark
" colorscheme kanagawa-wave
" colorscheme snow
" colorscheme kuroi
" colorscheme monochrome
" colorscheme solarized8_high
set cursorline

lua << EOF


EOF

lua require('init')

" MAPPINGS
" terminal mappings
" tnoremap<Esc> <C-\><C-n>

" FZF mappings:
" nnoremap <leader>f :Files<CR>
" nnoremap <leader>b :Buffers<CR>
nnoremap <silent> <leader>L :Lines<CR>
nnoremap <silent> <leader>l :BLines<CR>
" nnoremap <silent> <leader>r :Rg <c-r><c-w><cr>
" nnoremap <leader>R :cfdo %s/<c-r><c-w>/

" gitgutter settings
let g:gitgutter_highlight_lines = 0
nnoremap \g :GitGutterLineHighlightsToggle<CR>

" My custom mappings:
noremap s :update<cr>
nnoremap <leader>c :close<CR>
vnoremap  <leader>y "+y
vnoremap <leader>p "+p

nnoremap go <C-w><C-o>
nnoremap gh <C-w>h
nnoremap gH <C-w>H
nnoremap gl <C-w>l
nnoremap gL <C-w>L
nnoremap gk <C-w>k
nnoremap gj <C-w>j
" To close a split:
nnoremap g- <C-w>c
" To jump to a split buffer based on the current buffer
nnoremap g= <C-w>v<C-w>l
" To jump to a popup window:
nnoremap gw <C-w>w
" To move window to a new tab:
nnoremap gt <C-w>T

nnoremap th :tabprevious<CR>
nnoremap tl :tabnext<CR>
nnoremap tH :-tabmove<CR>
nnoremap tL :+tabmove<CR>

nnoremap T :tabnew<CR>
" nnoremap DiffSplit :windo diffthis<CR>

" nnoremap <leader>T :NERDTreeToggle<CR>
" nnoremap <leader>F :NERDTreeFind<CR>

" nnoremap <leader>F :NvimTreeFindFile<CR>
" nnoremap <leader>T :NvimTreeToggle<CR>

set shiftwidth=2
set expandtab
set tabstop=2
" set foldmethod=indent   
" set foldmethod=syntax
" set foldlevel=2
" set foldcolumn=0
" set foldcolumn=1
" set foldcolumn=auto:9

" All language servers seem to need this, and so does ToggleTerm:
set hidden


nnoremap <leader>d :bdelete<CR>
" Inspired by https://stackoverflow.com/questions/4545275/vim-close-all-buffers-but-this-one#comment93467529_42071865
nnoremap <leader>D :%bd\|e#\|bd#<CR>


" <vim_oscyank_setup>
nmap <leader>y <Plug>OSCYankOperator
nmap <leader>yy <leader>c_
vmap <leader>y <Plug>OSCYankVisual
" </vim_oscyank_setup>

" <vim-cutlass>
" Some maps from vim-cutlass to support 'cut' operations since vim-cutlass
" disables cut on deletion (see https://github.com/svermeulen/vim-cutlass
" README.md):
" nnoremap m 
" xnoremap m d
" nnoremap mm dd
" nnoremap M D

" nnoremap x d
" xnoremap x d
" nnoremap xx dd
" nnoremap X D
" </vim-cutlass>

" <smartyank.nvim>
" https://stackoverflow.com/questions/11993851/how-to-delete-not-cut-in-vim

nnoremap x "_x

" Personal opinion, but p in visual mode should NEVER yank the selection
" that will be overwritten by the paste/put:
vnoremap p P

" <smartyank.nvim>



vnoremap gch :TCommentAs html<CR>
noremap gch :TCommentAs html<CR>

" <vim_floatterm>
" noremap   <silent>   <leader>t  :FloatermToggle<CR>
" tnoremap   <silent>   <leader>t   <C-\><C-n>:FloatermToggle<CR>
"
" tnoremap   <silent>   <leader>n    <C-\><C-n>:FloatermNew<CR>
"
" tnoremap   <silent>   <leader>s    <C-\><C-n>:Floaterms<CR>
"
" tnoremap   <leader>r    <C-\><C-n>:FloatermUpdate --title=
"
" tnoremap   <leader>h    <C-\><C-n>:FloatermUpdate --position=topleft<CR>
" tnoremap   <leader>l    <C-\><C-n>:FloatermUpdate --position=topright<CR>
" tnoremap   <leader>.    <C-\><C-n>:FloatermUpdate --position=center<CR>
"
" tnoremap   <silent>   <leader>[    <C-\><C-n>:FloatermPrev<CR>
"
" tnoremap   <silent>   <leader>]    <C-\><C-n>:FloatermPrev<CR>
"
" tnoremap   <silent>   <C-w>.   <C-\><C-n>
" tnoremap   <silent>   <C-w>   <C-\><C-n><C-w>
" tnoremap   <silent>   <leader>v   <C-\><C-n>:FloatermUpdate --wintype=vsplit<CR>
" tnoremap   <silent>   <leader>f   <C-\><C-n>:FloatermUpdate --wintype=float<CR>
"
" let g:floaterm_wintype = 'float'
" let g:floaterm_position = 'right'
" let g:floaterm_height  = 1.0
" let g:floaterm_autoinsert = v:true


" </vim_floatterm>

noremap <leader>G :vert Git<CR>

"
"
" <code_formatter>
" let g:neoformat_try_node_exe = 1
" nnoremap   <silent>   <space>n    :Neoformat<CR>
" </code_formatter>

" <vim-indent-guides>
let g:indent_guides_enable_on_vim_startup = 1
" let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 2

" </vim-indent-guides>


:command DiffThis windo diffthis
:command DiffOff windo diffoff
:command DiffGit Gvdiffsplit
:command DiffGitOff only " Equivalent to <C-w><C-o>



" For :Cfilter, :Lfilter commands
packadd cfilter

" LSPs that need to be installed:
" 
