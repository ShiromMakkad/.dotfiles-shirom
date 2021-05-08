let g:polyglot_disabled = ['autoindent', 'sensible']
call plug#begin('~/.vim/plugged')
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
Plug 'edkolev/tmuxline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive' " Using it for git information on the statusline
" IDE
Plug 'neoclide/coc.nvim'
Plug 'sheerun/vim-polyglot'
call plug#end()

" Set leader to space
nnoremap <SPACE> <Nop>
let mapleader=" "

" Sync clipboard with system
set clipboard=unnamedplus 

" Turn on line numbers
set number 

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

" Sets NERDTree open button
nnoremap <F2> :NERDTreeToggle<CR>

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

" Navigate to next error https://github.com/vim-syntastic/syntastic/issues/32
function NavigateError(cmd)
    try
        exec a:cmd
    catch /:E553:/
        lfirst
    catch /:E42:/
        echo "Location list empty"
    catch /.*/
        echo v:exception
    endtry
endfunction

nmap <Leader>e <Plug>(coc-diagnostic-prev)
nmap <Leader>E <Plug>(coc-diagnostic-next)

" COC bindings
let g:coc_global_extensions = ['coc-json', 'coc-vimlsp']

" https://github.com/neoclide/coc.nvim/issues/856
if $NVM_BIN != ""
  let g:coc_node_path = '$NVM_BIN/node'
endif

let g:coc_disable_startup_warning = 1
set hidden
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
if has("patch-8.1.1564")
    set signcolumn=number
else
    set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <Leader>r <Plug>(coc-rename)

" GoTo code navigation.
nmap <silent> <Leader>gd <Plug>(coc-definition)
nmap <silent> <Leader>gy <Plug>(coc-type-definition)
nmap <silent> <Leader>gi <Plug>(coc-implementation)
nmap <silent> <Leader>gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> <Leader>d :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Formatting selected code.
xmap <Leader>f  <Plug>(coc-format-selected)
nmap <Leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" End coc.vim config
     
" Aesthetic config
 
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
" Speeds up relative line numbers set re=1
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  " The two lets are for tmux truecolor
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

colorscheme base16-monokai 

" Make vim look right in tmux
set background=dark

" Airline config
let g:airline#extensions#tabline#enabled = 1 " Turns on the tabline up top
let g:airline_theme='base16_monokai'
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


" Tmuxline config
let g:tmuxline_preset = {
      \'a'    : '\uf31b #H',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'x' : ["\uf9c4 RAM:#(free -m -h | grep Mem | awk '{ print $4 }')", "\ue266 CPU:#(mpstat 2 1 | awk '$12 ~ /[0-9.]+/ { print 100 - $12 }')%", '\uf578 #(cat /sys/class/power_supply/battery/capacity)%'],
      \'y'    : '\uf64f %R',
      \'z'    : ['\uf133 %a #(date "+%m/%d/%y")'], 
      \'options' : {'status-justify' : 'left'}}
