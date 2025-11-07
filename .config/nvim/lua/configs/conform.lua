local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        css = { "stylelint", "prettier" },
        html = { "prettier" },
        python = { "ruff_format" },
        javascript = { "biome" },
        javascriptreact = { "biome" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
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
