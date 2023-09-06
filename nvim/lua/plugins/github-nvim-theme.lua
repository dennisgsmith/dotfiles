local M = {
  'projekt0n/github-nvim-theme',
  lazy = false,      -- make sure we load this during startup if it is your main colorscheme
  priority = 1000,   -- make sure to load this before all the other start plugins
  config = function()
    require('github-theme').setup({
      options = {
        transparent = true,
        modules = {
          gitsigns = true,
        },
        specs = {
          all = {
            git = {
              changed = '#fff761',
            },
          },
        },
      },
    })
  end,
}

return M
