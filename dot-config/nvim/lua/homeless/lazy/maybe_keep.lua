return {
  {
    -- eh, this aint' great.  comma-p in neo-tree to preview an image in a new split kinda sucks.
    "adelarsq/image_preview.nvim",
    event = "VeryLazy",
    config = function()
      require("image_preview").setup({})
    end,
  },
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      require("mini.icons").setup()
      require("mini.files").setup({
        windows = {
          preview = true,
        },
      })

      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },

  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {
      --
      -- All of these are just the defaults
      --
      enabled = false, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
      trigger_events = { -- See :h events
        immediate_save = { "BufLeave", "FocusLost" }, -- vim events that trigger an immediate save
        defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
        cancel_deferred_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
      },
      -- function that takes the buffer handle and determines whether to save the current buffer or not
      -- return true: if buffer is ok to be saved
      -- return false: if it's not ok to be saved
      -- if set to `nil` then no specific condition is applied
      -- condition = nil,
      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")

        -- don't save for `sql` file types
        if utils.not_in(fn.getbufvar(buf, "&filetype"), { "sql" }) then
          return true
        end
        return false
      end,
      write_all_buffers = false, -- write all buffers when the current one meets `condition`
      noautocmd = false, -- do not execute autocmds when saving
      lockmarks = false, -- lock marks when saving, see `:h lockmarks` for more details
      debounce_delay = 1000, -- delay after which a pending save is executed
      -- log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
      debug = false,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        sections = {
          lualine_x = {
            {
              require("noice").api.statusline.mode.get,
              cond = require("noice").api.statusline.mode.has,
              color = { fg = "#ff9e64" },
            },
          },
        },
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require("noice").setup({
        cmdline = {
          enabled = true,
          view = "cmdline", -- Use default cmdline position
        },
        messages = {
          enabled = true,
          view = "notify", -- This keeps the notifications in the corner
          view_error = "notify",
          view_warn = "notify",
          view_history = "messages",
        },
        popupmenu = {
          enabled = true,
          backend = "nui",
        },
        notify = {
          enabled = true,
          view = "notify",
        },
        lsp = {
          progress = {
            enabled = true,
            view = "notify",
          },
        },
      })
    end,
  },
  -- {
  -- 	"folke/noice.nvim",
  -- 	event = "VeryLazy",
  -- 	opts = {
  -- 		-- add any options here
  -- 	},
  -- 	dependencies = {
  -- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  -- 		"MunifTanjim/nui.nvim",
  -- 		-- OPTIONAL:
  -- 		--   `nvim-notify` is only needed, if you want to use the notification view.
  -- 		--   If not available, we use `mini` as the fallback
  -- 		"rcarriga/nvim-notify",
  -- 	},
  -- 	config = function()
  -- 		require("noice").setup({
  -- 			-- lsp = {
  -- 			-- 	-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  -- 			-- 	override = {
  -- 			-- 		["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  -- 			-- 		["vim.lsp.util.stylize_markdown"] = true,
  -- 			-- 		["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
  -- 			-- 	},
  -- 			-- },
  -- 			lsp = {
  -- 				message = {
  -- 					-- Messages shown by lsp servers
  -- 					enabled = true,
  -- 					view = "mini",
  -- 				},
  -- 			},
  -- 			-- you can enable a preset for easier configuration
  -- 			presets = {
  -- 				bottom_search = true, -- use a classic bottom cmdline for search
  -- 				-- command_palette = true, -- position the cmdline and popupmenu together
  -- 				-- long_message_to_split = true, -- long messages will be sent to a split
  -- 				-- inc_rename = false, -- enables an input dialog for inc-rename.nvim
  -- 				-- lsp_doc_border = false, -- add a border to hover docs and signature help
  -- 			},
  --
  -- 			messages = {
  -- 				-- NOTE: If you enable messages, then the cmdline is enabled automatically.
  -- 				-- This is a current Neovim limitation.
  -- 				enabled = true, -- enables the Noice messages UI
  -- 				view = "mini", -- default view for messages
  -- 				view_error = "mini", -- view for errors
  -- 				view_warn = "mini", -- view for warnings
  -- 				view_history = "mini", -- view for :messages
  -- 				view_search = "mini", -- view for search count messages. Set to `false` to disable
  -- 			},
  -- 			notify = {
  -- 				-- Noice can be used as `vim.notify` so you can route any notification like other messages
  -- 				-- Notification messages have their level and other properties set.
  -- 				-- event is always "notify" and kind can be any log level as a string
  -- 				-- The default routes will forward notifications to nvim-notify
  -- 				-- Benefit of using Noice for this is the routing and consistent history view
  -- 				enabled = true,
  -- 				view = "mini",
  -- 			},
  --
  -- 			views = {
  -- 				-- This sets the position for the search popup that shows up with / or with :
  -- 				cmdline_popup = {
  -- 					position = {
  -- 						row = "40%",
  -- 						col = "50%",
  -- 					},
  -- 				},
  -- 				mini = {
  -- 					timeout = 5000, -- timeout in milliseconds
  -- 					align = "center",
  -- 					position = {
  -- 						-- Centers messages top to bottom
  -- 						row = "95%",
  -- 						-- Aligns messages to the far right
  -- 						col = "100%",
  -- 					},
  -- 				},
  -- 			},
  -- 		})
  -- 	end,
  -- },

  -- {
  -- 	"echasnovski/mini.hipatterns",
  -- 	config = function()
  -- 	end,
  -- },
}
