-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
--   vim.fn.system({
--     "git",
--     "clone",
--     "--filter=blob:none",
--     "https://github.com/folke/lazy.nvim.git",
--     "--branch=stable", -- latest stable release
--     lazypath,
--   })
-- end
-- vim.opt.rtp:prepend(lazypath)
--
-- require("lazy").setup({
--   {
--     'nvim-telescope/telescope.nvim',
--     tag = '0.1.5',
--     -- or
--     -- , branch = '0.1.x',
--     dependencies = { 'nvim-lua/plenary.nvim' }
--   },
--   {
--     "ryanmsnyder/toggleterm-manager.nvim",
--     dependencies = {
--       "akinsho/nvim-toggleterm.lua",
--       "nvim-telescope/telescope.nvim",
--       "nvim-lua/plenary.nvim", -- only needed because it's a dependency of telescope
--     },
--     config = true,
--   }
-- })

-- <nvim_cmp_setup>
-- Set up nvim-cmp.
local cmp = require 'cmp'

cmp.setup({
  -- snippet = {
  --   -- REQUIRED - you must specify a snippet engine
  --   expand = function(args)
  --     vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
  --     -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
  --     -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
  --     -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
  --   end,
  -- },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end
      }
    },
    { name = 'path' }
  })
})

-- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
--   }, {
--     { name = 'buffer' },
--   })
-- })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- -- Set up lspconfig.
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['elixirls'].setup {
--   capabilities = capabilities
-- }

-- </nvim_cmp_setup>

-- <nvim_lsp_config>


-- NOTE the following LSPs need to be installed via NPM, etc:
-- For lua-language-server, see docs at: https://github.com/bellini666/asdf-lua-language-server
--
-- For typescript and tsserver
-- $ npm install -g typescript-language-server typescript
--
-- For bash-language-server:
-- $ npm i -g bash-language-server
--
-- For yaml-language-server:
-- $ yarn global add yaml-language-server # NOTE I ran `npm install -g yaml-language-server` because I don't have yarn installed

-- local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()


require("mason").setup()
require("mason-lspconfig").setup()

local util = require 'lspconfig.util'

require 'lspconfig'.elixirls.setup {
  -- Unix
  cmd = { "elixir-ls" },
  capabilities = capabilities,
  root_dir = function(fname)
    return util.root_pattern 'mix.exs' (fname) or util.find_git_ancestor(fname)
  end,
  -- ...
}

require 'lspconfig'.flow.setup {}

require 'lspconfig'.ts_ls.setup {
  -- filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" }
}

require 'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require 'lspconfig'.tailwindcss.setup {
  init_options = {
    userLanguages = {
      ["phoenix-heex"] = "html",
      elixir = "html",
      eelixir = "html-eex",
      eruby = "erb"
    }
  }
}

require 'lspconfig'.yamlls.setup {
  settings = {
    yaml = {
      validate = false
    }
  }
}

require 'lspconfig'.bashls.setup {}

require 'lspconfig'.marksman.setup {}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- NOTE doubling <C-k> puts cursor/focus into the popup
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

    -- NOTE not sure if I'll realy use these LSP shortcuts:
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)

    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    -- vim.keymap.set('n', '<space>rw', ":%s/<c-r><c-w>/", opts)
    -- vim.keymap.set('n', '<space>qr', ":cfdo %s/<c-r><c-w>/", {})
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    -- See telescope_setup's builtin.lsp_references	 keymap
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    -- vim.keymap.set('n', '<space>f', function()
    --   vim.lsp.buf.format { async = true }
    -- end, opts)
  end,
})

-- </nvim_lsp_config>

-- <nvim_tree_setup>

-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
-- require("nvim-tree").setup({
--   sort_by = "case_sensitive",
--   view = {
--     width = 30,
--   },
--   renderer = {
--     group_empty = true,
--     icons =  {
--       show = {
--           -- file = false,
--           -- folder = false,
--           -- folder_arrow = true,
--           -- git = true,
--           -- modified = true,
--       },
-- 	    glyphs = {
--         -- default = "📄",
--         -- folder = {
--           -- default = "📁",
--           -- arrow_closed = "▸",
--           -- arrow_open = "▿",
-- 	      -- },
--         git = {
--           -- unstaged = "✗",
--           -- staged = "✓",
--           -- unmerged = "⚠️",
--           -- renamed = "➜",
--           -- untracked = "★",
--           -- deleted = "🗑️",
--           -- ignored = "◌",
--         },
-- 	},
--     },
--   },
--   filters = {
--     dotfiles = true,
--   },
-- })

-- </nvim_tree_setup>

-- <toggleterm>
require("toggleterm").setup({
  size = 100,
  -- size can be a number or function which is passed the current terminal
  -- size = 100 | function(term)
  --   if term.direction == "horizontal" then
  --     return 15
  --   elseif term.direction == "vertical" then
  --     return vim.o.columns * 0.4
  --   end
  -- end,
  -- open_mapping = [[<C-\>]],
  open_mapping = "<Leader>t",
  direction = "vertical",
  -- direction = "float",
})

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  -- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
  -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-w>.', [[<C-\><C-n>]], opts)
  -- vim.keymap.set('t', '<C-M-n>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-W-n>', [[<C-\><C-n>]], opts)
  -- vim.keymap.set('<leader', '<C-M-n>', [[<C-\><C-n>]], opts)
  -- vim.keymap.set('n', '<leader>s', ":Telescope toggleterm_manager<CR>", opts)
  -- vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  -- vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  -- vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  -- vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- </toggleterm>

-- <toggleterm_manager>
local toggleterm_manager = require("toggleterm-manager")
local actions = toggleterm_manager.actions
toggleterm_manager.setup({
  mappings = {
    i = {
      ["<CR>"] = { action = actions.toggle_term, exit_on_action = true }, -- toggles terminal open/closed
      -- ["<CR>"] = { action = actions.create_and_name_term, exit_on_action = true },
      -- ["<C-d>"] = { action = actions.delete_term, exit_on_action = false },
      -- ["<C-c>"] = { action = actions.create_and_name_term, exit_on_action = true },
      ["<m-c>"] = { action = actions.create_and_name_term, exit_on_action = true },
    },
    n = {
      ["<CR>"] = { action = actions.toggle_term, exit_on_action = true }, -- toggles terminal open/closed
      ["t"] = { action = actions.toggle_term, exit_on_action = false },   -- toggles terminal open/closed
      -- ["<CR>"] = { action = actions.create_and_name_term, exit_on_action = true },
      ["x"] = { action = actions.delete_term, exit_on_action = false },
      -- ["c"] = { action = actions.create_term, exit_on_action = false }, -- creates a new terminal buffer,
      ["c"] = { action = actions.create_and_name_term, exit_on_action = true },
      ["r"] = { action = actions.rename_term, exit_on_action = false },
    },
  },
})

-- </toggleterm_manager>

-- <lualine>
-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = colors.black },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

require('lualine').setup {
  options = {
    theme = bubbles_theme,
    icons_enabled = false,
    section_separators = '',
    component_separators = '',
    component_separators = '|',
    -- section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = {
      'filename', 'branch'
    },
    lualine_c = { 'fileformat' },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}

-- </lualine>

-- <symbols_outline_setup>

require("symbols-outline").setup()

-- </symbols_outline_setup>

-- <telescope_setup>

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>ss', builtin.live_grep, {})
vim.keymap.set('n', '<space>gg', builtin.live_grep, {})
vim.keymap.set('n', '<space>ga', function()
  builtin.live_grep({
    additional_args = { "--hidden" }
  })
end)
-- vim.keymap.set('n', '<space>ga', builtin.live_grep, {
--   -- additional_args = function(_)
--   --   return { "--hidden" }
--   -- end
-- })

-- mnemonic: \sw => search word
vim.keymap.set('n', '<leader>sw', builtin.grep_string, {})
vim.keymap.set('n', '<space>gw', builtin.grep_string, {})

vim.keymap.set('n', '<leader>sy', ":Telescope grep_string search=<c-r>0<cr>", {})
vim.keymap.set('n', '<space>gy', ":Telescope grep_string search=<c-r>0<cr>", {})
-- NOTE I'm chooing not to use builtin.current_buffer_fuzzy_find because it
-- does not use ripgrep, doesn't support exact match or regex in general
-- it's fuzzy which pollutes results
-- vim.keymap.set('n', '<leader>sb', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<space>l', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>sb', function()
  builtin.live_grep({ grep_open_files = true })
end
, {})
vim.keymap.set('n', '<space>gb', function()
  builtin.live_grep({ grep_open_files = true })
end
, {})

vim.keymap.set('n', '<leader>sh', builtin.help_tags, {})
vim.keymap.set('n', '<space>h', builtin.help_tags, {})
vim.keymap.set('n', '<leader>sq', builtin.quickfixhistory, {})
vim.keymap.set('n', '<leader>st', ":Telescope toggleterm_manager<CR>", {})
vim.keymap.set('t', '<leader>st', '<C-\\><C-n>:Telescope toggleterm_manager<CR>', {})
vim.keymap.set('n', '<leader>qq', builtin.quickfix, {})
vim.keymap.set('n', '<leader>qh', builtin.quickfixhistory, {})

vim.keymap.set('n', '<leader>rw', ":%s/<c-r><c-w>/", {})
vim.keymap.set('n', '<space>rw', ":%s/<c-r><c-w>/", {})
vim.keymap.set('n', '<leader>ry', ':%s/<c-r>"/', {})
vim.keymap.set('n', '<space>ry', ':%s/<c-r>"/', {})

vim.keymap.set('n', '<leader>rs', ":%s/", {})
vim.keymap.set('n', '<space>rs', ":%s/", {})

vim.keymap.set('n', '<leader>ra', ":cfdo %s/<c-r><c-w>/", {})
vim.keymap.set('n', '<space>ra', ":cfdo %s/<c-r><c-w>/", {})

vim.keymap.set('n', '<space>T', builtin.builtin, {})

vim.keymap.set('n', '<space>f', builtin.find_files, {})
vim.keymap.set('n', '<space>b', builtin.buffers, {})
vim.keymap.set('n', '<space>m', builtin.marks, {})
vim.keymap.set('n', '<space>d', builtin.diagnostics, {})
vim.keymap.set('n', '<space>s', builtin.lsp_document_symbols, {})
-- vim.keymap.set('n', '<space>ws', builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set('n', '<space>r', builtin.lsp_references, {})
-- vim.keymap.set('n', '<space>gs', builtin.git_status, {})
-- vim.keymap.set('n', '<space>gc', builtin.git_commits, {})
-- vim.keymap.set('n', '<space>gc', builtin.git_bcommits, {})
vim.keymap.set('n', '<space>o', builtin.oldfiles, {})


local actions = require "telescope.actions"
require("telescope").setup {
  defaults = {
    sorting_strategy      = "ascending",
    layout_config         = {
      horizontal = {
        prompt_position = "top",
      }
    },
    dynamic_preview_title = true,
    mappings              = {
      n = {
        ["q"] = actions.send_to_qflist + actions.open_qflist,
        ["Q"] = actions.send_selected_to_qflist + actions.open_qflist,
      }
    }
  },
  pickers = {
    buffers = {
      -- sorting_strategy = "descending",
      mappings = {
        n = {
          ["x"] = actions.delete_buffer + actions.move_to_top,
        },
        i = {
          ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
        }
      }
    },
    find_files = {
      hidden = true
    },
    lsp_references = {
      path_display = {
        shorten = {
          length = 1,
          exclude = { -1, -2 }
        }
      }
    },
    colorscheme = {
      enable_preview = true
    }
  },
  extensions = {
    file_browser = {
      -- dir_icon = "📁",
      depth = 1,
      hijack_netrw = true,
      auto_depth = true
    }
  }
}
-- </telescope_setup>
--

-- <telescope_file_browser>
vim.api.nvim_set_keymap(
  "n",
  "<leader>e",
  ":Telescope file_browser <cr>",
  { noremap = true }
)

-- open file_browser with the path of the current buffer

-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension "file_browser"

vim.api.nvim_set_keymap(
  "n",
  "<leader>w",
  ":Telescope file_browser path=%:p:h select_buffer=true <cr>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<space>w",
  ":Telescope file_browser path=%:p:h select_buffer=true <cr>",
  { noremap = true }
)

-- </telescope_file_browser>

-- <telescope_tabs>
require('telescope').load_extension 'telescope-tabs'
require('telescope-tabs').setup {
  -- Your custom config :^)
}
vim.api.nvim_set_keymap(
  "n",
  "<space>t",
  ":Telescope telescope-tabs list_tabs <cr>",
  { noremap = true }
)
-- </telescope_tabs>

-- <nvim_web_icons_setup>
require 'nvim-web-devicons'.setup {
  -- your personnal icons can go here (to override)
  -- you can specify color or cterm_color instead of specifying both of them
  -- DevIcon will be appended to `name`
  override = {
    zsh = {
      icon = "",
      color = "#428850",
      cterm_color = "65",
      name = "Zsh"
    }
  },
  -- globally enable different highlight colors per icon (default to true)
  -- if set to false all icons will have the default icon's color
  color_icons = true,
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true,
  -- globally enable "strict" selection of icons - icon will be looked up in
  -- different tables, first by filename, and if not found by extension; this
  -- prevents cases when file doesn't have any extension but still gets some icon
  -- because its name happened to match some extension (default to false)
  strict = true,
  -- same as `override` but specifically for overrides by filename
  -- takes effect when `strict` is true
  override_by_filename = {
    [".gitignore"] = {
      icon = "",
      color = "#f1502f",
      name = "Gitignore"
    }
  },
  -- same as `override` but specifically for overrides by extension
  -- takes effect when `strict` is true
  override_by_extension = {
    ["log"] = {
      icon = "",
      color = "#81e043",
      name = "Log"
    }
  },
}
-- </nvim_web_icons_setup>

-- <theme>
-- Default options:
require('kanagawa').setup({
  compile = false,  -- enable compiling the colorscheme
  undercurl = true, -- enable undercurls
  commentStyle = { italic = false },
  functionStyle = {},
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = false,   -- do not set background color
  dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
  terminalColors = true, -- define vim.g.terminal_color_{0,17}
  colors = {             -- add/modify theme and palette colors
    palette = {},
    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
  },
  overrides = function(colors) -- add/modify highlights
    return {}
  end,
  theme = "wave",  -- Load "wave" theme when 'background' option is not set
  background = {   -- map the value of 'background' option to a theme
    dark = "wave", -- try "dragon" !
    light = "lotus"
  },
})

-- setup must be called before loading
vim.cmd("colorscheme kanagawa")

-- </theme>
--

-- <markdown_preview_plugin>
require('glow').setup()
-- </markdown_preview_plugin>

-- -- <formatter.nvim>
-- -- Utilities for creating configurations
-- local util = require "formatter.util"
--
-- -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
-- require("formatter").setup {
--   -- Enable or disable logging
--   logging = true,
--   -- Set the log level
--   log_level = vim.log.levels.WARN,
--   -- All formatter configurations are opt-in
--   filetype = {
--     -- Formatter configurations for filetype "lua" go here
--     -- and will be executed in order
--     lua = {
--       -- "formatter.filetypes.lua" defines default configurations for the
--       -- "lua" filetype
--       require("formatter.filetypes.lua").stylua,
--
--       -- You can also define your own configuration
--       function()
--         -- Supports conditional formatting
--         if util.get_current_buffer_file_name() == "special.lua" then
--           return nil
--         end
--
--         -- Full specification of configurations is down below and in Vim help
--         -- files
--         return {
--           exe = "stylua",
--           args = {
--             "--search-parent-directories",
--             "--stdin-filepath",
--             util.escape_path(util.get_current_buffer_file_path()),
--             "--",
--             "-",
--           },
--           stdin = true,
--         }
--       end
--     },
--
--     javascript = { require("formatter.filetypes.javascript").prettier },
--     javascriptreact = { require("formatter.filetypes.javascriptreact").prettier },
--     typescript = { require("formatter.filetypes.typescript").prettier },
--     typescriptreact = { require("formatter.filetypes.typescriptreact").prettier },
--
--     -- Use the special "*" filetype for defining formatter configurations on
--     -- any filetype
--     ["*"] = {
--       -- "formatter.filetypes.any" defines default configurations for any
--       -- filetype
--       require("formatter.filetypes.any").remove_trailing_whitespace
--     }
--   }
-- }
-- -- </formatter.nvim>

-- <conform.nvim> code formatter, augments LSP formatter and replaces formatter.nvim
require("conform").setup({
  formatters_by_ft = {
    -- Use a sub-list to run only the first available formatter
    javascript = { { "prettier" } },
    javascriptreact = { { "prettier" } },
    typescript = { 'prettier' },
    typescriptreact = { 'prettier' },
    json = { 'prettier' },
    jsonc = { 'prettier' },
    markdown = { 'prettier' }
  },
  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
})

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_fallback = true, range = range })
end, { range = true })

vim.keymap.set('n', '<space>F', ':Format<CR>', {})

-- </conform.nvim>
--


-- <mini.nvim>
-- require('mini.animate').setup({
--   scroll = {
--     enable = false
--     -- enable = false
--   },
--   -- Window resize
--   resize = {
--     -- Whether to enable this animation
--     enable = false
--
--     -- Timing of animation (how steps will progress in time)
--     -- timing = --<function: implements linear total 250ms animation duration>,
--
--     -- Subresize generator for all steps of resize animations
--     -- subresize = --<function: implements equal linear steps>,
--   }
-- })
require('mini.icons').setup()
-- require('mini.files').setup()
-- require('mini.clue').setup()
-- </mini.nvim>
--

-- <specs.nvim>
-- require('specs').setup({
--     show_jumps  = true,
--     min_jump = 30,
--     popup = {
--         delay_ms = 0, -- delay before popup displays
--         inc_ms = 10, -- time increments used for fade/resize effects
--         blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
--         width = 10,
--         winhl = "PMenu",
--         fader = require('specs').linear_fader,
--         resizer = require('specs').shrink_resizer
--     },
--     ignore_filetypes = {},
--     ignore_buftypes = {
--         nofile = true,
--     },
-- })
-- </specs.nvim>

-- <nvim-treesitter>
-- vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'
-- NOTE to use treesitter's folding, you need to set foldmethod='expr',
-- but since typescriptreact files aren't working, I'm going to set it to
-- indent:
-- vim.wo.foldmethod = 'expr'
vim.wo.foldmethod = 'indent'
vim.wo.foldlevel = 1
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo.foldcolumn = '0'

-- NOT sure if this is reqired over the longterm, but
-- nvim-treesitter isn't being used for tsx files, so I'm trying this hack:
-- vim.treesitter.language.register("typescript", "typescriptreact")

require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = {
    "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
    -- my additions:
    "bash",
    "elixir", "heex", "eex",
    "typescript", "javascript", "css", "json", "jsonc",
    "python", "yaml",
    "zig", "rust",
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
    enable = true
  },
  folding = {
    enable = true
  }
}
-- </nvim-treesitter>

-- <remote_clipboard_plugins>
require('smartyank').setup {
  osc52 = {
    enabled = true,
    -- escseq = 'tmux',     -- use tmux escape sequence, only enable if
    -- you're using tmux and have issues (see #4)

    -- default ssh_only = true
    ssh_only = false,      -- false to OSC52 yank also in local sessions

    silent = false,        -- true to disable the "n chars copied" echo
    echo_hl = "Directory", -- highlight group of the OSC52 echo message
  },

}
-- </remote_clipboard_plugins>

-- <cutlass.nvim>
require("cutlass").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  --
  -- NOTE I'm NOT setting the cut_key because we're going to rely
  -- on visual x, normal/visual X to cut, but NOT x in normal mode:
  cut_key = "x",
})

-- vim.keymap.set('n', 'x', '"_x',
--   { noremap = true, nowait = true }
-- )

-- vim.keymap.set('x', 'x', "d",
--   { noremap = true }
-- )
-- vim.keymap.set('n', 'xx', "dd",
--   { noremap = true }
-- )
-- vim.keymap.set('n', 'X', "D",
--   { noremap = true }
-- )

-- </cutlass.nvim>

-- <marks.nvim>
require 'marks'.setup {
  -- whether to map keybinds or not. default true
  default_mappings = true,
  -- which builtin marks to show. default {}
  builtin_marks = { ".", "<", ">", "^" },
  -- whether movements cycle back to the beginning/end of buffer. default true
  cyclic = true,
  -- whether the shada file is updated after modifying uppercase marks. default false
  force_write_shada = false,
  -- how often (in ms) to redraw signs/recompute mark positions.
  -- higher values will have better performance but may cause visual lag,
  -- while lower values may cause performance penalties. default 150.
  refresh_interval = 250,
  -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
  -- marks, and bookmarks.
  -- can be either a table with all/none of the keys, or a single number, in which case
  -- the priority applies to all marks.
  -- default 10.
  sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
  -- disables mark tracking for specific filetypes. default {}
  excluded_filetypes = {},
  -- disables mark tracking for specific buftypes. default {}
  excluded_buftypes = {},
  -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
  -- sign/virttext. Bookmarks can be used to group together positions and quickly move
  -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
  -- default virt_text is "".
  bookmark_0 = {
    sign = "⚑",
    virt_text = "hello world",
    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
    -- defaults to false.
    annotate = false,
  },
  mappings = {}
}
-- </marks.nvim>


-- <indent-blankline.nvim>
-- <indent-blankline.nvim>
require("ibl").setup()
-- </indent-blankline.nvim>

-- <custom_ex_commands>
vim.api.nvim_create_user_command('YankPL', function()
  local relative_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
  local line_number = vim.fn.line(".")
  vim.fn.setreg('+', relative_path .. ":" .. line_number)
end, {})
-- </custom_ex_commands>

-- <nvim_scrolling>
require('neoscroll').setup({
  mappings = { -- Keys to be mapped to their corresponding default scrolling animation
    '<C-u>', '<C-d>',
    '<C-b>', '<C-f>',
    '<C-y>', '<C-e>',
    'zt', 'zz', 'zb',
  },
  hide_cursor = true,          -- Hide cursor while scrolling
  stop_eof = true,             -- Stop at <EOF> when scrolling downwards
  respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
  duration_multiplier = 1.0,   -- Global duration multiplier
  easing = 'linear',           -- Default easing function
  pre_hook = nil,              -- Function to run before the scrolling animation starts
  post_hook = nil,             -- Function to run after the scrolling animation ends
  performance_mode = false,    -- Disable "Performance Mode" on all buffers.
  ignored_events = {           -- Events ignored while scrolling
    'WinScrolled', 'CursorMoved'
  },
})
-- </nvim_scrolling>

-- <custom_commenting_commands>

vim.api.nvim_create_user_command('CommentJSConsoleCalls', function()
  -- vim.cmd("%s/^\([:space:]*\\)console/\1\\/\\/ console/ga")
  vim.cmd("%s/^\\([[:space:]]*\\)console/\\1\\/\\/ console/gc")
end, {})

vim.api.nvim_create_user_command('UncommentJSConsoleCalls', function()
  -- vim.cmd("%s/^\([[:space:]]*\\)console/\1\\/\\/ console/ga")
  vim.cmd("%s/^\\([[:space:]]*\\)\\/\\/[[:space:]]\\?console/\\1console/gc")
end, {})
-- </custom_commenting_commands>


-- <log_highlight_plugin>
require('log-highlight').setup {
  -- The following options support either a string or a table of strings.

  -- The file extensions.
  extension = {
    'log',
    'dump'
  },

  -- The file names or the full file paths.
  filename = {
    'messages',
  },

  -- The file path glob patterns, e.g. `.*%.lg`, `/var/log/.*`.
  -- Note: `%.` is to match a literal dot (`.`) in a pattern in Lua, but most
  -- of the time `.` and `%.` here make no observable difference.
  pattern = {
    '/var/log/.*',
    'messages%..*',
  },
}
-- </log_highlight_plugin>


-- <oil_file_explorer_plugin>
-- <oil_file_explorer_plugin>
require("oil").setup(
  {
    -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
    -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
    default_file_explorer = false,
    columns               = {
      "icon",
      "permissions",
      "size",
      "mtime",
    },
    view_options          = {
      -- Show files and directories that start with "."
      show_hidden = false,
    },
    float                 = {
      preview_split = "right"
    }
  }
)
vim.keymap.set("n", "<space>W", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
-- </oil_file_explorer_plugin>
