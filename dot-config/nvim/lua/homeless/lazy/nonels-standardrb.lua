return {
  -- {
  --   "nvimtools/none-ls.nvim",
  --   config = function()
  --     local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  --     local null_ls = require("null-ls")
  --
  --     local standardrb_diagnostics = {
  --       method = null_ls.methods.DIAGNOSTICS,
  --       filetypes = { "ruby" },
  --       generator = null_ls.generator({
  --         command = "standardrb",
  --         args = { "--fix", "--format", "json", "--force-exclusion", "--stdin", "$FILENAME" },
  --         to_stdin = true,
  --         from_stderr = true,
  --         format = "json",
  --         on_output = function(params)
  --           local diags = {}
  --           for _, offense in ipairs(params.output[1].offenses) do
  --             table.insert(diags, {
  --               row = offense.location.start_line,
  --               col = offense.location.start_column,
  --               end_row = offense.location.end_line,
  --               end_col = offense.location.end_column,
  --               source = "standardrb",
  --               message = offense.message,
  --               severity = offense.severity == "error" and 1 or 2, -- 1 for error, 2 for warning
  --             })
  --           end
  --           return diags
  --         end,
  --       }),
  --     }
  --
  --     local standardrb_formatting = {
  --       method = null_ls.methods.FORMATTING,
  --       filetypes = { "ruby" },
  --       generator = null_ls.generator({
  --         command = "standardrb",
  --         args = { "--fix", "--stdin", "$FILENAME" },
  --         to_stdin = true,
  --       }),
  --     }
  --
  --     null_ls.setup({
  --       on_attach = function(client, bufnr)
  --         if client.supports_method("textDocument/formatting") then
  --           vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  --           vim.api.nvim_create_autocmd("BufWritePre", {
  --             group = augroup,
  --             buffer = bufnr,
  --             callback = function()
  --               vim.lsp.buf.format({ async = false })
  --             end,
  --           })
  --         end
  --       end,
  --       sources = {
  --         null_ls.builtins.formatting.stylua.with({
  --           extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
  --         }),
  --
  --         standardrb_diagnostics,
  --         standardrb_formatting,
  --       },
  --     })
  --
  --     vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, {})
  --   end,
  -- },
}
