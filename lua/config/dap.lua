-- ~/.config/nvim/lua/config/dap.lua
local dap = require('dap')
local dapui = require('dapui')

-- Configuración para la interfaz de usuario
dapui.setup()

-- Configuración del adaptador para PHP
dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = { '/home/neandertech/vscode-php-debug/out/phpDebug.js' },
}

dap.configurations.php = {
    {
        type = 'php',
        request = 'launch',
        name = 'Run and Listen for Xdebug',
        port = 9003,
        log = true,
    }
}
-- Abrir/cerrar la interfaz de usuario automáticamente
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
