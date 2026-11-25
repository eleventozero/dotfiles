-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>r", function()
  vim.cmd("write")
  Snacks.terminal("python3 " .. vim.fn.shellescape(vim.fn.expand("%:p")) .. "; read -p 'Enter zum Schließen'")
end, { desc = "Python-Datei ausführen" })
