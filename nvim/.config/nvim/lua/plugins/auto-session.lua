return {
    "rmagatti/auto-session",
    config = function()
        local auto_session = require("auto-session")
        local function close_nvim_tree()
            require("nvim-tree.view").close()
        end

        local function open_nvim_tree()
            require("nvim-tree.view").open()
        end

        auto_session.setup({
            log_level = "error",
            pre_save_cmds = { close_nvim_tree },
            post_save_cmds = { open_nvim_tree },
            post_open_cmds = { open_nvim_tree },
            post_restore_cmds = { open_nvim_tree },
            cwd_change_handling = {
                restore_upcoming_session = true,
            },
            auto_save = true,
            suppressed_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop", "~/src" },
        })

        local keymap = vim.keymap

        keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
        keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })
    end,
}
