return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",

			build = "make",

			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },

		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		local ts_select_dir_for_grep = function(prompt_bufnr)
			local action_state = require("telescope.actions.state")
			local fb = require("telescope").extensions.file_browser
			local live_grep = require("telescope.builtin").live_grep
			local current_line = action_state.get_current_line()

			fb.file_browser({
				files = false,
				depth = false,
				attach_mappings = function(prompt_bufnr)
					require("telescope.actions").select_default:replace(function()
						local entry_path = action_state.get_selected_entry().Path
						local dir = entry_path:is_dir() and entry_path or entry_path:parent()
						local relative = dir:make_relative(vim.fn.getcwd())
						local absolute = dir:absolute()

						live_grep({
							results_title = relative .. "/",
							cwd = absolute,
							default_text = current_line,
						})
					end)

					return true
				end,
			})
		end

		require("telescope").setup({
			defaults = {
				preview = {
					filesize_limit = 0.2, -- MB
				},
				mappings = {
					i = {
						["<C-j>"] = "move_selection_next",
						["<C-k>"] = "move_selection_previous",
					},
				},
				path_display = { "truncate" },
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				file_browser = {
					theme = "dropdown",

					display_stat = { date = true },

					hidden = { file_browser = true, folder_browser = true },
					-- disables netrw and use telescope-file-browser in its place
					hijack_netrw = true,
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					find_command = {
						"rg",
						"--files",
						"--hidden",
						"--glob=!**/.git/*",
						"--glob=!**/.idea/*",
						"--glob=!**/.vscode/*",
						"--glob=!**/build/*",
						"--glob=!**/dist/*",
						"--glob=!**/yarn.lock",
						"--glob=!**/package-lock.json",
						"--glob=!**/.github/*",
					},
				},
				live_grep = {
					mappings = {
						i = {
							["<C-f>"] = ts_select_dir_for_grep,
						},
						n = {
							["<C-f>"] = ts_select_dir_for_grep,
						},
					},
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		pcall(require("telescope").load_extension, "file_browser")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
		vim.keymap.set(
			"n",
			"<space>fb",
			":Telescope file_browser path=%:p:h select_buffer=true<CR>",
			{ desc = "Open [F]ile [b]rowser in current buffer directory" }
		)
		vim.keymap.set("n", "<space>fB", function()
			require("telescope").extensions.file_browser.file_browser()
		end, { desc = "Open [F]ile [B]rowser in root" })

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to Telescope to change the theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		-- It's also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		-- Shortcut for searching your Neovim configuration files
		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim files" })
	end,
}
