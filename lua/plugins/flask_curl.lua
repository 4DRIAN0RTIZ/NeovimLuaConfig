local M = {}

-- Detect Flask route and extract method, headers, and body if any
function M.detect_flask_route()
    local line = vim.api.nvim_get_current_line()
    vim.api.nvim_out_write("Current line: " .. line .. "\n")

    -- Simplified regex to capture blueprint, route, and methods
    local blueprint, route, methods = line:match("@([%w_]+)_bp%.route%(%'([^']+)%', methods=%[(%b'')%]%)")

    if not blueprint or not route or not methods then
        vim.api.nvim_err_writeln("No se detectó ninguna ruta, blueprint o método")
        return
    end

    vim.api.nvim_out_write("Blueprint: " .. blueprint .. "\n")
    vim.api.nvim_out_write("Route: " .. route .. "\n")
    vim.api.nvim_out_write("Methods: " .. methods .. "\n")

    local headers, body = M.detect_headers_and_body()

    -- Make the curl request based on detected method
    if methods:find("GET") then
        M.make_get_request(blueprint, route, headers)
    elseif methods:find("POST") then
        M.make_post_request(blueprint, route, headers, body)
    elseif methods:find("PUT") then
        M.make_put_request(blueprint, route, headers, body)
    elseif methods:find("DELETE") then
        M.make_delete_request(blueprint, route, headers)
    else
        vim.api.nvim_err_writeln("Método HTTP no soportado")
    end
end

-- Detect headers and body
function M.detect_headers_and_body()
    local headers = ""
    local body = ""

    -- Check for headers and body (simplified for demonstration)
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

-- Make GET request
function M.make_get_request(blueprint, route, headers)
    local full_route = "/" .. blueprint .. route
    local curl_cmd = "curl -s -L -X GET http://localhost:2089" .. full_route

    if headers and headers ~= "" then
        curl_cmd = curl_cmd .. " -H '" .. headers .. "'"
    end

    M.execute_curl_request(curl_cmd, full_route)
end

-- Make POST request
function M.make_post_request(blueprint, route, headers, body)
    if not body or body == "" then
        body = M.prompt_for_body()
    end

    local full_route = "/" .. blueprint .. route
    local curl_cmd = "curl -s -L -X POST http://localhost:2089" .. full_route

    if headers and headers ~= "" then
        curl_cmd = curl_cmd .. " -H '" .. headers .. "'"
    end

    curl_cmd = curl_cmd .. " -d '" .. body .. "'"

    M.execute_curl_request(curl_cmd, full_route)
end

-- Make PUT request
function M.make_put_request(blueprint, route, headers, body)
    if not body or body == "" then
        body = M.prompt_for_body()
    end

    local full_route = "/" .. blueprint .. route
    local curl_cmd = "curl -s -L -X PUT http://localhost:2089" .. full_route

    if headers and headers ~= "" then
        curl_cmd = curl_cmd .. " -H '" .. headers .. "'"
    end

    curl_cmd = curl_cmd .. " -d '" .. body .. "'"

    M.execute_curl_request(curl_cmd, full_route)
end

-- Make DELETE request
function M.make_delete_request(blueprint, route, headers)
    local full_route = "/" .. blueprint .. route
    local curl_cmd = "curl -s -L -X DELETE http://localhost:2089" .. full_route

    if headers and headers ~= "" then
        curl_cmd = curl_cmd .. " -H '" .. headers .. "'"
    end

    M.execute_curl_request(curl_cmd, full_route)
end

-- Prompt for body in a floating window
function M.prompt_for_body()
    vim.api.nvim_out_write("Please enter the body for POST/PUT request:\n")
    local body = vim.fn.input("Body: ")
    return body
end

-- Execute curl request and show result in floating window
function M.execute_curl_request(curl_cmd, full_route)
    curl_cmd = curl_cmd .. " | jq '.'"  -- Pipe the output to jq for formatting

    local handle = io.popen(curl_cmd)
    local result = handle:read("*a")
    handle:close()

    M.show_result_in_floating_window(result, full_route)
end

-- Show result in a floating window
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
