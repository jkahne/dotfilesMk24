vim.g.mapleader = ","
vim.keymap.set('i', '<Leader>,', '<Esc>', { noremap = true })
vim.keymap.set('v', '<Leader>,', '<Esc>', { noremap = true })
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true })
vim.keymap.set('i', 'kk', '<Esc>', { noremap = true })
-- vim.keymap.set('i', ',,', '<Esc>', { noremap = true })
-- vim.keymap.set('v', ',,', '<Esc>', { noremap = true })

vim.keymap.set('n', 'go', 'o<Esc>', { noremap = false })
vim.keymap.set('n', 'gO', 'O<Esc>', { noremap = false })
vim.keymap.set('n', 'gp', '`[v`]', { noremap = true })

vim.keymap.set({'n', 'v', 'o'}, 'j', 'gj', { noremap = false })
vim.keymap.set({'n', 'v', 'o'}, 'k', 'gk', { noremap = false })

vim.keymap.set('n', 'n', 'nzzzv', { noremap = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true })

vim.keymap.set('x', 'p', 'pgvy', { noremap = true })

vim.keymap.set('n', 'Q', 'q', { noremap = false })

vim.keymap.set('n', 'Y', 'y$', { noremap = true })

vim.keymap.set('n', '<S-Tab>', 'za', { noremap = true })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true })

vim.keymap.set('n', '<C-H>', '<C-W>h', { noremap = false })
vim.keymap.set('n', '<C-J>', '<C-W>j', { noremap = false })
vim.keymap.set('n', '<C-K>', '<C-W>k', { noremap = false })
vim.keymap.set('n', '<C-L>', '<C-W>l', { noremap = false })

vim.keymap.set("n", "<C-b>", "<cmd>bprev<CR>zz")
vim.keymap.set("n", "<C-f>", "<cmd>bnext<CR>zz")

vim.keymap.set('i', '<C-h>', '<Left>', { noremap = true })
vim.keymap.set('i', '<C-j>', '<Down>', { noremap = true })
vim.keymap.set('i', '<C-k>', '<Up>', { noremap = true })
vim.keymap.set('i', '<C-l>', '<Right>', { noremap = true })

vim.api.nvim_set_keymap('i', '<leader>j', '<Plug>(snippy-next)', {silent = true})
vim.api.nvim_set_keymap('i', '<leader>k', '<Plug>(snippy-previous)', {silent = true})

-- Mappings for =>, <%= %>, and #{}
vim.keymap.set('i', '<C-Enter>', ' => ', { noremap = true })
vim.keymap.set('i', '<C-;>', '- [ ] ', { noremap = true })
vim.keymap.set('n', "<C-,>", 'i<%=  %><Left><Left><Left>')
vim.keymap.set('i', "<C-,>", '<%=  %><Left><Left><Left>')
vim.keymap.set('n', "<C-.>", 'i#{  }<Left><Left>')
vim.keymap.set('i', "<C-.>", '#{  }<Left><Left>')
vim.keymap.set('n', "<leader>3", 'i#{  }<Left><Left>')
vim.keymap.set('i', "<leader>3", '#{  }<Left><Left>')
vim.keymap.set('n', "<leader>4", 'i${  }<Left><Left>')
vim.keymap.set('i', "<leader>4", '${  }<Left><Left>')
vim.keymap.set('n', "<leader>5", 'i%{  }<Left><Left>')
vim.keymap.set('i', "<leader>5", '%{  }<Left><Left>')

-- undo break points
vim.keymap.set('i', ',', ',<C-g>u', { noremap = true })
vim.keymap.set('i', '.', '.<C-g>u', { noremap = true })
vim.keymap.set('i', '!', '!<C-g>u', { noremap = true })
vim.keymap.set('i', '?', '?<C-g>u', { noremap = true })


-- Search and replace shortcuts
vim.keymap.set('n', '<Leader>rr', ':%s//g<Left><Left>', { noremap = true })
vim.keymap.set('n', '<Leader>rw', function()
    vim.cmd('%s/' .. vim.fn.expand('<cword>') .. '//g<Left><Left>')
end, { noremap = true })

-- Toggle text wrapping
vim.api.nvim_set_keymap('n', '<leader>w', ':lua WrapPencil()<CR>', {noremap = true, silent = true})


-- Clear search highlighting with a leader key
vim.keymap.set('n', '<Leader><space>', ':noh<CR>', { noremap = true })

-- Map '0' to go to the first non-blank character of the line
vim.keymap.set({'n', 'v', 'o'}, '0', '^', { noremap = false })

-- Scratch and Vim notes with leader key for quick access
vim.keymap.set('n', '<Leader>sn', ':tab drop /Users/jkahne/Library/Mobile\\ Documents/iCloud~md~obsidian/Documents/Brain/*99\\ Meta/scratch.md<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>vn', ':tab drop /Users/jkahne/Library/Mobile\\ Documents/iCloud~md~obsidian/Documents/Brain/*99\\ Meta/vimnotes.md<CR>', { noremap = true })

vim.keymap.set({ 'n', 'v' }, '<space>', '<Nop>', { silent = true })

vim.api.nvim_create_user_command(
  'W',
  function()
    vim.cmd('w !sudo tee % > /dev/null')
    vim.cmd('edit!')
  end,
  {}
)

vim.api.nvim_create_autocmd("FileType", {
    pattern = "elixir",
    callback = function()
        vim.keymap.set('n', '<leader>dr', ':!mix format<CR>', { noremap = true, silent = true, buffer = true })
    end,
    group = vim.api.nvim_create_augroup("ElixirSettings", { clear = true })
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "ruby",
    callback = function()
        vim.keymap.set('n', '<leader>dr', ':!bundle exec standardrb --fix<CR><CR>', { noremap = true, silent = true, buffer = true })
        -- vim.keymap.set('n', '<leader>dc', ':!bin/ci<CR><CR>', { noremap = true, silent = true, buffer = true })
    end,
    group = vim.api.nvim_create_augroup("RubySettings", { clear = true })
})

-- vim.api.nvim_set_keymap('i', '<C-y>', '<C-y>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('c', '<C-y>', '<C-y>', { noremap = true, silent = true })

-- Close the current buffer and move to the previous one
vim.keymap.set('n', '<leader>bd', ':bp <bar> bd #<CR>', { noremap = true, silent = true })
-- Close all buffers except the current one
vim.keymap.set('n', '<leader>bo', ':up <bar> %bd <bar> e#<CR>', { noremap = true, silent = true })
-- Switch between current and last buffer
vim.keymap.set('n', '<Leader>c', '<C-^><CR>', { noremap = false, silent = true })


function WrapPencil()
  if vim.o.wrap then
    vim.cmd('set nowrap')
  else
    vim.cmd('set wrap')
    vim.cmd('PencilSoft')
  end
end

-- Lua function to merge tabs in Neovim
function MergeTabs()
    -- Check if only one tab is open
    if vim.fn.tabpagenr() == 1 then
        return
    end

    -- Get the current buffer name
    local bufferName = vim.fn.bufname("%")

    -- Check if it's the last tab page, then close it and switch to the previous one
    if vim.fn.tabpagenr("$") == vim.fn.tabpagenr() then
        vim.cmd('close!')
    else
        vim.cmd('close!')
        vim.cmd('tabprev')
    end

    -- Split the window and load the buffer
    vim.cmd('split')
    vim.cmd('buffer ' .. bufferName)
end

-- Mapping the function to a key or calling it in Lua
-- For example, to call this function you can bind it to a key:
vim.api.nvim_set_keymap('n', '<C-w>u', ':lua MergeTabs()<CR>', {noremap = true, silent = true})
-- Tab navigation and management with leader key
vim.keymap.set('n', '<Leader>>', ':tabnext<CR>', { noremap = false })
vim.keymap.set('n', '<Leader><', ':tabprevious<CR>', { noremap = false })
vim.keymap.set('n', '<Leader>T', ':tabnew<CR>', { noremap = false })



