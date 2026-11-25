vim.keymap.set("n", "<leader>r", function()
  require("utils.runner").run()
end, { desc = "Run current file" })

-- Quick command line access

vim.keymap.set("n", ";", ":", { desc = "Command line" })
