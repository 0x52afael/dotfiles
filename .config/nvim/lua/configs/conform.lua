local options = {
  formatters_by_ft = {
    -- lua = { "stylua" },
    css = { "stylelint", "prettier" },
    tex = {"latexindent"},
    html = { "prettierd" },
    python = { "ruff_format" },
    javascript = { "biome" },
    javascriptreact = { "biome" },
    typescript = { "biome" },
    typescriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
  },
  formatters = {
    ruff_format = {
      command = "ruff",
      args = { "format", "-" },
      stdin = true,
    },
  },
}

return options
