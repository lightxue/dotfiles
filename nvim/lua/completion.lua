-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

require("nvim-lsp-installer").setup {
    automatic_installation = true
}

local lspconfig = require('lspconfig')

local lspsaga_on_attach = function(client, bufnr)
    local saga = require 'lspsaga'
    saga.init_lsp_saga()
    local keymap = vim.keymap.set
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    -- Lsp finder find the symbol definition implement reference
    -- if there is no implement it will hide
    -- when you use action in finder like open vsplit then you can
    -- use <C-t> to jump back
    keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", bufopts)

    -- Code action
    keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", bufopts)

    -- Rename
    keymap("n", "gr", "<cmd>Lspsaga rename<CR>", bufopts)

    -- Peek Definition
    -- you can edit the definition file in this flaotwindow
    -- also support open/vsplit/etc operation check definition_action_keys
    -- support tagstack C-t jump back
    keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", bufopts)

    -- Show line diagnostics
    keymap("n", "<leader>de", "<cmd>Lspsaga show_line_diagnostics<CR>", bufopts)

    -- Show cursor diagnostic
    keymap("n", "<leader>de", "<cmd>Lspsaga show_cursor_diagnostics<CR>", bufopts)

    -- Diagnsotic jump can use `<c-o>` to jump back
    keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", bufopts)
    keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", bufopts)

    -- Only jump to error
    keymap("n", "[E", function()
      require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, bufopts)
    keymap("n", "]E", function()
      require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, bufopts)

    -- Outline
    keymap("n","<leader>o", "<cmd>LSoutlineToggle<CR>",bufopts)

    -- Hover Doc
    keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", bufopts)

    -- Float terminal
    keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", bufopts)
    -- if you want pass somc cli command into terminal you can do like this
    -- open lazygit in lspsaga float terminal
    keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", bufopts)
    -- close floaterm
    keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], bufopts)
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<Leader>dD', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', 'gl', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<Leader>ii', vim.lsp.buf.formatting, bufopts)
    -- TODO range_formatting

    lspsaga_on_attach (client, bufnr)

    -- preview definition
    vim.keymap.set('n', 'gD', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', '<Leader>dq', vim.diagnostic.setloclist, bufopts)
    vim.keymap.set("n", "<Leader>dc", '<CMD>NvimContextVtToggle<CR>', bufopts)

    require("nvim-navic").attach(client, bufnr)
    require('illuminate').on_attach(client)

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

require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
