-- ~/.config/nvim/lua/plugins/notify.lua
require("notify").setup({
    stages = "slide",
    timeout = 5000,
    background_colour = "#000000",
    icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
    },
    position = {
      row = 10,
      col = "50%",
    },
})
