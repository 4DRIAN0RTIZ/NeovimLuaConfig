-- ~/.config/nvim/lua/plugins/nvim_tree.lua
require("nvim-tree").setup({
    view = {
        width = 30,
        side = "right",
    },
    filters = {
        dotfiles = false,
        custom = {
          "node_modules",
          "^\\.git",
        },
    },
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
})
