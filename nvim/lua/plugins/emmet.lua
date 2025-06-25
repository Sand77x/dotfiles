return {
    "mattn/emmet-vim",
    init = function()
        vim.g.user_emmet_install_global = 0
        vim.keymap.set({ "i", "n" }, "<c-g>", "<plug>(emmet-expand-abbr)", { noremap = false, silent = true })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "html", "css", "typescriptreact", "javascriptreact", "javascript", "typescript" },
            callback = function()
                vim.cmd("EmmetInstall")
            end
        })
    end
}
