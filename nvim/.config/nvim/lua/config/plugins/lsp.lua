return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason").setup()

			vim.lsp.enable("eslint")
			vim.lsp.enable("vtsls")
			vim.lsp.enable("vue_ls")
			vim.lsp.enable("tailwindcss")

			local vue_language_server_path = vim.fn.expand("$MASON/packages")
				.. "/vue-language-server"
				.. "/node_modules/@vue/language-server"

			local vue_plugin = {
				name = "@vue/typescript-plugin",
				location = vue_language_server_path,
				languages = { "vue" },
				configNamespace = "typescript",
			}

			vim.lsp.config("vtsls", {
				filetypes = { "typescript", "javascript", "vue" },
				settings = {
					vtsls = {
						tsserver = {
							globalPlugins = { vue_plugin },
						},
					},
				},
			})

			--[[
			require("mason-lspconfig").setup({
				ensure_installed = { "vtsls", "volar", "eslint" },
			})

			lspconfig.eslint.setup({
				settings = {
					workingDirectories = { mode = "auto" },
				},
			})
			lspconfig.vtsls.setup({
				filetypes = { "typescript", "javascript", "vue" },
				settings = {
					vtsls = {
						tsserver = {
							globalPlugins = {
								{
									name = "@vue/typescript-plugin",
									location = require("mason-registry")
										.get_package("vue-language-server")
										:get_install_path() .. "/node_modules/@vue/language-server",
									languages = { "vue" },
									configNamespace = "typescript",
									enableForWorkspaceTypeScriptVersion = true,
								},
							},
						},
					},
				},
			})
			]]

			vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
			vim.keymap.set("n", "grr", require("telescope.builtin").lsp_references, { desc = "[G]oto [R]eferences" })
			vim.keymap.set(
				"n",
				"gO",
				require("telescope.builtin").lsp_document_symbols,
				{ desc = "Open document symbols" }
			)
		end,
	},
}
