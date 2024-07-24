return {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
        -- Old text                    Command         New text
        -- surr*ound_words             ysiw)           (surround_words)
        -- *make strings               ys$"            "make strings"
        -- [delete ar*ound me!]        ds]             delete around me!
        -- remove <b>HTML t*ags</b>    dst             remove HTML tags
        -- 'change quot*es'            cs'"            "change quotes"
        -- <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
        -- delete(functi*on calls)     dsf             function calls
      })
    end
  },

   {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    lazy = false,
    enabled = true,
    config = function ()
      require("hardtime").setup({
        disable_mouse = false,
        disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil", "grug-far", "dbui", "Trouble", "trouble" },
      })
    end
  },

  -- {
  --   'MagicDuck/grug-far.nvim',
  --   event = 'VeryLazy',
  --   keys = {
  --     {
  --       "<leader>sr",
  --       "<cmd>lua require('grug-far').toggle_instance({ instanceName='far', staticTitle='Search and Replace' })<CR>",
  --       mode = { "n", "o", "x" },
  --     },
  --     {
  --       "<leader>srw",
  --       "<cmd>lua require('grug-far').grug_far({ prefills = { search = vim.fn.expand('<cword>') } })<CR>",
  --       mode = { "n", "o", "x" },
  --     },
  --     -- I use nvim-rip-substitute for file search and replace
  --     -- {
  --     --   "<leader>srf",
  --     --   "<cmd>lua require('grug-far').grug_far({ prefills = { flags = vim.fn.expand('%') } })<CR>",
  --     --   mode = { "n", "o", "x" },
  --     -- },
  --   },
  --   config = function()
  --     require('grug-far').setup({
  --       -- startInInsertMode = false,
  --     });
  --   end
  -- },

  {
    "nvim-tree/nvim-web-devicons",
    name = "nvim-web-devicons",
    config = function()
      require('nvim-web-devicons').setup({})
    end
  },
  {
    "nvim-lua/plenary.nvim",
    name = "plenary"
  },
  -- filename
  -- {
  --   "b0o/incline.nvim",
  --   dependencies = {},
  --   event = "BufReadPre",
  --   priority = 1200,
  --   config = function()
  --     local helpers = require("incline.helpers")
  --     require("incline").setup({
  --       window = {
  --         padding = 0,
  --         margin = { horizontal = 0 },
  --       },
  --       render = function(props)
  --         local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
  --         local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
  --         local modified = vim.bo[props.buf].modified
  --         local buffer = {
  --           ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
  --           or "",
  --           " ",
  --           { filename, gui = modified and "bold,italic" or "bold" },
  --           " ",
  --           -- guibg = "#6699aa",
  --           guibg = "#FFFC1F",
  --           guifg = "#000000",
  --         }
  --         return buffer
  --       end,
  --     })
  --   end,
  -- },

  { 'tpope/vim-abolish'
    -- fooBar => foo_bar  :  crs (coerce to snake_case)
    -- MixedCase (crm),
    -- camelCase (crc),
    -- UPPER_CASE (cru),
    -- dash-case (cr-),
    -- dot.case (cr.)
  },

  -- { 'tpope/vim-endwise' },
  { 'kshenoy/vim-signature' },
  { 'rizzatti/dash.vim' },
  {
    'mhinz/vim-signify',
    init = function()
      vim.g.signify_update_on_bufenter = 1
      vim.g.signify_update_on_focusgained = 1
    end
  },
  {
    'junegunn/vim-easy-align',
    config = function()
      vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)', { noremap = false, silent = true })
      vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)', { noremap = false, silent = true })
    end
  },
  { 'mg979/vim-visual-multi', },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require("nvim-ts-autotag").setup({
        {
          opts = {
            -- Defaults
            enable_close = true,         -- Auto close tags
            enable_rename = true,        -- Auto rename pairs of tags
            enable_close_on_slash = true -- Auto close on trailing </
          },
          -- Also override individual filetype configs, these take priority.
          -- Empty by default, useful if one of the "opts" global settings
          -- doesn't work well in a specific filetype
          -- per_filetype = {
          --   ["html"] = {
          --     enable_close = false
          --   }
          -- }
        }
      })
    end
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    -- @type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
    config = function()
      require("flash").setup({
        modes = {
          char = {
            enabled = false
          }
        }
      })
    end
  },

  {
    "azabiong/vim-highlighter",
    init = function()
      vim.cmd([[
        let HiSet   = 'f<CR>'
        let HiErase = 'f<BS>'
        let HiClear = 'f<C-L>'
        let HiFind  = 'f<Tab>'
        " let HiSetSL = 't<CR>'
        ]])

      -- vim.keymap.set("n", "g<cr>", "<cmd>Hi><CR>")
      -- vim.keymap.set("n", "gb<cr>", "<cmd>Hi<<CR>")
      -- nn <CR>   <Cmd>Hi><CR>
      -- nn g<CR>  <Cmd>Hi<<CR>
      -- nn ]<CR>  <Cmd>Hi}<CR>
      -- nn [<CR>  <Cmd>Hi{<CR>
    end
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("aerial").setup({
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
      })
      -- You probably also want to set a keymap to toggle aerial
      vim.keymap.set('n', '<leader>aa', '<cmd>AerialToggle!<CR>')
    end
  },
  -- consider using https://github.com/klen/nvim-test instead
  -- looks like you can configure to append docker commands to the test commands (see comments below 🤝)
  {
    "vim-test/vim-test",
    config = function()
      -- vim.g['test#strategy'] = 'basic'
      -- vim.g['test#strategy'] = 'neovim_sticky'

      vim.keymap.set('n', '<Leader>sa', ':TestSuite<CR>', { noremap = true, silent = true, desc = "Run Test Suite" })
      vim.keymap.set('n', '<Leader>sf', ':TestFile<CR>', { noremap = true, silent = true, desc = "Run Test File" })
      vim.keymap.set('n', '<Leader>ss', ':TestNearest<CR>', { noremap = true, silent = true, desc = "Run Nearest Test" })
      vim.keymap.set('n', '<Leader>sl', ':TestLast<CR>', { noremap = true, silent = true, desc = "Run Last Test" })
      vim.keymap.set('n', '<Leader>sv', ':TestVisit<CR>', { noremap = true, silent = true, desc = "Visit Test File" })
    end
  },
  -- comment 🤝 here
  -- This is code taken from https://gitlab.com/oinak/dot_config_nvim/-/blob/main/lua/plugins/languages.lua?ref_type=heads
  -- I have not tried this yet
  --  {
  --   'klen/nvim-test', -- run tests from nvim
  --   dependencies = { "nvim-treesitter/nvim-treesitter", },
  --   config = function()
  --     require('nvim-test').setup({
  --       termOpts = {
  --         direction = "horizontal", -- terminal's direction ("horizontal"|"vertical"|"float")
  --       },
  --     })
  --
  --     require('nvim-test.runners.rspec'):setup({
  --       command = 'docker-compose',
  --       args = { "exec", "web", "bundle", "exec", "rspec" },
  --       file_pattern = "\\v(spec_[^.]+|[^.]+_spec)\\.rb$",
  --       find_files = { "{name}_spec.rb" },
  --     })
  --
  --     vim.keymap.set("n", "<leader>tn", vim.cmd.TestNearest, { desc = '[T]est [N]earest' })
  --     vim.keymap.set("n", "<leader>tf", vim.cmd.TestFile, { desc = '[T]est [F]ile' })
  --     vim.keymap.set("n", "<leader>ts", vim.cmd.TestSuite, { desc = '[T]est [S]uite' })
  --     vim.keymap.set("n", "<leader>tl", vim.cmd.TestLast, { desc = '[T]est [L]ast' })
  --     vim.keymap.set("n", "<leader>tv", vim.cmd.TestVisit, { desc = '[T]est [V]isit' })
  --   end,
  -- },

  {
    'szw/vim-maximizer',
    config = function()
      -- Set up key mapping for maximizing the current split window
      vim.keymap.set('n', '<C-w>m', ':MaximizerToggle!<CR>',
        { noremap = true, silent = true, desc = "Toggle maximize current split" })
    end
  },
  -- {
  --   "utilyre/sentiment.nvim",
  --   version = "*",
  --   event = "VeryLazy", -- keep for lazy loading
  --   opts = {
  --     -- config
  --   },
  --   init = function()
  --     -- `matchparen.vim` needs to be disabled manually in case of lazy loading
  --     vim.g.loaded_matchparen = 1
  --   end,
  -- },
  -- {
  --   "tris203/hawtkeys.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   opts = {
  --     -- an empty table will work for default config
  --     --- if you use functions, or whichkey, or lazy to map keys
  --     --- then please see the API below for options
  --   },
  -- },
  -- {
  --   's1n7ax/nvim-window-picker',
  --   name = 'window-picker',
  --   event = 'VeryLazy',
  --   version = '2.*',
  --   config = function()
  --     require'window-picker'.setup({
  --       highlights = {
  --         statusline = {
  --           focused = {
  --             fg = '#000000',
  --             bg = '#72C0FF',
  --             bold = true,
  --           },
  --           unfocused = {
  --             fg = '#000000',
  --             bg = '#61AFEF',
  --             bold = true,
  --           },
  --         },
  --         winbar = {
  --           focused = {
  --             fg = '#000000',
  --             bg = '#e35e4f',
  --             bold = true,
  --           },
  --           unfocused = {
  --             fg = '#000000',
  --             bg = '#44cc41',
  --             bold = true,
  --           },
  --         },
  --       },
  --     })
  --
  --     local picker = require('window-picker')
  --
  --     -- Swap two windows using the awesome window picker
  --     local function swap_windows()
  --       local window = picker.pick_window({
  --         include_current_win = false
  --       })
  --       local target_buffer = vim.fn.winbufnr(window)
  --       -- Set the target window to contain current buffer
  --       vim.api.nvim_win_set_buf(window, 0)
  --       -- Set current window to contain target buffer
  --       vim.api.nvim_win_set_buf(0, target_buffer)
  --     end
  --
  --     vim.keymap.set('n', '<leader>ws', swap_windows, { desc = 'Window Swap' })
  --   end,
  -- },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "git", ":Git ")
      -- vim.keymap.set("n", "gb",  ":Git blame<CR>")
      -- vim.keymap.set("n", "gap", ":Git add -p<CR>")
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
      -- { "<leader>lz", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    },

    config = function()
      require("lazy").setup()
    end
  },

  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
    config = function()
      require('Comment').setup({})
    end
  },

  {
    "EdenEast/nightfox.nvim",
    config = function()
      require('nightfox').setup({
        -- disable_background = true,
      })
      vim.cmd.colorscheme("terafox")
    end
  },
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   main = "ibl",
  --   opts = {},
  --   config = function()
  --     local highlight = {
  --       "RainbowRed",
  --       "RainbowYellow",
  --       "RainbowBlue",
  --       "RainbowOrange",
  --       "RainbowGreen",
  --       "RainbowViolet",
  --       "RainbowCyan",
  --     }
  --
  --     local hooks = require "ibl.hooks"
  --     -- create the highlight groups in the highlight setup hook, so they are reset
  --     -- every time the colorscheme changes
  --     hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  --       vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
  --       vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
  --       vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  --       vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  --       vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  --       vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  --       vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
  --     end)
  --
  --     -- require("ibl").setup { indent = { highlight = highlight } }
  --     -- require("ibl").setup {  }
  --   end
  -- },
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      vim.defer_fn(function()
        -- require("copilot").setup() -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration

        require("copilot").setup({
          suggestion = { enabled = false },
          panel = { enabled = false },
        })

        require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
      end, 100)
    end,
  },
  {
    "mbbill/undotree",

    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
  },
  -- {
  --   "luckasRanarison/tailwind-tools.nvim",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   opts = {} -- your configuration
  -- },
}
