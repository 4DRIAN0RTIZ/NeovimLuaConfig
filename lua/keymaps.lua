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

-- Diffview Conf
-- Open Diffview
vim.api.nvim_set_keymap('n', ';df', ':DiffviewOpen<CR>', { noremap = true, silent = true })
-- Toggle Diffview
vim.api.nvim_set_keymap('n', ';dt', ':DiffviewToggleFiles<CR>', { noremap = true, silent = true })
-- Refresh Diffview
vim.api.nvim_set_keymap('n', ';dr', ':DiffviewRefresh<CR>', { noremap = true, silent = true })

-- CopilotChat Conf
vim.api.nvim_set_keymap('n', ';ct', ':CopilotChatToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', ';ce', ':CopilotChatExplain<CR>', { noremap = true, silent = true })

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


-- NEOVIM DAP

-- Mapeos de teclas para controlar la depuración
vim.api.nvim_set_keymap('n', '<F5>', ':lua require"dap".continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F10>', ':lua require"dap".step_over()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F11>', ':lua require"dap".step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F12>', ':lua require"dap".step_out()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>b', ':lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dr', ':lua require"dap".repl.open()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dl', ':lua require"dap".run_last()<CR>', { noremap = true, silent = true })

-- Remove ^M from files
vim.api.nvim_set_keymap('n', '<leader>rm', ':silent %s/\\r//g<CR>', { noremap = true, silent = true })

-- Move lines up and down with Alt + j/k
vim.api.nvim_set_keymap('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-j>', ':m \'>+1<CR>gv=gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-k>', ':m \'<-2<CR>gv=gv', { noremap = true, silent = true })

-- Map to replace <?php echo with <?= in PHP files
vim.api.nvim_set_keymap('n', ';cph', ':%s/<?php echo/<?=/g<CR>', { noremap = true, silent = true })

-- Keymaps para gestionar notas de tickets
vim.api.nvim_set_keymap('n', ';tn', ':lua require("config.ticket_notes").new_note()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ';tl', ':lua require("config.ticket_notes").list_notes()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ';te', ':lua require("config.ticket_notes").edit_note("<ID_DEL_TICKET>")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ';td', ':lua require("config.ticket_notes").delete_note("<ID_DEL_TICKET>")<CR>', { noremap = true, silent = true })
