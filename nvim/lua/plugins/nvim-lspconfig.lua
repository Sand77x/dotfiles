return {
	"mfussenegger/nvim-jdtls",
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"mason-org/mason-lspconfig.nvim",
				opts = {},
				dependencies = {
					{ "mason-org/mason.nvim", opts = {} },
				},
			},
		},
		opts = {
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Disable",
								keywordSnippet = "Disable",
							},
						},
					},
				},
				ts_ls = {
					filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "typescript.tsx" },
					cmd = { "typescript-language-server", "--stdio" },
					init_options = {
						-- preferences = {
						--     disableSuggestions = true
						-- }
					},
				},
				eslint = {},
				tailwindcss = {},
				intelephense = {},
				clangd = {},
				pyright = {},
				html = {
					settings = {
						css = {
							lint = {
								validProperties = {},
							},
						},
					},
				},
				cssls = {},
				jdtls = {},
				svelte = {},
			},
		},
		config = function(_, opts)
			local on_attach = function(_, _)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
				vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
				vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, {})
				vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, {})
				vim.keymap.set("n", "[d", vim.diagnostic.goto_next, {})
				vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, {})
				vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, {})
				vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, {})
			end

			local lspconfig = require("lspconfig")
			for server, config in pairs(opts.servers) do
				config.capabilities = require("blink.cmp").get_lsp_capabilities({
					textDocument = { completion = { completionItem = { snippetSupport = false } } },
				})
				config.on_attach = on_attach
				lspconfig[server].setup(config)
			end
		end,
	},
}
