return {

	{
		"echasnovski/mini.nvim",
		version = "*",
		config = function()
			require("mini.icons").setup()
			require("mini.files").setup({
				windows = {
					preview = true,
				},
			})

			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})
		end,
	},

	{
		"okuuva/auto-save.nvim",
		cmd = "ASToggle", -- optional for lazy loading on command
		event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
		opts = {
			--
			-- All of these are just the defaults
			--
			enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
			trigger_events = { -- See :h events
				immediate_save = { "BufLeave", "FocusLost" }, -- vim events that trigger an immediate save
				defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
				cancel_deferred_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
			},
			-- function that takes the buffer handle and determines whether to save the current buffer or not
			-- return true: if buffer is ok to be saved
			-- return false: if it's not ok to be saved
			-- if set to `nil` then no specific condition is applied
			-- condition = nil,
			condition = function(buf)
				local fn = vim.fn
				local utils = require("auto-save.utils.data")

				-- don't save for `sql` file types
				if utils.not_in(fn.getbufvar(buf, "&filetype"), { "sql" }) then
					return true
				end
				return false
			end,
			write_all_buffers = false, -- write all buffers when the current one meets `condition`
			noautocmd = false, -- do not execute autocmds when saving
			lockmarks = false, -- lock marks when saving, see `:h lockmarks` for more details
			debounce_delay = 1000, -- delay after which a pending save is executed
			-- log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
			debug = false,
		},
		config = function()
			require("auto-save").setup()
			local group = vim.api.nvim_create_augroup("autosave", {})

			vim.api.nvim_create_autocmd("User", {
				pattern = "AutoSaveWritePost",
				group = group,
				callback = function(opts)
					if opts.data.saved_buffer ~= nil then
						local filename = vim.api.nvim_buf_get_name(opts.data.saved_buffer)
						print("AutoSave: saved " .. filename .. " at " .. vim.fn.strftime("%H:%M:%S"))
					end
				end,
			})
		end,
	},

	-- {
	-- 	"akinsho/bufferline.nvim",
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- 	version = "*",
	-- 	opts = {
	-- 		options = {
	-- 			mode = "tabs",
	-- 			separator_style = "slant",
	-- 		},
	-- 	},
	-- },
	--

	-- {
	-- 	"echasnovski/mini.hipatterns",
	-- 	config = function()
	-- 	end,
	-- },
}
