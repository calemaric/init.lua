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
				["Story plan"] = {
					strategy = "workflow",
					description = "Guide user from story acceptance criteria to dev plans based on acceptance criteria.",
					opts = {
						index = 0,
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

Make a list of search terms to determine what needs to be updated based on the plan.

]],
								opts = { auto_submit = false },
							},
						},
						{
							{
								role = constants.USER_ROLE,
								content = [[Use @{vectorcode_query} to search the codebase. Then summarize the proposed locations and give explanation why they need to be updated.]],
								opts = { auto_submit = true },
							},
						},
						{
							{
								role = constants.USER_ROLE,
								content = [[Make the final plan and and provide next actions. For each step, specify what needs to be done, why it is necessary, and any relevant considerations (e.g., refactoring, code reuse, documentation, testing hooks). Ensure the plan is actionable and covers all acceptance criteria.]],
								opts = { auto_submit = true },
							},
						},
					},
				},
				["Test plan"] = {
					strategy = "workflow",
					description = "Create test plan for the story.",
					opts = {
						index = 1,
						short_name = "testplan",
						is_default = false,
					},
					prompts = {
						{
							{
								role = constants.USER_ROLE,
								content = [[Acceptance Criteria:


---------

@{mcp}

Create a comprehensive test plan based on the git diff to verify that all acceptance criteria are met. 
For each criterion, describe the test approach (manual/automated), test cases, expected results, and any edge cases to consider. Include both positive and negative scenarios. If relevant, specify tools, frameworks, or data needed for testing. Ensure the plan is clear enough for another developer or QA to follow.

]],
								opts = { auto_submit = false },
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
						tool_opts = {
							query = {
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
