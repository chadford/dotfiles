set nocompatible              " be iMproved, required
filetype off                  " required

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
"

let mapleader=" "
inoremap jk <ESC>
set tabstop=2 shiftwidth=2 expandtab
set background=dark

autocmd BufRead,BufNewFile *.md setlocal spell

if has("unix")
   let s:uname = system("uname -s")
   if s:uname == "Darwin\n"
        " Do Mac stuff here
        set mouse=a
   endif
endif

if exists('g:vscode')
    call plug#begin('~/.local/share/nvim/plugged')
    
    " common start
    Plug 'tpope/vim-surround'
    Plug 'justinmk/vim-sneak'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'
    " common end 

    Plug 'asvetliakov/vim-easymotion'
    "Plug 'roy2220/easyjump.tmux'

    call plug#end()

    command Write Wall
    
else
    call plug#begin('~/.local/share/nvim/plugged')
    
    " common start
    Plug 'tpope/vim-surround'
    Plug 'justinmk/vim-sneak'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'
    " common end 
    
    " Use release branch (recommend)
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'preservim/nerdtree'
    
    Plug 'derekwyatt/vim-scala'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'hashivim/vim-terraform'

    Plug 'sbdchd/neoformat'

    " Configuration for vim-scala
    au BufRead,BufNewFile *.sbt set filetype=scala
    
    call plug#end()
    
    function! SetupCommandAbbrs(from, to)
      exec 'cnoreabbrev <expr> '.a:from
            \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
            \ .'? ("'.a:to.'") : ("'.a:from.'"))'
    endfunction
    
    " Use C to open coc config
    call SetupCommandAbbrs('C', 'CocConfig')
    
    " use <tab> for trigger completion and navigate to the next complete item
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction
    
    inoremap <silent><expr> <Tab>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<Tab>" :
          \ coc#refresh()

    set number

    "map ; :Files<CR>
    map <C-n> :NERDTreeToggle<CR>
    
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    command! -nargs=0 MetalsDoctor :call CocRequestAsync('metals', 'workspace/executeCommand', { 'command': 'doctor-run' })

    nnoremap <silent> <M-b> :call CocRequestAsync('metals', 'workspace/executeCommand', { 'command': 'build-import' })<CR> 
    nnoremap <silent> <M-y> :call CocRequestAsync('metals', 'workspace/executeCommand', { 'command': 'doctor-run' })><CR> 
    nnoremap <silent> <M-c> :call CocRequestAsync('metals', 'workspace/executeCommand', { 'command': 'build-connect' })<CR>

    let g:terraform_align=1
    let g:terraform_fmt_on_save=1
endif
