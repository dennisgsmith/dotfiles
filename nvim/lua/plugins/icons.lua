return {
  'echasnovski/mini.icons',
  version = '*',
  config = function(_, opts)
    local MiniIcons = require 'mini.icons'
    MiniIcons.setup(opts)
    MiniIcons.mock_nvim_web_devicons()
  end,
}
