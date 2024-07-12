return {
  'vimwiki/vimwiki',
  init = function()
    vim.cmd [[
      set nocompatible
      filetype plugin on
      syntax on
      let g:vimwiki_list = [{'path': '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Personal Vault/dnd-5e-srd', 'syntax': 'markdown', 'ext': '.md'}]

      set concealcursor=nc
      set formatoptions=l
      set lbr
    ]]
  end,
}
