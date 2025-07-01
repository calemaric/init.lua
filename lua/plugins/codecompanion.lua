return {
	"olimorris/codecompanion.nvim",
	opts = {},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "copilot",
					tools = {
						opts = {
							default_tools = {
								"next_edit_suggestion",
							},
						},
					},
				},
				inline = {
					adapter = "copilot",
				},
			},
			display = {
				chat = {
					show_header_separator = true,
				},
			},
			extensions = {
				vectorcode = {
					opts = {
						add_tool = true,
						tool_opts = {
							chunk_mode = true,
						},
					},
				},
				mcphub = {
					callback = "mcphub.extensions.codecompanion",
					opts = {
						show_result_in_chat = true, -- Show mcp tool results in chat
						make_vars = true, -- Convert resources to #variables
						make_slash_commands = true, -- Add prompts as /slash commands
					},
				},
			},
		})

		vim.keymap.set({ "n", "v" }, "<C-a>", require("codecompanion").actions, { noremap = true, silent = true })
		vim.keymap.set(
			{ "n", "v" },
			"<LocalLeader>a",
			require("codecompanion").toggle,
			{ noremap = true, silent = true }
		)
		vim.keymap.set("v", "ga", require("codecompanion").add, { noremap = true, silent = true })

		-- Expand 'cc' into 'CodeCompanion' in the command line
		vim.cmd([[cab cc CodeCompanion]])
	end,
}
