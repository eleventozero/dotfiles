-- Code runner
vim.keymap.set("n", "<leader>r", function()
  require("utils.runner").run()
end, { desc = "Run current file" })

-- Quick commands
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file", nowait = true })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit window", nowait = true })
