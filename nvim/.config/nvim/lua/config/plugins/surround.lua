return {
	"nvim-mini/mini.surround",
	config = function()
		require("mini.surround").setup({
			mappings = {
				add = "ss", -- Add surrounding in Normal and Visual modes
				delete = "ds", -- Delete surrounding
				replace = "cs", -- Replace surrounding
			},
		})
	end,
}
