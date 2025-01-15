return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			config = function()
				require("mason").setup()
				require("mason-lspconfig").setup({
					ensure_installed = {
						"lua_ls",
						"ts_ls",
						"eslint",
						"pyright",
						"html",
						"cssls",
					},
				})
			end,
		},
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	opts = {
		servers = {
			lua_ls = {
				init_options = {
					preferences = {
						disableSuggestions = true,
					},
				},
			},
            ts_ls = {},
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
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			config.on_attach = on_attach
			lspconfig[server].setup(config)
		end
	end,
}
