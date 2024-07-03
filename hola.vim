" Define highlight groups for active and inactive windows
highlight InactiveWindow guibg=#3c3c3c

" Set window highlight options, 
autocmd WinEnter * setlocal winhighlight=Normal:None
autocmd WinLeave * setlocal winhighlight=Normal:InactiveWindow

set runtimepath+=~/.config/nvim/lua
lua require('flask_curl')
nnoremap <leader>fc :lua require('flask_curl').detect_flask_route()<CR>
" ~/.config/nvim/init.vim
"let &t_ut=""
" Basic Configuration
" Esto modifica el color de la barra de signos
" highlight SignColumn ctermbg=52 guibg=#8b0000
" Autocmd's
autocmd FileType markdown let g:indentLine_enabled=0
"autocmd FileType sh setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2 signcolumn=no
"autocmd FileType sh colorscheme ron
"autocmd FileType sh let g:airline_theme='badwolf'
" Change font family sh files
"autocmd FileType sh set guifont=FuraCode\ Nerd\ Font:h14
set signcolumn=no
set shell=sh
let mapleader=" "
set clipboard=unnamedplus
set sw=2
set number
set mouse=a
set cursorline
syntax enable
set noshowcmd
set encoding=UTF-8
set showmatch
set relativenumber
set noshowmode
" Plugins file linked
so ~/.config/nvim/plugins.vim

" Lua Settings file linked
so ~/.config/nvim/lua/settings.vim

" Personal Keymaps file linked
so ~/.config/nvim/keymaps.vim

"Set minimalist theme for Airline
"let g:airline_theme='jellybeans'
"let g:airline_theme='badwolf'
"let g:airline_theme='bubblegum'
"let g:airline_theme='luna'
"let g:airline_theme='molokai'
"let g:airline_theme='papercolor'
"let g:airline_theme='solarized'
"let g:airline_theme='tomorrow'
"let g:airline_theme='gruvbox'
"let g:airline_theme='tomorrow'
let g:airline_theme='wombat'
"Set powerline fonts
let g:airline_powerline_fonts = 1
"Blade Conf
" Define some single Blade directives. This variable is used for highlighting only.

let g:signs = {}

let g:blade_custom_directives = ['datetime', 'javascript']

" Define pairs of Blade directives. This variable is used for highlighting and indentation.
let g:blade_custom_directives_pairs = {
      \   'markdown': 'endmarkdown',
      \   'cache': 'endcache',
      \ }

"Copilot.vim next suggestion

" Autofiletype



"NerdTree Conf
"let NERDTreeMinimalUI=1

"autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
"let g:NERDTreeWinPos = "right"
"let NERDTreeShowHidden=1
"nnoremap <silent> <F2> :NvimTreeToggle<CR>
""GitStatus Conf Dependency of NerdTree
"let g:NERDTreeGitStatusUntrackedFilesMode = 'all' " a heavy feature too. default: normal
"let NERDTreeQuitOnOpen=1
"let g:NERDTreeGitStatusIndicatorMapCustom = {
"                \ 'Modified'  :'✹',
"                \ 'Staged'    :'✚',
"                \ 'Untracked' :'✭',
"                \ 'Renamed'   :'➜',
"                \ 'Unmerged'  :'═',
"                \ 'Deleted'   :'✖',
"                \ 'Dirty'     :'✗',
"                \ 'Ignored'   :'☒',
"                \ 'Clean'     :'✔︎',
"                \ 'Unknown'   :'?',
"                \ }
"let NERDTreeShowHidden=1

"Airline Conf
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_x = '%{MyClock()}'


"NvimTree Conf

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

"Theme Conf
"set t_Co=256
"set termguicolors

" Colorscheme dracula
"colorscheme dracula
"colorscheme gruvbox
" Todo lo de abajo me funcionó con Kitty Terminal
augroup user_colors
  autocmd!
  autocmd ColorScheme * highlight Normal guibg=none 
  autocmd ColorScheme * highlight SignColumn guibg=none 
  autocmd Colorscheme * highlight StatusLine guibg=none
augroup END

colorscheme catppuccin
let g:gruvbox_material_background = 'hard'
set termguicolors

" Todo lo de arriba me funcionó con Kitty Terminal


"Closetag Conf
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
"let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'

so ~/.config/nvim/cocconfig.vim

" Functions
"

function! MyUsername()
  return $USER
endfunction

function! MyClock()
  " Formatea la fecha y hora
  let l:date_time = strftime("%a %d %b %Y %H:%M") 
  " Retorna el nombre de usuario seguido de la fecha y hora formateada
  return MyUsername() . ' hoy es ' . l:date_time
endfunction

" Set spelllang to spanish only in markdown files, and enable spell checking
autocmd FileType markdown setlocal spell spelllang=es
