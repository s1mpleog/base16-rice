local map = vim.keymap.set

-- C = ctrl
-- leader = space
-- "v" = only works in visual mode
-- "n" = only works in normal mode
-- "t" = only works in terminal mode

-- Better window navigation (no need to hit W after leader)
map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower split" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper split" })

map("n", "<leader>fm", function() vim.lsp.buf.format({ async = true }) end,
    { desc = "Format file" })

-- Resize splits
map("n", "<C-Up>", ":resize +2<CR>", { silent = true })
map("n", "<C-Down>", ":resize -2<CR>", { silent = true })
map("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true })
map("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true })

map("n", "<leader>\\", ":leftabove vsplit<CR>", { desc = "Split vertical (left)" })
map("n", "<leader>|", ":split<CR>", { desc = "Split horizontal (down)" })

-- Better indenting (stay in visual mode)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move selected lines up/down
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Buffer management
map("n", "<leader>bd", ":bd<CR>", { desc = "Delete buffer" })
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprev<CR>", { desc = "Prev buffer" })

-- Clear search highlight
map("n", "<Esc>", ":nohl<CR>", { silent = true })

-- Save
map("n", "<C-s>", ":w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc>:w<CR>", { desc = "Save file" })

-- Duplicate line down without yanking
map("n", "<leader>d", "yyp", { desc = "Duplicate line" })

-- Delete without yanking (goes to black hole register)
map("n", "x", '"_x', { desc = "Delete char without yank" })
map("v", "<leader>D", '"_d', { desc = "Delete without yank" })

-- Paste without overwriting your yank register
map("v", "p", '"_dP', { desc = "Paste without overwriting register" })

-- Quickly open a terminal split
map("n", "<leader>tt", ":split | terminal<CR>", { desc = "Terminal below" })
map("n", "<leader>tv", ":vsplit | terminal<CR>", { desc = "Terminal right" })

-- Exit terminal mode easily (default is Ctrl+\ Ctrl+n which is painful)
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Select all
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })
