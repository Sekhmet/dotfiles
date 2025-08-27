return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		enabled = true,
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "typescript", "html", "css", "json", "vue" },
				auto_install = false,
				highlight = {
					enable = true,
				},
			})
		end,
	},
}
