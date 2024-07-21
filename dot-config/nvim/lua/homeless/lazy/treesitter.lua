return {
  {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
   {"nvim-treesitter/nvim-treesitter-textobjects", event = "InsertEnter"},
  },
  build = ":TSUpdate",
  config = function()
    -- require('nvim-ts-autotag').setup()
    require("nvim-treesitter.configs").setup({

      textobjects = {
        move = {
          -- enable = true,
          -- set_jumps = true, -- whether to set jumps in the jumplist
          -- goto_next_start = {
          --   ["]m"] = "@function.outer",
          --   ["]]"] = {query = "@class.outer", desc = "Next class start"},
          --   ["]s"] = {
          --     query = "@scope",
          --     query_group = "locals",
          --     desc = "Next scope"
          --   }
          -- },
          -- goto_previous_start = {
          --   ["[m"] = "@function.outer",
          --   ["[["] = "@class.outer"
          -- },
          -- goto_next_end = {
          --   ["]M"] = "@function.outer",
          --   ["]["] = "@class.outer"
          -- },
          -- goto_previous_end = {
          --   ["[M"] = "@function.outer",
          --   ["[]"] = "@class.outer"
          -- },
          -- goto_next = {["]d"] = "@conditional.outer"},
          -- goto_previous = {["[d"] = "@conditional.outer"}
        },
        swap = {
          enable = true,
          swap_next = {["<leader>a"] = "@parameter.inner"},
          swap_previous = {["<leader>A"] = "@parameter.inner"}
        },
        select = {
          -- enable = true,
          -- lookahead = true,
          -- keymaps = {
          --   ["af"] = "@function.outer",
          --   ["if"] = "@function.inner",
          --   ["ac"] = "@class.outer",
          --   ["ic"] = "@class.inner"
          -- },
          -- selection_modes = {
          --   ["@parameter.outer"] = "v", -- charwise
          --   ["@function.outer"] = "V", -- linewise
          --   ["@class.outer"] = "<c-v>" -- blockwise
          -- }
        },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<space>i",
          scope_incremental = "<space>i",
          node_incremental = "<space>n",
          node_decremental = "<space>p"
        }
      },

      -- A list of parser names, or "all"
      ensure_installed = {
        "css", 
       -- "dockerfile", 
        "html",
       -- "elixir", 
        --"heex", 
       -- "eex",
        "javascript", 
        "json", 
        "json5", 
        "lua",
        -- "markdown", 
        -- "markdown_inline",
        "sql", 
        "tsx", 
        "typescript", 
        "ruby",
        "embedded_template", 
        "bash", 
        "astro",
        "c",
        "vimdoc",
        "jsdoc"
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
      auto_install = false,

      indent = {
        enable = true,
        -- disable = {"python"}
      },

      -- autotag = {
      --   enable = true,
      -- },

      highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        -- additional_vim_regex_highlighting = { "markdown" },
      },
    })

    -- TODO:  astro  tree sitter
    -- Plug 'virchau13/tree-sitter-astro'

    -- You might need to manually add the ERB parser if it's not officially supported:
    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.erb = {
      install_info = {
        url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
        files = {"src/parser.c"},
        branch = "main"
      },
      filetype = "erb", -- Ensure it associates with `erb` files
    }
  end
}
