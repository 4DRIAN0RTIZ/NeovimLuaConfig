-- -- coc-prettier configuration
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = "CocCommand prettier.forceFormatDocument"
})

-- COC Configuration
vim.g.completion_enable_snippet = 'vim-vsnip'

-- Some servers have issues with backup files, see #649.
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.opt.signcolumn = "yes"

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice.
vim.api.nvim_set_keymap('i', '<CR>', [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], { noremap = true, silent = true, expr = true })

-- Function to check backspace
_G.CheckBackspace = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

-- Use <c-space> to trigger completion.
vim.api.nvim_set_keymap('i', '<c-space>', 'coc#refresh()', { noremap = true, silent = true, expr = true })

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
vim.api.nvim_set_keymap('n', '[g', '<Plug>(coc-diagnostic-prev)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', ']g', '<Plug>(coc-diagnostic-next)', { noremap = false, silent = true })

-- GoTo code navigation.
vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', { noremap = false, silent = true })

-- Use K to show documentation in preview window.
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua ShowDocumentation()<CR>', { noremap = true, silent = true })

function ShowDocumentation()
  if vim.fn.CocAction('hasProvider', 'hover') then
    vim.fn.CocActionAsync('doHover')
  else
    vim.api.nvim_feedkeys('K', 'in', false)
  end
end

-- Highlight the symbol and its references when holding the cursor.
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    vim.fn.CocActionAsync('highlight')
  end
})

-- Symbol renaming.
vim.api.nvim_set_keymap('n', '<leader>rn', '<Plug>(coc-rename)', { noremap = false, silent = true })

-- Formatting selected code.
vim.api.nvim_set_keymap('x', '<leader>f', '<Plug>(coc-format-selected)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>f', '<Plug>(coc-format-selected)', { noremap = false, silent = true })

-- Autocommands for COC
vim.api.nvim_create_augroup('mygroup', { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "typescript,json",
  command = "setl formatexpr=CocAction('formatSelected')",
  group = 'mygroup'
})
vim.api.nvim_create_autocmd("User", {
  pattern = "CocJumpPlaceholder",
  callback = function()
    vim.fn.CocActionAsync('showSignatureHelp')
  end,
  group = 'mygroup'
})

-- Applying codeAction to the selected region.
vim.api.nvim_set_keymap('x', '<leader>a', '<Plug>(coc-codeaction-selected)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>a', '<Plug>(coc-codeaction-selected)', { noremap = false, silent = true })

-- Remap keys for applying codeAction to the current buffer.
vim.api.nvim_set_keymap('n', '<leader>ac', '<Plug>(coc-codeaction)', { noremap = false, silent = true })

-- Apply AutoFix to problem on the current line.
vim.api.nvim_set_keymap('n', '<leader>qf', '<Plug>(coc-fix-current)', { noremap = false, silent = true })

-- Run the Code Lens action on the current line.
vim.api.nvim_set_keymap('n', '<leader>cl', '<Plug>(coc-codelens-action)', { noremap = false, silent = true })

-- Map function and class text objects
vim.api.nvim_set_keymap('x', 'if', '<Plug>(coc-funcobj-i)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('o', 'if', '<Plug>(coc-funcobj-i)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('x', 'af', '<Plug>(coc-funcobj-a)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('o', 'af', '<Plug>(coc-funcobj-a)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('x', 'ic', '<Plug>(coc-classobj-i)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('o', 'ic', '<Plug>(coc-classobj-i)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('x', 'ac', '<Plug>(coc-classobj-a)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('o', 'ac', '<Plug>(coc-classobj-a)', { noremap = false, silent = true })

-- Remap <C-f> and <C-b> for scroll float windows/popups.
if vim.fn.has('nvim-0.4.0') == 1 or vim.fn.has('patch-8.2.0750') == 1 then
  vim.api.nvim_set_keymap('n', '<C-f>', [[coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"]], { noremap = true, silent = true, expr = true })
  vim.api.nvim_set_keymap('n', '<C-b>', [[coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"]], { noremap = true, silent = true, expr = true })
  vim.api.nvim_set_keymap('i', '<C-f>', [[coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"]], { noremap = true, silent = true, expr = true })
  vim.api.nvim_set_keymap('i', '<C-b>', [[coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"]], { noremap = true, silent = true, expr = true })
  vim.api.nvim_set_keymap('v', '<C-f>', [[coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"]], { noremap = true, silent = true, expr = true })
  vim.api.nvim_set_keymap('v', '<C-b>', [[coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"]], { noremap = true, silent = true, expr = true })
end

-- Add `:Format` command to format current buffer.
vim.api.nvim_create_user_command('Format', "call CocActionAsync('format')", {})

-- Add `:Fold` command to fold current buffer.
vim.api.nvim_create_user_command('Fold', "call CocAction('fold', <f-args>)", { nargs = '?' })

-- Add `:OR` command for organize imports of the current buffer.
vim.api.nvim_create_user_command('OR', "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support.
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline.
vim.opt.statusline = "%{coc#status()}%{get(b:,'coc_current_function','')}"

-- Mappings for CoCList
-- Show all diagnostics.
vim.api.nvim_set_keymap('n', '<space>a', ':<C-u>CocList diagnostics<cr>', { noremap = true, silent = true, nowait = true })
-- Manage extensions.
vim.api.nvim_set_keymap('n', '<space>e', ':<C-u>CocList extensions<cr>', { noremap = true, silent = true, nowait = true })
-- Show commands.
vim.api.nvim_set_keymap('n', '<space>c', ':<C-u>CocList commands<cr>', { noremap = true, silent = true, nowait = true })
-- Find symbol of current document.
vim.api.nvim_set_keymap('n', '<space>o', ':<C-u>CocList outline<cr>', { noremap = true, silent = true, nowait = true })
-- Search workspace symbols.
vim.api.nvim_set_keymap('n', '<space>s', ':<C-u>CocList -I symbols<cr>', { noremap = true, silent = true, nowait = true })
-- Do default action for next item.
vim.api.nvim_set_keymap('n', '<space>j', ':<C-u>CocNext<CR>', { noremap = true, silent = true, nowait = true })
-- Do default action for previous item.
vim.api.nvim_set_keymap('n', '<space>k', ':<C-u>CocPrev<CR>', { noremap = true, silent = true, nowait = true })
-- Resume latest coc list.
vim.api.nvim_set_keymap('n', '<space>p', ':<C-u>CocListResume<CR>', { noremap = true, silent = true, nowait = true })
