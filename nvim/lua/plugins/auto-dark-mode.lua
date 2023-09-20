local M = {
  "f-person/auto-dark-mode.nvim",
  dependencies = {
    "folke/twilight.nvim",
    "nvim-lualine/lualine.nvim",
    "petertriho/nvim-scrollbar",
  },
  lazy = false,
  priority = 999,
  opts = {
    update_interval = 1000,
    set_dark_mode = function()
      vim.api.nvim_set_option("background", "dark")
      vim.cmd("colorscheme catppuccin-mocha")
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#333333" })
      require('lualine').refresh()
      require('scrollbar').render()
      require('twilight').setup({
        dimming = {
          term_bg = '000000'
        }
      })
    end,
    set_light_mode = function()
      vim.api.nvim_set_option("background", "light")
      vim.cmd("colorscheme catppuccin-latte")
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#cccccc" })
      require('lualine').refresh()
      require('scrollbar').render()
      require('twilight').setup({
        dimming = {
          term_bg = 'ffffff'
        }
      })
    end,
  }
}

return M
