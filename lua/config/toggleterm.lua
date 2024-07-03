require("toggleterm").setup{
  -- Establece el tamaño del terminal. Puede ser un número o una función
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  -- Mapeo para abrir el terminal con ctrl + x
  open_mapping = [[<c-x>]],
  -- Ocultar la columna de números en los buffers de toggleterm
  hide_numbers = true,
  -- Sombras para los terminales
  shade_terminals = true,
  shading_factor = 2, -- Factor de sombreado para terminales
  start_in_insert = true, -- Iniciar en modo de inserción
  insert_mappings = true, -- Permitir mapeo de apertura en modo de inserción
  terminal_mappings = true, -- Permitir mapeo de apertura en los terminales abiertos
  persist_size = true, -- Recordar el tamaño del terminal
  direction = 'float', -- Dirección del terminal ('vertical', 'horizontal', 'tab', 'float')
  close_on_exit = true, -- Cerrar el terminal cuando el proceso termina
  shell = vim.o.shell, -- Cambiar el shell por defecto
  auto_scroll = true, -- Auto desplazarse al final en la salida del terminal
  -- Opciones específicas para cuando la dirección es 'float'
  float_opts = {
    border = 'curved', -- Tipo de borde (single, double, shadow, curved)
    width = 100,
    height = 30,
    winblend = 3,
  },
  winbar = {
    enabled = false,
  },
}

-- Mapeo para cerrar el terminal con <c-x>

vim.api.nvim_set_keymap('t', '<c-x>', [[<C-\><C-n><cmd>q<CR>]], { noremap = true, silent = true })
