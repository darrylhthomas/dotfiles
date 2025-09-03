return {
    "rmagatti/auto-session",
    config = function()
        local auto_session = require("auto-session")
        auto_session.setup({
            auto_save = true,
            auto_restore = false,
            cwd_change_handling = true,
            log_level = "error",
            suppressed_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop", "~/src" },
        })

        local keymap = vim.keymap

        keymap.set("n", "<leader>wr", "<cmd>AutoSession restore<CR>", { desc = "Restore session for cwd" })
        keymap.set("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "Save session for auto session root dir" })
        keymap.set("n", "<leader>wd", "<cmd>AutoSession delete<CR>", { desc = "Delete session for cwd" })
    end,
}
