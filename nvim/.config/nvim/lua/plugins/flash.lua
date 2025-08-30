return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
        modes = {
            search = {
                enabled = true,
            },
        },
    },
    keys = {
        {
            "<leader>jj",
            mode = { "n", "x", "o" },
            function()
                require("flash").jump({
                    -- labels = "asdfghjklqwertyuiopzxcvbnm",
                    -- labeler = function(matches, state)
                    --     -- Assign labels to matches
                    --     for i, match in ipairs(matches) do
                    --         match.label = tostring(i) -- Use numbers as labels
                    --     end
                    -- end,
                    -- search = {
                    --     mode = function(str)
                    --         return "\\V" .. str:gsub("\\", "\\\\") .. "\\c"
                    --     end,
                    -- },
                    label = {

                        reuse = "all",
                        format = function(opts)
                            -- Custom format for label display
                            return {
                                { "[" .. opts.match.label .. "]", opts.hl_group },
                            }
                        end,
                    },
                })
            end,
            desc = "Flash",
        },
        {
            "<leader>jt",
            mode = { "n", "x", "o" },
            function()
                require("flash").treesitter()
            end,
            desc = "Flash Treesitter",
        },
        {
            "<leader>jr",
            mode = "o",
            function()
                require("flash").remote({
                    label = {
                        format = function(opts)
                            -- Custom format for label display
                            return {
                                { "[" .. opts.match.label .. "]", opts.hl_group },
                            }
                        end,
                    },
                })
            end,
            desc = "Flash remote",
        },
        {
            "<leader>js",
            mode = { "x", "o" },
            function()
                require("flash").treesitter_search({
                    label = {
                        format = function(opts)
                            -- Custom format for label display
                            return {
                                { "[" .. opts.match.label .. "]", opts.hl_group },
                            }
                        end,
                    },
                })
            end,
            desc = "Flash Treesitter search",
        },
        {
            "<c-s>",
            mode = { "c" },
            function()
                require("flash").toggle()
            end,
            desc = "Toggle Flash search",
        },
    },
}
