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
        "windwp/nvim-ts-autotag",
        config = function()
            --    require("nvim-ts-autotag").config()
        end,
        opts = {},
    },
    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup({})
        end,
    },
}
