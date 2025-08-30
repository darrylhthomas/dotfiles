return {
    "L3MON4D3/LuaSnip",
    event = "VeryLazy",
    run = "make install_jsregexp",
    config = function()
        require("luasnip.loaders.from_lua").load({ paths = "./snippets" })
    end,
}
