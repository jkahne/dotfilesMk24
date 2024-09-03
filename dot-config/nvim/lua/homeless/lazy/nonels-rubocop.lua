return {
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local null_ls = require("null-ls")
      null_ls.setup({
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
          end
        end,
        sources = {
          null_ls.builtins.formatting.stylua.with({
            extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
          }),
          -- null_ls.builtins.formatting.prettier, -- yml, probably
          -- null_ls.builtins.diagnostics.erb_lint,
          -- null_ls.builtins.formatting.erb_format,
          -- null_ls.builtins.diagnostics.eslint_d,
          -- null_ls.builtins.diagnostics.rubocop,
          -- null_ls.builtins.formatting.rubocop,

          null_ls.builtins.diagnostics.rubocop.with({
            command = "rubocop",
            args = function(params)
              return {
                "--config",
                ".rubocop_local.yml", -- Explicitly specify the local config file
                "--format",
                "json", -- Ensure JSON output
                "--force-exclusion",
                "--stdin",
                params.bufname, -- Use params.bufname for the full path
              }
            end,
            to_stdin = true,
            format = "json",
          }),
          null_ls.builtins.formatting.rubocop.with({
            command = "rubocop",
            args = function(params)
              return {
                "--config",
                ".rubocop_local.yml", -- Explicitly specify the local config file
                "--auto-correct",
                "--stdin",
                params.bufname, -- Use params.bufname for the full path
                "--stderr",
                "--format",
                "quiet",
              }
            end,
            to_stdin = true,
            from_stderr = false,
          }),
        },
      })

      vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, {})
    end,
  },
}
