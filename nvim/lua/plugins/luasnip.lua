return {
    "L3MON4D3/LuaSnip",
    enabled = false,
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()

        local ls = require("luasnip")

        ls.config.set_config({
            updateevents = "TextChanged, TextChangedI",
            enable_autosnippets = true,
        })

        -- extensions for better snippets
        ls.filetype_extend("javascript", { "javascriptreact" })
        ls.filetype_extend("javascript", { "html" })
    end,
}
