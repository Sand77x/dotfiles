return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				sources = {
					"filesystem",
					"document_symbols",
				},
				filesystem = {
					window = {
						position = "current",
						mappings = {
							["-"] = "navigate_up",
							["."] = "set_root",
							["l"] = "open",
                            ["<C-f>"] = "filter_on_submit",
                            ["<C-x>"] = "clear_filter",
							["<Esc>"] = "close_window",
							["<leader>pv"] = "close_window",
						},
					},
					follow_current_file = {
						enabled = true,
					},
				},
			})
		end,
	},
}
