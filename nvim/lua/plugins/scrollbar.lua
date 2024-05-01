local M = {
  'petertriho/nvim-scrollbar',
  dependencies = { 'f-person/auto-dark-mode.nvim' },
  opts = {
    marks = {
      GitAdd = {
        text = '|',
      },
      GitChange = {
        text = '|',
      },
    },
    handlers = {
      gitsigns = true, -- Requires gitsigns
      search = true, -- Requires hlslens
    },
  },
  lazy = false,
  priority = 1002,
}

return M
