local M = {
  'rmagatti/auto-session',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  keys = {
    {
      "<C-s>",
      "<cmd>lua require('auto-session.session-lens').search_session<cr>",
      desc = "[s]earch session",
      remap = false,
    },
  },
  opts = {
    log_level = "error",
    cwd_change_handling = {
      post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
        require("lualine").refresh()     -- refresh lualine so the new session name is displayed in the status bar
      end,
    },
  },
  config = function(_, opts)
    require("auto-session").setup(opts)
  end
}

return M
