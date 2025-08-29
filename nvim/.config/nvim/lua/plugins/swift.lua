return {
    {
        "keith/swift.vim",
        ft = "swift",
    },
    {
        "wojciech-kulik/xcodebuild.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("xcodebuild").setup()
        end,
    },
}
