-- help command but in fullscreen
vim.api.nvim_create_user_command("H", "tab help <args>", {
	nargs = "?",
	complete = function(arg_lead, _, _)
		return vim.fn.getcompletion(arg_lead, "help")
	end,
})

-- add close and goto keymap for help pages
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function(args)
		vim.api.nvim_buf_set_keymap(args.buf, "n", "<Esc>", ":quit<CR>", { silent = true })
		vim.api.nvim_buf_set_keymap(args.buf, "n", "gd", "<C-]>", { silent = true })
	end,
})
