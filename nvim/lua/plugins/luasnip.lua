return {
    "L3MON4D3/LuaSnip",
    event = "LspAttach",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    init = function()
        require("luasnip.loaders.from_vscode").lazy_load()

        -- local ls = require("luasnip")

        -- extensions for better snippets
        -- ls.filetype_extend("javascript", { "javascriptreact" })
        -- ls.filetype_extend("javascript", { "html" })
    end,

}
