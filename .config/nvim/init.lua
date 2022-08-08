-- Inspiration:
-- https://jose-elias-alvarez.medium.com/configuring-neovims-lsp-client-for-typescript-development-5789d58ea9c
--    * https://github.com/jose-elias-alvarez/dotfiles/tree/main/config/nvim/lua/lsp

require('conf.basic')
require('conf.autocmds')
require('plugins')

require('lsp_config')
require('conf.keymaps')
require('completion')
-- plugin configs
require('comment')
require('lline')

