return {
	"tpope/vim-fugitive",
	config = function()
		-- add quit keymap for vim-fugitive
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "fugitive",
			callback = function(args)
				vim.api.nvim_buf_set_keymap(args.buf, "n", "<Esc>", ":quit<CR>", { silent = true })
				vim.api.nvim_buf_set_keymap(args.buf, "n", "<leader>gs", ":quit<CR>", { silent = true })
			end,
		})
	end,
}
