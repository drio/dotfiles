require('telescope').setup({
  defaults = {
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

