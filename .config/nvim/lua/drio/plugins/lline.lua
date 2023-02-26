require("lualine").setup({
	options = {
		-- necessary for laststatus=3 to work
		globalstatus = true,
		-- theme = 'auto'
    theme = 'tokyonight',
		--theme = "onedark",
		icons_enabled = false,
		component_separators = "|",
		section_separators = "",
	},
})
