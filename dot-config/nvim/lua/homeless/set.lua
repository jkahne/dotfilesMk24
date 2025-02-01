-- vim.opt.guicursor = ""

vim.opt.nu = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.shiftround = true

vim.opt.smartindent = false
vim.opt.completeopt = { "menuone", "noselect" }

vim.opt.breakindent = false
vim.opt.linebreak = false

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.shell = "zsh"

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hidden = true
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Set options for better performance and folding behavior
-- can't remember why or when this was added.
-- commenting out while adding noice
-- vim.opt.lazyredraw = true -- Minimize redraw operations while executing macros and other scripts
vim.opt.foldmethod = "indent" -- Use indentation levels to define folds
vim.opt.foldlevel = 10 -- Set the depth of opened folds (high number to keep most folds open)
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldcolumn = "1"

vim.opt.termguicolors = true

vim.opt.pumheight = 10
vim.opt.pumblend = 10

vim.opt.showmode = false
vim.opt.showtabline = 1

vim.opt.scrolloff = 4
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50
vim.opt.timeoutlen = 500

vim.opt.clipboard:append("unnamedplus")

vim.opt.showmatch = true

vim.opt.wildignorecase = true
vim.opt.wildignore:append("**/node_modules/*")
vim.opt.wildignore:append("**/.git/*")
vim.g.ruby_host_prog = vim.fn.expand("~/.asdf/shims/neovim-ruby-host")

vim.opt.fixendofline = false -- Prevent Nvim from removing end of file new line

-- Ensure I dont freak out by hitting the cap w when exiting
vim.cmd([[
  cnoreabbrev W! w!
  cnoreabbrev W1 w!
  cnoreabbrev w1 w!
  cnoreabbrev Q! q!
  cnoreabbrev Q1 q!
  cnoreabbrev q1 q!
  cnoreabbrev Qa! qa!
  cnoreabbrev Qall! qall!
  cnoreabbrev Wa wa
  cnoreabbrev Wq wq
  cnoreabbrev wQ wq
  cnoreabbrev WQ wq
  cnoreabbrev wq1 wq!
  cnoreabbrev Wq1 wq!
  cnoreabbrev wQ1 wq!
  cnoreabbrev WQ1 wq!
  cnoreabbrev W w
  cnoreabbrev Q q
  cnoreabbrev Qa qa
  cnoreabbrev Qall qall
]])

-- Enable autoread
vim.o.autoread = true

-- Create an autocommand in Lua to check for file changes
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	pattern = "*",
	callback = function()
		vim.cmd("checktime")
	end,
})

-- Key mapping using vim.keymap.set for better readability and functionality
vim.keymap.set("i", "<Tab>", function()
	return vim.fn.pumvisible() == 1 and "\\<C-n>" or "\\<Tab>"
end, { expr = true, noremap = true, silent = true })

-- Use Lua API to create autocommands for cursorline highlighting
vim.api.nvim_create_augroup("CursorLineHighlight", { clear = true })

vim.api.nvim_create_autocmd("WinEnter", {
	group = "CursorLineHighlight",
	pattern = "*",
	command = "set cursorline",
})

vim.api.nvim_create_autocmd("WinLeave", {
	group = "CursorLineHighlight",
	pattern = "*",
	command = "set nocursorline",
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highligh when yanking test",
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- :help highlight
		vim.api.nvim_set_hl(0, "Search", { bg = "#E5C07B", fg = "#455354", bold = true })
		vim.api.nvim_set_hl(0, "CurSearch", { bg = "#D19A66", fg = "#455354", bold = true })
		vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#0080FF", fg = "#FFFFFF" })
		vim.api.nvim_set_hl(0, "LineHighlight", { bg = "#56B6C2", fg = "#000000" })
		vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#D19A66", bold = true })
		vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#abb2bf" })
		vim.api.nvim_set_hl(0, "MatchParen", { fg = "#000000", bg = "#989797" })
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "dot-zshrc",
	command = "set filetype=zsh",
})
