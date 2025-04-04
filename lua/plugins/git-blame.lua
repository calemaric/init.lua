return {
	"f-person/git-blame.nvim",
	event = "VeryLazy",
	config = function()
		local gitblame = require("gitblame")
		vim.keymap.set(
			"n",
			"<leader>gbc",
			gitblame.copy_commit_url_to_clipboard,
			{ desc = "[G]it [B]lame [C]ommit URL" }
		)
		vim.keymap.set("n", "<leader>gbo", gitblame.open_commit_url, { desc = "[G]it [B]lame [O]pen Commit URL" })
	end,
}
