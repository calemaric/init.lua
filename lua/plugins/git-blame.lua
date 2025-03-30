return {
	"f-person/git-blame.nvim",
	event = "VeryLazy",
	config = function()
		local gitblame = require("gitblame")
		vim.keymap.set("n", "<leader>gc", gitblame.copy_commit_url_to_clipboard, { desc = "[G]it [C]ommit URL" })
		vim.keymap.set("n", "<leader>go", gitblame.open_commit_url, { desc = "[G]it [O]pen Commit URL" })
	end,
}
