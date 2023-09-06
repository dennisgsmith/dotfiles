local M = {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {},
  config = function()
    require('lualine').setup({
      extensions = { 'lazy', 'fugitive' },
    })
  end,
  event = "VimEnter",
  lazy = false,
  priority = 1001,
}

return M
