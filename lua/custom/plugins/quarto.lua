return {
  'quarto-dev/quarto-nvim',
  dependencies = {
    'jmbuhr/otter.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  ft = { 'quarto', 'markdown' },
  opts = {
    lspFeatures = {
      -- NOTE: put whatever languages you want here:
      enabled = true,
      languages = { 'r', 'python', 'rust', 'bash', 'html' },
      chunks = 'all',
      diagnostics = {
        enabled = true,
        triggers = { 'BufWritePost' },
      },
      completion = {
        enabled = true,
      },
    },
    codeRunner = {
      enabled = true,
      default_method = 'molten',
    },
  },
  config = function()
    local runner = require 'quarto.runner'
    vim.keymap.set('n', '<localleader>rc', runner.run_cell, { desc = 'Quarto: run cell', silent = true })
    vim.keymap.set('n', '<localleader>ra', runner.run_above, { desc = 'Quarto: run cell and above', silent = true })
    vim.keymap.set('n', '<localleader>rA', runner.run_all, { desc = 'Quarto: run all cells', silent = true })
    vim.keymap.set('n', '<localleader>rl', runner.run_line, { desc = 'Quarto: run line', silent = true })
    vim.keymap.set('v', '<localleader>r', runner.run_range, { desc = 'Quarto: run visual range', silent = true })
    vim.keymap.set('n', '<localleader>RA', function()
      runner.run_all(true)
    end, { desc = 'Quarto: run all cells of all languages', silent = true })
  end,
}
