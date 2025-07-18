return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            highlight = {
                enable = true,
            },
            indent = { enable = true },
            autotag = { enable = true },
            ensure_installed = { "lua", "php", "python", "vim", "javascript", "html", "css" },
            auto_install = false,
        })
    end
}

