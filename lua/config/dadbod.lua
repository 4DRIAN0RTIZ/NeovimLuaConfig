-- nvim/lua/config/dadbod.lua
return {
  'kristijanhusak/vim-dadbod-ui',
  requires = {
    { 'tpope/vim-dadbod', opt = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, opt = true }, -- Opcional
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  config = function()
    -- Configuración de DBUI
    vim.g.db_ui_use_nerd_fonts = 1
  end
}
