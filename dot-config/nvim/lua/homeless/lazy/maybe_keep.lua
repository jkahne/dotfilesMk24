return {

  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      require("mini.icons").setup()
    end,
  },

  -- {
  -- 	"akinsho/bufferline.nvim",
  -- 	dependencies = { "nvim-tree/nvim-web-devicons" },
  -- 	version = "*",
  -- 	opts = {
  -- 		options = {
  -- 			mode = "tabs",
  -- 			separator_style = "slant",
  -- 		},
  -- 	},
  -- },
}
