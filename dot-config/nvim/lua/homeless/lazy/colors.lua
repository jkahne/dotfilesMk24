function ColorMyPencils(color)
	color = color or "terafox"
	-- color = color or "happy_hacking"
	-- color = color or "hybrid_reverse"
	vim.cmd.colorscheme(color)
	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {

	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	config = function()
	-- 		require("kanagawa").load("wave")
	-- 	end,
	-- },

	{
		"rmehri01/onenord.nvim",
		lazy = false,
		config = function()
			local colors = require("config.colors").colors

			-- local prompt = colors.grey14
			-- local results = colors.grey14
			-- local preview = colors.grey14
			-- local float_bg = colors.grey14

			require("onenord").setup({
				-- borders = true,
				-- fade_nc = false,
				-- styles = {
				--   comments = "italic",
				--   strings = "NONE",
				--   keywords = "NONE",
				--   functions = "NONE",
				--   variables = "NONE",
				--   diagnostics = "italic",
				-- },
				disable = {
					background = true,
					float_background = true,
					-- cursorline = false,
					--   eob_lines = true,
				},
				-- custom_highlights = {
				--   -- Examples
				--   -- LspDiagnosticsUnderlineInformation = { style = config.styles.diagnostics, sp = colors.info },
				--   -- ["@text.uri"] = { fg = colors.cyan, style = "underline" },
				--   -- Todo = { fg = colors.yellow, bg = colors.none, style = "bold,italic" },
				--   -- DiagnosticError = { link = "LspDiagnosticsDefaultError" },
				--
				-- Nvim Core
				Folded = { fg = colors.grey10 },
				--   VertSplit = { fg = colors.lblue },
				--   MsgArea = { fg = colors.grey7 },
				--   NormalFloat = { bg = colors.grey14 },
				--   FloatBorder = { bg = colors.grey14, fg = colors.grey14 },
				--   IncSearch = { style = "reverse" },
				--
				--   -- LSP Document Highlights
				--   -- gui=bold guifg=#81a1c1 guibg=#4c566a
				--   LspReferenceText = { bg = colors.grey11, style = "none" },
				--   LspReferenceRead = { link = "LspReferenceText", style = "none" },
				--   LspReferenceWrite = { link = "LspReferenceText", style = "none" },
				--
				--   -- Better Quick List
				--   BqfPreviewBorder = { fg = float_bg },
				--   -- BqfPreviewFloat = { bg = float_bg },
				--
				--   -- Notify
				--   NotifyBackground = { bg = float_bg },
				--
				--   -- Color Column
				--   NonText = { fg = colors.grey13 },
				--
				--   -- Rnvimr
				--   RnvimrNormal = { bg = float_bg },
				--
				--   -- Neotree
				--   NeoTreeNormal = { bg = float_bg },
				--
				--   -- Whichkey
				--   -- WhichKeyFloat = { bg = float_bg },
				--   -- WhichKey = { fg = colors.magenta },
				--   -- WhichKeyGroup = { fg = colors.grey7 },
				--   -- WhichKeySeparator = { fg = colors.grey12 },
				--   -- WhichKeyDesc = { fg = colors.grey7 },
				--   -- WhichKeyValue = { fg = colors.grey7 },
				--
				--   -- Color columns
				--   VirtColumn = { bg = colors.bg, fg = colors.grey13 },
				--
				--   -- Buffer Line
				--   BufferLineIndicatorSelected = { fg = colors.cyan, bg = colors.bg },
				--   BufferLineFill = { fg = colors.fg, bg = colors.grey14 },
				--
				--   -- Telescope
				--   -- https://github.com/nvim-telescope/telescope.nvim/blob/master/plugin/telescope.lua
				--   TelescopeMatching = { fg = colors.blue },
				--   TelescopeNormal = { fg = colors.grey8 },
				--   TelescopePreviewBorder = { bg = preview, fg = preview },
				--   TelescopePreviewNormal = { bg = preview },
				--   TelescopePreviewTitle = { fg = preview },
				--
				--   TelescopePromptNormal = { bg = prompt },
				--   TelescopePromptBorder = { bg = prompt, fg = prompt },
				--   TelescopePromptPrefix = { bg = prompt },
				--   TelescopePromptTitle = { fg = prompt },
				--
				--   TelescopeResultsBorder = { bg = results, fg = results },
				--   TelescopeResultsNormal = { bg = results },
				--   TelescopeResultsTitle = { fg = results },
				--   -- The current item
				--   TelescopeSelection = { fg = colors.magenta_dark, bg = results },
				--   TelescopeSelectionCaret = { fg = colors.magenta_dark, bg = results },
				-- },
			})
		end,
	},

	-- {
	-- 	"EdenEast/nightfox.nvim",
	-- 	config = function()
	-- 		require("nightfox").setup({
	-- 			-- disable_background = true,
	-- 		})
	-- 		ColorMyPencils()
	-- 	end,
	-- },

	-- {
	--   "lukas-reineke/indent-blankline.nvim",
	--   main = "ibl",
	--   opts = {},
	--   config = function()
	--     -- local highlight = {
	--     --   "RainbowRed",
	--     --   "RainbowYellow",
	--     --   "RainbowBlue",
	--     --   "RainbowOrange",
	--     --   "RainbowGreen",
	--     --   "RainbowViolet",
	--     --   "RainbowCyan",
	--     -- }
	--
	--     local hooks = require("ibl.hooks")
	--     -- create the highlight groups in the highlight setup hook, so they are reset
	--     -- every time the colorscheme changes
	--     hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	--       vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
	--       vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
	--       vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
	--       vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
	--       vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
	--       vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
	--       vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
	--     end)
	--
	--     -- require("ibl").setup { indent = { highlight = highlight } }
	--     -- require("ibl").setup {  }
	--   end,
	-- },
}
