function ColorMyPencils(color)

  color = color or "terafox"
  -- color = color or "happy_hacking"
  -- color = color or "hybrid_reverse"
  vim.cmd.colorscheme(color)
  -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {

  { "brenoprata10/nvim-highlight-colors",

    config=function()
      require('nvim-highlight-colors').setup {
        enable_named_colors = true,
        enable_tailwind = true
      }

    end
  },

  -- {
  --   "folke/tokyonight.nvim",
  --   config = function()
  --     require("tokyonight").setup({
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  --       transparent = true, -- Enable this to disable setting the background color
  --       terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  --       styles = {
  --         -- Style to be applied to different syntax groups
  --         -- Value is any valid attr-list value for `:help nvim_set_hl`
  --         comments = { italic = false },
  --         keywords = { italic = false },
  --         -- Background styles. Can be "dark", "transparent" or "normal"
  --         sidebars = "dark", -- style for sidebars, see below
  --         floats = "dark", -- style for floating windows
  --       },
  --     })
  --   end
  -- },
  --
  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   config = function()
  --     require('rose-pine').setup({
  --       disable_background = true,
  --       styles = {
  --         italic = false,
  --       },
  --     })
  --
  --   end
  -- },
  -- {
  --   "rafi/awesome-vim-colorschemes",
  --   config = function()
  --     ColorMyPencils()
  --   end
  -- },

  {
    "EdenEast/nightfox.nvim" ,
    config = function()
      require('nightfox').setup({
        -- disable_background = true,
      })
      ColorMyPencils()
    end
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      -- require("ibl").setup { indent = { highlight = highlight } }
      -- require("ibl").setup {  }
    end
  },
}
