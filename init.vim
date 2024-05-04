call plug#begin('~/.config/nvim/plugged')
Plug 'https://github.com/kien/rainbow_parentheses.vim'
Plug 'vimlab/split-term.vim'
Plug 'SirVer/ultisnips'
Plug 'https://github.com/tpope/vim-surround'
Plug 'honza/vim-snippets'
" debugger
Plug 'https://github.com/mfussenegger/nvim-dap'
Plug 'https://github.com/rcarriga/nvim-dap-ui'
Plug 'oliverdding/nvim-dap-rust'
Plug 'https://github.com/mfussenegger/nvim-jdtls'
" file navigation and commenting 
Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'preservim/tagbar'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" start screen
Plug 'mhinz/vim-startify'
" autocomplete/ integrated with TabNine
Plug 'tabnine/YouCompleteMe', { 'do': './install.py' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" toml syntax highlighting
Plug 'cespare/vim-toml', { 'branch': 'main' }
" themes and cosmetic
Plug 'vim-airline/vim-airline'
Plug 'https://github.com/morhetz/gruvbox'
Plug 'https://github.com/folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'dracula/vim'
Plug 'https://github.com/sainnhe/everforest'
" languages
Plug 'lervag/vimtex'
"Plug 'ryanoasis/vim-devicons'
call plug#end()
colorscheme gruvbox
"colorscheme dracula
"colorscheme everforest
let g:gruvbox_contrast_dark = 'hard'
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
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

set t_Co=256
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
" set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=80                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set autochdir

set shell=fish
"noremap ; l
"noremap l j
"noremap j h
"noremap h ;

" Startify
map <M-l> :Startify<Enter>

let g:startify_bookmarks = [{'v': '~/.config/nvim/init.vim'}]

" tagbar
nmap <M-C> :TagbarToggle<CR>

"telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

 "ycm
    "nnoremap gd :YcmCompleter GoToDefinition<cr>
    "nnoremap sk :YcmRestartServer<cr>
    "nnoremap <F1> :YcmCompleter FixIt<cr>
    "nnoremap K :YcmCompleter GetDoc<cr>
    "nnoremap ; :YcmCompleter GetType<cr>

"coc prettier
map <M-f> <Plug>(coc-format-selected) 

" coc shits
let g:coc_global_extensions = [
    \'coc-json',
    \'coc-pairs',
    \'coc-prettier',
    \'coc-tabnine',
    \'coc-rust-analyzer',
    \'coc-snippets',
    \'coc-tsserver',
    \'coc-jedi',
    \'coc-java',
    \'coc-java-debug',
    \'coc-clangd',
\]

" coc-java-debug
nmap <F1> :CocCommand java.debug.vimspector.start<CR>
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> chitc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

 "Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

 "Remap for rename current word
nmap <F2> <Plug>(coc-rename)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Rainbow parentheses
"let g:rbpt_colorpairs = [
    "\ ['brown',       'RoyalBlue3'],
    "\ ['Darkblue',    'SeaGreen3'],
    "\ ['darkgray',    'DarkOrchid3'],
    "\ ['darkgreen',   'firebrick3'],
    "\ ['darkcyan',    'RoyalBlue3'],
    "\ ['darkred',     'SeaGreen3'],
    "\ ['darkmagenta', 'DarkOrchid3'],
    "\ ['brown',       'firebrick3'],
    "\ ['gray',        'RoyalBlue3'],
    "\ ['black',       'SeaGreen3'],
    "\ ['darkmagenta', 'DarkOrchid3'],
    "\ ['Darkblue',    'firebrick3'],
    "\ ['darkgreen',   'RoyalBlue3'],
    "\ ['darkcyan',    'SeaGreen3'],
    "\ ['darkred',     'DarkOrchid3'],
    "\ ['red',         'firebrick3'],
    "\ ]

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" NerdTree
"let NERDTreeChDirMode=2
noremap <C-n> :NERDTreeToggle<CR>

"Terminal
noremap <C-h> :VTerm<Enter>

"Commenting
"map <C-_> <Leader>c<space>
map <C-/> <Leader>c<space>

