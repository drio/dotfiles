-- Tell the language server what the lsp client is able to do
local capabilities = require('cmp_nvim_lsp')
  .update_capabilities(vim.lsp
  .protocol
  .make_client_capabilities())

function org_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

-- Setup language servers
-- Connect lsp client to the server
-- Use :LspInfo to confirm the lsp client is connected to server
local servers = { 'pyright', 'tsserver', 'svelte', 'gopls', 'sumneko_lua', 'terraformls', 'tflint'}

local lspconfig = require('lspconfig')
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
    completeUnimported = true,
    analyses = {unusedparams = true},
    staticcheck = true,
    -- This will run inside of every buffer when the first get attach to the lsp
    on_attach = function()
        -- "n" normal mode
        -- {buffer=0} means only for this buffer
        -- <cmd> == :
        -- <cr> == enter
        -- Pressing K twice will get you inside the "window"; ctrl-o takes you out
        vim.keymap.set("n", "K",  vim.lsp.buf.hover, {buffer = 0})
        vim.keymap.set("n", "E",  vim.diagnostic.open_float, {buffer = 0})
        vim.keymap.set("n", "gs", vim.diagnostic.show, {buffer = 0})
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = 0})
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer = 0})
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer = 0})
        vim.keymap.set("n", "gR", vim.lsp.buf.references, {buffer = 0})
        vim.keymap.set("n", "gr", vim.lsp.buf.rename, {buffer = 0})
        vim.keymap.set("n", "gf", vim.lsp.buf.formatting, {buffer = 0})
        vim.keymap.set("n", "ga", vim.lsp.buf.code_action, {buffer = 0})
        vim.keymap.set("n", "en", vim.diagnostic.goto_next, {buffer = 0})
        vim.keymap.set("n", "ep", vim.diagnostic.goto_prev, {buffer = 0})

        vim.cmd("au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
        vim.cmd("au BufWritePre *.go lua org_imports(3000)")
    end
  }
end

-- Fix the Undefined global vim issues
lspconfig.sumneko_lua.setup {
    settings = {
        Lua = {
            diagnostics = {
                -- neovim and hammerspoon
                globals = { 'vim', 'hs', 'spoon' }
            }
        }
    }
}

-- LSP autocomplete
vim.opt.completeopt = {"menu", "menuone", "noselect"} -- setting vim values

-- Setup nvim-cmp
local cmp = require 'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
        ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item()),
        ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item()),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
        }),
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({select = true})
    },
    sources = cmp.config.sources({
      {name = 'nvim_lsp'},
      {name = 'luasnip'} -- For luasnip users.
    }, {
      {name = 'buffer'}
    })
})


-- Enable inline errors
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {update_in_insert = true})

