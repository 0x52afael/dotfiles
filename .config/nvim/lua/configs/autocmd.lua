vim.api.nvim_create_autocmd("FileType", {
  pattern = "http",
  callback = function()
    vim.keymap.set({ "n", "v" }, "<CR>", function()
      require("kulala").run()
    end, { desc = "Send request (Kulala)", buffer = true })
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd([[
		highlight! link Pmenu Normal
		highlight! link PmenuSel Visual
		highlight! link PmenuThumb Normal
		highlight! link NormalFloat Normal
		highlight! link FloatBorder Normal
		highlight! link CmpItemKindFunction Function
		highlight! link CmpItemKindVariable Identifier
		highlight! link CmpItemKindKeyword Keyword
		]])
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    local filename = vim.fn.expand("%:t")
    vim.opt_local.spelllang = { "sv", "en" }
    vim.opt_local.spellfile = vim.fn.stdpath("config") .. "/spell/personal.utf-8.add"
    vim.opt_local.spell = true
  end,
})


vim.api.nvim_create_user_command("LTeXAddWord", function(opts)
  -- Require a word argument
  if not opts.args or opts.args == "" then
    vim.notify("❌ Usage: :LTeXAddWord <word>", vim.log.levels.ERROR)
    return
  end

  -- Path to your dictionary file
  local dict_path = vim.fn.stdpath("config") .. "/ltex-dict.txt"

  -- Ensure file exists
  if vim.fn.filereadable(dict_path) == 0 then
    vim.fn.writefile({}, dict_path)
  end

  -- Try to open for appending
  local file, err = io.open(dict_path, "a")
  if not file then
    vim.notify("❌ Could not open " .. dict_path .. ": " .. tostring(err), vim.log.levels.ERROR)
    return
  end

  -- Write the word
  file:write(opts.args .. "\n")
  file:close()
  vim.notify("✅ Added '" .. opts.args .. "' to LTeX dictionary.")
end, {
  nargs = 1,         -- require exactly one argument
  complete = "file", -- optional completion behavior
})
