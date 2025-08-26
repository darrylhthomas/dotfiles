return {
    "mfussenegger/nvim-lint",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            ---     python = { "pylint" },
            twig = { "twig-cs-fixer" },
            swift = { "swiftlint" },
            javascript = { "eslint_d" },
            html = { "htmlhint" },
        }

        ---        local venv_path =
        ---            'import sys; sys.path.append("/opt/homebrew/lib/python3.13/site-packages"); import pylint_venv; pylint_venv.inithook(force_venv_activation=True, quiet=True)'
        ---        local pylint = lint.linters.pylint
        ---        pylint.args = {
        ---            "-f",
        ---            "json",
        ---            "--init-hook",
        ---            venv_path,
        ---        }

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })

        vim.keymap.set("n", "<leader>ll", function()
            lint.try_lint()
        end, { desc = "Lint current file" })
    end,
}
