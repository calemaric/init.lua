return {
	"zbirenbaum/copilot.lua",
	config = function()
		require("copilot").setup({
			copilot_model = "gpt-4.1",
		})
	end,
}
