local M = {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    lsp_cfg = false,
  },
  config = function(_, opts)
    require("go").setup(opts)
  end,
  event = { "CmdlineEnter" },
  ft = { "go", 'gomod' },
  build = ':lua require("go.install").update_all_sync()'
}

return M
