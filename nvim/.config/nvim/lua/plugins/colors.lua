local function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end

return {
    {
        "arcticicestudio/nord-vim",
        config = function()
            vim.cmd.colorscheme "nord"
            enable_transparency()

        end
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            theme = 'nord',
        }
    },
}

