-- leader
vim.g.mapleader = " "

-- wezterm nops
vim.keymap.set({ "n", "v", "i" }, "<C-/>", "<nop>")
vim.keymap.set({ "n", "v", "i" }, "<C-s>", "<nop>")

-- move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- better 0 remap
vim.keymap.set("n", "0", "^")
vim.keymap.set("n", "^", "0")

-- zz remaps
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- macro remap
vim.keymap.set("n", "Q", "q")
vim.keymap.set("n", "q", "<nop>")

-- next greatest remap ever : asbjornHaland (system paste)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- no copy on delete (except d)
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("v", "<leader>p", "p")
vim.keymap.set("v", "<leader>P", "P")
vim.keymap.set("v", "p", [["_dp]])
vim.keymap.set("v", "P", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>c", "c")
vim.keymap.set({ "n", "v" }, "<leader>C", "C")
vim.keymap.set({ "n", "v" }, "c", [["_c]])
vim.keymap.set({ "n", "v" }, "C", [["_C]])
vim.keymap.set({ "n", "v" }, "<leader>x", "x")
vim.keymap.set({ "n", "v" }, "<leader>X", "X")
vim.keymap.set({ "n", "v" }, "x", [["_x]])
vim.keymap.set({ "n", "v" }, "X", [["_X]])

-- file sourcing maps
vim.keymap.set("n", "<leader><leader>", "<cmd>source %<CR>")
vim.keymap.set("v", "<leader><leader>", ":lua<CR>")

-- lsp remaps
vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
end, vim.opts)
vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
end, vim.opts)
vim.keymap.set("n", "<leader>vws", function()
    vim.lsp.buf.workspace_symbol()
end, vim.opts)
vim.keymap.set("n", "<leader>vd", function()
    vim.diagnostic.open_float()
end, vim.opts)
vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_next()
end, vim.opts)
vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_prev()
end, vim.opts)
vim.keymap.set("n", "<leader>vca", function()
    vim.lsp.buf.code_action()
end, vim.opts)
vim.keymap.set("n", "<leader>vrr", function()
    vim.lsp.buf.references()
end, vim.opts)
vim.keymap.set("n", "<leader>vrn", function()
    vim.lsp.buf.rename()
end, vim.opts)
vim.keymap.set("i", "<C-h>", function()
    vim.lsp.buf.signature_help()
end, vim.opts)
vim.keymap.set("n", "<leader>fo", vim.lsp.buf.format)

-- autoclose remaps (fucken amazing)
vim.keymap.set("i", '"<tab>', '""<Left>')
vim.keymap.set("i", "'<tab>", "''<Left>")
vim.keymap.set("i", "(<tab>", "()<Left>")
vim.keymap.set("i", "<<tab>", "<><Left>")
vim.keymap.set("i", "><tab>", "</><Left>")
vim.keymap.set("i", "[<tab>", "[]<Left>")
vim.keymap.set("i", "{<tab>", "{}<Left>")
vim.keymap.set("i", "{<CR>", "{<CR>}<ESC>O")
vim.keymap.set("i", "{;<CR>", "{<CR>};<ESC>O")

-- splits remaps
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<leader>vs", ":vsplit<CR>")
vim.keymap.set("n", "<leader>vh", ":split<CR>")
vim.keymap.set("n", "<leader>vo", ":only<CR>")

-- splits resize
vim.keymap.set("n", "<C-Left>", "<C-w>3<")
vim.keymap.set("n", "<C-Right>", "<C-w>3>")
vim.keymap.set("n", "<C-Up>", "<C-w>3-:set cmdheight=1<CR>")
vim.keymap.set("n", "<C-Down>", "<C-w>3+")

-- changing working dir
vim.keymap.set("n", "<leader>cdh", ":cd %:h<CR>:cd<CR>")

-- fugitive git
vim.keymap.set("n", "<leader>gs", ":tab Git<CR>")

-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- remap "go to next instance" binds
vim.keymap.set("n", ")", "*")
vim.keymap.set("n", "(", "#")

-- neotree
vim.keymap.set("n", "<leader>pv", function()
    local disabled_fts = { "fugitive", "TelescopePrompt" }
    for _, ft in ipairs(disabled_fts) do
        if vim.bo.filetype == ft then
            return
        end
    end
    vim.cmd(":Neotree")
end)
vim.keymap.set("n", "<leader>pd", function()
    vim.cmd(":Neotree document_symbols reveal toggle position=right")
end)

-- leap remaps
vim.keymap.set({ "n", "x" }, "<Enter>", function()
    local current_window = vim.fn.win_getid()
    require("leap").leap({ target_windows = { current_window } })
end)
