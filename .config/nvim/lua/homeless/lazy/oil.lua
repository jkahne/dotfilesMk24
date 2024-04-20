return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config=function()
    require("oil").setup({
      keymaps = {
        ["<ESC>"] = "actions.close",
        ["q"] = "actions.close",
        ["?"] = "actions.show_help",
      },
    })
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end

}
