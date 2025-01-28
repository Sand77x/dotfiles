return {
    "leath-dub/snipe.nvim",
    keys = {
        { "gb", function() require("snipe").open_buffer_menu() end, desc = "Open Snipe buffer menu" }
    },
    opts = {
        ui = {
            position = "center",
        },
        hints = {
            dictionary = "asdfqwer1234"
        },
        navigate = {
            close_buffer = "D",
        },
        sort = "default"
    }
}
