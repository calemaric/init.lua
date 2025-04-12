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
				},
				inline = {
					adapter = "copilot",
				},
			},
		})

		vim.keymap.set("n", "<leader>aic", function()
			require("codecompanion").toggle()
		end, { desc = "[A][I] [C]hat" })
		vim.keymap.set("v", "<leader>aic", function()
			require("codecompanion").toggle()
		end, { desc = "[A][I] [C]hat" })
	end,
}
