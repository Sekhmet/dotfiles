-- Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.tabstop = 2
vim.opt.cmdheight = 0

vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.diagnostic.config({ virtual_text = true })

-- Keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics [Q]uickfix list" })
-- Disable Ctrl+u in insert mode to avoid accidental deletions when trying to use Ctrl+y
vim.keymap.set("i", "<C-u>", "<Nop>")

-- Show command line only while recording a macro
vim.api.nvim_create_autocmd("RecordingEnter", {
	callback = function()
		vim.opt.cmdheight = 1
	end,
})
vim.api.nvim_create_autocmd("RecordingLeave", {
	callback = function()
		vim.opt.cmdheight = 0
	end,
})

-- Plugins
vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin", version = "main" },
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1") },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/github/copilot.vim" },
	{ src = "https://github.com/linrongbin16/gitlinker.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/williamboman/mason.nvim" },
	{ src = "https://github.com/nvim-mini/mini.icons" },
	{ src = "https://github.com/nvim-mini/mini.statusline" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim", version = "master" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/esmuellert/codediff.nvim" },
	{ src = "https://github.com/tpope/vim-sleuth" },
})

-- Rebuild treesitter parsers when the plugin updates
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(event)
		if event.data.spec.name == "nvim-treesitter" and event.data.kind == "update" then
			vim.cmd("TSUpdate")
		end
	end,
})

-- Colorscheme
require("catppuccin").setup({ flavour = "frappe", transparent_background = true })
vim.cmd.colorscheme("catppuccin")

-- Icons (shared by oil and statusline)
require("mini.icons").setup()

-- Statusline
local statusline = require("mini.statusline")
statusline.setup({
	content = {
		active = function()
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
			local git = MiniStatusline.section_git({ trunc_width = 40 })
			local diff = MiniStatusline.section_diff({ trunc_width = 75 })
			local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
			local filename = MiniStatusline.section_filename({ trunc_width = 140 })
			local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 0 })

			return statusline.combine_groups({
				{ hl = mode_hl, strings = { mode } },
				{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics } },
				"%<",
				{ hl = "MiniStatuslineFilename", strings = { filename } },
				"%=",
				{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
			})
		end,
	},
})

-- Completion
require("blink.cmp").setup({
	keymap = { preset = "default" },
})

-- Treesitter
-- nvim-treesitter (main) ships its queries under runtime/, which is not on the
-- runtimepath by default; add it so inherited query modules (html_tags, ecma, ...) resolve
vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/site/pack/core/opt/nvim-treesitter/runtime")

require("nvim-treesitter").install({ "lua", "typescript", "tsx", "javascript", "html", "css", "json", "vue", "go" })

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

-- File explorer
require("oil").setup({
	view_options = { show_hidden = true },
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Telescope
local builtin = require("telescope.builtin")
-- find_files respects .gitignore; append gitignored .env* files so they stay reachable
vim.keymap.set("n", "<C-p>", function()
	builtin.find_files({
		find_command = { "sh", "-c", "{ rg --files; rg --files -g '.env*'; } | awk '!seen[$0]++'" },
	})
end, { desc = "Telescope find files" })
vim.keymap.set("n", "<C-f>", builtin.live_grep, { desc = "Telescope live grep" })

-- Git link
require("gitlinker").setup()
vim.keymap.set({ "n", "v" }, "<leader>gy", "<cmd>GitLink<cr>", { desc = "Yank git link" })
vim.keymap.set({ "n", "v" }, "<leader>gY", "<cmd>GitLink!<cr>", { desc = "Open git link" })

-- Git signs
require("gitsigns").setup({
	current_line_blame = true,
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end)

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end)

		map("n", "<leader>hs", gitsigns.stage_hunk)
		map("n", "<leader>hr", gitsigns.reset_hunk)
		map("n", "<leader>hp", gitsigns.preview_hunk)

		map("v", "<leader>hs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)

		map("v", "<leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)
	end,
})

-- Formatting
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

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = web_formatter,
		typescript = web_formatter,
		javascriptreact = web_formatter,
		typescriptreact = web_formatter,
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
})

-- LSP
require("mason").setup()

vim.lsp.enable("eslint")
vim.lsp.enable("vtsls")
vim.lsp.enable("vue_ls")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("gopls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("biome")
vim.lsp.enable("solidity_ls_nomicfoundation")

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
	filetypes = {
		"typescript",
		"javascript",
		"vue",
		"typescriptreact",
		"javascriptreact",
	},
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = { vue_plugin },
			},
		},
	},
})

vim.keymap.set("n", "grr", builtin.lsp_references, { desc = "[G]oto [R]eferences" })
vim.keymap.set("n", "gO", builtin.lsp_document_symbols, { desc = "Open document symbols" })
