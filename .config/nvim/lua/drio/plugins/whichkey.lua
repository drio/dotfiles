-- references
-- 1. https://alpha2phi.medium.com/neovim-for-beginners-key-mappings-and-whichkey-31dbf58f9f87
-- 2. https://github.com/folke/which-key.nvim#%EF%B8%8F-mappings

local wk = require("which-key")

wk.setup({
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
	},
})

wk.register({
	["c"] = { ":set list!<cr>", "toggle special [c]haracters" },
	["e"] = { ":w<CR>", "sav[E]" },
	["q"] = { ">nohlsearch<CR>", "[Q]uit search" },
	["v"] = { "<c-^>", "previous buffer" },
	["V"] = { ":e $MYVIMRC<CR>", "edit vimrc" },
	["z"] = { ":ZenMode<CR>", "Toogle Zen Mode" },

	["<leader>"] = {
		q = { ":qa!<CR>", "Quit" },
	},

	f = {
		name = "Telescope",
		b = { "<cmd>Telescope buffers<cr>", "find in buffers" },
		f = { "<cmd>Telescope find_files<cr>", "find in files" },
		g = { "<cmd>Telescope live_grep<cr>", "grep" },
		k = { "<cmd>Telescope help_tags<cr>", "list in help tags" },
	},

	m = {
		t = { ":set spell!<cr>", "[M]isc toggle [S]pell" },
	},

	n = {
		name = "NvimTree",
		t = { ":NvimTreeToggle<CR>", "toggle" },
		f = { ":NvimTreeFindFile<CR>", "find file" },
	},

	s = {
		name = "Sessions and Split",
		t = { ":lua require('utils.session').toggle_session()<cr>", "[S]ession [T]oggle" },
		l = { ":lua require('utils.session').list_session()<cr>", "[S]ession [L]ist" },
		d = { ":lua require('utils.session').delete_session()<cr>", "[S]ession [D]elete" },
		--
		h = { ":sp<CR>", "[S]plit [H]orizontally" },
		v = { ":vsp<CR>", "[S]plit [V]ertically" },
		c = { ":close<cr>", "[S]plit [C]lose" },
	},

	t = {
		f = { ":tabfirst<cr>", "[T]ab [F]irst" },
		l = { ":tablast<cr>", "[T]ab [L]ast" },
		p = { ":tabprevious<cr>", "[T]ab [P]rev" },
		n = { ":tabnext<cr>", "[T]ab [N]ext" },
	},
}, {
	mode = "n", -- Normal mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = false, -- use `nowait` when creating keymaps
})
