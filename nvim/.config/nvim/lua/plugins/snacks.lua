return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = function()
        require("snacks").setup({
            bigfile = { enabled = true },
            dashboard = {
                enabled = true,
                width = 60,
                row = nil, -- dashboard position. nil for center
                col = nil, -- dashboard position. nil for center
                pane_gap = 4, -- empty columns between vertical panes
                autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
                -- These settings are used by some built-in sections
                preset = {
                    -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
                    ---@type fun(cmd:string, opts:table)|nil
                    pick = nil,
                    -- Used by the `keys` section to show keymaps.
                    -- Set your custom keymaps here.
                    -- When using a function, the `items` argument are the default keymaps.
                    keys = {
                        {
                            icon = " ",
                            key = "f",
                            desc = "Find File",
                            action = ":lua Snacks.dashboard.pick('files')",
                        },
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        {
                            icon = " ",
                            key = "g",
                            desc = "Find Text",
                            action = ":lua Snacks.dashboard.pick('live_grep')",
                        },
                        {
                            icon = " ",
                            key = "r",
                            desc = "Recent Files",
                            action = ":lua Snacks.dashboard.pick('oldfiles')",
                        },
                        {
                            icon = " ",
                            key = "c",
                            desc = "Config",
                            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                        },
                        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                        {
                            icon = "󰒲 ",
                            key = "L",
                            desc = "Lazy",
                            action = ":Lazy",
                            enabled = package.loaded.lazy ~= nil,
                        },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                    -- Used by the `header` section
                    header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
                },
                -- item field formatters
                formats = {
                    -- icon = function(item)
                    --     if item.file and item.icon == "file" or item.icon == "directory" then
                    --         return M.icon(item.file, item.icon)
                    --     end
                    --     return { item.icon, width = 2, hl = "icon" }
                    -- end,
                    footer = { "%s", align = "center" },
                    header = { "%s", align = "center" },
                    file = function(item, ctx)
                        local fname = vim.fn.fnamemodify(item.file, ":~")
                        fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
                        if #fname > ctx.width then
                            local dir = vim.fn.fnamemodify(fname, ":h")
                            local file = vim.fn.fnamemodify(fname, ":t")
                            if dir and file then
                                file = file:sub(-(ctx.width - #dir - 2))
                                fname = dir .. "/…" .. file
                            end
                        end
                        local dir, file = fname:match("^(.*)/(.+)$")
                        return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } }
                            or { { fname, hl = "file" } }
                    end,
                },
                sections = {
                    { section = "header" },
                    { section = "keys", gap = 1, padding = 1 },
                    { section = "recent_files", icon = " ", title = "Recent Files", indent = 3, padding = 2 },
                    { section = "startup" },
                },
            },
            indent = { enabled = true },
            scroll = { enabled = true },
            explorer = { enabled = true },
            picker = {
                enabled = true,
                config = function()
                    vim.ui.select = require("snacks.picker").select
                end,
            },
            statuscolumn = { enabled = true },
            notifier = { enabled = true },
            words = { enabled = true },
            zen = {
                enabled = true,
            },
        })
    end,
    keys = {
        {
            "<leader><space>",
            function()
                Snacks.picker.smart()
            end,
            desc = "Smart Find Files",
        },
        {
            "<leader>,",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>/",
            function()
                Snacks.picker.grep()
            end,
            desc = "Grep",
        },
        {
            "<leader>:",
            function()
                Snacks.picker.command_history()
            end,
            desc = "Command History",
        },
        {
            "<leader>n",
            function()
                Snacks.picker.notifications()
            end,
            desc = "Notification History",
        },
        {
            "<leader>e",
            function()
                Snacks.explorer()
            end,
            desc = "File Explorer",
        },
        {
            "<leader>fb",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>fc",
            function()
                Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
            end,
            desc = "Find Config File",
        },
        {
            "<leader>ff",
            function()
                Snacks.picker.files()
            end,
            desc = "Find Files",
        },
        {
            "<leader>fg",
            function()
                Snacks.picker.git_files()
            end,
            desc = "Find Git Files",
        },
        {
            "<leader>fp",
            function()
                Snacks.picker.projects()
            end,
            desc = "Projects",
        },
        {
            "<leader>fr",
            function()
                Snacks.picker.recent()
            end,
            desc = "Recent",
        },

        {
            "gd",
            function()
                Snacks.picker.lsp_definitions()
            end,
            desc = "Goto Definition",
        },
        {
            "gD",
            function()
                Snacks.picker.lsp_declarations()
            end,
            desc = "Goto Declaration",
        },
        {
            "gr",
            function()
                Snacks.picker.lsp_references()
            end,
            nowait = true,
            desc = "References",
        },
        {
            "gI",
            function()
                Snacks.picker.lsp_implementations()
            end,
            desc = "Goto Implementation",
        },
        {
            "gy",
            function()
                Snacks.picker.lsp_type_definitions()
            end,
            desc = "Goto T[y]pe Definition",
        },
        {
            "<leader>ss",
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = "LSP Symbols",
        },
        {
            "<leader>sS",
            function()
                Snacks.picker.lsp_workspace_symbols()
            end,
            desc = "LSP Workspace Symbols",
        },
        {
            "<leader>z",
            function()
                Snacks.zen()
            end,
            desc = "Toggle Zen Mode",
        },
    },
}
