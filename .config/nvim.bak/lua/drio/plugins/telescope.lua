require("telescope").setup({
	defaults = {
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key",
        ['<c-d>'] = require('telescope.actions').delete_buffer
      }
    },
		layout_config = {
			prompt_position = "bottom",
			horizontal = {
				width_padding = 0.04,
				height_padding = 0.5,
				preview_width = 0.5,
			},
			vertical = {
				width_padding = 0.05,
				height_padding = 1,
				preview_height = 1,
			},
		},
		-- other defaults configuration here
	},
	-- other configuration values here
})
