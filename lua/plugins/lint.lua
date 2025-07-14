return {
	"mfussenegger/nvim-lint",
	config = function()
		vim.env.ESLINT_D_PPID = vim.fn.getpid()
		require("lint").linters_by_ft = {
			javascript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescript = { "eslint_d" },
			typescriptreact = { "eslint_d" },
		}

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
