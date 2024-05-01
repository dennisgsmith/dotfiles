local M = {
  'nvim-tree/nvim-web-devicons',
  dependencies = { 'mskelton/termicons.nvim' },
  config = function()
    require('termicons').setup()
  end,
  opts = {
    filters = {
      git_ignored = false,
    },
  },
}

return M
