return {
    {
        'ibhagwan/fzf-lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            require('fzf-lua').setup({
               --- defaults = {
               ---     git_icons = false,
               ---     file_icons = false,
               ---     color_icons = false,
               --- },
            })
        local fzf = require('fzf-lua')
        vim.keymap.set('n', '<leader>fzf', fzf.files, { desc = 'fzf find files' })
        vim.keymap.set('n', '<leader>fzg', fzf.live_grep, { desc = 'fzf live grep' })
        vim.keymap.set('n', '<leader>fzb', fzf.buffers, { desc = 'fzf buffers' })
        vim.keymap.set('n', '<leader>fzh', fzf.help_tags, { desc = 'fzf help tags' })
        end,

    },
}

