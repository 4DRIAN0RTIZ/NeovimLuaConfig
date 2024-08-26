-- ~/.config/nvim/lua/config/ticket_notes.lua
local M = {}
local notes_dir = vim.fn.stdpath('data') .. '/ticket_notes/'

-- Asegura que el directorio de notas existe
local function ensure_notes_dir()
    if vim.fn.isdirectory(notes_dir) == 0 then
        vim.fn.mkdir(notes_dir, 'p')
    end
end

-- Obtener el ID del ticket desde .last_ticket
local function get_ticket_id()
    local last_ticket_file = vim.fn.expand('~/.last_ticket')
    local ticket_id = ''

    if vim.fn.filereadable(last_ticket_file) == 1 then
        ticket_id = vim.fn.readfile(last_ticket_file)[1]
    else
        vim.api.nvim_out_write('.last_ticket no encontrado.\n')
        return nil
    end

    if ticket_id == '' or ticket_id == nil then
        vim.api.nvim_out_write('El archivo .last_ticket está vacío o es inválido.\n')
        return nil
    end

    return ticket_id
end

-- Crear una nueva ventana flotante
local function open_floating_window(note_file)
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

    vim.cmd('edit ' .. note_file)
end
-- Crear una nueva nota
function M.new_note()
    ensure_notes_dir()

    local ticket_id = get_ticket_id()
    if not ticket_id then return end

    local note_file = notes_dir .. ticket_id .. '.md'
    
    if vim.fn.filereadable(note_file) == 1 then
        vim.api.nvim_out_write('La nota para este ticket ya existe.\n')
        return
    end
    
    open_floating_window(note_file)
    vim.api.nvim_buf_set_lines(0, 0, -1, false, { '# Nota para Ticket ' .. ticket_id })
end

-- Editar una nota existente
function M.edit_note()
    ensure_notes_dir()

    local ticket_id = get_ticket_id()
    if not ticket_id then return end

    local note_file = notes_dir .. ticket_id .. '.md'
    
    if vim.fn.filereadable(note_file) == 0 then
        vim.api.nvim_out_write('No existe una nota para este ticket: ' .. note_file .. '\n')
        return
    end
    
    open_floating_window(note_file)
end

-- Listar todas las notas
function M.list_notes()
    ensure_notes_dir()
    local notes = vim.fn.globpath(notes_dir, '*.md', false, true)
    
    if #notes == 0 then
        vim.api.nvim_out_write('No hay notas.\n')
        return
    end
    
    for _, note in ipairs(notes) do
        local ticket_id = vim.fn.fnamemodify(note, ':t:r')
        vim.api.nvim_out_write(ticket_id .. '\n')
    end
end

-- Eliminar una nota existente
function M.delete_note()
    ensure_notes_dir()

    -- Ventana flotante para confirmar la eliminación
    local confirm = vim.fn.confirm('¿Estás seguro de que quieres eliminar la nota?', '&Sí\n&No', 2)
    if confirm ~= 1 then return end

    local ticket_id = get_ticket_id()
    if not ticket_id then return end

    local note_file = notes_dir .. ticket_id .. '.md'
    
    if vim.fn.filereadable(note_file) == 0 then
        vim.api.nvim_out_write('No existe una nota para este ticket.\n')
        return
    end
    
    vim.fn.delete(note_file)
    vim.api.nvim_out_write('Nota para el ticket ' .. ticket_id .. ' eliminada.\n')
end

return M
