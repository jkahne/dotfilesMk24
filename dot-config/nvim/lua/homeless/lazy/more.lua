return {
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
				-- Old text                    Command         New text
				-- surr*ound_words             ysiw)           (surround_words)
				-- *make strings               ys$"            "make strings"
				-- [delete ar*ound me!]        ds]             delete around me!
				-- remove <b>HTML t*ags</b>    dst             remove HTML tags
				-- 'change quot*es'            cs'"            "change quotes"
				-- <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
				-- delete(functi*on calls)     dsf             function calls
			})
		end,
	},

	{
		"tpope/vim-abolish",
		-- fooBar => foo_bar  :  crs (coerce to snake_case)
		-- MixedCase (crm),
		-- camelCase (crc),
		-- UPPER_CASE (cru),
		-- dash-case (cr-),
		-- dot.case (cr.)
	},

	{ "rizzatti/dash.vim" },

	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup()
			vim.keymap.set("n", "<leader>k", function()
				require("lsp_signature").toggle_float_win()
			end, { silent = true, noremap = true, desc = "toggle signature" })
		end,
	},
	{ "kshenoy/vim-signature" },
	{
		"mhinz/vim-signify",
		init = function()
			vim.g.signify_update_on_bufenter = 1
			vim.g.signify_update_on_focusgained = 1
		end,
	},

	{
		"junegunn/vim-easy-align",
		config = function()
			vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", { noremap = false, silent = true })
			vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { noremap = false, silent = true })
		end,
	},

	{ "mg979/vim-visual-multi" },

	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				{
					opts = {
						-- Defaults
						enable_close = true, -- Auto close tags
						enable_rename = true, -- Auto rename pairs of tags
						enable_close_on_slash = true, -- Auto close on trailing </
					},
					-- Also override individual filetype configs, these take priority.
					-- Empty by default, useful if one of the "opts" global settings
					-- doesn't work well in a specific filetype
					-- per_filetype = {
					--   ["html"] = {
					--     enable_close = false
					--   }
					-- }
				},
			})
		end,
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		-- @type Flash.Config
		opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
		config = function()
			require("flash").setup({
				modes = {
					char = {
						enabled = false,
					},
				},
			})
		end,
	},
	{
		"azabiong/vim-highlighter",
		init = function()
			vim.cmd([[
        let HiSet   = 'f<CR>'
        let HiErase = 'f<BS>'
        let HiClear = 'f<C-l>'
        let HiFind  = 'f<Tab>'
        " let HiSetSL = 't<CR>'
        ]])

			-- vim.keymap.set("n", "g<cr>", "<cmd>Hi><CR>")
			-- vim.keymap.set("n", "gb<cr>", "<cmd>Hi<<CR>")
			-- nn <CR>   <Cmd>Hi><CR>
			-- nn g<CR>  <Cmd>Hi<<CR>
			-- nn ]<CR>  <Cmd>Hi}<CR>
			-- nn [<CR>  <Cmd>Hi{<CR>
		end,
	},

	{
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("aerial").setup({
				-- optionally use on_attach to set keymaps when aerial has attached to a buffer
				on_attach = function(bufnr)
					-- Jump forwards/backwards with '{' and '}'
					vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				end,
			})
			-- You probably also want to set a keymap to toggle aerial
			vim.keymap.set("n", "<leader>aa", "<cmd>AerialToggle!<CR>")
		end,
	},

	-- consider using https://github.com/klen/nvim-test instead
	-- looks like you can configure to append docker commands to the test commands (see comments below 🤝)
	{
		"vim-test/vim-test",
		config = function()
			-- vim.g['test#strategy'] = 'basic'
			-- vim.g['test#strategy'] = 'neovim_sticky'

			vim.keymap.set(
				"n",
				"<Leader>sa",
				":TestSuite<CR>",
				{ noremap = true, silent = true, desc = "Run Test Suite" }
			)
			vim.keymap.set(
				"n",
				"<Leader>sf",
				":TestFile<CR>",
				{ noremap = true, silent = true, desc = "Run Test File" }
			)
			vim.keymap.set(
				"n",
				"<Leader>ss",
				":TestNearest<CR>",
				{ noremap = true, silent = true, desc = "Run Nearest Test" }
			)
			vim.keymap.set(
				"n",
				"<Leader>sl",
				":TestLast<CR>",
				{ noremap = true, silent = true, desc = "Run Last Test" }
			)
			vim.keymap.set(
				"n",
				"<Leader>sv",
				":TestVisit<CR>",
				{ noremap = true, silent = true, desc = "Visit Test File" }

				-- vim.cmd("let test#strategy = 'vimux'")
			)
		end,
	},
	-- comment 🤝 here
	-- This is code taken from https://gitlab.com/oinak/dot_config_nvim/-/blob/main/lua/plugins/languages.lua?ref_type=heads
	-- I have not tried this yet
	--  {
	--   'klen/nvim-test', -- run tests from nvim
	--   dependencies = { "nvim-treesitter/nvim-treesitter", },
	--   config = function()
	--     require('nvim-test').setup({
	--       termOpts = {
	--         direction = "horizontal", -- terminal's direction ("horizontal"|"vertical"|"float")
	--       },
	--     })
	--
	--     require('nvim-test.runners.rspec'):setup({
	--       command = 'docker-compose',
	--       args = { "exec", "web", "bundle", "exec", "rspec" },
	--       file_pattern = "\\v(spec_[^.]+|[^.]+_spec)\\.rb$",
	--       find_files = { "{name}_spec.rb" },
	--     })
	--
	--     vim.keymap.set("n", "<leader>tn", vim.cmd.TestNearest, { desc = '[T]est [N]earest' })
	--     vim.keymap.set("n", "<leader>tf", vim.cmd.TestFile, { desc = '[T]est [F]ile' })
	--     vim.keymap.set("n", "<leader>ts", vim.cmd.TestSuite, { desc = '[T]est [S]uite' })
	--     vim.keymap.set("n", "<leader>tl", vim.cmd.TestLast, { desc = '[T]est [L]ast' })
	--     vim.keymap.set("n", "<leader>tv", vim.cmd.TestVisit, { desc = '[T]est [V]isit' })
	--   end,
	-- },

	{
		"szw/vim-maximizer",
		config = function()
			-- Set up key mapping for maximizing the current split window
			vim.keymap.set(
				"n",
				"<C-w>m",
				":MaximizerToggle!<CR>",
				{ noremap = true, silent = true, desc = "Toggle maximize current split" }
			)
		end,
	},

	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "git", ":Git ")
			-- vim.keymap.set("n", "gb",  ":Git blame<CR>")
			-- vim.keymap.set("n", "gap", ":Git add -p<CR>")
		end,
	},

	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			-- { "<leader>lz", "<cmd>LazyGit<cr>", desc = "LazyGit" },
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},

		config = function()
			require("lazy").setup()
		end,
	},

	-- {
	--   'numToStr/Comment.nvim',
	--   opts = {
	--     -- add any options here
	--   },
	--   lazy = false,
	--   config = function()
	--     require('Comment').setup({})
	--   end
	-- },

	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end,
	},

	{
		"rgroli/other.nvim",
		config = function()
			require("other-nvim").setup({
				mappings = {
					-- builtin mappings
					-- "livewire",
					-- "angular",
					-- "laravel",
					"rails",
					-- "golang",
					-- custom mapping
					-- {
					--     pattern = "/path/to/file/src/app/(.*)/.*.ext$",
					--     target = "/path/to/file/src/view/%1/",
					--     transformer = "lowercase"
					-- }
				},
				transformers = {
					-- defining a custom transformer
					-- lowercase = function (inputString)
					--     return inputString:lower()
					-- end
				},
				style = {
					-- How the plugin paints its window borders
					-- Allowed values are none, single, double, rounded, solid and shadow
					border = "solid",

					-- Column seperator for the window
					seperator = "|",

					-- width of the window in percent. e.g. 0.5 is 50%, 1.0 is 100%
					width = 0.7,

					-- min height in rows.
					-- when more columns are needed this value is extended automatically
					minHeight = 2,
				},
			})

			vim.api.nvim_set_keymap("n", "<leader>ll", "<cmd>:Other<CR>", { noremap = true, silent = true })
			-- vim.api.nvim_set_keymap("n", "<leader>ltn", "<cmd>:OtherTabNew<CR>", { noremap = true, silent = true })
			-- vim.api.nvim_set_keymap("n", "<leader>lp", "<cmd>:OtherSplit<CR>", { noremap = true, silent = true })
			-- vim.api.nvim_set_keymap("n", "<leader>lv", "<cmd>:OtherVSplit<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>lc", "<cmd>:OtherClear<CR>", { noremap = true, silent = true })

			-- Context specific bindings
			-- vim.api.nvim_set_keymap("n", "<leader>lt", "<cmd>:Other test<CR>", { noremap = true, silent = true })
			-- vim.api.nvim_set_keymap("n", "<leader>ls", "<cmd>:Other scss<CR>", { noremap = true, silent = true })
		end,
	},
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim", -- optional
			"neovim/nvim-lspconfig", -- optional
		},
		opts = {}, -- your configuration
		config = function()
			require("tailwind-tools").setup({
				document_color = {
					enabled = true, -- can be toggled by commands
					kind = "background", -- "inline" | "foreground" | "background"
				},

				vim.api.nvim_set_keymap(
					"n",
					"<leader>fc",
					"<cmd>:TailwindColorToggle<CR>",
					{ noremap = true, silent = true }
				),
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"luckasRanarison/tailwind-tools.nvim",
			"onsails/lspkind-nvim",
		},
		opts = function()
			return {
				formatting = {
					format = require("lspkind").cmp_format({
						before = require("tailwind-tools.cmp").lspkind_format,
					}),
				},
			}
		end,
	},
	{
		"kevinhwang91/nvim-bqf", -- better quickfix
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		build = ":TSUpdate",
		config = function()
			vim.api.nvim_set_keymap("n", "<leader>cn", ":cnext<cr>", {})
			vim.api.nvim_set_keymap("n", "<leader>cp", ":cprevious<cr>", {})
		end,
	},
}
