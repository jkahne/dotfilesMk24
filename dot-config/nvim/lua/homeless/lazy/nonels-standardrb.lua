return {
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local null_ls = require("null-ls")

      local standardrb_diagnostics = {
        method = null_ls.methods.DIAGNOSTICS,
        filetypes = { "ruby" },
        generator = null_ls.generator({
          command = "bundle",
          args = {
            "exec",
            "standardrb",
            "--fix",
            "--format",
            "json",
            "--force-exclusion",
            "--stdin",
            "$FILENAME",
          },
          to_stdin = true,
          from_stderr = true,
          format = "json",
          on_output = function(params)
            if not params.output then
              return {}
            end

            local ok, decoded = pcall(vim.json.decode, params.output)
            if not ok or not decoded[1] or not decoded[1].offenses then
              return {}
            end

            local diags = {}
            for _, offense in ipairs(params.output[1].offenses) do
              table.insert(diags, {
                row = offense.location.start_line,
                col = offense.location.start_column,
                end_row = offense.location.end_line,
                end_col = offense.location.end_column,
                source = "standardrb",
                message = offense.message,
                severity = offense.severity == "error" and 1 or 2, -- 1 for error, 2 for warning
              })
            end
            return diags
          end,
        }),
      }

      local standardrb_formatting = {
        method = null_ls.methods.FORMATTING,
        filetypes = { "ruby" },
        generator = null_ls.generator({
          command = "bundle",
          args = { "exec", "standardrb", "--fix", "--stdin", "$FILENAME" },
          to_stdin = true,
        }),
      }

      null_ls.setup({
        -- debug = true,
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
          -- null_ls.builtins.diagnostics.erb_lint,
          -- null_ls.builtins.formatting.erb_format,
          -- null_ls.builtins.formatting.erb_format.with({
          --   extra_args = {
          --     "--stdin",
          --     "--print-width",
          --     "120",
          --     "--single-quote",
          --     "--preserve-blank-lines",
          --   },
          -- }),

          -- null_ls.builtins.formatting.prettier.with({
          --   extra_args = {
          --     "--plugin=@prettier/plugin-ruby",
          --     "--print-width",
          --     "120",
          --     "--html-whitespace-sensitivity",
          --     "strict",
          --     "--preserve-blank-lines",
          --   },
          -- }),

          -- null_ls.builtins.formatting.htmlbeautifier,
          -- null_ls.builtins.formatting.prettier,
          standardrb_diagnostics,
          standardrb_formatting,
        },
      })

      vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, {})
    end,
  },
}
