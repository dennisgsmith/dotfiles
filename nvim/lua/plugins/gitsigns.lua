local function previous_hunk()
  require('gitsigns').nav_hunk 'prev'
end

local function next_hunk()
  require('gitsigns').nav_hunk 'next'
end

local function preview_hunk()
  require('gitsigns').preview_hunk()
end

local M = {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
      vim.keymap.set('n', '<leader>gp', previous_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
      vim.keymap.set('n', '<leader>gn', next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
      vim.keymap.set('n', '<leader>ph', preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
    end,
  },
  config = function()
    require('gitsigns').setup {}
    require('scrollbar.handlers.gitsigns').setup()
  end,
  dependencies = { 'petertriho/nvim-scrollbar', 'f-person/auto-dark-mode.nvim' },
}

return M
