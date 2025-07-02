return {
	"olimorris/codecompanion.nvim",
	opts = {},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		local constants = {
			USER_ROLE = "user",
			SYSTEM_ROLE = "system",
		}

		require("codecompanion").setup({
			prompt_library = {
				["Story Planning Workflow"] = {
					strategy = "workflow",
					description = "Guide user from story acceptance criteria to dev and test plans",
					opts = {
						index = 5,
						short_name = "story",
						is_default = false,
					},
					prompts = {
						{
							{
								role = constants.USER_ROLE,
								content = [[Acceptance Criteria:


---------

Break down the work into logical tasks, considering architecture, dependencies, and integration points.

For each step, specify what needs to be done, why it is necessary, and any relevant considerations (e.g., refactoring, code reuse, documentation, testing hooks). Ensure the plan is actionable and covers all acceptance criteria.

]],
								opts = { auto_submit = false },
							},
						},
						{
							{
								role = constants.USER_ROLE,
								content = [[Now, create a comprehensive test plan to verify that all acceptance criteria are met. 
For each criterion, describe the test approach (manual/automated), test cases, expected results, and any edge cases to consider. Include both positive and negative scenarios. If relevant, specify tools, frameworks, or data needed for testing. Ensure the plan is clear enough for another developer or QA to follow.]],
								opts = { auto_submit = true },
							},
						},
					},
				},
			},
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
						query = {
							tool_opts = {
								chunk_mode = true,
							},
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
