-- set colorscheme to nightfly with protected call
-- in case it isn't installed
local status, _ = pcall(vim.cmd, "colorscheme material")
if not status then
  print("Colorscheme not found!")
  return
end

-- vim.cmd 'colorscheme NeoSolarized'
-- vim.g['gruvbox_contrast_dark'] = 'low'
-- vim.g.material_style = "oceanic"
--
vim.cmd 'colorscheme material'
--vim.cmd [[colorscheme nightfly]]
--
-- vim.g.material_style = "palenight"
-- vim.g.material_style = "oceanic"
--
-- vim.cmd 'colorscheme rubber-enhanced'
-- vim.cmd[[colorscheme tokyonight]]
--
-- vim.cmd("colorscheme nightfox")
