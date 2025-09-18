return {
  'benlubas/molten-nvim',
  version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
  dependencies = { '3rd/image.nvim' },
  build = ':UpdateRemotePlugins',
  init = function()
    -- these are examples, not defaults. Please see the readme
    vim.g.molten_image_provider = 'image.nvim'
    vim.g.molten_output_win_max_height = 20
    vim.g.molten_wrap_output = true
    vim.g.molten_virt_text_output = true
    vim.g.molten_virt_lines_off_by_1 = true
  end,
  config = function()
    -- Pointer to the local neovim venv with molten python dependencies
    vim.g.python3_host_prog = vim.fn.expand '~/.virtualenvs/neovim/bin/python3'
    -- Recommended keymap to acces venv kernels
    vim.keymap.set('n', '<localleader>ip', function()
      local venv = os.getenv 'VIRTUAL_ENV' or os.getenv 'CONDA_PREFIX'
      if venv ~= nil then
        -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
        venv = string.match(venv, '/.+/(.+)')
        vim.cmd(('MoltenInit %s'):format(venv))
      else
        vim.cmd 'MoltenInit python3'
      end
    end, { desc = 'Molten: Initialize Molten for python3', silent = true })

    vim.keymap.set('n', '<localleader>mi', ':MoltenInit<CR>', { silent = true, desc = 'Molten: Initialize the plugin' })
    vim.keymap.set('n', '<localleader>e', ':MoltenEvaluateOperator<CR>', { silent = true, desc = 'Molten: run operator selection' })
    vim.keymap.set('n', '<localleader>rl', ':MoltenEvaluateLine<CR>', { silent = true, desc = 'Molten: evaluate line' })
    vim.keymap.set('n', '<localleader>rr', ':MoltenReevaluateCell<CR>', { silent = true, desc = 'Molten: re-evaluate cell' })
    vim.keymap.set('v', '<localleader>r', ':<C-u>MoltenEvaluateVisual<CR>gv', { silent = true, desc = 'Molten: evaluate visual selection' })
    vim.keymap.set('n', '<localleader>rd', ':MoltenDelete<CR>', { silent = true, desc = 'Molten: molten delete cell' })
    vim.keymap.set('n', '<localleader>oh', ':MoltenHideOutput<CR>', { silent = true, desc = 'Molten: hide output' })
    vim.keymap.set('n', '<localleader>os', ':noautocmd MoltenEnterOutput<CR>', { silent = true, desc = 'Molten: show/enter output' })
    vim.keymap.set('n', '<localleader>mx', ':MoltenOpenInBrowser<CR>', { desc = 'Molten: open output in browser', silent = true })
  end,
}
