local M = {
  "kevinhwang91/nvim-hlslens",
  keys = {
    {
      'n',
      "<cmd>lua require('hlslens').start()<cr>",
      desc = "",
      silent = true,
      remap = false,
    },
    {
      'N',
      "<cmd>lua require('hlslens').start()<cr>",
      desc = "",
      silent = true,
      remap = false,
    },
    {
      '*',
      "<cmd>lua require('hlslens').start()<cr>",
      desc = "",
      silent = true,
      remap = false,
    },
    {
      '#',
      "<cmd>lua require('hlslens').start()<CR>",
      desc = "",
      silent = true,
      remap = false,
    },
    {
      'g*',
      "<cmd>lua require('hlslens').start()<cr>",
      desc = "",
      silent = true,
      remap = false,
    },
    {
      'g#',
      "<cmd>lua require('hlslens').start()<cr>",
      desc = "",
      silent = true,
      remap = false,
    },
    {
      '<Leader>l',
      '<cmd>noh<cr>',
      desc = "",
      silent = true,
      remap = false,
    },
  },
  config = function()
    require("scrollbar.handlers.search").setup()
  end,
}

return M
