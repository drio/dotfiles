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
	["1"] = { ":set spell!<cr>", "toogle spell" },
	["e"] = { ":w<CR>", "sav[E]" },
	["q"] = { ">nohlsearch<CR>", "clear search" },
	["l"] = { ":set list!<cr>", "toggle special characters" },
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

	n = {
		name = "NvimTree",
		t = { ":NvimTreeToggle<CR>", "toogle" },
		f = { ":NvimTreeFindFile<CR>", "find file" },
	},
}, {
	mode = "n", -- Normal mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = false, -- use `nowait` when creating keymaps
})
