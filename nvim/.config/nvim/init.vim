set nocompatible              " be iMproved, required
filetype off                  " required

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
"

let mapleader=" "

if exists('g:vscode')
    call plug#begin('~/.local/share/nvim/plugged')
    
    " common start
    Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
    Plug 'easymotion/vim-easymotion'
    Plug 'tpope/vim-surround'
    Plug 'justinmk/vim-sneak'
    " common end 
    
    call plug#end()
    
else
    call plug#begin('~/.local/share/nvim/plugged')
    
    " common start
    Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
    Plug 'easymotion/vim-easymotion'
    Plug 'tpope/vim-surround'
    Plug 'justinmk/vim-sneak'
    " common end 
    
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'preservim/nerdtree'
    
    Plug 'derekwyatt/vim-scala'
    
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

    set tabstop=4 shiftwidth=4 expandtab

    if has("unix")
        let s:uname = system("uname -s")
        if s:uname == "Darwin\n"
            " Do Mac stuff here
            set clipboard+=unnamedplus
            set mouse=a
        endif
    endif
endif
