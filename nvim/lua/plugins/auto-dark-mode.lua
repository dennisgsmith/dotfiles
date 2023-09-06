local M = {
  "f-person/auto-dark-mode.nvim",
  lazy = false,
  priority = 999,
  opts = {
    update_interval = 1000,
    set_dark_mode = function()
      vim.api.nvim_set_option("background", "dark")
      vim.cmd("colorscheme github_dark")
      require('lualine').refresh()
      require('scrollbar').render()
    end,
    set_light_mode = function()
      vim.api.nvim_set_option("background", "light")
      vim.cmd("colorscheme github_light")
      require('lualine').refresh()
      require('scrollbar').render()
    end,
  }
}

return M
