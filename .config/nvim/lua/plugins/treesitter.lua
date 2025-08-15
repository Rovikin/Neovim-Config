return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects'
  },
  opts = {
    highlight = { enable = true },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
    },
    ensure_installed = { 'javascript', 'typescript', 'tsx', 'lua' },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
