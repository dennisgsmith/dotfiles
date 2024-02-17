local M = {
  'rmagatti/auto-session',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  lazy = false,
  priority = 2500,
  keys = {
    { "<leader>as", "<cmd>Autosession search<cr>", desc = "[A]utosession [S]earch" },
    { "<leader>ad", "<cmd>Autosession delete<cr>", desc = "[A]utosession [D]elete" },
    { "<leader>ss", "<cmd>SessionSave<cr>",        desc = "[S]ession [S]ave" },
  },
  opts = {
    log_level = 'info',
    auto_session_enable_last_session = false,
    auto_session_root_dir = vim.fn.stdpath('data') .. "/sessions/",
    auto_session_enabled = true,
    auto_save_enabled = nil,
    auto_restore_enabled = nil,
    auto_session_suppress_dirs = nil,
    auto_session_use_git_branch = nil,
    bypass_session_save_file_types = nil,
    cwd_change_handling = {
      restore_upcoming_session = true,
      pre_cwd_changed_hook = nil,
      post_cwd_changed_hook = function()
        require("lualine").refresh()
      end,
    },
    session_lens = {
      buftypes_to_ignore = {},
      load_on_setup = true,
      theme_conf = { border = true },
      previewer = true,
    },
    -- needed to set correct lualine theme ater session init
    post_restore_cmds = { require("lualine").setup },
  },
  config = function(_, opts)
    require("auto-session").setup(opts)
  end
}

return M
