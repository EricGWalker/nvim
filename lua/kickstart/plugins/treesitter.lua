return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    main = 'nvim-treesitter', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      -- Autoinstall languages that are not installed
      auto_install = true,
      -- Broken with nvim 12.0
      -- highlight = {
      --   enable = true,
      --   -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --   --  If you are experiencing weird indenting issues, add the language to
      --   --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      --   additional_vim_regex_highlighting = { 'ruby' },
      -- },
      -- indent = { enable = true, disable = { 'ruby' } },
      init = function()
        vim.api.nvim_create_autocmd('FileType', {
          callback = function()
            -- Enable treesitter highlighting and disable regex syntax
            pcall(vim.treesitter.start)
            -- Enable treesitter-based indentation
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end,
        })
        local ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
        local alreadyInstalled = require('nvim-treesitter.config').get_installed()
        local parsersToInstall = vim
          .iter(ensureInstalled)
          :filter(function(parser)
            return not vim.tbl_contains(alreadyInstalled, parser)
          end)
          :totable()
        require('nvim-treesitter').install(parsersToInstall)
      end,
    },
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      branch = 'main',
      opts = {
        move = {
          enable = true,
          set_jumps = false, -- you can change this if you want.
          goto_next_start = {
            --- ... other keymaps
            [']b'] = { query = '@code_cell.inner', desc = 'next code block' },
          },
          goto_previous_start = {
            --- ... other keymaps
            ['[b'] = { query = '@code_cell.inner', desc = 'previous code block' },
          },
        },
        select = {
          enable = true,
          lookahead = true, -- you can change this if you want
          keymaps = {
            --- ... other keymaps
            ['ib'] = { query = '@code_cell.inner', desc = 'in block' },
            ['ab'] = { query = '@code_cell.outer', desc = 'around block' },
          },
        },
        swap = { -- Swap only works with code blocks that are under the same
          -- markdown header
          enable = true,
          swap_next = {
            --- ... other keymap
            ['<leader>sbl'] = '@code_cell.outer',
          },
          swap_previous = {
            --- ... other keymap
            ['<leader>sbh'] = '@code_cell.outer',
          },
        },
      },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
}
-- vim: ts=2 sts=2 sw=2 et
