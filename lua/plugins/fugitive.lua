return {
	"tpope/vim-fugitive",
	config = function()
		local get_gbrowse = function()
			local cursor_position = vim.api.nvim_win_get_cursor(0)[1]
			return cursor_position .. "GBrowse"
		end
		local get_open_command = function()
			vim.cmd(get_gbrowse())
		end

		local get_copy_command = function()
			vim.cmd(get_gbrowse() .. "!")
		end

		vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]tatus" })
		vim.keymap.set("n", "<leader>go", get_open_command, { desc = "[O]pen Line" })
		vim.keymap.set("n", "<leader>gc", get_copy_command, { desc = "[C]opy Line" })

		local autocmd = vim.api.nvim_create_autocmd
		autocmd("BufWinEnter", {
			pattern = "*",
			callback = function()
				if vim.bo.ft ~= "fugitive" then
					return
				end

				local bufnr = vim.api.nvim_get_current_buf()
				local opts = { desc = "[P]ush", buffer = bufnr, remap = false }
				vim.keymap.set("n", "<leader>p", function()
					vim.cmd.Git("push")
				end, opts)

				vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
			end,
		})
	end,
}
