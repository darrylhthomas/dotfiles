vim.g.mapleader = " "

local km = vim.keymap

km.set("n", "<leader>cd", vim.cmd.Ex, { desc = "Show file explorer" })
km.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

km.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
km.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
km.set("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
km.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

km.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
km.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
km.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
km.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
km.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

km.set("v", "-", function()
    vim.cmd.norm("gc")
end, { desc = "Toggle comment" })
km.set("n", "-", function()
    vim.cmd.norm("gcc")
end, { desc = "Toggle comment" })
