return {
  {
  "nvim-telescope/telescope.nvim",

  tag = "0.1.8",

  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "AckslD/nvim-neoclip.lua",
      config = function()
        require('neoclip').setup({
          keys = {
            telescope = {
              i = {
                paste = '<cr>',
                paste_behind = '<c-p>',
              },
              n = {
                paste = '<cr>',
                paste_behind = 'P',
              },
            },
          }
        })
      end
    },
  },

  config = function()
    require('telescope').setup({

      defaults = {
        mappings = {
          i = {
            -- ["<C-h>"] = "which_key",
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            -- ['<C-g>'] = function(prompt_bufnr)
            --   -- Use nvim-window-picker to choose the window by dynamically attaching a function
            --   local action_set = require('telescope.actions.set')
            --   local action_state = require('telescope.actions.state')
            --
            --   local picker = action_state.get_current_picker(prompt_bufnr)
            --   picker.get_selection_window = function(picker, entry)
            --     local picked_window_id = require('window-picker').pick_window() or vim.api.nvim_get_current_win()
            --     -- Unbind after using so next instance of the picker acts normally
            --     picker.get_selection_window = nil
            --     return picked_window_id
            --   end
            --
            --   return action_set.edit(prompt_bufnr, 'edit')
            -- end,
          },

        },
        layout_strategy = "vertical",
        anchor = "N",
        file_ignore_patterns = { "node_modules", "package-lock.json", "lazy-lock.json" },
        path_display = { "truncate" },
        layout_config = {
          center = {
            preview_height = 0.7,
          },
          vertical = {
            prompt_position = "top",
            preview_height = 0.7,
            mirror = true,
            preview_cutoff = 4,
            width = 0.99,
            height = 0.99,
          },
          horizontal = {
            prompt_position = "top",
            preview_width = 0.7,
            width = 0.99,
            height = 0.99,
          },
        },
        sorting_strategy = "ascending",
        -- preview = true,
      },
      pickers = {
        buffers = {
          -- path_display = formattedName,
          mappings = {
            i = {
              ["<C-d>"] = require("telescope.actions").delete_buffer,
            },
            n = {
              ["<C-d>"] = require("telescope.actions").delete_buffer,
            },
          },
          -- previewer = false,
          -- initial_mode = "normal",
          -- -- theme = "dropdown",
          -- layout_config = {
          --   height = 0.4,
          --   width = 0.6,
          --   prompt_position = "top",
          --   preview_cutoff = 120,
          -- },
        },
      },

    })

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>t', builtin.find_files, {})
    vim.keymap.set('n', 'g*', builtin.grep_string, {})
    vim.keymap.set('n', 'g/', builtin.live_grep, {})

    -- vim.keymap.set('n', '<leader>8', function()
    --   local word = vim.fn.expand("<cword>")
    --   builtin.grep_string({ search = word })
    -- end)
    -- vim.keymap.set('n', '<leader>*', function()
    --   local word = vim.fn.expand("<cWORD>")
    --   builtin.grep_string({ search = word })
    -- end)
    -- vim.keymap.set('n', '<leader>ps', function()
    --   builtin.grep_string({ search = vim.fn.input("Grep > ") })
    -- end)


    vim.keymap.set('n', '<leader>b', builtin.buffers, {})
    vim.keymap.set('n', '<leader>km', builtin.keymaps, {})
    vim.keymap.set('n', '<leader>gc', builtin.commands, {})
    vim.keymap.set('n', '<leader>ht', builtin.help_tags, {})
    vim.keymap.set('n', '<leader>ef', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
    vim.keymap.set('n', '<leader>m', builtin.marks, {})
    vim.keymap.set('n', '<leader>qh', builtin.quickfixhistory, {})

    vim.keymap.set('n', '<leader>eh', "<cmd>Telescope find_files hidden=true<cr>", {})

    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')

    function live_grep_in_directory()
      local opts = {}
      local cwd = vim.fn.input("Path to directory: ", "", "dir")
      if cwd ~= "" then
        opts.cwd = cwd
      end
      require('telescope.builtin').live_grep(opts)
    end

    vim.api.nvim_set_keymap('n', '<leader>ee', 
    [[<cmd>lua live_grep_in_directory()<CR>]], 
    { noremap = true, silent = true }
    )

    require("telescope").load_extension "neoclip"
    -- Lua mapping for launching Telescope's neoclip extension
    vim.keymap.set('n', '<Leader>p', function()
      require('telescope').extensions.neoclip.default()
    end, { noremap = true, silent = true, desc = "Open Telescope neoclip" })
  end,
},

}
