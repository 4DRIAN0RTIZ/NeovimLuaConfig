local function get_time()
    return os.date("%A, %d %B %Y, %X")
end

local function working_on_ticket()
    local file = io.open(os.getenv("HOME") .. "/.last_ticket", "r")
    if file == nil then
        return ""
    end

    local ticket = file:read("*all")
    -- Remover el salto de línea
    ticket = string.gsub(ticket, "\n", "")
    file:close()

    return "Working on ticket: " .. ticket
end

local function end_laboral_day()
    local date_time = os.date("*t")
    local day = date_time.wday
    local current_hour = date_time.hour
    local current_minute = date_time.min
    local current_second = date_time.sec

    local end_hour = 16
    local end_minute = 0
    local end_second = 0

    -- Ajustar la hora de finalización para el domingo
    if day == 7 then
        end_hour = 14
    end

    -- Calcular el tiempo restante en segundos
    local total_seconds_left = (end_hour * 3600 + end_minute * 60 + end_second) - (current_hour * 3600 + current_minute * 60 + current_second)

    if total_seconds_left < 0 then
        -- Calcular segundos y minutos de retraso, en caso de que minutos sea cero mostrar solo segundos
        local seconds_late = math.abs(total_seconds_left)
        local minutes_late = math.floor(seconds_late / 60)
        seconds_late = seconds_late % 60

        local message = "Late by "

        if minutes_late > 0 then
            message = message .. string.format("%d minutes and ", minutes_late)
        end

        message = message .. string.format("%d seconds", seconds_late)

        return message
    else
        -- Calcular las horas, minutos y segundos restantes
        local hours_left = math.floor(total_seconds_left / 3600)
        local minutes_left = math.floor((total_seconds_left % 3600) / 60)
        local seconds_left = total_seconds_left % 60

        -- Construir el mensaje basado en las horas, minutos y segundos restantes
        local message = "End of laboral day in "

        if hours_left > 0 then
            message = message .. string.format("%d hours, ", hours_left)
        end

        if minutes_left > 0 then
            message = message .. string.format("%d minutes, ", minutes_left)
        end

        -- Siempre mostramos los segundos
        message = message .. string.format("%d seconds", seconds_left)

        return message
    end
end

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {},
        always_divide_middle = true,
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', {'diagnostics', sources={'nvim_lsp', 'coc'}}},
        lualine_c = {'filename'},
        lualine_x = { working_on_ticket, get_time, end_laboral_day,'encoding', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {'fugitive'}
}
