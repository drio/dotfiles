-- change some telescope options and a keymap to browse plugin files
return {
  --  test
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>sh", false },
      { "<leader>sv", false },
      { "<leader>sc", false },
      { "<leader><leader>", false },
    },
  },
  {
    "folke/flash.nvim",
    enabled = false,
  },
}
