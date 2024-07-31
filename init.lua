_G.vim = vim
-- ~/.config/nvim/init.lua
-- Load plugin settings
require('settings')

-- Basic Configuration
vim.opt.signcolumn = "no"
vim.opt.shell = "sh"
vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.cmd("syntax enable")
vim.opt.showcmd = false
vim.opt.encoding = "UTF-8"
vim.opt.showmatch = true
vim.opt.relativenumber = true
vim.opt.showmode = false

-- Custom functions
_G.MyUsername = function()
  return os.getenv("USER")
end

_G.MyClock = function()
  local date_time = os.date("%a %d %b %Y %H:%M")
  return _G.MyUsername() .. ' hoy es ' .. date_time
end


-- Blade Configuration
vim.g.blade_custom_directives = { 'datetime', 'javascript' }
vim.g.blade_custom_directives_pairs = {
  markdown = 'endmarkdown',
  cache = 'endcache'
}

-- NvimTree Configuration
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Theme Configuration
vim.opt.termguicolors = true
-- Closetag Configuration
vim.g.closetag_filenames = '*.html,*.xhtml,*.phtml'
vim.g.closetag_xhtml_filenames = '*.xhtml,*.jsx'
vim.g.closetag_filetypes = 'html,xhtml,phtml'
vim.g.closetag_xhtml_filetypes = 'xhtml,jsx'
vim.g.closetag_emptyTags_caseSensitive = 1
vim.g.closetag_regions = {
  ['typescript.tsx'] = 'jsxRegion,tsxRegion',
  ['javascript.jsx'] = 'jsxRegion',
  ['typescriptreact'] = 'jsxRegion,tsxRegion',
  ['javascriptreact'] = 'jsxRegion'
}
vim.g.closetag_close_shortcut = '<leader>>'

-- Set spelllang to Spanish only in markdown files, and enable spell checking
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = true
    -- add es, and en to spelllang
    vim.opt_local.spelllang = "es,en"
    -- set colorscheme 
    vim.cmd("colorscheme vim")
  end
})

-- Set colorcolum in commit messages
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.colorcolumn = "79"
  end
})
