vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

keymap.set({"n", "v"}, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true , desc = "Make file executable" })

keymap.set('n', 'x', [["_dP]], { desc = "Delete highlighted word into void register, then paste" })
keymap.set('n', 'x', '"_x', { desc = "Delete single character without copying into register" })

keymap.set('n', '<C-a>', 'gg<S-v>G', { desc = "Select all" })

keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted lines up" })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted lines down" })

keymap.set("n", "Q", "<nop>", { noremap = true, silent = true })
keymap.set('n', 'a', '<nop>', { noremap = true, silent = true })
keymap.set('n', 'O', '<nop>', { noremap = true, silent = true })
keymap.set('n', 'o', '<nop>', { noremap = true, silent = true })

keymap.set('n', '<leader>st', ':tabedit', { desc = "New tab" })

keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })
