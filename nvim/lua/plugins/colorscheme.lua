return {
    { "savq/melange-nvim" },
    { 'andreypopp/vim-colors-plain' },
    { "alligator/accent.vim" },
    { "zenbones-theme/zenbones.nvim", dependencies = "rktjmp/lush.nvim" },
    { "mcauley-penney/ice-cave.nvim" },
    { 'bettervim/yugen.nvim' },
    { "gmr458/cold.nvim" },
    { "lunarvim/Onedarker.nvim" },
    { "sam4llis/nvim-tundra" },
    { "sainnhe/everforest" },
    {
        "olivercederborg/poimandres.nvim",
        config = function()
            require('poimandres').setup {
                bold_vert_split = true,           -- use bold vertical separators
                dim_nc_background = true,         -- dim 'non-current' window backgrounds
                disable_background = false,       -- disable background
                disable_float_background = false, -- disable background for floats
                disable_italics = false,          -- disable italics
            }
        end,
    },
    {
        'AlexvZyl/nordic.nvim',
        config = function()
            require 'nordic'.load()
        end
    },
}
