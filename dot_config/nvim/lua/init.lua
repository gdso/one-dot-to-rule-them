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

require 'lspconfig'.tsserver.setup {
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
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<spacspacee>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>rw', ":%s/<c-r><c-w>/", opts)
    vim.keymap.set('n', '<space>qr', ":cfdo %s/<c-r><c-w>/", {})
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

-- mnemonic: \sw => search word
vim.keymap.set('n', '<leader>sw', builtin.grep_string, {})

vim.keymap.set('n', '<leader>sy', ":Telescope grep_string search=<c-r>0<cr>", {})
-- NOTE I'm chooing not to use builtin.current_buffer_fuzzy_find because it 
-- does not use ripgrep, doesn't support exact match or regex in general 
-- it's fuzzy which pollutes results
-- vim.keymap.set('n', '<leader>sb', builtin.current_buffer_fuzzy_find, {})
-- mnemonic: \sb => search bufferS
vim.keymap.set('n', '<leader>sb', function()
  builtin.live_grep({ grep_open_files = true })
end
, {})
vim.keymap.set('n', '<leader>sh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>sq', builtin.quickfixhistory, {})
vim.keymap.set('n', '<leader>st', ":Telescope toggleterm_manager<CR>", {})
vim.keymap.set('t', '<leader>st', '<C-\\><C-n>:Telescope toggleterm_manager<CR>', {})
vim.keymap.set('n', '<leader>qq', builtin.quickfix, {})
vim.keymap.set('n', '<leader>qh', builtin.quickfixhistory, {})
vim.keymap.set('n', '<leader>rw', ":%s/<c-r><c-w>/", {})
vim.keymap.set('n', '<leader>ry', ':%s/<c-r>"/', {})
vim.keymap.set('n', '<leader>ra', ":cfdo %s/<c-r><c-w>/", {})
-- vim.keymap.set('n', '<space>b', builtin.buffers, {})
vim.keymap.set('n', '<space>d', builtin.diagnostics, {})
vim.keymap.set('n', '<space>s', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<space>ws', builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set('n', '<space>r', builtin.lsp_references, {})
vim.keymap.set('n', '<space>gs', builtin.git_status, {})
vim.keymap.set('n', '<space>gc', builtin.git_commits, {})
vim.keymap.set('n', '<space>gb', builtin.git_bcommits, {})
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
    mappings = {
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

-- </telescope_file_browser>

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
    jsonc = { 'prettier' }
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

vim.keymap.set('n', '<space>f', ':Format<CR>', {})

-- </conform.nvim>
