-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
	return
end

local keymap = vim.keymap -- for conciseness

function org_imports(wait_ms)
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { "source.organizeImports" } }
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

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- set keybinds
	keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
	keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
	--keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	keymap.set("n", "K", "<cmd> lua vim.lsp.diagnostics.open_float()<CR>", opts) -- show documentation for what is under cursor
	--keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
	--keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
	keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

	--[[
        vim.keymap.set("n", "K",  vim.lsp.buf.hover, {buffer = 0})
        vim.keymap.set("n", "E",  vim.diagnostic.open_float, {buffer = 0})
        vim.keymap.set("n", "gs", vim.diagnostic.show, {buffer = 0})
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = 0})
        --vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer = 0})
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer = 0})
        vim.keymap.set("n", "gR", vim.lsp.buf.references, {buffer = 0})
        vim.keymap.set("n", "gr", vim.lsp.buf.rename, {buffer = 0})
        vim.keymap.set("n", "gf", vim.lsp.buf.formatting, {buffer = 0})
        vim.keymap.set("n", "ga", vim.lsp.buf.code_action, {buffer = 0})
        vim.keymap.set("n", "en", vim.diagnostic.goto_next, {buffer = 0})
        vim.keymap.set("n", "ep", vim.diagnostic.goto_prev, {buffer = 0})

        vim.cmd("au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
        vim.cmd("au BufWritePre *.go lua org_imports(3000)")
  --]]

	if client.name == "gopls" then
		vim.cmd("au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		vim.cmd("au BufWritePre *.go lua org_imports(3000)")
	end

	-- typescript specific keymaps (e.g. rename file and update imports)
	if client.name == "tsserver" then
		keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
		keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
		keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
	end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- configure html server
lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure typescript server with plugin
typescript.setup({
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
	},
})

-- configure css server
lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["sumneko_lua"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim", "hs", "spoon" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

-- configure gopls server
lspconfig["gopls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["pyright"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["yamlls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["terraformls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-------------------------------
-- OLD lspconfig starts here
--------------------------------

-- Tell the language server what the lsp client is able to do
--[[
local capabilities = require('cmp_nvim_lsp')
  .update_capabilities(vim.lsp
  .protocol
  .make_client_capabilities())
--]]

--[[

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

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
-- yamlls: npm install -g yaml-language-server
-- yamlls: https://github.com/pwntester/nvim-lsp/blob/master/lua/nvim_lsp/yamlls.lua
local servers = { 'pyright', 'tsserver', 'svelte', 'gopls', 'sumneko_lua', 'terraformls', 'tflint', 'yamlls' }

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
        --vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer = 0})
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

--]]
