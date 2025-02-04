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
            dictionary = "sadflewcmpghio"
        },
        navigate = {
            close_buffer = "D",
        },
        sort = "default"
    }
}
