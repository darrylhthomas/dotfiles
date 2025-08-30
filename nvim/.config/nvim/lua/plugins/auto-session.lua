return {
    "rmagatti/auto-session",
    config = function()
        local auto_session = require("auto-session")
        local function close_nvim_tree()
            -- require("nvim-tree.view").close()
        end

        local function open_nvim_tree()
            -- require("nvim-tree.view").open()
        end

        auto_session.setup({
            auto_save = false,
            cwd_change_handling = true,
            log_level = "error",
            post_open_cmds = { open_nvim_tree },
            -- post_restore_cmds = { open_nvim_tree },
            pre_save_cmds = { close_nvim_tree },
            -- post_save_cmds = { open_nvim_tree },
            suppressed_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop", "~/src" },
        })

        local keymap = vim.keymap

        keymap.set("n", "<leader>wr", "<cmd>AutoSession restore<CR>", { desc = "Restore session for cwd" })
        keymap.set("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "Save session for auto session root dir" })
    end,
}
