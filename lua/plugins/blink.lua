return {
	"saghen/blink.cmp",
	version = "2.*",
	build = function() require("blink.cmp").build():wait(30000) end,
	dependencies = { "saghen/blink.lib", "rafamadriz/friendly-snippets" },

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
			default = { "lsp", "path", "snippets", "buffer", "codecompanion" },
		},
	},
}
