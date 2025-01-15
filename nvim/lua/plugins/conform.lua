return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "isort", "black" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
			},
			formatters = {
				prettier = {
					command = "C:/nvim-formatters/prettier.cmd",
				},
			},
			config = function()
				-- enable format on save for these filetypes
				local fts = { "*.js", "*.html", "*.css", "*.scss", "*.lua", "*.py" }

				vim.api.nvim_create_autocmd("BufWritePre", {
					pattern = fts,
					callback = function(args)
						require("conform").format({ bufnr = args.buf })
					end,
				})
			end,
		})
	end,
}
