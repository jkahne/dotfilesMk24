return {

	{
		"iamcco/markdown-preview.nvim",
		enabled = false,
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
		config = function()
			vim.keymap.set("n", "<leader>mdn", ":MarkdownPreview<CR>")
			vim.keymap.set("n", "<leader>mds", ":MarkdownPreviewStop<CR>")

			-- vim.g.mkdp_markdown_css = "C:/users/micha/appdata/local/nvim/md.css"
			-- vim.g.mkdp_highlight_css = "C:/users/micha/appdata/local/nvim/mdhl.css"
		end,
	},
	{
		"roodolv/markdown-toggle.nvim",
		enabled = true,
		config = function()
			require("markdown-toggle").setup({
				-- If true, the auto-setup for the default keymaps is enabled
				use_default_keymaps = false,
				-- The keymaps are valid only for these filetypes
				filetypes = { "markdown", "markdown.mdx" },

				-- The list marks table used in cycle-mode (list_table[1] is used as the default list-mark)
				list_table = { "-", "+", "*", "=" },
				-- Cycle the marks in user-defined table when toggling lists
				cycle_list_table = false,

				-- The checkbox marks table used in cycle-mode (box_table[1] is used as the default checked-state)
				box_table = { "x", "~", "!", ">" },
				-- Cycle the marks in user-defined table when toggling checkboxes
				cycle_box_table = false,
				-- A bullet list is toggled before turning into a checkbox (similar to how it works in Obsidian).
				list_before_box = false,

				-- The heading marks table used in `markdown-toggle.heading`
				heading_table = { "#", "##", "###", "####", "#####" },

				-- Skip blank lines and headings in Visual mode (except for `quote()`)
				enable_blankhead_skip = true,
				-- Insert an indented quote for new lines within quoted text
				enable_inner_indent = false,
				-- Toggle only unmarked lines first
				enable_unmarked_only = true,
				-- Automatically continue lists on new lines
				enable_autolist = true,
				-- Maintain checkbox state when continuing lists
				enable_auto_samestate = true,
				-- Dot-repeat for toggle functions in Normal mode
				enable_dot_repeat = true,
			})

			vim.api.nvim_create_autocmd("FileType", {
				desc = "markdown-toggle.nvim keymaps",
				pattern = { "markdown", "markdown.mdx" },
				callback = function(args)
					local opts = { silent = true, noremap = true, buffer = args.buf }
					local toggle = require("markdown-toggle")

					-- Keymap configurations will be added here for each feature
					opts.expr = true -- required for dot-repeat in Normal mode
					-- vim.keymap.set("n", "<C-q>", toggle.quote_dot, opts)
					-- vim.keymap.set("n", "<C-l>", toggle.list_dot, opts)
					-- vim.keymap.set("n", "<Leader><C-l>", toggle.list_cycle_dot, opts)
					-- vim.keymap.set("n", "<C-n>", toggle.olist_dot, opts)
					vim.keymap.set("n", "<M-z>", toggle.checkbox_dot, opts)
					vim.keymap.set("n", "<M-a>", toggle.checkbox_cycle_dot, opts)
					-- vim.keymap.set("n", "<C-h>", toggle.heading_dot, opts)
					--
					opts.expr = false -- required for Visual mode
					-- vim.keymap.set("x", "<C-q>", toggle.quote, opts)
					-- vim.keymap.set("x", "<C-l>", toggle.list, opts)
					-- vim.keymap.set("x", "<Leader><C-l>", toggle.list_cycle, opts)
					-- vim.keymap.set("x", "<C-n>", toggle.olist, opts)
					vim.keymap.set("x", "<M-z>", toggle.checkbox, opts)
					vim.keymap.set("x", "<M-a>", toggle.checkbox_cycle, opts)
					-- vim.keymap.set("x", "<C-h>", toggle.heading, opts)
				end,
			})
		end,
	},
	{
		"lukas-reineke/headlines.nvim",
		enabled = true,
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			-- Define custom highlight groups using Vimscript
			vim.cmd([[highlight Headline1 guibg=#c792ea guifg=black]])
			vim.cmd([[highlight Headline2 guibg=#89ddff guifg=black]])
			vim.cmd([[highlight Headline3 guibg=#33728e guifg=white]])
			vim.cmd([[highlight Headline4 guibg=#274d61 guifg=white]])
			vim.cmd([[highlight Headline5 guibg=#163242 guifg=white]])
			vim.cmd([[highlight Headline6 guibg=#7e0000 guifg=white]])

			-- vim.cmd([[highlight Headline1 guibg=#295715 guifg=white]])
			-- vim.cmd([[highlight Headline2 guibg=#8d8200 guifg=white]])
			-- vim.cmd([[highlight Headline3 guibg=#a56106 guifg=white]])
			-- vim.cmd([[highlight Headline4 guibg=#7e0000 guifg=white]])
			-- vim.cmd([[highlight Headline5 guibg=#1e0b7b guifg=white]])
			-- vim.cmd([[highlight Headline6 guibg=#560b7b guifg=white]])

			-- Defines the codeblock background color to something darker
			-- vim.cmd([[highlight CodeBlock guibg=#09090d]])
			-- When you add a line of dashes with --- this specifies the color, I'm not
			-- adding a "guibg" but you can do so if you want to add a background color
			vim.cmd([[highlight Dash guifg=white]])

			-- Setup headlines.nvim with the newly defined highlight groups
			require("headlines").setup({
				markdown = {
					-- If set to false, headlines will be a single line and there will be no
					-- "fat_headline_upper_string" and no "fat_headline_lower_string"
					fat_headlines = false,
					--
					-- Lines added above and below the header line makes it look thicker
					-- "lower half block" unicode symbol hex:2584
					-- "upper half block" unicode symbol hex:2580
					-- fat_headline_upper_string = "▄",
					-- fat_headline_lower_string = " ", --  "▀",
					--
					-- You could add a full block if you really like it thick ;)
					-- fat_headline_upper_string = "█",
					-- fat_headline_lower_string = "█",
					--
					-- Other set of lower and upper symbols to try
					-- fat_headline_upper_string = "▃",
					-- fat_headline_lower_string = "-",
					--
					headline_highlights = {
						"Headline1",
						"Headline2",
						"Headline3",
						"Headline4",
						"Headline5",
						"Headline6",
					},
				},
			})
		end,
	},

	{
		"epwalsh/obsidian.nvim",
		enabled = true,
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		--   "BufReadPre path/to/my-vault/**.md",
		--   "BufNewFile path/to/my-vault/**.md",
		-- },
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",
			"s1n7ax/nvim-window-picker",
			-- see below for full list of optional dependencies 👇
		},
		init = function()
			vim.g.vim_markdown_frontmatter = 1
			vim.wo.conceallevel = 2
		end,
		config = function()
			require("obsidian").setup({
				workspaces = {
					{
						name = "Brain",
						path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain/",
						overrides = {
							notes_subdir = "00 Inbox",
						},
					},
					{
						name = "Brain23oey",
						path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain23eoy/",
					},
					{
						name = "worknotes",
						path = "~/projects/worknotes",
						overrides = {
							notes_subdir = "00 Inbox",
						},
					},
				},

				-- see below for full list of options 👇
				daily_notes = {
					-- Optional, if you keep daily notes in a separate directory.
					folder = "06 Dailies",
					-- Optional, if you want to change the date format for the ID of daily notes.
					-- date_format = "%Y-%m-%d",
					date_format = "%Y-wk%U",
					-- Optional, if you want to change the date format of the default alias of daily notes.
					alias_format = "%B %Y, week %U",
					-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
					template = nil,
				},

				-- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
				completion = {
					-- Set to false to disable completion.
					nvim_cmp = true,
					-- Trigger completion at 2 chars.
					min_chars = 2,
				},

				-- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
				-- way then set 'mappings = {}'.
				mappings = {
					-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
					["gd"] = {
						action = function()
							return require("obsidian").util.gf_passthrough()
						end,
						opts = { noremap = false, expr = true, buffer = true },
					},
					-- Toggle check-boxes.
					-- ["<leader>ch"] = {
					-- 	action = function()
					-- 		return require("obsidian").util.toggle_checkbox()
					-- 	end,
					-- 	opts = { buffer = true },
					-- },
					-- Smart action depending on context, either follow link or toggle checkbox.
					["<cr>"] = {
						action = function()
							return require("obsidian").util.smart_action()
						end,
						opts = { buffer = true, expr = true },
					},
				},

				-- Optional, customize how note IDs are generated given an optional title.
				---@param title string|?
				---@return string
				note_id_func = function(title)
					return title
				end,

				wiki_link_func = function(opts)
					if opts.id == nil then
						return string.format("[[%s]]", opts.label)
					elseif opts.label ~= opts.id then
						return string.format("[[%s|%s]]", opts.id, opts.label)
					else
						return string.format("[[%s]]", opts.id)
					end
				end,

				-- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
				-- URL it will be ignored but you can customize this behavior here.
				---@param url string
				follow_url_func = function(url)
					-- Open the URL in the default web browser.
					vim.fn.jobstart({ "open", url }) -- Mac OS
					-- vim.fn.jobstart({"xdg-open", url})  -- linux
				end,

				-- Where to put new notes. Valid options are
				--  * "current_dir" - put new notes in same directory as the current buffer.
				--  * "notes_subdir" - put new notes in the default notes subdirectory.
				new_notes_location = "current_dir",

				-- Optional, for templates (see below).
				templates = {
					subdir = "99 Meta/__templates",
					date_format = "%Y-%m-%d",
					time_format = "%H:%M",
					-- A map for custom variables, the key should be the variable and the value a function
					substitutions = {},
				},
				--
				picker = {
					-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
					name = "telescope.nvim",
					-- Optional, configure key mappings for the picker. These are the defaults.
					-- Not all pickers support all mappings.
					mappings = {
						-- Create a new note from your query.
						new = "<C-x>",
						-- Insert a link to the selected note.
						insert_link = "<C-l>",
					},
				},

				-- Optional, configure additional syntax highlighting / extmarks.
				-- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
				ui = {
					enable = true, -- set to false to disable all additional syntax features
					update_debounce = 200, -- update delay after a text change (in milliseconds)
					-- Define how various check-boxes are displayed
					checkboxes = {
						-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
						[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
						["x"] = { char = "", hl_group = "ObsidianDone" },
						[">"] = { char = "", hl_group = "ObsidianRightArrow" },
						["~"] = { char = "", hl_group = "ObsidianTilde" },
						["!"] = { char = "", hl_group = "ObsidianRefText" },
						-- Replace the above with this if you don't have a patched font:
						-- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
						-- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

						-- You can also add more custom ones...
					},
					-- Use bullet marks for non-checkbox lists.
					bullets = { char = "•", hl_group = "ObsidianBullet" },
					external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
					-- Replace the above with this if you don't have a patched font:
					-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
					reference_text = { hl_group = "ObsidianRefText" },
					highlight_text = { hl_group = "ObsidianHighlightText" },
					tags = { hl_group = "ObsidianTag" },
					block_ids = { hl_group = "ObsidianBlockID" },
					hl_groups = {
						-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
						ObsidianTodo = { bold = true, fg = "#f78c6c" },
						ObsidianDone = { bold = true, fg = "#89ddff" },
						ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
						ObsidianTilde = { bold = true, fg = "#ff5370" },
						ObsidianBullet = { bold = true, fg = "#89ddff" },
						ObsidianRefText = { underline = true, fg = "#c792ea" },
						ObsidianExtLinkIcon = { fg = "#c792ea" },
						ObsidianTag = { italic = true, fg = "#89ddff" },
						ObsidianBlockID = { italic = true, fg = "#89ddff" },
						ObsidianHighlightText = { bg = "#75662e" },
					},
				},

				--
				-- Specify how to handle attachments.
				attachments = {
					-- The default folder to place images in via `:ObsidianPasteImg`.
					-- If this is a relative path it will be interpreted as relative to the vault root.
					-- You can always override this per image by passing a full path to the command instead of just a filename.
					img_folder = "99 Meta/__media", -- This is the default
				},
			})

			vim.keymap.set("n", "<leader>ot", ":ObsidianTOC<CR>", { noremap = true, silent = true })
		end,
	},

	{
		-- This plugin automatically adds bulletpoints on the next line respecting
		-- indentation
		-- In markdown or a text file start a bulleted list using - or *. Press return
		-- to go to the next line, a new list item will be created.
		--
		-- When in insert mode, you can increase indentation with ctrl+t and decrease it
		-- with ctrl+d
		--
		-- By default its enabled on filetypes 'markdown', 'text', 'gitcommit', 'scratch'
		-- https://github.com/bullets-vim/bullets.vim
		"bullets-vim/bullets.vim",
		enabled = true,
		config = function()
			-- Disable deleting the last empty bullet when pressing <cr> or 'o'
			-- default = 1
			vim.g.bullets_delete_last_bullet_if_empty = 1

			-- (Optional) Add other configurations here
			-- For example, enabling/disabling mappings
			-- vim.g.bullets_set_mappings = 1
		end,
	},
}
