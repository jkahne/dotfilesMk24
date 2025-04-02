return {

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },

    config = function()
      require("neo-tree").setup({
        window = {
          mappings = {
            ["<space>"] = "toggle_or_close",
            ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = false } },
            ["F"] = "system_open",
            ["l"] = "noop",
            ["/"] = "noop",

            ["C"] = "copy_to_clipboard",
            ["X"] = "cut_to_clipboard",
            ["V"] = "paste_from_clipboard",
            ["x"] = "close_node",

            ["<leader>p"] = "image_wezterm", -- " or another map

            ["m"] = { "move", config = { show_path = "absolute" } },
            ["oc"] = "noop",
            ["od"] = "noop",
            ["om"] = "noop",
            ["on"] = "noop",
            ["os"] = "noop",
            ["ot"] = "noop",
            ["og"] = "noop",
          },
        },
        commands = {
          image_wezterm = function(state)
            local node = state.tree:get_node()
            if node.type == "file" then
              require("image_preview").PreviewImage(node.path)
            end
          end,

          system_open = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            if node.type == "file" then
              local lastSlashIndex = path:match("^.+()/[^/]*$") -- Match the last slash and everything before it
              path = path:sub(1, lastSlashIndex - 1) -- Extract substring before the last slash
            end

            vim.fn.jobstart({ "open", path }, { detach = true })
          end,

          toggle_or_close = function(state)
            local node = state.tree:get_node()
            if node.type == "file" then
              require("neo-tree.sources.filesystem.commands").close_node(state)
            elseif node.type == "directory" then
              require("neo-tree.sources.filesystem.commands").toggle_node(state)
            end
          end,
        },
        close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_git_status = true,
        sort_case_insensitive = false, -- used when sorting files and directories in the tree
        sort_function = function(a, b)
          return a.path < b.path
        end, -- this sorts files and directories descendantly

        filesystem = {
          filtered_items = {
            visible = true, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = false,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
              --"node_modules"
            },
            hide_by_pattern = { -- uses glob style patterns
              --"*.meta",
              --"*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
              --".gitignored",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
              ".DS_Store",
              --"thumbs.db"
            },
            never_show_by_pattern = { -- uses glob style patterns
              --".null-ls_*",
              -- "vendor/**/*/",
            },
          },
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --                       -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          highlight_current_file = true, -- Highlight the current file in the tree
          use_libuv_file_watcher = true, -- Keep tree in sync
        },

        default_component_configs = {
          name = {
            use_git_status_colors = false,
          },
          container = {
            enable_character_fade = true,
          },
          git_status = {
            window = {
              position = "float",
              mappings = {
                ["A"] = "noop",
                ["gu"] = "noop",
                ["ga"] = "noop",
                ["gr"] = "noop",
                ["gc"] = "noop",
                ["gp"] = "noop",
                ["gg"] = "noop",
                ["o"] = "noop",
                ["oc"] = "noop",
                ["od"] = "noop",
                ["om"] = "noop",
                ["on"] = "noop",
                ["os"] = "noop",
                ["ot"] = "noop",
              },
            },
            symbols = {
              -- Change type
              added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted = "✖", -- this can only be used in the git_status source
              renamed = "➜", -- this can only be used in the git_status source
              -- Status type
              untracked = "",
              ignored = "",
              unstaged = "󰄱",
              staged = "",
              conflict = "",
            },
          },
        },
      })
    end,
    init = function()
      vim.keymap.set("n", "gt", ":Neotree toggle<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>gt", ":Neotree reveal<CR>", {})
      vim.keymap.set("n", "<leader>bt", ":Neotree buffers reveal float<CR>", {})
    end,
  },
}
