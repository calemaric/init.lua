return {
	"saghen/blink.cmp",
	dependencies = { "fang2hou/blink-copilot", "rafamadriz/friendly-snippets" },

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = { preset = "enter" },
		appearance = {
			nerd_font_variant = "normal",
		},

		completion = {
			documentation = { auto_show = true, auto_show_delay_ms = 200 },
		},

		signature = { enabled = true },

		sources = {
			default = { "copilot", "lsp", "path", "snippets", "buffer", "codecompanion" },
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-copilot",
					score_offset = 100,
					async = true,
					opts = {
						max_completions = 3,
					},
				},
			},
		},
		enabled = function()
			return not vim.list_contains({ "codecompanion" }, vim.bo.filetype)
				and vim.bo.buftype ~= "prompt"
				and vim.b.completion ~= false
		end,
	},
}
