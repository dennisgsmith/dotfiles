local M = {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  opts = {
    integrations = {
      cmp = true,
      gitsigns = true,
      treesitter = true,
      telescope = { enabled = true },
      lsp_trouble = true,
      dap = {
        enabled = true,
        enable_ui = true,
      },
      mason = true,
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
  end,
}

return M
