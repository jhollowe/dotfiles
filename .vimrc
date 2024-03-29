syntax on               " enable syntax highlighting
set nobackup noswapfile " don't create pointless backup/swap files; Use VCS instead
set autoread            " watch for file changes
set number              " show line numbers
set showmode            " show INSERT, VISUAL, etc. mode
set showmatch           " show matching brackets
set smarttab            " better backspace and tab functionality
filetype on             " enable filetype detection
filetype indent on      " enable filetype-specific indenting
filetype plugin on      " enable filetype-specific plugins

" tabs and indenting
set autoindent          " auto indenting
set smartindent         " smart indenting
set expandtab           " spaces instead of tabs
set tabstop=2           " 2 spaces for tabs
set shiftwidth=2        " 2 spaces for indentation

" bells
set noerrorbells        " turn off audio bell
set visualbell          " but leave on a visual bell

" search
set hlsearch            " highlighted search results
set incsearch           " do incremental searching

" Mouse support (scroll, visual select)
set mouse=a

" Alternate way to get out of edit mode, very useful when your terminal captures ESC
imap jj <ESC>

" More natural split directions
set splitbelow
set splitright

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
