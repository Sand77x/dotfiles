return {
	"saghen/blink.cmp",
	version = "*",
	build = "cargo build --release",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"folke/lazydev.nvim",
	},

	opts = {
		keymap = {
			["<C-n>"] = { "show", "hide" },
			["<CR>"] = { "accept", "fallback" },
			["<C-l>"] = { "snippet_forward", "fallback" },
			["<C-h>"] = { "snippet_backward", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<Tab>"] = { "select_next", "fallback" },
			["<C-j>"] = { "scroll_documentation_down", "fallback" },
			["<C-k>"] = { "scroll_documentation_up", "fallback" },
		},

		completion = {
			list = {
				selection = {
					preselect = true,
					auto_insert = false,
				},
			},
			menu = {
				auto_show = false,
				draw = {
					treesitter = { "lsp" },
					columns = { { "kind_icon", "label", "source_name", gap = 1 } },
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 0,
			},
			ghost_text = {
				enabled = false,
			},
		},

		fuzzy = {
			use_frecency = true,
			use_proximity = true,
		},

		signature = {
			enabled = true,
			window = {
				show_documentation = false,
			},
		},

		snippets = {
			-- preset = "default",
		},

		sources = {
            -- disable snippets
			-- transform_items = function(_, items)
			-- 	return vim.tbl_filter(function(item)
			-- 		return item.kind ~= require("blink.cmp.types").CompletionItemKind.Snippet
			-- 	end, items)
			-- end,

			default = { "lsp", "path", "snippets", "buffer", "lazydev" },
			providers = {
				lsp = {
					score_offset = 3,
				},
				path = {
					min_keyword_length = 3,
					score_offset = 2,
				},
				buffer = {
					min_keyword_length = 3,
					score_offset = 1,
				},
				snippets = {
					opts = {
						friendly_snippets = true,
						extended_filetypes = {
							["javascript"] = { "javascriptreact" },
						},
					},
					score_offset = 4,
				},
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
			},
		},
	},

	opts_extend = { "sources.default" },
}
