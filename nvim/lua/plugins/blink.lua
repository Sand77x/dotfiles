return {
    "saghen/blink.cmp",
    version = "*",
    build = "cargo build --release",

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
                    auto_insert = false
                }
            },
            menu = {
                auto_show = false,
            },
            ghost_text = {
                enabled = false,
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
                update_delay_ms = 500,
                window = {
                    min_width = 10,
                    max_width = 80,
                    max_height = 20,
                    border = "padded",
                    winblend = 0,
                    winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
                    scrollbar = true,
                    direction_priority = {
                        menu_north = { "e", "w", "n", "s" },
                        menu_south = { "e", "w", "s", "n" },
                    },
                },
            },
        },

        fuzzy = {
            use_frecency = true,
            use_proximity = true,
        },

        -- REALLY COOL, but until it has a way to be only enabled on keymap,
        -- i dont really want to use it
        signature = {
            enabled = false,
        },

        snippets = {
            preset = "default",
        },

        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            providers = {

                snippets = {
                    name = 'Snippets',
                    module = 'blink.cmp.sources.snippets',

                    opts = {
                        friendly_snippets = true,
                        global_snippets = { 'all' },
                        extended_filetypes = {
                            ["javascript"] = { "javascriptreact" }
                        },
                        ignored_filetypes = {},
                        get_filetype = function(_)
                            return vim.bo.filetype
                        end,
                    },
                },

                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    -- make lazydev completions top priority (see `:h blink.cmp`)
                    score_offset = 100,
                },
            },
        },
    },

    opts_extend = { "sources.default" },
}
