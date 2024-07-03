vim.g.mapleader = ' '

-- CONFIGURATION KEYMAPS
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-w>', ':q<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-p>', ':bnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-o>', ':bprevious<CR>', { noremap = true })

-- Copilot.vim Conf
vim.api.nvim_set_keymap('i', '<C-k>', '<Plug>(copilot-next)', {})
vim.api.nvim_set_keymap('i', '<C-j>', '<Plug>(copilot-previous)', {})

-- Telescope live grep
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = true })

-- CurlVim
vim.api.nvim_set_keymap('n', '<leader>fc', '<cmd>lua require("config.curlvim").detect_route()<cr>', { noremap = true, silent = true })

-- Toggle NvimTree
vim.api.nvim_set_keymap('n', '<F2>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F3>', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })

-- Prettier Conf
vim.api.nvim_create_user_command('Prettier', 'CocCommand prettier.forceFormatDocument', {})
vim.api.nvim_set_keymap('n', '<leader>pr', ':Prettier<CR>', { noremap = true, silent = true })

-- Telescope Conf
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })

-- Commentary Conf
vim.api.nvim_set_keymap('n', '<leader>/', ':Commentary<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>/', ':Commentary<CR>', { noremap = true, silent = true })

-- Emmet Conf
vim.g.user_emmet_mode = 'n'
vim.g.user_emmet_leader_key = ','
vim.g.user_emmet_settings = {
  javascript = {
    extends = 'jsx'
  }
}

-- Colorizer Conf
vim.api.nvim_set_keymap('n', '<leader>hc', ':ColorizerToggle<CR>', { noremap = true, silent = true })

-- CopilotChat Conf
vim.api.nvim_set_keymap('n', '<leader>pc', ':CopilotChatToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>pe', ':CopilotChatExplain<CR>', { noremap = true, silent = true })

-- Window split and navigation Conf
-- Split window vertically
vim.api.nvim_set_keymap('n', '<C-v>', ':vsplit<CR>', { noremap = true, silent = true })
-- Split window horizontally
vim.api.nvim_set_keymap('n', '<C-s>', ':split<CR>', { noremap = true, silent = true })
-- Move to the left Window
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
-- Move to the right Window
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
-- Move to the upper Window
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
-- Move to the lower Window
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
-- Resize Window
vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize +5<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Left>', ':vertical resize -5<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Up>', ':resize +5<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Down>', ':resize -5<CR>', { noremap = true, silent = true })
-- Close Window
vim.api.nvim_set_keymap('n', '<C-q>', ':close<CR>', { noremap = true, silent = true })
