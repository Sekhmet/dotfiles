function SetColors(scheme)
  scheme = scheme or "onenord"

  vim.cmd.colorscheme(scheme)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#22282A" })
end

SetColors()
