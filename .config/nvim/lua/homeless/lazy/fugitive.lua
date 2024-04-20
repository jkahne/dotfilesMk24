return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "git", ":Git ")
        vim.keymap.set("n", "gb",  ":Git blame<CR>")
        vim.keymap.set("n", "gap", ":Git add -p<CR>")
    end
}
