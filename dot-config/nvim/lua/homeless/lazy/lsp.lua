return {
  --
  -- { "brenoprata10/nvim-highlight-colors",
  --
  --   config=function()
  --     require('nvim-highlight-colors').setup {
  --       enable_named_colors = true,
  --       enable_tailwind = true
  --     }
  --   end
  -- },
  --
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/nvim-cmp",
      "dcampos/nvim-snippy",
      "dcampos/cmp-snippy",
      "j-hui/fidget.nvim",
      -- {
      --   "folke/trouble.nvim",
      --   dependencies = { "nvim-tree/nvim-web-devicons" },
      --   opts = {
      --     -- your configuration comes here
      --     -- or leave it empty to use the default settings
      --     -- refer to the configuration section below
      --   },
      --   config = function()
      --     require("trouble").setup({})
      --     -- Lua
      --     vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
      --     -- vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
      --     -- vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
      --     vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
      --     -- vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
      --     -- vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
      --   end
      -- },
    },
    -- opts = {
    --   servers = {
    --     tailwindcss = {}
    --   }
    -- },
    config = function()
      local cmp = require('cmp')
      local cmp_lsp = require("cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities())

      require("fidget").setup({})
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          -- "tailwindcss",
          "tsserver",
          "html",
          -- "dockerls",
          -- "solargraph", -- don't install via mason.  it somehow sucks.
          -- "docker_compose_language_service",
          "cssls",
          -- "ruby_lsp",
          "astro"
        },
        handlers = {
          function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {
              capabilities = capabilities
            }
          end,

          -- ["solargraph"] = function()
          --   lspconfig.solargraph.setup({
          --     on_attach = M.on_attach,
          --     capabilities,
          --     filetypes = { "ruby", "eruby" },
          --     settings = {
          --       solargraph = {
          --         useBundler = true,
          --         diagnostic = true,
          --         completion = true,
          --         hover = true,
          --         formatting = true,
          --         symbols = true,
          --         definitions = true,
          --         rename = true,
          --         references = true,
          --         folding = true
          --       }
          --     }
          --   })
          -- end,


          ["lua_ls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup {
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = { version = "Lua 5.1" },
                  diagnostics = {
                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                  }
                }
              }
            }
          end,

          ["tailwindcss"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.tailwindcss.setup {
              cmd = {"tailwindcss-language-server", "--stdio"},
              capabilities = capabilities,
              on_attach = function(client, bufnr)
                local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
                buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
              end,
              settings = {
                tailwindCSS = {
                  classAttributes = { "class", "className", "class:list", "classList", "ngClass", "class: " },
                  emmetCompletions = true,
                  lint = {
                    cssConflict = "warning",
                    invalidApply = "error",
                    invalidConfigPath = "error",
                    invalidScreen = "error",
                    invalidTailwindDirective = "error",
                    invalidVariant = "error",
                    recommendedVariantOrder = "warning"
                  },
                  validate = true
                }
              },
              filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "erb" },
              -- userLanguages = { eruby = "erb", ruby = "rb", html = 'html', css = 'css' }
            }
          end,
        }
      })

      -- local lspconfig = require("lspconfig")
      -- lspconfig.tailwindcss.setup {
      --   -- -- cmd = { "/Users/nick/.config/nvim/language-servers/node_modules/.bin/tailwindcss-language-server", "--stdio" }
      --   -- capabilities = capabilities,
      --   -- on_attach = function(client, bufnr)
      --   --   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
      --   --   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
      --   -- end,
      --   -- settings = {
      --   --   tailwindCSS = {
      --   --     classAttributes = { "class", "className", "class:list", "classList", "ngClass", "class: " },
      --   --     emmetCompletions = true,
      --   --     lint = {
      --   --       cssConflict = "warning",
      --   --       invalidApply = "error",
      --   --       invalidConfigPath = "error",
      --   --       invalidScreen = "error",
      --   --       invalidTailwindDirective = "error",
      --   --       invalidVariant = "error",
      --   --       recommendedVariantOrder = "warning"
      --   --     },
      --   --     validate = true
      --   --   }
      --   -- },
      --   -- filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "erb" },
      --   -- userLanguages = { eruby = "erb", ruby = "rb", html = 'html', css = 'css' }
      --   -- --   -- eelixir = "html-eex",
      -- }



      -- require('lspconfig').ruby_lsp.setup {
      --   capabilities = capabilities,
      --   diagnostics = false -- Enable diagnostics
      -- }

      -- require('lspconfig').solargraph.setup( -- setup solargraph (Don't install it with mason, it sucks)
      --   {
      --     on_attach = on_attach,
      --     settings = {
      --       solargraph = {
      --         formatting = true,
      --         useBundler = true,
      --         diagnostics = true, -- lsp diagnostics are slow
      --       },
      --       formatting = true,
      --       useBundler = true,
      --       diagnostics = true, -- lsp diagnostics are slow
      --
      --     },
      --   }
      -- )


            require('lspconfig').solargraph.setup({
              on_attach = on_attach,
              capabilities,
              filetypes = { "ruby", "eruby" },
              settings = {
                solargraph = {
                  useBundler = true,
                  diagnostic = true,
                  completion = true,
                  hover = true,
                  formatting = true,
                  symbols = true,
                  definitions = true,
                  rename = true,
                  references = true,
                  folding = true
                }
              }
            })



      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        snippet = {
          expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        -- formatting = {
        --   require("nvim-highlight-colors").format
        -- },
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          -- ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<C-y>'] = cmp.mapping(
            cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            },
            { "i", "c" }
          ),
          -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),

          -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
          -- ['<C-j>'] = cmp.mapping.select_next_item(),
          -- ['<C-k>'] = cmp.mapping.select_prev_item(),
          -- ['<C-e>'] = cmp.mapping.abort(),
          -- ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.


        }),
        sources = cmp.config.sources({
          { name = "copilot", group_index = 2 },
          { name = 'nvim_lsp' },
          { name = 'snippy' }, -- For snippy users.

          -- { name = 'path' },
          -- { name = 'calc' },
          -- { name = 'treesitter' },
          -- { name = 'tags' },
          -- { name = 'rg' },

        }, {

          { name = 'buffer' },
        })
      })

      -- `:` cmdline setup.
      -- cmp.setup.cmdline(':', {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = cmp.config.sources({
      --     { name = 'path' }
      --   }, {
      --     {
      --       name = 'cmdline',
      --       option = {
      --         ignore_cmds = { 'Man', '!' }
      --       }
      --     }
      --   })
      -- })

      -- cmp.setup.cmdline(':', {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = {
      --     { name = 'path' },
      --     { name = 'cmdline' }
      --   }
      -- })


      require('snippy').setup({
        mappings = {
          is = {
            ['<Tab>'] = 'expand_or_advance',
            ['<S-Tab>'] = 'previous',
          },
          nx = {
            ['<leader>x'] = 'cut_text',
          },
        },
      })

      vim.diagnostic.config({
        -- update_in_insert = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
        virtual_text = false,
        signs = false,
        underline = false,

      })

      -- vim.keymap.set('n', '<leader>ngd', vim.lsp.buf.definition, { silent = true, noremap = true })
      -- vim.keymap.set('n', '<leader>ngD', vim.lsp.buf.declaration, { silent = true, noremap = true })
      -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { silent = true, noremap = true })
      -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, { silent = true, noremap = true })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true, noremap = true })

      vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, { silent = true, noremap = true })
      vim.keymap.set('n', 'gD', require('telescope.builtin').lsp_type_definitions, { silent = true, noremap = true })

      -- vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', { silent = true, noremap = true })
      -- vim.keymap.set('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', { silent = true, noremap = true })

      vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations, { silent = true, noremap = true })
      vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { silent = true, noremap = true })
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { silent = true, noremap = true })
      vim.keymap.set('n', 'gq', vim.lsp.buf.code_action, { silent = true, noremap = true })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { silent = true, noremap = true })

      vim.keymap.set('n', 'ff', vim.lsp.buf.format, { silent = true, noremap = true })

      -- vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, { silent = true, noremap = true })
      -- vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, { silent = true, noremap = true })
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
      vim.keymap.set('n', 'd[', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
      vim.keymap.set('n', 'd]', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
      vim.keymap.set('n', '<leader>h', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
        {})
    end
  },

  -- Signature
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup()
      vim.keymap.set("n", "<leader>k", function()
        require("lsp_signature").toggle_float_win()
      end, { silent = true, noremap = true, desc = "toggle signature" })
    end,
  },



}
