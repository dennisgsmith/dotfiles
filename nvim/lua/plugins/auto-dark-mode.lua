local M = {
  "f-person/auto-dark-mode.nvim",
  dependencies = { "folke/twilight.nvim" },
  lazy = false,
  priority = 999,
  opts = {
    update_interval = 1000,
    set_dark_mode = function()
      vim.api.nvim_set_option("background", "dark")
      vim.cmd("colorscheme github_dark")
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
      vim.cmd("colorscheme github_light")
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
