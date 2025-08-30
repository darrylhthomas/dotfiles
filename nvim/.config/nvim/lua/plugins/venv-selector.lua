return {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "mfussenegger/nvim-dap",
        "mfussenegger/nvim-dap-python", --optional
        { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    ft = "python", -- Load when opening Python files
    keys = {
        { "<leader>v", "<cmd>VenvSelect<cr>" }, -- Open picker on keymap
    },
    opts = {
        -- Your settings go here
    },
}
