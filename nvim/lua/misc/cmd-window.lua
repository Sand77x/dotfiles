-- add enter keymap for cmdline-window
vim.api.nvim_create_autocmd("CmdwinEnter", {
	pattern = "*",
	callback = function(args)
		vim.api.nvim_buf_set_keymap(args.buf, "n", "<CR>", "<CR>", {})
		vim.api.nvim_buf_set_keymap(args.buf, "v", "<CR>", "<CR>", {})
		vim.api.nvim_buf_set_keymap(args.buf, "n", "<Esc>", ":q<CR>", { silent = true })
	end,
})

-- new keymap for cmdline-window
vim.keymap.set("n", "<leader>q", "q:")
