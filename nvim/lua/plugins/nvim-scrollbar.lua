return {
	"petertriho/nvim-scrollbar",
	config = function()
		require("scrollbar").setup({
			excluded_filetypes = {
                "snipe-menu",
				"nofile",
				"neo-tree",
				"neo-tree filesystem",
				"dropbar_menu",
				"dropbar_menu_fzf",
				"DressingInput",
				"cmp_docs",
				"cmp_menu",
				"noice",
				"prompt",
				"TelescopePrompt",
				"fugitive",
			},
		})
	end,
}
