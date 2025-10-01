return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>fo',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat [O]pen buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        -- to find more formatters run :help conform-formatters
        lua = { 'stylua' },
        python = { 'ruff_format' },
        htmldjango = { 'djlint' },
        c = { 'clang-format' },
        jsonc = { 'fixjson' },
        json = { 'fixjson' },
        sh = { 'beautysh' },
        sql = { 'pg_format' }, -- requires manual installation as mason installation was cooked.
        markdown = { 'markdownlint' },
        php = { 'prettier', 'pretty-php' }, -- Make sure to manually change the parser for php files to html in the project config (b/c I don't know how to do that in the nvim config)
        html = { 'prettierd', 'prettier', stop_after_first = true },
        css = { 'prettierd', 'prettier', stop_after_first = true },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        tex = { 'tex-fmt' },
        -- Conform can also run multiple formatters sequentially
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
