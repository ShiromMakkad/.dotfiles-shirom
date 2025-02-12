" Install vim plug if not installed
if !has("ide")
    let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
    if empty(glob(data_dir . '/autoload/plug.vim'))
        silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
    " Run PlugInstall if there are missing plugins
    autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
                \| PlugInstall --sync | source $MYVIMRC
                \| endif
endif

let g:polyglot_disabled = ['autoindent', 'sensible']
call plug#begin()
" Essentials
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-sleuth'
" Very Useful
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'easymotion/vim-easymotion'
" Useful
Plug 'preservim/nerdtree'
Plug 'machakann/vim-highlightedyank'
" Aesthetic
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive' " Using it for git information on the statusline
" IDE
Plug 'sheerun/vim-polyglot'
call plug#end()

" Set leader to space
nnoremap <SPACE> <Nop>
let mapleader=" "

" Sync clipboard with system
set clipboard=unnamedplus 

" Turn on line numbers
set relativenumber number 

" Always show 7 lines above and below
set so=7

" Mouse support
set mouse=a

" Turn off 'o' and enter inserting a comment
autocmd FileType * setlocal formatoptions-=ro

" Center search results
nmap n nzz
nmap N Nzz

" Give more space for displaying messages.
set cmdheight=2

" Jump to the previous function
noremap 88 [{
" Jump to the next function
noremap 99 ]}

" Buffer keymaps
nnoremap <Leader>b :bnext<CR>
nnoremap <Leader>B :bprevious<CR>

" Make p no longer overwrite copy
xmap p <Plug>ReplaceWithRegisterVisual

" vim-polyglot
let g:cpp_simple_highlight = 1
let g:cpp_member_highlight = 1

" Easymotion bindings
map <Leader>s <Plug>(easymotion-s)

map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

map <Leader>w <Plug>(easymotion-bd-w)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion"
let g:EasyMotion_smartcase = 1

" Aesthetic config

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
" Speeds up relative line numbers set re=1
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if !has("ide")
    colorscheme base16-tomorrow-night-eighties

    " Make vim look right in tmux
    set background=dark

    " Airline config
    let g:airline#extensions#tabline#enabled = 1 " Turns on the tabline up top
    let g:airline_theme='base16_tomorrow_night_eighties'
    " Adds the angled seperators
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = '' 

    " Airline tabline config
    let g:airline#extensions#tabline#show_tab_type = 0 " Doesn't show tab type because it's always the same
    let g:airline#extensions#tabline#show_close_button = 0 " Removes close button because it's obvious that you can close a file 
    let g:airline#extensions#tabline#left_sep = '' " For some reason, you have to specify the tabline left seperator specifically, everything else works in the general case
    let g:airline#extensions#tabline#left_alt_sep = ''

    " Disables the whitespace error counter (didn't really know what it did)
    let g:airline#extensions#whitespace#enabled = 0

    " Removes the part of the bar that tells you that you whether you're in a utf-8 or Ascii doc (etc.). 
    let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

endif
