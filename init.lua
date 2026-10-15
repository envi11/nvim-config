local gh = function(x) return "https://github.com/" .. x end
vim.pack.add({
    gh "sainnhe/gruvbox-material",
    gh "nvim-treesitter/nvim-treesitter",
    gh "nvim-mini/mini.nvim",
    gh "nvim-tree/nvim-web-devicons",
    gh "nvim-lualine/lualine.nvim",
    gh "brenoprata10/nvim-highlight-colors",
    gh "tpope/vim-fugitive",
    gh "ojroques/vim-oscyank",
    gh "neovim/nvim-lspconfig",
    gh "saghen/blink.compat",
    gh "saghen/blink.lib",
    gh "saghen/blink.cmp",
    gh "rafamadriz/friendly-snippets",
    gh "mason-org/mason.nvim",
    gh "PaterJason/cmp-conjure",
    gh "Olical/conjure",
    gh "rluba/jai.vim",
    gh "leafo/moonscript-vim",
    gh "assistcontrol/readline.nvim",
    gh "vim-scripts/transpose-words",
    gh "m4xshen/autoclose.nvim",
})
vim.cmd "colorscheme gruvbox-material"
require("lualine").setup {
    options = { theme = "gruvbox-material" }
}
require('mini.align').setup()
require("nvim-highlight-colors").setup({})
require("mason").setup {
    firewall = {
        enabled = true
    }
}
require("autoclose").setup({
    keys = {
        ["'"] = { escape = false, close = false },
        ["`"] = { escape = false, close = false },
    },
    options = {
        disable_when_touch = true,
    }
})
local cmp = require("blink.cmp")
cmp.setup({
    fuzzy = { implementation = "lua" },
    keymap = { preset = 'super-tab' },
    completion = { menu = { auto_show = false } },
    sources = {
        default = { "lsp", "path", "snippets", "buffer", "conjure" },
        providers = {
            conjure = {
                name = "conjure",
                module = "blink.compat.source",
            }
        }
    },
})
local lsp = vim.lsp.config
-- lsp.ols = {
--     cmd = {
--         "grun",
--         os.getenv("HOME")
--         .. "/thirdparty/ols-arm64-unknown-linux-gnu"
--     }
-- }
lsp.clangd = {
    cmd = {
        "clangd",
        "--fallback-style=WebKit",
    }
}
vim.lsp.enable(
    {
        --'rust_analyzer',
        'lua_ls',
        'clangd',
        --'denols',
        --'zls',
        --'ols',
    }
)
local readline = require 'readline'
vim.keymap.set('!', '<M-f>', readline.forward_word)
vim.keymap.set('!', '<M-b>', readline.backward_word)
vim.keymap.set('!', '<C-a>', readline.beginning_of_line)
vim.keymap.set('!', '<C-e>', readline.end_of_line)
vim.keymap.set('!', '<M-d>', readline.kill_word)
vim.keymap.set('!', '<M-BS>', readline.backward_kill_word)
vim.keymap.set('!', '<C-w>', readline.unix_word_rubout)
vim.keymap.set('!', '<C-k>', readline.kill_line)
vim.keymap.set('!', '<C-u>', readline.backward_kill_line)

local cmds = {
    "set number",
    "set cursorline",
    "set relativenumber",
    "set shiftwidth=4",
    "set softtabstop=4",
    "set smartindent",
    "set expandtab",
    "set scrolloff=6"
}
for _, v in pairs(cmds) do
    vim.cmd(v)
end
vim.o.signcolumn = "yes"
vim.diagnostic.config({ virtual_text = true })
vim.g["conjure#mapping#doc_word"] = { "<leader>k" }
vim.g["conjure#filetypes"] = { "clojure", "fennel", "python" }

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup(
        "tree-sitter-enable", { clear = true }
    ),
    callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang or
            not vim.treesitter.language.add(lang)
        then
            return
        end

        if vim.treesitter.query.get(lang, "highlights") then
            vim.treesitter.start(args.buf)
        end

        -- if vim.treesitter.query.get(lang, "indents") then
        --   vim.opt_local.indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'
        -- end
        --
        -- if vim.treesitter.query.get(lang, "folds") then
        --   vim.opt_local.foldmethod = "expr"
        --   vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        -- end
    end,
})

package.path = os.getenv("HOME") .. "/.config/nvim/?.lua;"
    .. package.path

require "keybinds"
