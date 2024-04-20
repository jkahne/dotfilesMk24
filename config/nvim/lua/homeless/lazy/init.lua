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
  { 'tpope/vim-abolish' },
  {
    "preservim/vim-pencil",
    init = function()
      vim.g["pencil#wrapModeDefault"] = "soft"
    end,
  },


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
  --   'smoka7/hop.nvim',
  --   version = "*",
  --   opts = {},
  --   config = function()
  --     require('hop').setup({
  --       vim.keymap.set('n', 's', ':HopChar2<CR>', { noremap = true, silent = true })
  --     })
  --   end
  -- },

  {
    "ggandor/leap.nvim",
    config=function()
      vim.keymap.set('n', ' ', function ()
        require('leap').leap {
          target_windows = require('leap.user').get_focusable_windows()
        }
      end)
    end
  },

  {
    "azabiong/vim-highlighter",
    init = function()
      vim.cmd([[
        let HiSet   = 'f<CR>'
        let HiErase = 'f<BS>'
        let HiClear = 'f<C-L>'
        " let HiFind  = 'f<Tab>'
        let HiSetSL = 't<CR>'
        ]])
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
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup {
        nextls = {
          enable = true
        },
        credo = {
          -- enable = true
        },
        elixirls = {
          enable = true,
          settings = elixirls.settings {
            -- dialyzerEnabled = false,
            -- enableTestLenses = false,
            dialyzerEnabled = true,
            fetchDeps = false,
            enableTestLenses = false,
            suggestSpecs = false,
          },
          -- on_attach = function(client, bufnr)
          --   vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
          --   vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
          --   vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
          -- end,
        }
      }

      vim.keymap.set('n', '<leader>eo', function()
        require("elixir.elixirls").open_output_panel()
      end, { noremap = true, silent = true, desc = "Open ElixirLS Output Panel" })

      vim.keymap.set('n', '<leader>er', ':ElixirRestart<CR>:edit<CR>', { noremap = true, silent = true, desc = "Restart ElixirLS and Refresh Buffer" })


    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
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

      vim.keymap.set('n', ',ws', swap_windows, { desc = 'Window Swap' })
    end,
  },

}

