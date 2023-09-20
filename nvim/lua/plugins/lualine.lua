local M = {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = "catppuccin",
      globalstatus = true,
    },
    extensions = { 'lazy', 'fugitive' },
  },
  config = function(_, opts)
    require('lualine').setup(opts)
  end,
  event = "VimEnter",
  lazy = false,
  priority = 1001,
}

return M
