execute pathogen#infect()

filetype plugin indent on
syntax on
set encoding=utf-8
set clipboard=unnamedplus 
set tabstop=4
set shiftwidth=4
set expandtab
nnoremap <F2> :NERDTreeToggle<CR>

" Highlight search resuls
set hlsearch

" Iterate through search results
set incsearch

" Always show 7 lines above and below
set so=7

" Center search results
nmap n nzz
nmap N Nzz

" Automatically indent code when going to the next line
set autoindent

" jump to the previous function
noremap 99 [{
" jump to the next function
noremap 00 ]}

" Mouse support
set mouse=a

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

" Set relative line numbers
set number relativenumber 

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

" Removes the part of the bar that tells you that you whether you're in a utf-8 or Ascii doc (etc.). I've never needed that information
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
