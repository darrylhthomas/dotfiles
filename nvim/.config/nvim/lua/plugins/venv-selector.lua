return {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "mfussenegger/nvim-dap",
        "mfussenegger/nvim-dap-python", --optional
        { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    ft = "python", -- Load when opening Python files
    branch = "regexp", -- This is the regexp branch, use this for the new version
    keys = {
        { "<leader>v", "<cmd>VenvSelect<cr>" }, -- Open picker on keymap
    },
    opts = {
        -- Your settings go here
    },
}
