return {
	"nvim-treesitter/nvim-treesitter",
	enabled = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"javascript",
				"typescript",
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"luadoc",
				"markdown",
			},
			highlight = {
				enable = true,
			},
			disable = function(_, buf)
				local max_filesize = 100 * 1024
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_get_buf_name(buf))
				if ok and stats.size > max_filesize then
					return true
				end
			end,
		})
	end,
}
