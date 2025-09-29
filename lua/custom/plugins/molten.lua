return {
  -- {
  --   'benlubas/molten-nvim',
  --   version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
  --   dependencies = { '3rd/image.nvim' },
  --   build = ':UpdateRemotePlugins',
  --   keys = { 'markdown' },
  --   init = function()
  --     -- these are examples, not defaults. Please see the readme
  --     vim.g.molten_image_provider = 'image.nvim'
  --     vim.g.molten_output_win_max_height = 20
  --     vim.g.molten_wrap_output = true
  --     vim.g.molten_virt_text_output = true
  --     vim.g.molten_virt_lines_off_by_1 = true
  --     vim.g.molten_auto_open_output = false
  --
  --     -- Keybinds
  --     vim.keymap.set('n', '<leader>e', ':MoltenEvaluateOperator<CR>', { desc = 'Molten: evaluate operator', silent = true })
  --     vim.keymap.set('n', '<leader>os', ':noautocmd MoltenEnterOutput<CR>', { desc = 'Molten: open output window', silent = true })
  --     vim.keymap.set('n', '<leader>rr', ':MoltenReevaluateCell<CR>', { desc = 'Molten: re-eval cell', silent = true })
  --     vim.keymap.set('v', '<leader>r', ':<C-u>MoltenEvaluateVisual<CR>gv', { desc = 'Molten: execute visual selection', silent = true })
  --     vim.keymap.set('n', '<leader>oh', ':MoltenHideOutput<CR>', { desc = 'Molten: close output window', silent = true })
  --     vim.keymap.set('n', '<leader>md', ':MoltenDelete<CR>', { desc = 'Molten: delete Molten cell', silent = true })
  --
  --     -- if you work with html outputs:
  --     vim.keymap.set('n', '<leader>mx', ':MoltenOpenInBrowser<CR>', { desc = 'Molten: open output in browser', silent = true })
  --
  --     vim.keymap.set('n', '<leader>ip', function()
  --       local venv = os.getenv 'VIRTUAL_ENV' or os.getenv 'CONDA_PREFIX'
  --       if venv ~= nil then
  --         -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
  --         venv = string.match(venv, '/.+/(.+)')
  --         vim.cmd(('MoltenInit %s'):format(venv))
  --       else
  --         vim.cmd 'MoltenInit python3'
  --       end
  --     end, { desc = 'Molten: Initialize Molten for python3', silent = true })
  --   end,
  -- },
  {
    'quarto-dev/quarto-nvim',
    dependencies = {
      'jmbuhr/otter.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    ft = { 'quarto', 'markdown' },
    opts = {
      lspFeatures = {
        -- NOTE: put whatever languages you want here:
        languages = { 'r', 'python', 'rust' },
        chunks = 'all',
        diagnostics = {
          enabled = true,
          triggers = { 'BufWritePost' },
        },
        completion = {
          enabled = true,
        },
      },
      -- codeRunner = {
      --   enabled = true,
      --   default_method = 'molten',
      -- },
    },
    -- config = function()
    --   local runner = require 'quarto.runner'
    --   vim.keymap.set('n', '<localleader>rc', runner.run_cell, { desc = 'Quarto: run cell', silent = true })
    --   vim.keymap.set('n', '<localleader>ra', runner.run_above, { desc = 'Quarto: run cell and above', silent = true })
    --   vim.keymap.set('n', '<localleader>rA', runner.run_all, { desc = 'Quarto: run all cells', silent = true })
    --   vim.keymap.set('n', '<localleader>rl', runner.run_line, { desc = 'Quarto: run line', silent = true })
    --   vim.keymap.set('v', '<localleader>r', runner.run_range, { desc = 'Quarto: run visual range', silent = true })
    --   vim.keymap.set('n', '<localleader>RA', function()
    --     runner.run_all(true)
    --   end, { desc = 'Quarto: run all cells of all languages', silent = true })
    -- end,
  },
  {
    'GCBallesteros/jupytext.nvim',
    config = true,
    opts = {
      style = 'markdown',
      output_extension = 'md',
      force_ft = 'markdown',
    },
  },
  {
    'jmbuhr/otter.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
  },
}
