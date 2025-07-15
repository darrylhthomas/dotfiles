local function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end

return {
    {
        "arcticicestudio/nord-vim",
        config = function()
            local agrp = vim.api.nvim_create_augroup
            local acmd = vim.api.nvim_create_autocmd
            local _nord_overrides = agrp("_nord_overrides", { clear = true })
            acmd(
                { "ColorScheme" },
                {
                    pattern = "nord",
                    command = "highlight CursorLine ctermfg=14 guifg=#8FBCBB",
                    group = _nord_overrides
                })

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

