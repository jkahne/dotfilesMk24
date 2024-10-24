return {

  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      require("mini.icons").setup()
    end,
  },

  -- {
  --   "jinzhongjia/LspUI.nvim",
  --   branch = "main",
  --   config = function()
  --     require("LspUI").setup({
  --       virtual_text = true,
  --       diagnostics = true,
  --     })
  --   end,
  -- },
}
