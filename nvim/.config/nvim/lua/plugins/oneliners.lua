return {
    {
        "folke/which-key.nvim",
    },
    {
        "ojroques/vim-oscyank",
    },
    {
        "tpope/vim-fugitive",
    },
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
    },
    {
        "windwp/nvim-ts-autotag",
        opts = {},
    },
    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup({})
        end,
    },
}
