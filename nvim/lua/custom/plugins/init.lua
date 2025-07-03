-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
    { -- Visualize colors for webdev
        'norcalli/nvim-colorizer.lua',
        ft = { 'html', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        config = function()
            require('colorizer').setup({ 'css', 'html', 'js' }, {
                css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                mode = 'background', -- Set the display mode.
            })
        end,
    },
    { -- Quick HTML element generation
        'mattn/emmet-vim',
        ft = { 'html', 'css', 'typescriptreact', 'javascriptreact', 'javascript', 'typescript' },
        cmd = 'EmmetInstall',
        init = function()
            vim.g.user_emmet_install_global = 0
            vim.keymap.set({ 'i', 'n' }, '<c-g>', '<plug>(emmet-expand-abbr)', { noremap = false, silent = true })
        end,
        config = function()
            vim.cmd 'EmmetInstall'
        end,
    },
    { -- Jump anywhere you can see easily
        'ggandor/leap.nvim',
        keys = {
            {
                '<CR>',
                function()
                    require('leap').leap { target_windows = { vim.fn.win_getid() } }
                end,
                mode = { 'n', 'x' },
                desc = 'Leap in current window',
            },
        },
        opts = {
            safe_labels = '',
            labels = 'abcdefghijklmnopqrstuvwxyz',
            special_keys = {
                next_target = '',
                prev_target = '',
                next_group = '<Enter>',
                prev_group = '<S-Enter>',
            },
        },
    },
    {
        'stevearc/oil.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        keys = {
            {
                '\\',
                function()
                    (vim.o.filetype ~= 'oil' and require('oil').open_float or require('oil').close)()
                end,
                mode = { 'n' },
                desc = 'Open parent directory',
            },
        },
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            default_file_explorer = true,
            columns = { 'icon', 'permissions', 'size', 'mtime' },
            delete_to_trash = false,
            constrain_cursor = 'name',
            float = {
                max_width = 0.8,
                max_height = 0.8,
            },
            keymaps = {
                ['\\'] = nil,
                ['<BS>'] = { 'actions.parent', mode = 'n' },
                ['-'] = { 'actions.cd', mode = 'n' },
            },
        },
        lazy = false,
    },
    {
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
        keys = {
            {
                '<leader>ts',
                function()
                    require('treesj').toggle()
                end,
                mode = { 'n' },
                desc = 'Treesj: Toggle split/join code block',
            },
        },
        opts = {
            use_default_keymaps = false,
        },
    },
    {
        'nvimdev/indentmini.nvim',
        opts = {
            char = '»',
            exclude = { 'markdown' },
            minlevel = 2,
            only_current = true,
        },
        init = function()
            vim.cmd.highlight 'IndentLine guifg=#62736b'
            vim.cmd.highlight 'IndentLineCurrent guifg=#62736b'
        end,
    },
    {
        'LunarVim/bigfile.nvim',
        opts = {
            filesize = 1,
        },
    },
}
