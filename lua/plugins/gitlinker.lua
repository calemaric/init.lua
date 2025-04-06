return {
	"ruifm/gitlinker.nvim",
	requires = "nvim-lua/plenary.nvim",
	config = function()
		require("gitlinker").setup({
			mappings = nil,
			callbacks = {
				["github.com"] = require("gitlinker.hosts").get_github_type_url,
				["code.devsnc.com"] = require("gitlinker.hosts").get_github_type_url,
			},
		})

		vim.api.nvim_set_keymap(
			"n",
			"<leader>go",
			'<cmd>lua require("gitlinker").get_buf_range_url("n", {action_callback = require("gitlinker.actions").open_in_browser})<cr>',
			{ silent = true, desc = "[O]pen permalink in browser" }
		)
		vim.api.nvim_set_keymap(
			"v",
			"<leader>go",
			'<cmd>lua require("gitlinker").get_buf_range_url("v", {action_callback = require("gitlinker.actions").open_in_browser})<cr>',
			{ silent = true, desc = "[O]pen permalink range in browser" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>cy",
			'<cmd>lua require("gitlinker").get_buf_range_url("n", {action_callback = require("gitlinker.actions").copy_to_clipboard})<cr>',
			{ silent = true, desc = "[C]opy permalink to clipboard" }
		)
		vim.api.nvim_set_keymap(
			"v",
			"<leader>cy",
			'<cmd>lua require("gitlinker").get_buf_range_url("v", {action_callback = require("gitlinker.actions").copy_to_clipboard})<cr>',
			{ silent = true, desc = "[C]opy permalink range to clipboard" }
		)
	end,
}
