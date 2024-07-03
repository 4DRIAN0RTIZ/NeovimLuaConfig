-- Guarda este archivo como lua/config/curlvim.lua

local M = {}

M.config = {
    -- Puertos y host para las rutas
    ports = {
        flask = 5000,
        express = 3000
    },
    base_url = "http://localhost",
    -- Configuración de la ventana flotante
    floating_window = {
        width = 80,
        height = 20,
        border = "rounded"
    }
}

-- Función para configurar los puertos
function M.setup(user_config)
    M.config = vim.tbl_extend('force', M.config, user_config or {})
end

-- Función que hace una peticion a la url que este en la linea actual
function M.request()
    local line = vim.api.nvim_get_current_line()
    local method, route = line:match("(%u+)%s+(%S+)")

    if not route or not method then
        vim.api.nvim_err_writeln("No se detectó ninguna ruta o método HTTP en la línea actual")
        return
    end

    local curl_cmd
    if method == "POST" then
        local next_line = vim.api.nvim_buf_get_lines(0, vim.api.nvim_win_get_cursor(0)[1], vim.api.nvim_win_get_cursor(0)[1] + 1, false)[1]
        local json_body = next_line:match("^%s*(%b{})")
        if not json_body then
            vim.api.nvim_err_writeln("No se detectó un cuerpo JSON en la línea siguiente")
            return
        end
        curl_cmd = "curl -s -X POST -H 'Content-Type: application/json' -d '" .. json_body .. "' '" .. route .. "' | jq '.'"
    else
        curl_cmd = "curl -s -X " .. method .. " '" .. route .. "' | jq '.'"
    end

    M.execute_curl_request(curl_cmd, route)
end

-- Función principal que detecta el tipo de ruta y llama a la función correspondiente
function M.detect_route()
    local line = vim.api.nvim_get_current_line()
    if line:match("GET") or line:match("POST") or line:match("PUT") or line:match("DELETE") then
        M.request()
        return
    end
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")
    if filetype == "python" then
        M.detect_flask_route()
    elseif filetype == "javascript" then
        M.detect_express_route()
    else
        vim.api.nvim_err_writeln("No se detectó un tipo de archivo compatible")
    end
end

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

    local headers, body = M.detect_headers_and_body()
    M.make_request(blueprint, route, methods, headers, body, M.config.ports.flask)

end

-- Función para detectar rutas de Express (Node.js)
function M.detect_express_route()
    local line = vim.api.nvim_get_current_line()
    local method, route = line:match("app%.(%a+)%s*%(?%s*['\"]([^'\"]+)['\"]")

    if not method or not route then
        vim.api.nvim_err_writeln("No se detectó ninguna ruta o método en Express")
        return
    end

    vim.api.nvim_out_write("Method: " .. method .. "\n")
    vim.api.nvim_out_write("Route: " .. route .. "\n")

    local headers, body = M.detect_headers_and_body()
    M.make_request(nil, route, method, headers, body, M.config.ports.express)
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
function M.make_request(blueprint, route, method, headers, body, port)
    local host = M.config.base_url .. ":" .. port
    local full_route = route
    if blueprint then
        full_route = "/" .. blueprint .. route
    end

    local curl_cmd = "curl -s -L -X " .. method:upper() .. " '" .. host .. full_route .. "'"

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
    -- curl_cmd con -i
    curl_cmd = curl_cmd .. " | jq '.'"  -- Pipe the output to jq for formatting

    local handle = io.popen(curl_cmd)
    local result = handle:read("*a")
    handle:close()

    M.show_result_in_floating_window(result, full_route)
end

-- Función para mostrar el resultado en una ventana flotante
function M.show_result_in_floating_window(result, route)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, "filetype", "json")
    local lines = { "Respuesta para la ruta: " .. route , "" } -- Title line and an empty line
    vim.list_extend(lines, vim.split(result, "\n")) -- Add the result lines after the title
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    -- Get the dimensions of the current window
    local width = vim.api.nvim_get_option("columns")
    local height = vim.api.nvim_get_option("lines")

    -- Define the size and position of the floating window
    local win_width = M.config.floating_window.width
    local win_height = M.config.floating_window.height
    local row = math.ceil((height - win_height) / 2)
    local col = math.ceil((width - win_width) / 2)

    -- Create the floating window for the result
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = win_width,
        height = win_height,
        row = row,
        col = col,
        style = "minimal",
        border = M.config.floating_window.border
    })

    -- Set up key mapping to close the floating window
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':lua vim.api.nvim_win_close('..win..', true)<CR>', { noremap = true, silent = true })
end

return M

