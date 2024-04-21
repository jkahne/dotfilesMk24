return {
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "git", ":Git ")
      vim.keymap.set("n", "gb",  ":Git blame<CR>")
      vim.keymap.set("n", "gap", ":Git add -p<CR>")
    end
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lz", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    },

    config = function()
      require("lazy").setup()
    end
  },
}
