require("homeless.set")
require("homeless.keymap")
require("homeless.lazy_init")

function HighlightCurrentLine()
  -- Retrieve the current line number
  local line_number = vim.fn.line('.')
  -- Add highlight to the current line
  vim.fn.matchadd('LineHighlight', '\\%'..line_number..'l')
end

vim.api.nvim_set_keymap('n', '<Leader>1', '<cmd>lua HighlightCurrentLine()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>2', '<cmd>lua vim.fn.clearmatches()<CR>', { noremap = true, silent = true })





local function auto_highlight_toggle()
  local auto_highlight_group = vim.api.nvim_create_augroup('auto_highlight', { clear = true })

  if vim.g.auto_highlight_active then
    vim.api.nvim_del_augroup_by_id(auto_highlight_group)
    vim.api.nvim_set_option('updatetime', 4000)
    vim.g.auto_highlight_active = false
    vim.fn.setreg('/', '')  -- Clear the search register
  else
    vim.api.nvim_create_autocmd('CursorHold', {
      group = auto_highlight_group,
      pattern = '*',
      callback = function()
        local cword = vim.fn.expand('<cword>')
        vim.fn.setreg('/', '\\V\\<' .. vim.fn.escape(cword, '\\') .. '\\>')
      end
    })
    vim.api.nvim_set_option('updatetime', 50)
    vim.g.auto_highlight_active = true
  end

  return vim.g.auto_highlight_active
end

vim.keymap.set('n', '<Leader>**', function()
    if auto_highlight_toggle() then
        vim.o.hlsearch = true
    end
end, { noremap = true, silent = true, desc = "Toggle auto highlight" })

