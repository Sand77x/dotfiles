vim.o.shell = 'cmd'
vim.o.shellquote = ''
vim.o.shellxquote = ''
vim.o.shellslash = true

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true

vim.o.wrap = false

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'

vim.o.updatetime = 250

vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }

vim.o.inccommand = 'split'

vim.o.cursorline = true

vim.o.guicursor = 'a:blinkon0'
vim.o.cindent = true
vim.o.autoindent = true

vim.o.scrolloff = 8

vim.o.confirm = true
vim.o.expandtab = true

vim.o.cmdwinheight = 20

-- [[ Basic Keymaps ]]

-- Open lazygit in new wezterm window
local function in_git_repo()
    vim.fn.system 'git rev-parse --is-inside-work-tree'
    return vim.v.shell_error == 0
end

if vim.fn.executable 'lazygit' then
    vim.keymap.set('n', '<leader>gs', function()
        if not in_git_repo() then
            print 'Error: Not in a git repo!'
            return
        end

        local dir = vim.fn.expand '%:p:h'
        dir = dir:gsub('^oil:///', '') -- if in oil buffer, get path
        dir = dir:gsub('^([A-Z])/', '%1:/') -- add colon after drive letter (for windows)

        vim.fn.jobstart({ 'wezterm', 'cli', 'spawn', '--new-window', '--cwd', dir, 'lazygit' }, { detach = true })
    end, { desc = 'Open lazygit in new wezterm window' })
else
    vim.keymap.set('n', '<leader>gs', '<cmd>echo "No lazygit installed!"<CR>')
end

-- Remap Esc
vim.keymap.set('i', '<C-c>', '<Esc>', { noremap = true })
vim.keymap.set('n', '<C-c>', '<Esc>', { noremap = true })
vim.keymap.set('v', '<C-c>', '<Esc>', { noremap = true })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Move lines in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Better 0 remap
vim.keymap.set('n', '0', '^')
vim.keymap.set('n', '^', '0')

-- zz remaps
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- QOL motion remaps
vim.keymap.set({ 'n', 'v' }, 'H', '^')
vim.keymap.set({ 'n', 'v' }, 'L', '$')
vim.keymap.set({ 'n', 'v' }, 'Q', '%')

-- Macro remap (I keep clicking it!!)
vim.keymap.set('n', 'q', '<nop>')
vim.keymap.set('n', 'M', 'q')

-- No copy on delete (except d)
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])
vim.keymap.set('v', '<leader>p', 'p')
vim.keymap.set('v', '<leader>P', 'P')
vim.keymap.set('v', 'p', [["_dp]])
vim.keymap.set('v', 'P', [["_dP]])
vim.keymap.set({ 'n', 'v' }, '<leader>c', 'c')
vim.keymap.set({ 'n', 'v' }, '<leader>C', 'C')
vim.keymap.set({ 'n', 'v' }, 'c', [["_c]])
vim.keymap.set({ 'n', 'v' }, 'C', [["_C]])
vim.keymap.set({ 'n', 'v' }, '<leader>x', 'x')
vim.keymap.set({ 'n', 'v' }, '<leader>X', 'X')
vim.keymap.set({ 'n', 'v' }, 'x', [["_x]])
vim.keymap.set({ 'n', 'v' }, 'X', [["_X]])

-- File sourcing maps
vim.keymap.set('n', '<leader><leader>', '<cmd>source %<CR>')
vim.keymap.set('v', '<leader><leader>', ':lua<CR>')

-- Changing working dir
vim.keymap.set('n', '<leader>cdh', ':cd %:h<CR>:cd<CR>')

-- Autoclose remaps
vim.keymap.set('i', '"<tab>', '""<Left>')
vim.keymap.set('i', "'<tab>", "''<Left>")
vim.keymap.set('i', '(<tab>', '()<Left>')
vim.keymap.set('i', '<<tab>', '<><Left>')
vim.keymap.set('i', '><tab>', '</><Left>')
vim.keymap.set('i', '[<tab>', '[]<Left>')
vim.keymap.set('i', '{<tab>', '{}<Left>')
vim.keymap.set('i', '{<CR>', '{<CR>}<ESC>O')
vim.keymap.set('i', '{;<CR>', '{<CR>};<ESC>O')

-- Split opening / closing
vim.keymap.set('n', '<leader>vs', ':vsplit<CR>')
vim.keymap.set('n', '<leader>vh', ':split<CR>')
vim.keymap.set('n', '<leader>vo', ':only<CR>')

-- Split navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Go to next instance
vim.keymap.set('n', ')', '*')
vim.keymap.set('n', '(', '#')

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
-- vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
-- vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
-- vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        --NVIM_ENTER=1
        vim.cmd [[call chansend(v:stderr, "\033]1337;SetUserVar=NVIM_ENTER=MQ==\007")]]
    end,
})

vim.api.nvim_create_autocmd('VimLeavePre', {
    callback = function()
        --NVIM_ENTER=0
        vim.cmd [[call chansend(v:stderr, "\033]1337;SetUserVar=NVIM_ENTER=MA==\007")]]
    end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]

-- NOTE: Here is where you install your plugins.
require('lazy').setup(
    {
        { -- Detect tabstop and shiftwidth automatically
            'NMAC427/guess-indent.nvim',
            opts = {},
        },
        { -- Adds git related signs to the gutter, as well as utilities for managing changes
            'lewis6991/gitsigns.nvim',
            opts = {
                signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                },
            },
        },
        { -- Fuzzy Finder (files, lsp, etc)
            'nvim-telescope/telescope.nvim',
            event = 'VimEnter',
            dependencies = {
                'nvim-lua/plenary.nvim',
                {
                    'nvim-telescope/telescope-fzf-native.nvim',
                    build = 'make',
                    cond = function()
                        return vim.fn.executable 'make' == 1
                    end,
                },
                { 'nvim-telescope/telescope-ui-select.nvim' },
                { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
            },
            config = function()
                require('telescope').setup {
                    defaults = {
                        mappings = {
                            i = {
                                ['<C-k>'] = require('telescope.actions').move_selection_previous,
                                ['<C-j>'] = require('telescope.actions').move_selection_next,
                            },
                        },
                        file_ignore_patterns = {
                            'node_modules',
                        },
                        preview = {
                            hide_on_startup = false, -- hide previewer when picker starts
                        },
                    },
                    pickers = {
                        find_files = {
                            preview = {
                                hide_on_startup = true,
                            },
                            hidden = true,
                            find_command = {
                                'rg',
                                '--files',
                                '--glob',
                                '!{.git/*,.svelte-kit/*,target/*,node_modules/*}',
                                '--path-separator',
                                '/',
                            },
                        },
                    },
                    extensions = {
                        ['ui-select'] = {
                            require('telescope.themes').get_dropdown(),
                        },
                    },
                }

                -- Enable Telescope extensions if they are installed
                pcall(require('telescope').load_extension, 'fzf')
                pcall(require('telescope').load_extension, 'ui-select')

                -- See `:help telescope.builtin`
                local builtin = require 'telescope.builtin'
                vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search Help' })
                vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search Keymaps' })
                vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search Files' })
                vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = 'Search Select Telescope' })
                vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Search current Word' })
                vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search by Grep' })
                vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search Diagnostics' })
                vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Search Resume' })
                vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })
                vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Find existing buffers' })

                -- Slightly advanced example of overriding default behavior and theme
                vim.keymap.set('n', '<leader>s/', function()
                    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
                    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                        winblend = 10,
                        previewer = false,
                    })
                end, { desc = '[/] Fuzzily search in current buffer' })

                -- Shortcut for searching your Neovim configuration files
                vim.keymap.set('n', '<leader>sn', function()
                    builtin.find_files { cwd = vim.fn.stdpath 'config' }
                end, { desc = '[S]earch [N]eovim files' })
            end,
        },

        -- LSP Plugins
        {
            -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
            -- used for completion, annotations and signatures of Neovim apis
            'folke/lazydev.nvim',
            ft = 'lua',
            opts = {
                library = {
                    -- Load luvit types when the `vim.uv` word is found
                    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                },
            },
        },
        {
            -- Main LSP Configuration
            'neovim/nvim-lspconfig',
            dependencies = {
                -- Mason must be loaded before its dependents so we need to set it up here.
                { 'mason-org/mason.nvim', opts = {} },
                'mason-org/mason-lspconfig.nvim',
                'WhoIsSethDaniel/mason-tool-installer.nvim',

                -- Useful status updates for LSP.
                { 'j-hui/fidget.nvim', opts = {} },

                -- Allows extra capabilities provided by blink.cmp
                'saghen/blink.cmp',
            },
            config = function()
                --  This function gets run when an LSP attaches to a particular buffer.
                --    That is to say, every time a new file is opened that is associated with
                --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
                --    function will be executed to configure the current buffer
                vim.api.nvim_create_autocmd('LspAttach', {
                    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
                    callback = function(event)
                        -- NOTE: Remember that Lua is a real programming language, and as such it is possible
                        -- to define small helper and utility functions so you don't have to repeat yourself.
                        --
                        -- In this case, we create a function that lets us more easily define mappings specific
                        -- for LSP related items. It sets the mode, buffer and description for us each time.
                        local map = function(keys, func, desc, mode)
                            mode = mode or 'n'
                            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                        end

                        -- Rename the variable under your cursor.
                        --  Most Language Servers support renaming across files, etc.
                        map('grn', vim.lsp.buf.rename, 'Rename')

                        -- Execute a code action, usually your cursor needs to be on top of an error
                        -- or a suggestion from your LSP for this to activate.
                        map('gra', vim.lsp.buf.code_action, 'Goto Code Action', { 'n', 'x' })

                        -- Find references for the word under your cursor.
                        map('grr', require('telescope.builtin').lsp_references, 'Goto References')

                        -- Jump to the implementation of the word under your cursor.
                        --  Useful when your language has ways of declaring types without an actual implementation.
                        map('gri', require('telescope.builtin').lsp_implementations, 'Goto Implementation')

                        -- Jump to the definition of the word under your cursor.
                        --  This is where a variable was first declared, or where a function is defined, etc.
                        --  To jump back, press <C-t>.
                        map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')

                        -- WARN: This is not Goto Definition, this is Goto Declaration.
                        --  For example, in C this would take you to the header.
                        map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

                        -- Fuzzy find all the symbols in your current document.
                        --  Symbols are things like variables, functions, types, etc.
                        map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

                        -- Fuzzy find all the symbols in your current workspace.
                        --  Similar to document symbols, except searches over your entire project.
                        map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

                        -- Jump to the type of the word under your cursor.
                        --  Useful when you're not sure what type a variable is and you want to see
                        --  the definition of its *type*, not where it was *defined*.
                        map('grt', require('telescope.builtin').lsp_type_definitions, 'Goto Type Definition')

                        -- Show error in floating window
                        vim.keymap.set('n', '<C-e>', vim.diagnostic.open_float, { noremap = true, silent = true, buffer = event.buf })
                    end,
                })

                -- Diagnostic Config
                vim.diagnostic.config {
                    update_in_insert = false,
                    severity_sort = true,
                    float = { border = 'rounded', source = 'if_many' },
                    underline = { severity = vim.diagnostic.severity.ERROR },
                    signs = vim.g.have_nerd_font and {
                        text = {
                            [vim.diagnostic.severity.ERROR] = '󰅚 ',
                            [vim.diagnostic.severity.WARN] = '󰀪 ',
                            [vim.diagnostic.severity.INFO] = '󰋽 ',
                            [vim.diagnostic.severity.HINT] = '󰌶 ',
                        },
                    } or {},
                    virtual_text = {
                        source = 'if_many',
                        spacing = 2,
                        format = function(diagnostic)
                            local diagnostic_message = {
                                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                                [vim.diagnostic.severity.WARN] = diagnostic.message,
                                [vim.diagnostic.severity.INFO] = diagnostic.message,
                                [vim.diagnostic.severity.HINT] = diagnostic.message,
                            }
                            return diagnostic_message[diagnostic.severity]
                        end,
                    },
                }

                local capabilities = require('blink.cmp').get_lsp_capabilities()

                -- Enable the following language servers
                --  Add any additional override configuration in the following tables. Available keys are:
                --  - cmd (table): Override the default command used to start the server
                --  - filetypes (table): Override the default list of associated filetypes for the server
                --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
                --  - settings (table): Override the default settings passed when initializing the server.
                local servers = {
                    ts_ls = {
                        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
                        init_options = {
                            preferences = {
                                disableSuggestions = true,
                            },
                        },
                    },
                    html = {
                        settings = {
                            css = {
                                lint = {
                                    validProperties = {},
                                },
                            },
                        },
                    },
                    cssls = {},
                    eslint = {},
                    tailwindcss = {},
                    clangd = {},
                    pyright = {},
                    svelte = {},
                    lua_ls = {
                        settings = {
                            Lua = {
                                completion = {
                                    callSnippet = 'Replace',
                                },
                                -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                                diagnostics = { disable = { 'missing-fields' } },
                            },
                        },
                    },
                }

                -- You can add other tools here that you want Mason to install
                -- for you, so that they are available from within Neovim.
                local ensure_installed = vim.tbl_keys(servers or {})
                vim.list_extend(ensure_installed, {
                    'stylua', -- Used to format Lua code
                })
                require('mason-tool-installer').setup { ensure_installed = ensure_installed }

                require('mason-lspconfig').setup {
                    ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
                    automatic_enable = true,
                    automatic_installation = true,
                    handlers = {
                        function(server_name)
                            local server = servers[server_name] or {}
                            -- This handles overriding only values explicitly passed
                            -- by the server configuration above. Useful when disabling
                            -- certain features of an LSP (for example, turning off formatting for ts_ls)
                            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                            require('lspconfig')[server_name].setup(server)
                        end,
                    },
                }
            end,
        },

        { -- Autoformat
            'stevearc/conform.nvim',
            event = { 'BufWritePre' },
            cmd = { 'ConformInfo' },
            keys = {
                {
                    '<leader>fo',
                    function()
                        require('conform').format { async = true, lsp_format = 'fallback' }
                    end,
                    mode = '',
                    desc = '[F]ormat buffer',
                },
            },
            opts = {
                notify_on_error = false,
                format_on_save = function(bufnr)
                    -- Disable "format_on_save lsp_fallback" for languages that don't
                    -- have a well standardized coding style. You can add additional
                    -- languages here or re-enable it for the disabled ones.
                    local disable_filetypes = { c = true, cpp = true }
                    if disable_filetypes[vim.bo[bufnr].filetype] then
                        return nil
                    else
                        return {
                            timeout_ms = 500,
                            lsp_format = 'fallback',
                        }
                    end
                end,
                formatters_by_ft = {
                    -- Conform can also run multiple formatters sequentially
                    lua = { 'stylua' },
                    python = { 'isort', 'black' },
                    javascript = { 'prettierd', 'prettier', stop_after_first = true },
                    typescript = { 'prettierd', 'prettier', stop_after_first = true },
                },
                formatters = {
                    prettier = {
                        prepend_args = {
                            '--tab-width',
                            '4',
                            '--use-tabs',
                            'false',
                            '--single-quote',
                            'true',
                            '--semi',
                            'true',
                        },
                    },
                },
            },
        },

        { -- Autocompletion
            'saghen/blink.cmp',
            event = 'VimEnter',
            version = '*',
            dependencies = {
                -- Snippet Engine
                {
                    'L3MON4D3/LuaSnip',
                    version = '2.*',
                    build = (function()
                        -- Build Step is needed for regex support in snippets.
                        -- This step is not supported in many windows environments.
                        -- Remove the below condition to re-enable on windows.
                        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                            return
                        end
                        return 'make install_jsregexp'
                    end)(),
                    dependencies = {
                        {
                            'rafamadriz/friendly-snippets',
                            config = function()
                                require('luasnip.loaders.from_vscode').lazy_load()
                            end,
                        },
                    },
                    opts = {},
                },
                'folke/lazydev.nvim',
            },
            --- @module 'blink.cmp'
            --- @type blink.cmp.Config
            opts = {
                keymap = {
                    ['<C-n>'] = { 'show', 'hide' },
                    ['<CR>'] = { 'accept', 'fallback' },
                    ['<C-l>'] = { 'snippet_forward', 'fallback' },
                    ['<C-h>'] = { 'snippet_backward', 'fallback' },
                    ['<S-Tab>'] = { 'select_prev', 'fallback' },
                    ['<Tab>'] = { 'select_next', 'fallback' },
                    ['<C-j>'] = { 'scroll_documentation_down', 'fallback' },
                    ['<C-k>'] = { 'scroll_documentation_up', 'fallback' },
                },

                appearance = {
                    nerd_font_variant = 'mono',
                },

                cmdline = {
                    keymap = {
                        preset = 'inherit',
                    },
                    enabled = true,
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
                            treesitter = { 'lsp' },
                            columns = { { 'kind_icon', 'label', 'source_name', gap = 1 } },
                        },
                    },
                    documentation = {
                        auto_show = true,
                        auto_show_delay_ms = 500,
                    },
                    ghost_text = {
                        enabled = false,
                    },
                },

                sources = {
                    default = { 'lsp', 'path', 'snippets', 'lazydev' },
                    providers = {
                        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
                    },
                },

                snippets = { preset = 'luasnip' },

                fuzzy = {
                    implementation = 'lua',
                    use_frecency = true,
                    use_proximity = true,
                },

                -- Shows a signature help window while you type arguments for a function
                signature = {
                    enabled = true,
                    window = {
                        show_documentation = false,
                    },
                },
            },
        },

        { -- You can easily change to a different colorscheme.
            'rose-pine/neovim',
            priority = 1000, -- Make sure to load this before all the other start plugins.
            config = function()
                -- ---@diagnostic disable-next-line: missing-fields
                -- require('tokyonight').setup {
                --     styles = {
                --         comments = { italic = false }, -- Disable italics in comments
                --     },
                -- }

                vim.cmd.colorscheme 'rose-pine'
            end,
        },

        -- Highlight todo, notes, etc in comments
        { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

        { -- Collection of various small independent plugins/modules
            'echasnovski/mini.nvim',
            config = function()
                -- Better Around/Inside textobjects
                require('mini.ai').setup { n_lines = 500 }

                -- Add/delete/replace surroundings (brackets, quotes, etc.)
                require('mini.surround').setup { silent = true }

                -- Simple and easy statusline.
                local statusline = require 'mini.statusline'
                statusline.setup { use_icons = vim.g.have_nerd_font }

                -- You can configure sections in the statusline by overriding their
                -- default behavior. For example, here we set the section for
                -- cursor location to LINE:COLUMN
                ---@diagnostic disable-next-line: duplicate-set-field
                statusline.section_location = function()
                    return '%2l:%-2v'
                end
            end,
        },
        { -- Highlight, edit, and navigate code
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',

            main = 'nvim-treesitter.configs', -- Sets main module to use for opts
            config = function(_, opts)
                require('nvim-treesitter.install').compilers = { 'zig', 'cl' }
                require('nvim-treesitter.configs').setup(opts)
            end,
            opts = {
                ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
                -- Autoinstall languages that are not installed
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { 'ruby' },
                },
                indent = { enable = true, disable = { 'ruby' } },
            },
        },

        -- Kickstart default plugins
        require 'kickstart.plugins.debug',
        require 'kickstart.plugins.lint',
        require 'kickstart.plugins.gitsigns',

        { import = 'custom.plugins' },
    },
    ---@diagnostic disable-next-line: missing-fields
    {
        ui = {
            -- If you are using a Nerd Font: set icons to an empty table which will use the
            -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
            icons = vim.g.have_nerd_font and {} or {
                cmd = '⌘',
                config = '🛠',
                event = '📅',
                ft = '📂',
                init = '⚙',
                keys = '🗝',
                plugin = '🔌',
                runtime = '💻',
                require = '🌙',
                source = '📄',
                start = '🚀',
                task = '📌',
                lazy = '💤 ',
            },
        },
    }
)
