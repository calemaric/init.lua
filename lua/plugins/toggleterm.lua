return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			-- size can be a number or function which is passed the current terminal
			size = 20,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shade_terminals = true,
			start_in_insert = true,
			persist_size = true,
			direction = "horizontal",
		})
	end,
}
