return {
  {
    "nvim-lua/plenary.nvim",
    name = "plenary"
  },
  {
    "nvim-tree/nvim-web-devicons",
    name = "nvim-web-devicons",
    config = function()
      require('nvim-web-devicons').setup({})
    end
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

  { 'tpope/vim-abolish' },
  -- {
  --   "preservim/vim-pencil",
  --   init = function()
  --     vim.g["pencil#wrapModeDefault"] = "soft"
  --   end,
  -- },


  { 'tpope/vim-endwise' },
  { 'kshenoy/vim-signature' },
  { 'rizzatti/dash.vim' },
  { 'eandrju/cellular-automaton.nvim',
    init = function()
      vim.keymap.set('n', '<leader>fml', '<cmd>CellularAutomaton make_it_rain<cr>', { noremap = false, silent = true })
    end
  },
  {
    'mhinz/vim-signify',
    init = function()
      vim.g.signify_update_on_bufenter = 1
      vim.g.signify_update_on_focusgained = 1
    end},
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
    config = true
  },

  -- {
  --   "ggandor/leap.nvim",
  --   config=function()
  --     vim.keymap.set('n', ' ', function ()
  --       require('leap').leap {
  --         target_windows = require('leap.user').get_focusable_windows()
  --       }
  --     end)
  --   end
  -- },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    -- @type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
    modes = {
      char = {
        jump_labels = true
      }
    }
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

    vim.keymap.set("n", "g<cr>", "<cmd>Hi><CR>" )
    vim.keymap.set("n", "gb<cr>", "<cmd>Hi<<CR>" )
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
      vim.keymap.set('n', '<C-w>m', ':MaximizerToggle!<CR>', {noremap = true, silent = true, desc = "Toggle maximize current split"})

    end
  },

  {
    "utilyre/sentiment.nvim",
    version = "*",
    event = "VeryLazy", -- keep for lazy loading
    opts = {
      -- config
    },
    init = function()
      -- `matchparen.vim` needs to be disabled manually in case of lazy loading
      vim.g.loaded_matchparen = 1
    end,
  },
  {
    "epwalsh/pomo.nvim",
    version = "*",  -- Recommended, use latest release instead of latest commit
    lazy = true,
    cmd = { "TimerStart", "TimerRepeat" },
    dependencies = {
      -- Optional, but highly recommended if you want to use the "Default" timer
      "rcarriga/nvim-notify",
    },
    opts = {
      -- How often the notifiers are updated.
      -- update_interval = 1000,

      -- Configure the default notifiers to use for each timer.
      -- You can also configure different notifiers for timers given specific names, see
      -- the 'timers' field below.
      notifiers = {
        -- The "Default" notifier uses 'vim.notify' and works best when you have 'nvim-notify' installed.
        {
          name = "Default",
          opts = {
            -- With 'nvim-notify', when 'sticky = true' you'll have a live timer pop-up
            -- continuously displayed. If you only want a pop-up notification when the timer starts
            -- and finishes, set this to false.
            sticky = false,

            -- Configure the display icons:
            -- title_icon = "󱎫",
            -- text_icon = "󰄉",
            -- Replace the above with these if you don't have a patched font:
            -- title_icon = "⏳",
            -- text_icon = "⏱️",
          },
        },

        -- The "System" notifier sends a system notification when the timer is finished.
        -- Available on MacOS natively and Linux via the `libnotify-bin` package.
        -- Tracking: https://github.com/epwalsh/pomo.nvim/issues/3
        -- { name = "System" },

        -- You can also define custom notifiers by providing an "init" function instead of a name.
        -- See "Defining custom notifiers" below for an example 👇
        -- { init = function(timer) ... end }
      },

      -- -- Override the notifiers for specific timer names.
      -- timers = {
      --   -- For example, use only the "System" notifier when you create a timer called "Break",
      --   -- e.g. ':TimerStart 2m Break'.
      --   Break = {
      --     { name = "System" },
      --   },
      -- },
    },
  },
  {
    "tris203/hawtkeys.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      -- an empty table will work for default config
      --- if you use functions, or whichkey, or lazy to map keys
      --- then please see the API below for options
    },
  },
  {
    's1n7ax/nvim-window-picker',
    name = 'window-picker',
    event = 'VeryLazy',
    version = '2.*',
    config = function()
      require'window-picker'.setup({
        highlights = {
          statusline = {
            focused = {
              fg = '#000000',
              bg = '#72C0FF',
              bold = true,
            },
            unfocused = {
              fg = '#000000',
              bg = '#61AFEF',
              bold = true,
            },
          },
          winbar = {
            focused = {
              fg = '#000000',
              bg = '#e35e4f',
              bold = true,
            },
            unfocused = {
              fg = '#000000',
              bg = '#44cc41',
              bold = true,
            },
          },
        },
      })

      local picker = require('window-picker')

      -- Swap two windows using the awesome window picker
      local function swap_windows()
        local window = picker.pick_window({
          include_current_win = false
        })
        local target_buffer = vim.fn.winbufnr(window)
        -- Set the target window to contain current buffer
        vim.api.nvim_win_set_buf(window, 0)
        -- Set current window to contain target buffer
        vim.api.nvim_win_set_buf(0, target_buffer)
      end

      vim.keymap.set('n', '<leader>ws', swap_windows, { desc = 'Window Swap' })
    end,
  },

}

