local function use_biome()
	return vim.fs.find({ "biome.json", "biome.jsonc" }, {
		upward = true,
		path = vim.fn.expand("%:p:h"),
	})[1] ~= nil
end

local function web_formatter()
	if use_biome() then
		return { "biome-check" }
	end

	return { "eslint_d" }
end

return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = web_formatter,
			typescript = web_formatter,
			vue = web_formatter,
			markdown = { "prettierd" },
			html = { "prettierd" },
			css = { "prettierd" },
			json = { "prettierd" },
			solidity = { "forgefmt" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = {
			timeout_ms = 500,
		},
		formatters = {
			forgefmt = {
				command = "forge",
				args = { "fmt", "-r", "-" },
				stdin = true,
			},
		},
	},
}
