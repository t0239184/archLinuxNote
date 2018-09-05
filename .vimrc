" Maintainer: 
"       YuanAn Chen - Alan Chen
" Version: 
"       0.5 - 2017/04/04  
" Sections:
"    -> XXXXX
"
"source ${HOME}/.vim/modules/vim-plug.vim
"source ${HOME}/.vim/modules/plugin_config.vim
"source ${HOME}/.vim/modules/hotkey_config.vim

"
"   Syntax
"
"colorscheme papercolor
syntax on                   " Enable syntax
syntax sync maxlines=5      " Max line syntax number
syntax sync minlines=5      " Min line syntax number
set synmaxcol=200           " Mini column syntax number
"set cursorline             "當前列位置標示
"set cursorcolumn           "當前欄位置標示

"
"   General
"
set list
set title
set ruler                   " Enable cursor now lineNumber
set number                  " Enable Line number
set splitright              " Split open in right
set splitbelow              " Split open in bottom
set nocompatible            " Disable Vi mode
set noerrorbells            " Disable Vim err bells
set showcmd                 " Enable Commandline tip 
set showmode                " Show 'INSERT' in CommandLine 
set cmdheight=2             " Set CommandLine height=2
set linespace=0             " 行距設定為零
set backspace=2             " Enable use Backspace
set laststatus=2            " Vim statusLine Enable=2 Disable=1
set mouse=a                 " Mouse Control Option a=all n=nomal v=visul i=insert c=cmdl
set lcs=tab:>-,trail:-
set gcr=a:block-blinkon0    " Stop blink cursor
set iskeyword+=_,$,@,%,#,-  " 帶有下列符號的單字不要換行分割
set virtualedit=onemore     " Cursor可以移動當行最後一個字之後
set scrolloff=10            " Cursor到達視窗最底保留行數

"
"   StatusLine
"
set statusline=
set statusline+=\ [%n]
set statusline+=\ [%{''.(&fenc!=''?&fenc:&enc).''}]
set statusline+=\ [%{&ff}]
set statusline+=\ %F
set statusline+=\ %03c\ %l/%L\ %03p%%
set statusline+=\ %m%r%w\ %P


"
"
"
set undofile                " Enable undo 回滾文件記錄
set history=200             " Max Vim history
set undolevels=1000         " Max的改變回滾
set undoreload=10000        " Max重載可回滾行數
set fileencoding=utf-8      " File encoding
set fencs=utf-8
set tenc=utf-8
set fenc=utf-8
set enc=utf-8
set noautowrite             " Disable Auto save
set nobackup                " No Backup file
set confirm                 " Enable confirm in quit
set ww=h,l,b,s,<,>,[,]      " 游標可以左右移到前後行
                            " b  :   Backspace
                            " s  :   Space
                            " hl :   Left,Right
                            " <> :   n/v mode Left,Right
                            " [] :   i/r mode Left,Right

filetype indent on          " Enable Indent
set wrap                    " Auto wrap
set cindent                 " Use C/C++ Indent Style
set fdc=4
set tabstop=4               " Tab space stop
set smarttab                " Smart tab
set expandtab
set autoindent              " Auto Indent
set smartindent             " Smart Indent
set shiftwidth=4
set softtabstop=4           " Backspace can delete indent
set formatoptions=tcrqn     " Auto format
set fdm=indent
set foldmethod=marker       " Set foldmethod
set foldlevel=0             " Set fold close in start
set foldcolumn=0            " Set fold statusline width
set showmatch               " Show 相對應的括號
set wildmenu                " Vim commandline auto complete
set incsearch               " Search 時立刻顯示結果
set hlsearch                " Highlight search result
highlight Search cterm=none ctermbg=Yellow ctermfg=black
filetype on                 " Auto filetype
filetype plugin on          " Auto download filetype need plugin
"讀取上次最後編輯的位置
"autocmd! BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
autocmd! BufWritePost .vimrc source %       " Auto reload .vimrc

