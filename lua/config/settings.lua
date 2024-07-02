-- ~/.config/nvim/lua/config/settings.lua

-- Load plugins
require('config.plugins')

-- Load plugin configurations
require('plugins.lsp')
require('plugins.telescope')
require('plugins.chatgpt')
require('plugins.themes')
require('plugins.whichkey')
require('plugins.trouble')
require('plugins.noice')
require('plugins.notify')
require('plugins.nvim_tree')
require('plugins.lualine')

-- Load keymaps
require('config.keymaps')
require('config.cocconfig')
