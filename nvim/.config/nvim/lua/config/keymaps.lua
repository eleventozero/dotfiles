vim.keymap.set("n", "<leader>r", function()
  require("utils.runner").run()
end, { desc = "Run current file" })
