return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "rcarriga/nvim-dap-ui",
            "mfussenegger/nvim-dap-python",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            local dap_python = require("dap-python")

            require("dapui").setup({})
            require("nvim-dap-virtual-text").setup({
                commented = true,
            })

            dap_python.setup("python3")

            vim.fn.sign_define("DapBreakpoint", {
                text = "󱖘",
                texthl = "DiagnosticSignError",
                linehl = "",
                numhl = "",
            })

            vim.fn.sign_define("DapBreakpointRejected", {
                text = "󱎘",
                texthl = "DiagnosticSignError",
                linehl = "",
                numhl = "",
            })

            vim.fn.sign_define("DapStopped", {
                text = "→",
                texthl = "DiagnosticSignWarn",
                linehl = "",
                numhl = "DiagnosticSignWarn",
            })

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end

            local opts = { noremap = true, silent = true }

            vim.keymap.set("n", "<leader>db", function()
                dap.toggle_breakpoint()
            end, opts)

            vim.keymap.set("n", "<leader>dc", function()
                dap.continue()
            end, opts)

            vim.keymap.set("n", "<leader>do", function()
                dap.step_over()
            end, opts)

            vim.keymap.set("n", "<leader>di", function()
                dap.step_into()
            end, opts)

            vim.keymap.set("n", "<leader>dO", function()
                dap.step_out()
            end, opts)

            vim.keymap.set("n", "<leader>dq", function()
                require("dap").terminate()
            end, opts)

            vim.keymap.set("n", "<leader>du", function()
                dapui.toggle()
            end, opts)
        end,
    },
}

