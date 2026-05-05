-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ========== Basics ==========
map("n", "<leader>w", "<cmd>w<CR>", opts)
map("n", "<leader>q", "<cmd>q<CR>", opts)

-- ========== Explorer ==========
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", opts)

-- ========== Terminal ==========
map("n", "<leader>t", "<cmd>terminal<CR>", opts)
map("t", "<leader>q", "<C-\\><C-n>", opts)

-- ========== Navigation ==========
map("n", "<Tab>", "<cmd>bnext<CR>", opts)
map("n", "<S-Tab>", "<cmd>bprevious<CR>", opts)

-- ========== Markdown ===========
map("n", "<leader>m", "<cmd>MarkdownPreviewToggle<CR>", opts)
