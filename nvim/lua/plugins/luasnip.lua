return {
	"L3MON4D3/LuaSnip",
	enabled = false,
	version = "v2.*",
	build = "make install_jsregexp",
	config = function()
		local ls = require("luasnip")

		ls.config.set_config({
			updateevents = "TextChanged, TextChangedI",
			enable_autosnippets = true,
		})
	end,
}
