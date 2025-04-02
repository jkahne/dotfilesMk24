vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
vim.keymap.set("i", "<Leader>,", "<Esc>", { noremap = true })
vim.keymap.set("v", "<Leader>,", "<Esc>", { noremap = true })
vim.keymap.set("i", "jj", "<Esc>", { noremap = true })
vim.keymap.set("i", "kk", "<Esc>", { noremap = true })
vim.keymap.set("i", "jkk", "<Esc>", { noremap = true })
-- vim.keymap.set('i', ',,', '<Esc>', { noremap = true })
-- vim.keymap.set('v', ',,', '<Esc>', { noremap = true })

vim.keymap.set("n", "go", "o<Esc>", { noremap = false })
vim.keymap.set("n", "gO", "O<Esc>", { noremap = false })
vim.keymap.set("n", "gp", "`[v`]", { noremap = true })

vim.keymap.set({ "n", "v", "o" }, "j", "gj", { noremap = false })
vim.keymap.set({ "n", "v", "o" }, "k", "gk", { noremap = false })

vim.keymap.set("n", "n", "nzzzv", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })

vim.keymap.set("x", "p", "pgvy", { noremap = true })

vim.keymap.set("n", "Q", "q", { noremap = false })

vim.keymap.set("n", "Y", "y$", { noremap = true })

vim.keymap.set("n", "<S-Tab>", "za", { noremap = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })

vim.keymap.set("n", "<C-H>", "<C-W>h", { noremap = false })
vim.keymap.set("n", "<C-J>", "<C-W>j", { noremap = false })
vim.keymap.set("n", "<C-K>", "<C-W>k", { noremap = false })
vim.keymap.set("n", "<C-L>", "<C-W>l", { noremap = false })

vim.keymap.set("n", "*", "*N", { noremap = true, silent = true })

-- vim.api.nvim_set_keymap( "n", "<C-k>", 'pumvisible() ? "<C-p>" : "<C-k>"', { noremap = true, expr = true, silent = true })
-- vim.api.nvim_set_keymap( "n", "<C-j>", 'pumvisible() ? "<C-n>" : "<C-j>"', { noremap = true, expr = true, silent = true })
-- vim.api.nvim_set_keymap( "n", "<C-m>", 'pumvisible() ? "<C-p>" : "<C-m>"', { noremap = true, expr = true, silent = true })

-- vim.api.nvim_set_keymap("i", "<C-k>", 'pumvisible() ? "<C-p>" : "<Up>"', { noremap = true, expr = true, silent = true })
-- vim.api.nvim_set_keymap( "i", "<C-j>", 'pumvisible() ? "<C-n>" : "<Down>"', { noremap = true, expr = true, silent = true })
-- vim.api.nvim_set_keymap( "i", "<C-m>", 'pumvisible() ? "<C-p>" : "<C-m>"', { noremap = true, expr = true, silent = true })

-- vim.api.nvim_set_keymap('i', '<C-n>', 'pumvisible() ? "<C-n>" : "<C-n>"', { noremap = true, expr = true, silent = true })

vim.keymap.set("n", "<C-b>", "<cmd>bprev<CR>zz")
vim.keymap.set("n", "<C-f>", "<cmd>bnext<CR>zz")
-- Close the current buffer and move to the previous one
vim.keymap.set("n", "<leader>bd", ":bp <bar> bd #<CR>", { noremap = true, silent = true })
-- Close all buffers except the current one
vim.keymap.set("n", "<leader>bo", ":up <bar> %bd <bar> e#<CR>", { noremap = true, silent = true })
-- Switch between current and last buffer
vim.keymap.set("n", "<Leader>c", "<C-^><CR>", { noremap = false, silent = true })

vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true })
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true })

-- I don't like this
vim.api.nvim_set_keymap("i", "<leader>j", "<Plug>(snippy-next)", { silent = true })
vim.api.nvim_set_keymap("i", "<leader>k", "<Plug>(snippy-previous)", { silent = true })

-- Mappings for =>, <%= %>, and #{}
vim.keymap.set("i", "<C-Enter>", " => ", { noremap = true })
vim.keymap.set("i", "<C-;>", "- [ ] ", { noremap = true })
vim.keymap.set("n", "<C-;>", "0i- [ ] ", { noremap = true })
vim.keymap.set("n", "<leader>8", "i<%=  %><Left><Left><Left>", { noremap = true, silent = true })
vim.keymap.set("i", "<leader>8", "<%=  %><Left><Left><Left>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>9", "i<% end %>", { noremap = true, silent = true })
vim.keymap.set("i", "<leader>9", "<% end %>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>7", "i#{  }<Left><Left>")
vim.keymap.set("i", "<leader>7", "#{  }<Left><Left>")

vim.keymap.set("n", "<C-.>", "i#{  }<Left><Left>")
vim.keymap.set("i", "<C-.>", "#{  }<Left><Left>")
-- vim.keymap.set("n", "<leader>4", "i${  }<Left><Left>")
-- vim.keymap.set("i", "<leader>4", "${  }<Left><Left>")
-- vim.keymap.set("n", "<leader>5", "i%{  }<Left><Left>")
-- vim.keymap.set("i", "<leader>5", "%{  }<Left><Left>")

-- undo break points
vim.keymap.set("i", ",", ",<C-g>u", { noremap = true })
vim.keymap.set("i", ".", ".<C-g>u", { noremap = true })
vim.keymap.set("i", "!", "!<C-g>u", { noremap = true })
vim.keymap.set("i", "?", "?<C-g>u", { noremap = true })

-- Toggle cursor crosshair
vim.keymap.set("n", "+", function()
  -- vim.opt.cursorline = not vim.opt.cursorline
  -- vim.opt.cursorcolumn = not vim.opt.cursorcolumn
  -- Halp! i can't even Lua properly
  vim.cmd([[
  set cursorline!
  set cursorcolumn!
  ]])
end, { desc = "[+] Show cursor line and column" })

-- "" Bubbling Text
-- " Bubble single lines
vim.keymap.set("n", "<C-Up>", "ddkP")
vim.keymap.set("n", "<C-Down>", "ddp")
-- " Bubble multiple lines
vim.keymap.set("v", "<C-Up>", "xkP`[V`]=gv")
vim.keymap.set("v", "<C-Down>", "xp`[V`]=gv")

vim.keymap.set("n", "gV", "`[v`]")

-- " <F12> " Invisible characters and colors
vim.keymap.set("n", "<F12>", ":set list!<CR>")
vim.keymap.set("v", "<F12>", "<ESC>:set list!<CR>gv")
vim.keymap.set("i", "<F12>", "<ESC>:set list!<CR>i")

-- Search and replace shortcuts
vim.keymap.set("n", "<Leader>rr", ":%s//g<Left><Left>", { noremap = true })
-- vim.keymap.set('n', '<Leader>rw', function()
--   vim.cmd('%s/' .. vim.fn.expand('<cword>') .. '//g<Left><Left>')
-- end, { noremap = true })

-- Toggle text wrapping
vim.api.nvim_set_keymap("n", "<leader>fw", ":lua WrapPencil()<CR>", { noremap = true, silent = true })

-- Clear search highlighting with a leader key
vim.keymap.set("n", "<Leader><space>", ":noh<CR>", { noremap = true })

vim.keymap.set({ "n", "v", "o" }, "<S-h>", "^", { noremap = false })
vim.keymap.set({ "n", "v", "o" }, "<S-l>", "g_", { noremap = false })
vim.keymap.set({ "n", "v", "o" }, "gh", "^", { noremap = false })
vim.keymap.set({ "n", "v", "o" }, "gl", "g_", { noremap = false })

-- Move lines up and down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "[P]Move line down in visual mode" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "[P]Move line up in visual mode" })

-- Scratch and Vim notes with leader key for quick access
vim.keymap.set(
  "n",
  "<Leader>sn",
  ":tab drop " .. vim.fn.expand("$HOME") .. "/projects/worknotes/00\\ Inbox/scratch.md<CR>",
  { noremap = true }
)
vim.keymap.set(
  "n",
  "<Leader>vn",
  ":tab drop " .. vim.fn.expand("$HOME") .. "/projects/worknotes/00\\ Inbox/vimnotes.md<CR>",
  { noremap = true }
)

vim.keymap.set({ "n", "v" }, "<space>", "<Nop>", { silent = true })

vim.api.nvim_create_user_command("W", function()
  vim.cmd("w !sudo tee % > /dev/null")
  vim.cmd("edit!")
end, {})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "elixir",
  callback = function()
    vim.keymap.set("n", "<leader>dr", ":!mix format<CR>", { noremap = true, silent = true, buffer = true })
  end,
  group = vim.api.nvim_create_augroup("ElixirSettings", { clear = true }),
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function()
    -- vim.keymap.set('n', '<leader>dr', ':!bundle exec standardrb --fix<CR><CR>', { noremap = true, silent = true, buffer = true })
    -- vim.keymap.set('n', '<leader>dc', ':!bin/ci<CR><CR>', { noremap = true, silent = true, buffer = true })
    vim.keymap.set("n", "<leader>dr", function()
      local current_file = vim.fn.expand("%:p")
      vim.cmd("!rubocop -a " .. current_file)
    end, { noremap = true, silent = true, buffer = true })
  end,
  group = vim.api.nvim_create_augroup("RubySettings", { clear = true }),
})

-- Set indentation settings specifically for Lua files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
  end,
})

-- -- Check if RuboCop is installed
-- local rubocop_installed = vim.fn.executable("rubocop") == 1
-- -- Auto command to run RuboCop on save
-- if rubocop_installed then
--   vim.api.nvim_create_autocmd("BufWritePost", {
--     pattern = "*.rb", -- Match Ruby files
--     callback = function()
--       vim.cmd("silent !rubocop --auto-correct-all %")
--       vim.cmd("edit") -- Reload the file after RuboCop modifies it
--     end,
--     group = vim.api.nvim_create_augroup("RubocopOnSave", { clear = true }),
--   })
-- end

-- vim.api.nvim_set_keymap('i', '<C-y>', '<C-y>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('c', '<C-y>', '<C-y>', { noremap = true, silent = true })

function WrapPencil()
  if vim.o.wrap then
    vim.cmd("set nowrap")
  else
    vim.cmd("set wrap")
    -- vim.cmd('PencilSoft')
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
    vim.cmd("close!")
  else
    vim.cmd("close!")
    vim.cmd("tabprev")
  end

  -- Split the window and load the buffer
  vim.cmd("split")
  vim.cmd("buffer " .. bufferName)
end

-- Mapping the function to a key or calling it in Lua
-- For example, to call this function you can bind it to a key:
vim.api.nvim_set_keymap("n", "<C-w>u", ":lua MergeTabs()<CR>", { noremap = true, silent = true })
-- Tab navigation and management with leader key
vim.keymap.set("n", "<Leader>>", ":tabnext<CR>", { noremap = false })
vim.keymap.set("n", "<Leader><", ":tabprevious<CR>", { noremap = false })
vim.keymap.set("n", "<Leader>T", ":tabnew<CR>", { noremap = false })

-- vim.keymap.set('i', "'", "''<left>", { noremap = true })
-- vim.keymap.set('i', '"', '""<left>', { noremap = true })
-- vim.keymap.set('i', "(", "()<left>", { noremap = true })
-- vim.keymap.set('i', "[", "[]<left>", { noremap = true })
-- vim.keymap.set('i', "{", "{}<left>", { noremap = true })

-- vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "gb", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
