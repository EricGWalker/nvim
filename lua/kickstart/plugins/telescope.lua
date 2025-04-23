-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'debugloop/telescope-undo.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          ['undo'] = {
            -- These are the defaults copy pasted
            -- https://github.com/debugloop/telescope-undo.nvim
            use_delta = true,
            use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
            side_by_side = false,
            vim_diff_opts = {
              ctxlen = vim.o.scrolloff,
            },
            entry_format = 'state #$ID, $STAT, $TIME',
            time_format = '',
            saved_only = false,
            mappings = {
              i = {
                ['<cr>'] = require('telescope-undo.actions').yank_additions,
                ['<S-cr>'] = require('telescope-undo.actions').yank_deletions,
                ['<C-cr>'] = require('telescope-undo.actions').restore,
                -- alternative defaults, for users whose terminals do questionable things with modified <cr>
                ['<C-y>'] = require('telescope-undo.actions').yank_deletions,
                ['<C-r>'] = require('telescope-undo.actions').restore,
              },
              n = {
                ['y'] = require('telescope-undo.actions').yank_additions,
                ['Y'] = require('telescope-undo.actions').yank_deletions,
                ['u'] = require('telescope-undo.actions').restore,
              },
            },
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'undo')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      local extensions = require('telescope').extensions

      local function telescope_keymap(entry)
        local mode = entry.mode or entry[1]
        local lhs = entry.lhs or entry[2]
        local rhs = entry.rhs or entry[3]
        local opts = entry.opts or entry[4] or {}
        local desc = entry.desc
        if not entry.opts and desc then
          opts = {
            desc = 'Telescope: ' .. desc,
          }
        end
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      telescope_keymap { 'n', [[<leader>fd]], builtin.diagnostics, ['desc'] = '[F]ind [D]iagnostics' }
      telescope_keymap { 'n', [[<leader>fr]], builtin.resume, ['desc'] = '[F]ind [R]esume' }
      telescope_keymap { 'n', [[<leader>f.]], builtin.oldfiles, ['desc'] = '[F]ind Recent Files ("." for repeat' }
      telescope_keymap { 'n', [[<leader>fw]], builtin.grep_string, ['desc'] = '[F]ind current [W]ord' }
      telescope_keymap { 'n', [[<leader>ff]], builtin.find_files, ['desc'] = '[F]ind [Files]' }
      telescope_keymap { 'n', [[<leader>fd]], builtin.fd, ['desc'] = '[F][D] Search' }
      telescope_keymap { 'n', [[<leader>fg]], builtin.live_grep, ['desc'] = '[F]ind [G]rep' }
      telescope_keymap { 'n', [[<leader>fi]], builtin.current_buffer_fuzzy_find, ['desc'] = '[F]ind [I]n Buffer' }
      telescope_keymap { 'n', [[<leader>ft]], builtin.builtin, ['desc'] = '[F]ind [T]elescope Tags' }
      telescope_keymap { 'n', [[<leader>fk]], builtin.keymaps, ['desc'] = '[F]ind [K]eymaps' }
      telescope_keymap { 'n', [[<leader>fh]], builtin.help_tags, ['desc'] = '[F]ind [H]elp' }
      telescope_keymap { 'n', [[<leader>u]], extensions.undo.undo, ['desc'] = '[_][U]ndo' }
      telescope_keymap { 'n', [[<leader><leader>]], builtin.buffers, ['desc'] = '[_]Find Buffers' }

      -- Shortcut for searching your Neovim configuration files
      telescope_keymap {
        mode = 'n',
        lhs = '<leader>fn',
        rhs = function()
          builtin.find_files { cwd = vim.fn.stdpath 'config' }
        end,
        desc = '[F]ind [N]eovim files',
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
