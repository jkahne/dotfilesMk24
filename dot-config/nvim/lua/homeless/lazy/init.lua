return {
	-- {
	--   "zbirenbaum/copilot-cmp",
	--   event = "InsertEnter",
	--   dependencies = { "zbirenbaum/copilot.lua" },
	--   config = function()
	--     vim.defer_fn(function()
	--       -- require("copilot").setup() -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
	--
	--       require("copilot").setup({
	--         suggestion = { enabled = false },
	--         panel = { enabled = false },
	--       })
	--
	--       require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
	--     end, 100)
	--   end,
	-- },

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
						enabled = false, -- This will find and focus the file in the active buffer every time
						--               -- the current file is changed while the tree is open.
						leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
					},
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
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			local mason = require("mason")

			local mason_tool_installer = require("mason-tool-installer")

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

			mason_tool_installer.setup({
				ensure_installed = {
					"prettier", -- prettier formatter
					"stylua", -- lua formatter
					-- "standardrb", -- ruby formatter
					"rubocop", -- ruby formatter
					"htmlhint", -- html linter
				},
			})
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
		"j-hui/fidget.nvim",
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
				},
			})

			local handlers = {
				["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					virtual_text = true,
				}),
			}

			lspconfig.solargraph.setup({
				-- cmd = {
				-- 	"asdf",
				-- 	"exec",
				-- 	"solargraph",
				-- 	"stdio",
				-- },
				filetypes = {
					"ruby",
				},
				flags = {
					debounce_text_changes = 150,
				},
				root_dir = lspconfig.util.root_pattern("Gemfile", ".git", "."),
				handlers = handlers,
				capabilities = capabilities,
				-- settings = {
				-- 	Solargraph = {
				-- 		completion = true,
				-- 		autoformat = false,
				-- 		formatting = true,
				-- 		symbols = true,
				-- 		definitions = true,
				-- 		references = true,
				-- 		folding = true,
				-- 		highlights = true,
				-- 		useBundler = true,
				-- 		rename = true,
				-- 		-- diagnostics = false, -- lsp diagnostics are slow
				-- 		-- hover = true,
				-- 		--    -- Enable this when running with docker compose
				-- 		--transport = 'external',
				-- 		--externalServer = {
				-- 		--    host = 'localhost',
				-- 		--    port = '7658',
				-- 		--}
				-- 	},
				-- },
			})

			-- lspconfig.ruby_lsp.setup({
			-- 	capabilities = capabilities,
			-- 	-- cmd = { "/jkahne/.asdf/shims/ruby-lsp" }
			-- })

			lspconfig.html.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})

			-- vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, { silent = true, noremap = true })
			-- vim.keymap.set('n', 'gD', require('telescope.builtin').lsp_type_definitions, { silent = true, noremap = true })
			-- vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', { silent = true, noremap = true })
			-- vim.keymap.set('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', { silent = true, noremap = true })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})

			-- vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations, { silent = true, noremap = true })
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { silent = true, noremap = true })
			vim.keymap.set("n", "gq", vim.lsp.buf.code_action, { silent = true, noremap = true })
			vim.keymap.set("n", "ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

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
					-- { name = "copilot", group_index = 2 },
					{ name = "nvim_lsp" },
					{ name = "snippy" }, -- For snippy users.
					{ name = "path" },
					-- { name = 'calc' },
					-- { name = 'treesitter' },
					-- { name = 'tags' },
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
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"tailwindcss",
					"html",
					"cssls",
					-- "solargraph",
					"lua_ls",
					-- "ruby_lsp",
				},
				automatic_installation = true,
			})
			-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
			-- require("mason-lspconfig").setup_handlers {
			--   -- The first entry (without a key) will be the default handler
			--   -- and will be called for each installed server that doesn't have
			--   -- a dedicated handler.
			--   function(server_name)    -- default handler (optional)
			--     require("lspconfig")[server_name].setup {
			--       capabilities = capabilities
			--     }
			--   end,
			--   -- Next, you can provide a dedicated handler for specific servers.
			--   ["tailwindcss"] = function()
			--     require 'lspconfig'.tailwindcss.setup {
			--       capabilities = capabilities,
			--       settings = {
			--         tailwindCSS = {
			--           classAttributes = { "class", "className", "class:list", "classList", "ngClass", "class:" },
			--           -- emmetCompletions = true,
			--           includeLanguages = {
			--             eelixir = "html-eex",
			--             eruby = "erb",
			--             -- htmlangular = "html",
			--             -- templ = "html"
			--           },
			--           lint = {
			--             cssConflict = "warning",
			--             invalidApply = "error",
			--             invalidConfigPath = "error",
			--             invalidScreen = "error",
			--             invalidTailwindDirective = "error",
			--             invalidVariant = "error",
			--             recommendedVariantOrder = "warning"
			--           },
			--           validate = true
			--         },
			--         filetypes = { "astro", "astro-markdown", "eelixir", "elixir", "ejs", "erb", "eruby", "handlebars", "hbs", "html", "html-eex", "heex", "markdown", "mdx", "mustache", "css", "less", "postcss", "sass", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "liquid" },
			--         -- userLanguages = { eruby = "erb", ruby = "rb", html = 'html', css = 'css' }
			--       }
			--     }
			--   end,
			--   ["solargraph"] = function()
			--     require("lspconfig")["solargraph"].setup {
			--       capabilities = capabilities,
			--       settings = {
			--         solargraph = {
			--           formatting = true,
			--           useBundler = true,
			--           diagnostics = false,     -- lsp diagnostics are slow
			--           completion = true,
			--           hover = true,
			--           definitions = true,
			--           rename = true,
			--           references = true,
			--           folding = true
			--         },
			--       },
			--     }
			--   end
			-- }
		end,
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
					-- "elixir",
					-- "eex",
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier,
					-- null_ls.builtins.diagnostics.erb_lint,
					null_ls.builtins.diagnostics.rubocop,
					null_ls.builtins.formatting.rubocop,
				},
			})

			vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},

	-- {
	-- 	"stevearc/conform.nvim",
	-- 	event = { "BufReadPre", "BufNewFile" },
	-- 	config = function()
	-- 		local conform = require("conform")
	--
	-- 		conform.setup({
	-- 			formatters_by_ft = {
	-- 				javascript = { "prettier" },
	-- 				-- typescript = { "prettier" },
	-- 				-- javascriptreact = { "prettier" },
	-- 				-- typescriptreact = { "prettier" },
	-- 				-- svelte = { "prettier" },
	-- 				css = { "prettier" },
	-- 				html = { "prettier" },
	-- 				json = { "prettier" },
	-- 				yaml = { "prettier" },
	-- 				markdown = { "prettier" },
	-- 				-- graphql = { "prettier" },
	-- 				-- lua = { "stylua" },
	-- 				ruby = { "rubocop" }, --, "standardrb",  "rubocop", "htmlbeautifier" } }
	-- 				-- python = { "isort", "black" },
	-- 			},
	-- 			format_on_save = {
	-- 				lsp_fallback = true,
	-- 				async = false,
	-- 				timeout_ms = 1000,
	-- 			},
	-- 		})
	-- 		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
	-- 			conform.format({
	-- 				lsp_fallback = true,
	-- 				async = false,
	-- 				timeout_ms = 1000,
	-- 			})
	-- 		end, { desc = "Format file or range (in visual mode)" })
	-- 	end,
	-- },

	-- {
	-- 	"mfussenegger/nvim-lint",
	-- 	event = {
	-- 		"BufReadPre",
	-- 		"BufNewFile",
	-- 	},
	-- 	config = function()
	-- 		local lint = require("lint")
	--
	-- 		lint.linters_by_ft = {
	-- 			-- javascript = { "eslint_d" },
	-- 			-- typescript = { "eslint_d" },
	-- 			-- javascriptreact = { "eslint_d" },
	-- 			-- typescriptreact = { "eslint_d" },
	-- 			ruby = { "rubocop" },
	-- 			html = { "htmlhint" },
	-- 		}
	--
	-- 		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
	--
	-- 		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	-- 			group = lint_augroup,
	-- 			callback = function()
	-- 				lint.try_lint()
	-- 			end,
	-- 		})
	--
	-- 		vim.keymap.set("n", "<leader>l", function()
	-- 			lint.try_lint()
	-- 		end, { desc = "Trigger linting for current file" })
	-- 	end,
	-- },

	-- {
	-- 	"mhartington/formatter.nvim",
	-- 	event = "BufWrite",
	-- 	config = function()
	-- 		local util = require("formatter.util")
	--
	-- 		vim.api.nvim_create_autocmd("BufWritePost", {
	-- 			group = vim.api.nvim_create_augroup("_formatter", { clear = true }),
	-- 			pattern = "*",
	-- 			command = "FormatWrite",
	-- 		})
	--
	-- 		-- Provides the following commands:
	-- 		-- Format, FormatWrite, FormatLock, FormatWriteLock
	-- 		require("formatter").setup({
	-- 			logging = true,
	-- 			log_level = vim.log.levels.WARN,
	-- 			filetype = {
	-- 				ruby = {
	-- 					function()
	-- 						return {
	-- 							exe = "rubocop",
	-- 							args = {
	-- 								"--fix-layout",
	-- 								"--autocorrect-all",
	-- 								"--stdin",
	-- 								util.escape_path(util.get_current_buffer_file_name()),
	-- 								"--format",
	-- 								"files",
	-- 								"--stderr",
	-- 							},
	-- 							stdin = true,
	-- 						}
	-- 					end,
	-- 				},
	-- 				lua = {
	-- 					require("formatter.filetypes.lua").stylua,
	-- 				},
	-- 				["*"] = {
	-- 					require("formatter.filetypes.any").remove_trailing_whitespace,
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
