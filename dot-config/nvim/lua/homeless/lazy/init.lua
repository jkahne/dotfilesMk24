return {

	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				keymaps = {
					["<ESC>"] = "actions.close",
					["q"] = "actions.close",
					["?"] = "actions.show_help",
				},
			})
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			-- "WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			local mason = require("mason")

			-- local mason_tool_installer = require("mason-tool-installer")

			-- enable mason and configure icons
			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			-- mason_tool_installer.setup({
			--   ensure_installed = {
			--     "prettier", -- prettier formatter
			--     "stylua",   -- lua formatter
			--     -- "standardrb", -- ruby formatter
			--     -- "rubocop", -- ruby formatter
			--     "htmlhint", -- html linter
			--   },
			-- })
		end,
	},
	{
		"dcampos/nvim-snippy",
		config = function()
			require("snippy").setup({
				mappings = {
					is = {
						["<Tab>"] = "expand_or_advance",
						["<S-Tab>"] = "previous",
					},
					-- nx = {
					--   ['<leader>x'] = 'cut_text',
					-- },
				},
			})
		end,
	},
	{

		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"dcampos/nvim-snippy",
			"dcampos/cmp-snippy",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim" },
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
							},
						},
					},
				},
			})

			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
				settings = {
					tailwindCSS = {
						classAttributes = {
							"class",
							"className",
							"class:list",
							"classList",
							"ngClass",
							"class:",
							"class=",
						},
						-- emmetCompletions = true,
						includeLanguages = {
							-- eelixir = "html-eex",
							eruby = "erb",
							-- htmlangular = "html",
							-- templ = "html"
						},
						lint = {
							cssConflict = "warning",
							invalidApply = "error",
							invalidConfigPath = "error",
							invalidScreen = "error",
							invalidTailwindDirective = "error",
							invalidVariant = "error",
							recommendedVariantOrder = "warning",
						},
						validate = true,
					},
					filetypes = {
						"astro",
						"astro-markdown",
						"eelixir",
						"elixir",
						"ejs",
						"erb",
						"eruby",
						"handlebars",
						"hbs",
						"html",
						"html-eex",
						"heex",
						"markdown",
						"mdx",
						"mustache",
						"css",
						"less",
						"postcss",
						"sass",
						"scss",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"liquid",
					},
					userLanguages = { eruby = "erb", ruby = "rb", html = "html", css = "css" },
					experimental = {
						classRegex = {
							'class[:]\\s*"([^"]*)"',
						},
					},
				},
			})

			-- local handlers = {
			--   ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			--     virtual_text = true,
			--   }),
			-- }

			-- lspconfig.solargraph.setup({
			--   -- cmd = {
			--   --   "asdf",
			--   --   "exec",
			--   --   "solargraph",
			--   --   "stdio",
			--   -- },
			--   -- filetypes = {
			--   --   "ruby",
			--   -- },
			--   -- flags = {
			--   --   debounce_text_changes = 150,
			--   -- },
			--   -- root_dir = lspconfig.util.root_pattern("Gemfile", ".git", "."),
			--   -- handlers = handlers,
			--   capabilities = capabilities,
			--   settings = {
			--     Solargraph = {
			--       -- completion = true,
			--       autoformat = false,
			--       formatting = false,
			--       diagnostics = false, -- turned off cause I want to use standardrb
			--       -- symbols = true,
			--       -- definitions = true,
			--       -- references = true,
			--       -- folding = true,
			--       -- highlights = true,
			--       -- useBundler = true,
			--       -- rename = true,
			--       -- hover = true,
			--       --    -- Enable this when running with docker compose
			--       --transport = 'external',
			--       --externalServer = {
			--       --    host = 'localhost',
			--       --    port = '7658',
			--       --}
			--     },
			--   },
			-- })

			-- local function add_ruby_deps_command(client, bufnr)
			-- 	vim.api.nvim_buf_create_user_command(bufnr, "ShowRubyDeps", function(opts)
			-- 		local params = vim.lsp.util.make_text_document_params()
			-- 		local showAll = opts.args == "all"
			--
			-- 		client.request("rubyLsp/workspace/dependencies", params, function(error, result)
			-- 			if error then
			-- 				print("Error showing deps: " .. error)
			-- 				return
			-- 			end
			--
			-- 			local qf_list = {}
			-- 			for _, item in ipairs(result) do
			-- 				if showAll or item.dependency then
			-- 					table.insert(qf_list, {
			-- 						text = string.format("%s (%s) - %s", item.name, item.version, item.dependency),
			-- 						filename = item.path,
			-- 					})
			-- 				end
			-- 			end
			--
			-- 			vim.fn.setqflist(qf_list)
			-- 			vim.cmd("copen")
			-- 		end, bufnr)
			-- 	end, {
			-- 		nargs = "?",
			-- 		complete = function()
			-- 			return { "all" }
			-- 		end,
			-- 	})
			-- end
			--
			-- local handlers = {
			-- 	["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			-- 		virtual_text = true,
			-- 	}),
			-- }

			lspconfig.ruby_lsp.setup({
				capabilities = capabilities,
				-- cmd = { "~/.asdf/shims/ruby-lsp" },
				-- handlers = handlers,
				-- cmd = { "~/.asdf/shims/ruby-lsp" },
				init_options = {
					formatter = "standard",
					linters = { "standard" },
					enabled_features = {
						definition = true,
						diagnostics = true,
						formatting = true,
					},
					indexing = {
						excluded_patterns = { "/vendor/" },
						-- included_patterns = { "path/to/included/file.rb" },
						-- excludedGems = { "gem1", "gem2", "etc." },
						-- excludedMagicComments = { "compiled:true" },
					},
				},
				-- on_attach = function(client, bufnr)
				-- 	add_ruby_deps_command(client, bufnr)
				-- end,
				settings = {
					completion = true,
					formatting = true,
					diagnostics = true,
					ruby_lsp = {
						-- Enable or disable specific features
						completion = true,
						formatting = true,
						diagnostics = true,
						-- Add other options as needed
					},
				},
			})

			lspconfig.html.setup({
				capabilities = capabilities,
			})

			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})
			lspconfig.bashls.setup({
				capabilities = capabilities,
			})
			-- lspconfig.yamlls.setup({
			--   capabilities = capabilities,
			-- })

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})

			-- vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, { silent = true, noremap = true })
			-- vim.keymap.set('n', 'gD', require('telescope.builtin').lsp_type_definitions, { silent = true, noremap = true })
			-- vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', { silent = true, noremap = true })
			-- vim.keymap.set('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', { silent = true, noremap = true })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})

			-- vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations, { silent = true, noremap = true })
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { silent = true, noremap = true })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, {})

			-- vim.keymap.set("n", "ff", vim.lsp.buf.format, { silent = true, noremap = true })

			-- vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, { silent = true, noremap = true })
			-- vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, { silent = true, noremap = true })
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
			vim.keymap.set("n", "d[", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
			vim.keymap.set("n", "d]", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
			vim.keymap.set("n", "<leader>h", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end, {})

			local cmp = require("cmp")

			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			cmp.setup({
				snippet = {
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
						require("snippy").expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					-- ['<C-y>'] = cmp.mapping.confirm({ select = true }),
					["<C-y>"] = cmp.mapping(
						cmp.mapping.confirm({
							behavior = cmp.ConfirmBehavior.Insert,
							select = true,
						}),
						{ "i", "c" }
					),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
				sources = cmp.config.sources({
					{ name = "copilot", group_index = 2 },
					{ name = "nvim_lsp" },
					{ name = "snippy" }, -- For snippy users.
					{ name = "path" },
					-- { name = 'calc' },
					{ name = "treesitter" },
					{ name = "tags" },
					-- { name = 'rg' },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},

	{
		"nvim-telescope/telescope.nvim",

		-- tag = "0.1.8",

		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"AckslD/nvim-neoclip.lua",
				config = function()
					require("neoclip").setup({
						keys = {
							telescope = {
								i = {
									paste = "<cr>",
									paste_behind = "<c-p>",
								},
								n = {
									paste = "<cr>",
									paste_behind = "P",
								},
							},
						},
					})
				end,
			},
		},

		config = function()
			require("telescope").setup({

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
					file_ignore_patterns = {
						"node_modules",
						"vcr_cassettes",
						"vendor",
						"package-lock.json",
						"lazy-lock.json",
					},
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
							width = 0.90,
							height = 0.90,
						},
						horizontal = {
							prompt_position = "top",
							preview_width = 0.7,
							width = 0.90,
							height = 0.90,
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

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>t", builtin.find_files, {})
			vim.keymap.set("n", "g*", builtin.grep_string, {})
			vim.keymap.set("n", "g/", builtin.live_grep, {})

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

			vim.keymap.set("n", "<leader>b", builtin.buffers, {})
			vim.keymap.set("n", "<leader>km", builtin.keymaps, {})
			vim.keymap.set("n", "<leader>gc", builtin.commands, {})
			vim.keymap.set("n", "<leader>ht", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>ef", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>gf", builtin.git_files, {})
			vim.keymap.set("n", "<leader>m", builtin.marks, {})
			vim.keymap.set("n", "<leader>qh", builtin.quickfixhistory, {})

			vim.keymap.set("n", "<leader>eh", "<cmd>Telescope find_files hidden=true<cr>", {})

			-- local actions = require('telescope.actions')
			-- local action_state = require('telescope.actions.state')

			function live_grep_in_directory()
				local opts = {}
				local cwd = vim.fn.input("Path to directory: ", "", "dir")
				if cwd ~= "" then
					opts.cwd = cwd
				end
				require("telescope.builtin").live_grep(opts)
			end

			vim.api.nvim_set_keymap(
				"n",
				"<leader>ee",
				[[<cmd>lua live_grep_in_directory()<CR>]],
				{ noremap = true, silent = true }
			)

			require("telescope").load_extension("neoclip")
			-- Lua mapping for launching Telescope's neoclip extension
			vim.keymap.set("n", "<Leader>p", function()
				require("telescope").extensions.neoclip.default()
			end, { noremap = true, silent = true, desc = "Open Telescope neoclip" })
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects", event = "InsertEnter" },
		},
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				auto_install = true,
				textobjects = {
					swap = {
						enable = true,
						swap_next = { ["<leader>a"] = "@parameter.inner" },
						swap_previous = { ["<leader>A"] = "@parameter.inner" },
					},
				},
				ensure_installed = {
					"bash",
					"css",
					"embedded_template",
					"html",
					"javascript",
					"query",
					"ruby",
					"scss",
					"vim",
					"vimdoc",
					-- "yaml",
					-- "elixir",
					-- "eex",
				},
				highlight = { enable = true },
				indent = { enable = false },
			})

			-- You might need to manually add the ERB parser if it's not officially supported:
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.erb = {
				install_info = {
					url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
					files = { "src/parser.c" },
					branch = "main",
				},
				filetype = "erb", -- Ensure it associates with `erb` files
			}
		end,
	},

	-- {
	--  "nvim-telescope/telescope-ui-select.nvim",
	-- },

	{
		"mhartington/formatter.nvim",
		event = "BufWrite",
		config = function()
			-- local util = require("formatter.util")

			vim.api.nvim_create_autocmd("BufWritePost", {
				group = vim.api.nvim_create_augroup("_formatter", { clear = true }),
				pattern = "*",
				command = "FormatWrite",
			})

			-- Provides the following commands:
			-- Format, FormatWrite, FormatLock, FormatWriteLock
			require("formatter").setup({
				logging = true,
				log_level = vim.log.levels.WARN,
				filetype = {
					-- ruby = {
					--   function()
					--     return {
					--       exe = "rubocop",
					--       args = {
					--         "--fix-layout",
					--         "--autocorrect-all",
					--         "--stdin",
					--         util.escape_path(util.get_current_buffer_file_name()),
					--         "--format",
					--         "files",
					--         "--stderr",
					--       },
					--       stdin = true,
					--     }
					--   end,
					-- },
					lua = {
						require("formatter.filetypes.lua").stylua,
					},
					["*"] = {
						require("formatter.filetypes.any").remove_trailing_whitespace,
					},
				},
			})
		end,
	},

	{
		"j-hui/fidget.nvim",
		-- tag = "v1.4.5",
		-- opts = {
		-- options
		-- },
	},
	-- {
	--   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	--   config = function()
	--     require("lsp_lines").setup()
	--   end,
	-- },
	-- { "tpope/vim-rails", },
	{ "tpope/vim-bundler" },

	-- consider
	-- https://github.com/RRethy/vim-illuminate
	--
}
