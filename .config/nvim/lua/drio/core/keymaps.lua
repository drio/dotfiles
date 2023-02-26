--[[
If you run into issues where a mapping is not working as expected use:

:map
:nmap for normal mode mappings
:vmap for visual mode mappings
:imap for insert mode mappings

To find out what plugin is attached to that mapping
--]]

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local function map(key)
	-- get the extra options
	local opts = { noremap = true }
	for i, v in pairs(key) do
		if type(i) == "string" then
			opts[i] = v
		end
	end

	-- basic support for buffer-scoped keybindings
	local buffer = opts.buffer
	opts.buffer = nil

	if buffer then
		vim.api.nvim_buf_set_keymap(0, key[1], key[2], key[3], opts)
	else
		vim.api.nvim_set_keymap(key[1], key[2], key[3], opts)
	end
end

local bind = vim.api.nvim_set_keymap
local noremap = function(m, lhs, rhs)
	bind(m, lhs, rhs, { noremap = true })
end

-- TODO ; dry please
-- map({ "n", "1", "1gt" })
-- map({ "n", "2", "2gt" })
-- map({ "n", "3", "3gt" })
-- map({ "n", "4", "4gt" })
-- map({ "n", "5", "5gt" })
-- map({ "n", "6", "6gt" })

-- mode, key, action, extra
map({ "n", "<SPACE>", "<Nop>" })
map({ "", "<C-h>", "<C-w>h" })
map({ "", "<C-j>", "<C-w>j" })
map({ "", "<C-k>", "<C-w>k" })
map({ "", "<C-l>", "<C-w>l" })

-- After nvim 0.6.0 YP did not do what I expected
map({ "", "YP", "yyp" })

--noremap("n", "<leader><leader>q", ":qa!<CR>")

-- toogle relative numbers
-- map({ "n", "<leader>r", ":set norelativenumber!<CR>" })

-- Switch to the directory of the open buffer
noremap("n", "<Leader>cd", ":lcd %:p:h<CR>:pwd<CR>")
noremap("n", "<Leader>7", "<C-w>|")
noremap("n", "<Leader>8", "<C-w>=")
noremap("n", "<Leader>r", ":LspRestart<CR>")
--[[ noremap("n", "<Leader>1", ":set spell!<CR>") ]]
--[[ noremap("n", "<Leader>e", ":w<CR>") ]]
-- noremap("n", "<leader>E", "<C-w>=leader>E <C-w>=") -- Resize Even
-- noremap("n", "<Leader>q", ":nohlsearch<CR>")
-- noremap("n", "<Leader>l", ":set list!<CR>")

-- noremap("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
-- noremap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
-- noremap("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
-- noremap("n", "<leader>fk", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- noremap("n", "<Leader>nt", ":NvimTreeToggle<CR>")
-- noremap("n", "<Leader>nf", ":NvimTreeFindFile<CR>")

--noremap("n", "<leader>sc", ":close<CR>")
--noremap("n", "<leader>sh", ":sp<CR>")
--noremap("n", "<leader>sv", ":vsp<CR>")

-- noremap("n", "<Leader>v", "<c-^>") -- cycle to previous buffer
-- noremap("n", "<Leader>V", ":e $MYVIMRC<CR>")

-- session management
-- noremap("n", "<leader>St", ":lua require('utils.session').toggle_session()<cr>")
-- noremap("n", "<leader>Sl", ":lua require('utils.session').list_session()<cr>")
-- noremap("n", "<leader>Sd", ":lua require('utils.session').delete_session()<cr>")

vim.cmd([[ "nnoremap <leader>Y :let @a='- \[\[' . expand("%:t") . '\]\]' <CR>" ]])
