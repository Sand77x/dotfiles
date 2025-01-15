return {
	"ggandor/leap.nvim",
	config = function()
		local leap = require("leap").opts

		leap.safe_labels = ""
		leap.labels = "abcdefghijklmnopqrstuvwxyz"
		leap.special_keys = {
			next_target = "",
			prev_target = "",
			next_group = "<Enter>",
			prev_group = "<S-Enter>",
		}
	end,
}
