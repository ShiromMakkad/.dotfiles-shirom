execute pathogen#infect()

filetype plugin indent on
syntax on
set encoding=utf-8
set clipboard=unnamedplus 
nnoremap <F2> :NERDTreeToggle<CR>

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
" Speeds up relative line numbers set re=1
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

colorscheme onedark


set number relativenumber 

" Speeds up relative line numbers
set re=1 

" Lightline config
set laststatus=2 " Necessary for display
set showtabline=2 " Turns on bar at the top

" Config files come from https://github.com/skbolton/titan/blob/master/states/nvim/nvim/status-line.vim
" See https://www.reddit.com/r/vimporn/comments/bxjd4p/cant_q_tinkering/
function! FileNameWithIcon() abort
  return winwidth(0) > 70  ? " " . WebDevIconsGetFileTypeSymbol() . ' ' . expand('%:t') : '' 
endfunction

function! FileNameWithParent(f) abort
  if expand('%:t') ==# ''
    return expand('%:p:h:t') . ' ' . WebDevIconsGetFileTypeSymbol()
  else
    return expand('%:p:h:t') . "/" . expand("%:t") . ' ' . WebDevIconsGetFileTypeSymbol()
  endif
endfunction

function! Line_num() abort
  return string(line('.'))
endfunction

function! Active_tab_num(n) abort
    return a:n . " "
endfunction

function! Inactive_tab_num(n) abort
  return a:n . " "
endfunction

function! Line_percent() abort
  return string((100*line('.'))/line('$'))
endfunction

function! Col_num() abort
    return string(getcurpos()[2])
endfunction

function! Git_branch() abort
  if fugitive#head() !=# ''
    return " " . fugitive#head()
  else
    return "\uf468"
  endif
endfunction

let g:lightline = {}
let g:lightline.colorscheme = 'onedark'
let g:lightline.active = { 
      \ 'left': [ ['mode', 'readonly'], ['filename_with_icon', 'modified'] ],
      \ 'right': [ ['lineinfo'] ]
      \ }
let g:lightline.separator = { 'left': "\ue0b0", 'right': "\ue0b2"  }
let g:lightline.subseparator = { 'left': "\ue0b1", 'right': "\ue0b2"}
let g:lightline#gitdiff#indicator_added = "\uf916"
let g:lightline#gitdiff#indicator_deleted = "\uf658 "
let g:lightline#gitdiff#indicator_modified = "\uf875 "

let g:lightline.tabline = {
            \ 'left': [ [ 'vim_logo'], [ 'tabs' ] ],
            \ 'right': [ [ 'git_branch' ], [ 'gitdiff' ]]
            \ }
let g:lightline.tab = {
        \ 'active': ['artify_activetabnum', 'filename_with_parent'],
        \ 'inactive': ['artify_inactivetabnum', 'filename']
        \ }

let g:lightline.tab_component = {}
let g:lightline.tab_component_function = {
            \ 'artify_activetabnum': 'Active_tab_num',
            \ 'artify_inactivetabnum': 'Inactive_tab_num',
            \ 'artify_filename': 'lightline_tab_filename',
            \ 'filename': 'lightline#tab#filename',
            \ 'modified': 'lightline#tab#modified',
            \ 'readonly': 'lightline#tab#readonly',
            \ 'tabnum': 'lightline#tab#tabnum',
            \ 'filename_with_parent': 'FileNameWithParent'
            \ }

let g:lightline.component = {
        \ 'filename_with_icon': '%{FileNameWithIcon()}',
        \ 'vim_logo': "\ue7c5 ",
        \ 'git_branch': '%{Git_branch()}',
        \ 'filename_with_parent': '%t',
        \ }

let g:lightline.component_expand = { 'gitdiff': 'lightline#gitdiff#get' }

let g:lightline.component_function = {
        \ }
