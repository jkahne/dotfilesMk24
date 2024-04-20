return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      -- A list of parser names, or "all"
      ensure_installed = {
        "css", "dockerfile", "html",
        "elixir", "heex", "eex",
        "javascript", "json", "json5", "lua",
        "markdown", "markdown_inline",
        "sql", "tsx", "typescript", "ruby",
        "embedded_template", "bash", "astro", "c",
        "vimdoc", "jsdoc"
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
      auto_install = false,

      indent = {
        enable = true
      },

      autotag = {
        enable = true,
      },

      highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = { "markdown" },
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
