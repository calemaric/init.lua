return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = { preset = "enter" },
		appearance = {
			nerd_font_variant = "normal",
		},

		completion = { documentation = { auto_show = true, auto_show_delay_ms = 500 } },
		signature = { enabled = true },

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
	},
	opts_extend = { "sources.default" },
}
