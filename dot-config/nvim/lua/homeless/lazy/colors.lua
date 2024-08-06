return{
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require('nightfox').setup({
        -- disable_background = true,
      })
      vim.cmd.colorscheme("terafox")
    end
  },


}
