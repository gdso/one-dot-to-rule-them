return {
  {
    "tomtom/tcomment_vim",
    -- enabled = false,
    lazy = false,
    keys = {
      -- vim.keymap.set('v', 'gch', ':TCommentAs html<CR>')
      -- vim.keymap.set('n', 'gch', ':TCommentAs html<CR>')
      { 'gch', ':TCommentAs html<CR>', mode = 'v' },
      { 'gch', ':TCommentAs html<CR>', mode = 'n' },
      { 'gcj', ':TCommentAs jsx_block<CR>', mode = 'n' },
      { 'gcj', ':TCommentAs jsx_block<CR>', mode = 'v' },
    }
  }
}
