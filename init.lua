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

-- SQL QUERY in PHP Files
-- let php_sql_query = 1
vim.g.php_sql_query = 1

-- Blade Configuration
vim.g.blade_custom_directives = { 'datetime', 'javascript' }
vim.g.blade_custom_directives_pairs = {
markdown = 'endmarkdown',
cache = 'endcache'
}

-- Dadbod Configuration, escapes "$" with "%24"
vim.g.db_ui_env_variable_url = 'sqlserver://osador:Os%40dor%24%40192.168.0.3/Entrega'
vim.g.db_ui_env_variable_name = 'ctSystem_PBA'
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
-- vim.api.nvim_create_autocmd("FileType", {
-- pattern = "markdown",
-- callback = function()
-- vim.opt_local.spell = true
-- -- add es, and en to spelllang
-- vim.opt_local.spelllang = "es,en"
-- -- set colorscheme 
-- vim.cmd("colorscheme vim")
-- end
-- })

-- Set colorcolum in commit messages
vim.api.nvim_create_autocmd("FileType", {
pattern = "gitcommit",
callback = function()
vim.opt_local.colorcolumn = "79"
end
})

-- Set nohlsearch after search
vim.api.nvim_create_autocmd("CmdlineEnter", {
pattern = "/",
callback = function()
vim.cmd("set nohlsearch")
end
})

-- Exec Format on save 
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- pattern = "*",
-- callback = function()
-- vim.cmd("silent call CocAction('format')")
-- end
-- })

-- keymap for format in php files
vim.api.nvim_set_keymap('n', '<leader>ff', 'silent call CocAction("format")', { noremap = true, silent = true })

-- Función para insertar el código en la línea anterior
local function insert_code()
  -- Obtiene la línea actual
  local line_number = vim.api.nvim_win_get_cursor(0)[1]
  -- Inserta la línea deseada en la posición anterior
  vim.api.nvim_buf_set_lines(0, line_number - 1, line_number - 1, false, {
    '  if ($login_v == "osador") $login_v = "hdorantes";'
  })
end

local function print_r()
  -- Obtiene la línea actual
  local line_number = vim.api.nvim_win_get_cursor(0)[1]
  -- Inserta la línea deseada en la posición anterior
  vim.api.nvim_buf_set_lines(0, line_number - 1, line_number - 1, false, {
    'echo "<pre>";',
    'print_r($_POST);',
    'echo "</pre>";'
  })
end

local function remove_print_r()
  -- Busca la línea que contenga
  -- echo "<pre>";
  -- print_r($_POST);
  -- echo "</pre>";
  -- y la elimina

  local pattern = {
    'echo "<pre>";',
    'print_r($_POST);',
    'echo "</pre>";'
  }

  for _, value in ipairs(pattern) do
      vim.cmd("g/".. value:gsub('/', '\\/') .."/d")
  end
end

local function insert_sql_echo()
  -- Obtiene la línea actual
  local line_number = vim.api.nvim_win_get_cursor(0)[1]
  -- Inserta la línea deseada en la posición anterior
  vim.api.nvim_buf_set_lines(0, line_number - 1, line_number - 1, false, {
    'echo $sql; exit;'
  })
end

local function remove_sql_echo()
  -- Busca la línea que contenga
  -- echo $sql; exit;
  -- y la elimina

  local pattern = {
    'echo $sql; exit;'
  }

  for _, value in ipairs(pattern) do
      vim.cmd("g/".. value:gsub('/', '\\/') .."/d")
  end
end

_G.remove_sql_echo = remove_sql_echo
_G.insert_sql_echo = insert_sql_echo
_G.remove_print_r = remove_print_r
_G.print_r = print_r
_G.insert_code = insert_code

-- Mapeo para activar la función cuando se ejecute un comando
vim.api.nvim_set_keymap('n', ';ic', ':lua insert_code()<CR>', { noremap = true, silent = true })

-- Mapeo para eliminar <?php echo y cambiarlo por <?= en un solo comando
vim.api.nvim_set_keymap('n', ';ec', ':%s/<?php echo/<?=/g<CR>', { noremap = true, silent = true })

-- Mapeo para agregar depuración en PHP con pre y print_r
vim.api.nvim_set_keymap('n', ';pr', ':lua print_r()<CR>', { noremap = true, silent = true })

-- Mapeo para eliminar depuración en PHP con pre y print_r
vim.api.nvim_set_keymap('n', ';rpr', ':lua remove_print_r()<CR>', { noremap = true, silent = true })

-- Mapeo para agregar el echo $sql; exit; en PHP
vim.api.nvim_set_keymap('n', ';sqle', ':lua insert_sql_echo()<CR>', { noremap = true, silent = true })

-- Mapeo para eliminar el echo $sql; exit; en PHP
vim.api.nvim_set_keymap('n', ';rsqle', ':lua remove_sql_echo()<CR>', { noremap = true, silent = true })
