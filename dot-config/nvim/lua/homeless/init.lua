require("homeless.set")
require("homeless.keymap")
require("homeless.lazy_init")

vim.api.nvim_command('command! CopyFilePath let @+ = expand("%:p")')

function HighlightCurrentLine()
  -- Retrieve the current line number
  local line_number = vim.fn.line(".")
  -- Add highlight to the current line
  vim.fn.matchadd("LineHighlight", "\\%" .. line_number .. "l")
end

vim.api.nvim_set_keymap("n", "<Leader>1", "<cmd>lua HighlightCurrentLine()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>2", "<cmd>lua vim.fn.clearmatches()<CR>", { noremap = true, silent = true })

-- function OpenMarkdownPreview(url)
--   vim.cmd("silent ! chrome --new-window " .. url)
-- end

-- function OpenMarkdownPreview(url)
--   vim.cmd("silent ! open -a Google\\ Chrome -n --args --new-window a:" .. url)
-- end

vim.fn.OpenMarkdownPreview = function(url)
  -- vim.cmd("silent ! /Applications/Firefox.app/Contents/MacOS/firefox --new-window " .. url)
  vim.cmd("silent ! /Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome --new-window " .. url)
end
vim.g.mkdp_browserfunc = "OpenMarkdownPreview"

local function auto_highlight_toggle()
  local auto_highlight_group = vim.api.nvim_create_augroup("auto_highlight", { clear = true })

  if vim.g.auto_highlight_active then
    vim.api.nvim_del_augroup_by_id(auto_highlight_group)
    vim.api.nvim_set_option("updatetime", 4000)
    vim.g.auto_highlight_active = false
    vim.fn.setreg("/", "") -- Clear the search register
  else
    vim.api.nvim_create_autocmd("CursorHold", {
      group = auto_highlight_group,
      pattern = "*",
      callback = function()
        local cword = vim.fn.expand("<cword>")
        vim.fn.setreg("/", "\\V\\<" .. vim.fn.escape(cword, "\\") .. "\\>")
      end,
    })
    vim.api.nvim_set_option("updatetime", 50)
    vim.g.auto_highlight_active = true
  end

  return vim.g.auto_highlight_active
end

vim.keymap.set("n", "<Leader>**", function()
  if auto_highlight_toggle() then
    vim.o.hlsearch = true
  end
end, { noremap = true, silent = true, desc = "Toggle auto highlight" })

function OpenScratch()
  vim.cmd("enew")
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "hide"
  vim.bo.swapfile = false
end

vim.api.nvim_create_user_command("Scratch", OpenScratch, {})

function NewNote()
  vim.ui.input({ prompt = "Name: ", relative = "editor" }, function(name)
    vim.api.nvim_command(":e ~/Notes/" .. name .. ".md")
  end)
end

vim.keymap.set("n", "<leader>nn", ":lua NewNote()<CR>", { noremap = true, silent = true })
-- -- Check if RuboCop is installed
-- local rubocop_installed = vim.fn.executable("rubocop") == 1
--
-- -- Auto command to run RuboCop on save
-- if rubocop_installed then
-- 	vim.api.nvim_create_autocmd("BufWritePost", {
-- 		pattern = "*.rb", -- Match Ruby files
-- 		callback = function()
-- 			vim.cmd("silent !rubocop -A %")
-- 		end,
-- 		group = vim.api.nvim_create_augroup("RubocopOnSave", { clear = true }),
-- 	})
-- end
--
local function take_screenshot(name)
  -- Take the screenshot using pngpaste
  local screenshot_command = "pngpaste ./images/" .. name .. ".png"
  vim.fn.system(screenshot_command)

  -- Create the image tag
  local img_tag = '<img src="/images/' .. name .. '.png">'

  -- Insert the image tag at the current cursor position
  local row, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { img_tag })

  -- Display a confirmation message
  print("Screenshot saved and image tag inserted!")
end

-- Create a Vim command for the Lua function
vim.api.nvim_create_user_command("Screenshot", function(opts)
  take_screenshot(opts.args)
end, { nargs = 1 })
