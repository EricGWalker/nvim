return {
  'rest-nvim/rest.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, 'http')
      -- Enable Telescope rest extension
      require('telescope').load_extension 'rest'
      -- then use it, you can also use the `:Telescope rest select_env` command
      -- require('telescope').extensions.rest.select_env()
    end,
  },
}
