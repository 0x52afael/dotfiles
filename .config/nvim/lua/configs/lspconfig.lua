require("mason-tool-installer").setup({
  ensure_installed = {
    "lua-language-server",
    "unocss",
    "html",
    "bashls",
    "cssls",
    "css_variables",
    "dockerls",
    "docker_compose_language_service",
    "cssmodules_ls",
    "jsonls",
    "debugpy",
    "basedpyright",
    "ruff",
    "tailwindcss",
    "lua_ls",
    "html-lsp",
    "emmet-language-server",
    "typescript-language-server",
    "stylua",
    "marksman",
    "markdownlint",
    "ltex-ls-plus",
    "jdtls",
  },
})

local servers = {
  "unocss",
  "ltex_plus",
  "bashls",
  "basedpyright",
  "html",
  "cssls",
  "css_variables",
  "dockerls",
  "docker_compose_language_service",
  "cssmodules_ls",
  "jsonls",
  "tailwindcss",
  "lua_ls",
  "jdtls",
  "marksman",
  "emmet_language_server",
  "ts_ls",
}
vim.lsp.config("marksman", {
  filetypes = { "md", "markdown", "mdx", "markdown.mdx" },
})

local dict_path = vim.fn.stdpath("config") .. "/ltex-dict.txt"
local function read_dict()
  local words = {}
  local file = io.open(dict_path, "r")
  if not file then return words end
  for line in file:lines() do
    if line ~= "" then
      table.insert(words, line)
    end
  end
  file:close()
  return words
end

vim.lsp.config("ltex_plus", {
  settings = {
    ltex = {
      language = "en-US",
      dictionary = {
        ["en-US"] = read_dict(),
      },
      disabledRules = {
        ["en-US"] = { "WHITESPACE_RULE" },
      },
    },
  },
})

vim.lsp.config("html", {
  filetypes = { "typescriptreact", "javascriptreact", "html", "htmlangular" },
})

for _, lsp in ipairs(servers) do
  vim.lsp.enable(lsp)
end
