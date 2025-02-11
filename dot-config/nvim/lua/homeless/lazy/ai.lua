return {
	-- {
	-- 	"robitx/gp.nvim",
	-- 	config = function()
	-- 		local conf = {
	-- 			-- For customization, refer to Install > Configuration in the Documentation/Readme
	-- 			providers = {
	-- 				openai = {
	-- 					endpoint = "https://api.openai.com/v1/chat/completions",
	-- 					-- secret = os.getenv("OPENAI_API_KEY"),
	-- 				},
	--
	-- 				anthropic = {
	-- 					endpoint = "https://api.anthropic.com/v1/messages",
	-- 					-- secret = os.getenv("ANTHROPIC_API_KEY"),
	-- 				},
	-- 			},
	-- 		}
	-- 		require("gp").setup(conf)
	--
	-- 		-- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
	-- 	end,
	-- },
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("codecompanion").setup({
				strategies = {
					chat = {
						adapter = "anthropic",
					},
					inline = {
						adapter = "anthropic",
					},
				},
				adapters = {
					anthropic = function()
						return require("codecompanion.adapters").extend("anthropic", {
							env = {
								api_key = "cmd:op read op://personal/ClaudeAPI/credential --no-newline",
							},
						})
					end,
					openai = function()
						return require("codecompanion.adapters").extend("openai", {
							env = {
								api_key = "cmd:op read op://personal/OpenAI/credential --no-newline",
							},
						})
					end,
				},
			})
		end,
	},
}
