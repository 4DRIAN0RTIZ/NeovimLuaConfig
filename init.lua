_G.vim = vim

-- Load plugin settings
require('settings')

-- Configuración básica
local function configure_basic()
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
  vim.g.php_sql_query = 1
end

-- Configuración de Blade
-- local function configure_blade()
--   vim.g.blade_custom_directives = { 'datetime', 'javascript' }
--   vim.g.blade_custom_directives_pairs = {
--     markdown = 'endmarkdown',
--     cache = 'endcache'
--   }
-- end

local function configure_dadbod()
  -- Configuración de Dadbod
  vim.g.db_ui_env_variable_url = 'sqlserver://osador:Os%40dor%24%40192.168.0.3/Entrega'
  vim.g.db_ui_env_variable_name = 'ctSystem_PBA'
end

-- Configuración de NvimTree
local function configure_nvimtree()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
end

-- Configuración del tema
local function configure_theme()
  -- Configurar tema
  vim.opt.termguicolors = true -- Esto es necesario para que los colores se vean bien. Lo que hace es que se usen los colores de 24 bits.
end

-- Configuración de Closetag
local function configure_closetag()
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
end

-- Autocommands
local function configure_autocommands()
  -- Configurar colorcolumn en mensajes de commit
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit",
    callback = function()
      vim.opt_local.colorcolumn = "79"
    end
  })

  -- Desactivar búsqueda resaltada después de buscar
  vim.api.nvim_create_autocmd("CmdlineEnter", {
    pattern = "/",
    callback = function()
      vim.cmd("set nohlsearch")
    end
  })
end

-- Funciones de utilidad
local function utility_functions()
  local function insert_code()
    local line_number = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(0, line_number - 1, line_number - 1, false, {
      '  if ($login_v == "osador") $login_v = "hdorantes";'
    })
  end

  local function print_r()
    local line_number = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(0, line_number - 1, line_number - 1, false, {
      'echo "<pre>";',
      'print_r($_POST);',
      'echo "</pre>";'
    })
  end

  local function remove_print_r()
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
    local line_number = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(0, line_number - 1, line_number - 1, false, {
      'echo $sql; exit;'
    })
  end

  local function remove_sql_echo()
    local pattern = {
      'echo $sql; exit;'
    }

    for _, value in ipairs(pattern) do
      vim.cmd("g/".. value:gsub('/', '\\/') .."/d")
    end
  end

  local function open_floating_window(content)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
    
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local opts = {
      style = "minimal",
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col
    }

    local win = vim.api.nvim_open_win(buf, true, opts)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(content, "\n"))
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
  end

  local function sql_query()
    local line = vim.fn.getline(".")
    if vim.fn.mode() == "v" then
      line = table.concat(vim.fn.getline("'<", "'>"), " ")
    end

    if line == "" or line == nil then
      print("No se ha seleccionado ninguna consulta SQL.")
      return
    end

    line = line:gsub("= (%w+)", "= '%1'")
    local path = "/home/neandertech/sqlCommands/sqlQuery.sh"
    local result = vim.fn.system(path .. " \"" .. line .. "\"")
    open_floating_window(result)
  end

  _G.sql_query = sql_query
  _G.remove_sql_echo = remove_sql_echo
  _G.insert_sql_echo = insert_sql_echo
  _G.remove_print_r = remove_print_r
  _G.print_r = print_r
  _G.insert_code = insert_code
end

-- Ejecución de las configuraciones
configure_basic()
-- configure_blade()
configure_dadbod()
configure_nvimtree()
configure_theme()
configure_closetag()
configure_autocommands()
utility_functions()
