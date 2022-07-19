-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

require("nvim-lsp-installer").setup {
    automatic_installation = true
}

local lspconfig = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<leader>dD', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', 'gl', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>df', vim.lsp.buf.formatting, bufopts)


    vim.keymap.set("n", "gh", require("lspsaga.finder").lsp_finder, bufopts)

    local action = require("lspsaga.codeaction")

    -- code action
    vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", bufopts)
    vim.keymap.set("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", bufopts)

    -- show hover doc
    vim.keymap.set("n", "K", require("lspsaga.hover").render_hover_doc, bufopts)

    local action = require("lspsaga.action")
    -- scroll down hover doc or scroll in definition preview
    vim.keymap.set("n", "<C-f>", function()
        action.smart_scroll_with_saga(1)
    end, bufopts)
    -- scroll up hover doc
    vim.keymap.set("n", "<C-b>", function()
        action.smart_scroll_with_saga(-1)
    end, bufopts)

    -- show signature help
    vim.keymap.set("n", "gs", require("lspsaga.signaturehelp").signature_help, bufopts)
    -- rename
    -- close rename win use <C-c> in insert mode or `q` in normal mode or `:q`
    vim.keymap.set("n", "gr", require("lspsaga.rename").lsp_rename, bufopts)
    -- preview definition
    vim.keymap.set('n', 'gD', vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "gd", require("lspsaga.definition").preview_definition, bufopts)

    vim.keymap.set("n", "<leader>de", require("lspsaga.diagnostic").show_line_diagnostics, bufopts)
    vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, opts)

    -- jump diagnostic
    vim.keymap.set("n", "[e", require("lspsaga.diagnostic").goto_prev, bufopts)
    vim.keymap.set("n", "]e", require("lspsaga.diagnostic").goto_next, bufopts)
    -- or jump to error
    vim.keymap.set("n", "[E", function()
        require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, bufopts)
    vim.keymap.set("n", "]E", function()
        require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, bufopts)
end
-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = {
    'awk_ls',
    'bashls',
    'clangd',
    'cssls',
    'dockerls',
    'gopls',
    'html',
    'jsonls',
    'lemminx',
    'pyright',
    -- 'remark_ls',
    'sqls',
    'sumneko_lua',
    'texlab',
    'tsserver',
    'vimls',
    'volar',
    'yamlls',
}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
    virtualTextCurrentLineOnly = true,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]


-- luasnip setup
local luasnip = require 'luasnip'

local lspkind = require('lspkind')

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-j>'] = cmp.mapping.scroll_docs(-4),
        ['<C-k>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        -- { name = 'dictionary', keyword_length = 2 },
        { name = 'zsh' },
        { name = 'nvim_lua' }
    }, {
        { name = 'buffer' },
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        })
    }
}
-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' },
        { name = 'cmdline_history' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' },
        { name = 'cmdline_history' }
    })
})

-- require("cmp_dictionary").setup({
    -- dic = {
        -- ["text,markdown"] = { "/usr/share/dict/words" },
    -- },
-- })

require("luasnip.loaders.from_vscode").lazy_load('bundle/friendly-snippets/snippets')

local saga = require 'lspsaga'
saga.init_lsp_saga()
