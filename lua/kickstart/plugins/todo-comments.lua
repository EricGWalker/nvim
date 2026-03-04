-- Highlight todo, notes, etc in comments
-- PERF: perf example
-- HACK: hack example
-- TODO: todo example
-- NOTE: note example
-- FIX: fix example
-- WARNING: warning example
-- TEST: test example
return {
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
}
-- vim: ts=2 sts=2 sw=2 et
