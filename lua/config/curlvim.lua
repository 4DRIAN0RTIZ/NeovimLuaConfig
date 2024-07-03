-- Guarda este archivo como lua/plugins/my_routes.lua

local M = {}

-- Función para detectar rutas de Flask
function M.detect_flask_route()
    local line = vim.api.nvim_get_current_line()
    -- Detecta si es una ruta o un blueprint con un operador |
    local blueprint, route, methods = line:match("@([%w_]+)_bp%.route%(%'([^']+)%', methods=%[(%b'')%]%)")

    if not blueprint or not route or not methods then
        vim.api.nvim_err_writeln("No se detectó ninguna ruta, blueprint o método en Flask")
        return
    end

    vim.api.nvim_out_write("Blueprint: " .. blueprint .. "\n")
    vim.api.nvim_out_write("Route: " .. route .. "\n")
    vim.api.nvim_out_write("Methods: " .. methods .. "\n")
    vim.api.nvim_out_write("Endpoint type: " .. type(methods) .. "\n")

    local headers, body = M.detect_headers_and_body()
    M.make_request(blueprint, route, methods, headers, body)
end

-- Función para detectar rutas de Express (Node.js)
function M.detect_express_route()
    local line = vim.api.nvim_get_current_line()
    local method, route = line:match("app%.(%a+)%(%'([^']+)%'")

    if not method or not route then
        vim.api.nvim_err_writeln("No se detectó ninguna ruta o método en Express")
        return
    end

    vim.api.nvim_out_write("Method: " .. method .. "\n")
    vim.api.nvim_out_write("Route: " .. route .. "\n")

    local headers, body = M.detect_headers_and_body()
    M.make_request(nil, route, method, headers, body)
end

-- Función para detectar headers y body (simplificada para demostración)
function M.detect_headers_and_body()
    local headers = ""
    local body = ""

    -- Lógica simplificada para detectar headers y body
    local header_line = vim.fn.search('headers%s*=%s*{', 'n', vim.fn.line('$'))
    if header_line > 0 then
        headers = vim.fn.getline(header_line):match('headers%s*=%s*{(.-)}')
    end

    local body_line = vim.fn.search('json%s*=%s*', 'n', vim.fn.line('$'))
    if body_line > 0 then
        body = vim.fn.getline(body_line):match('json%s*=%s*(.*)')
    end

    return headers, body
end

-- Función para realizar la petición basada en el método detectado
function M.make_request(blueprint, route, method, headers, body)
    local full_route = route
    if blueprint then
        full_route = "/" .. blueprint .. route
    end

    local curl_cmd = "curl -s -L -X " .. method:upper() .. " http://localhost:2089" .. full_route

    if headers and headers ~= "" then
        curl_cmd = curl_cmd .. " -H '" .. headers .. "'"
    end

    if (method:upper() == "POST" or method:upper() == "PUT") and (not body or body == "") then
        body = M.prompt_for_body()
        curl_cmd = curl_cmd .. " -d '" .. body .. "'"
    end

    M.execute_curl_request(curl_cmd, full_route)
end

-- Función para solicitar body en una ventana flotante
function M.prompt_for_body()
    vim.api.nvim_out_write("Por favor, ingrese el body para la solicitud POST/PUT:\n")
    local body = vim.fn.input("Body: ")
    return body
end

-- Función para ejecutar la solicitud curl y mostrar el resultado
function M.execute_curl_request(curl_cmd, full_route)
    curl_cmd = curl_cmd .. " | jq '.'"  -- Pipe the output to jq for formatting

    local handle = io.popen(curl_cmd)
    local result = handle:read("*a")
    handle:close()

    M.show_result_in_floating_window(result, full_route)
end

-- Función para mostrar el resultado en una ventana flotante
function M.show_result_in_floating_window(result, route)
    local buf = vim.api.nvim_create_buf(false, true)
    local lines = vim.split(result, "\n") -- Split result into lines
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    -- Get the dimensions of the current window
    local width = vim.api.nvim_get_option("columns")
    local height = vim.api.nvim_get_option("lines")

    -- Define the size and position of the floating window
    local win_width = 80
    local win_height = 20
    local row = math.ceil((height - win_height) / 2)
    local col = math.ceil((width - win_width) / 2)

    -- Create a buffer for the title and description
    local title_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(title_buf, 0, -1, false, {"Esta es la respuesta compa: " .. route})

    -- Create the floating window for the title and description
    local title_win = vim.api.nvim_open_win(title_buf, false, {
        relative = "editor",
        width = win_width,
        height = 2,
        row = row - 2,  -- Position the title window above the result window
        col = col,
        style = "minimal",
        border = "rounded"
    })

    -- Create the floating window for the result
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = win_width,
        height = win_height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded"
    })

    -- Set up key mapping to close both floating windows
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':lua vim.api.nvim_win_close('..win..', true) vim.api.nvim_win_close('..title_win..', true)<CR>', { noremap = true, silent = true })
end

return M
