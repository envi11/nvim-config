local gh = function(x) return "https://github.com/" .. x end
vim.pack.add({
    gh "sainnhe/gruvbox-material",
    gh "nvim-treesitter/nvim-treesitter",
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
})
vim.cmd "colorscheme gruvbox-material"
require("lualine").setup {
    options = { theme = "gruvbox-material" }
}
require("nvim-highlight-colors").setup({})
require("mason").setup {
    firewall = {
        enabled = true
    }
}
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
lsp.ols = {
    cmd = {
        "grun",
        os.getenv("HOME")
        .. "/thirdparty/ols-arm64-unknown-linux-gnu"
    }
}
vim.lsp.enable(
    {
        'rust_analyzer',
        'lua_ls',
        'clangd',
        'denols',
        'zls',
        'ols',
    }
)

local cmds = {
    "set number",
    "set cursorline",
    "set relativenumber",
    "set shiftwidth=4",
    "set softtabstop=4",
    "set smartindent",
    "set expandtab"
}
for _, v in pairs(cmds) do
    vim.cmd(v)
end
vim.o.signcolumn = "yes"
vim.diagnostic.config({ virtual_text = true })
vim.g["conjure#mapping#doc_word"] = { "<leader>k" }

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("tree-sitter-enable", { clear = true }),
    callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang or not vim.treesitter.language.add(lang) then return end

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

package.path = "/data/data/com.termux/files/home/.config/nvim/?.lua;"
    .. package.path

require "keybinds"
