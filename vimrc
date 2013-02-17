" basics
set nocompatible


" ============================================================================
" pathogen
" ============================================================================
filetype off
let g:pathogen_disabled = ['supertab', 'vimwiki']
call pathogen#infect()
call pathogen#helptags()
filetype indent plugin on



" ============================================================================
" common settings
" ============================================================================
" localleader
nnoremap <SPACE> <Nop>
let mapleader=" "

" editing
syntax on
set tabstop=4
set autoindent
"set list
set listchars=tab:▸\ ,eol:¬

" editor
set ruler
set number
set cursorline
set visualbell
set scrolloff=5
set laststatus=2
set statusline=%t\ [%c,%l\/%L]%=%{&fileencoding}\ %{&ff}\ %y\ 
set showcmd

" search
set hlsearch
set incsearch
set ignorecase
set smartcase

" vimrc handling
nmap <Leader>ev :e $MYVIMRC<CR>
nmap <Leader>sv :so $MYVIMRC<CR>



" ============================================================================
" filetype specific settings
" ============================================================================
" autocomplete funcs and identifiers for languages
set nowrap " @todo for .php, .css, .js, .html
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete



" ============================================================================
" plugin specific stuff
" ============================================================================

" ###### supertab #######
"
"let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']


" ###### PIV & php related stuff ######
"
let g:DisableAutoPHPFolding = 1
autocmd FileType php setlocal noeol binary fileformats="mac,unix,dos"


" ###### tagbar #######
"
if has("mac")
	" use macports version of exuberant ctags
	let g:tagbar_ctags_bin = '/opt/local/bin/ctags'
endif


" ###### Markdown ######
"
nmap <leader>md :%!Markdown.pl --html4tags <cr>


" ###### netrw ######
" set tree as default liststyle
let g:netrw_liststyle = 3
" use previous window when opening new file via <cr>
" let g:netrw_browse_split = 4
" open new window to the right
" let g:netrw_altv = 1
" size of the opened window is 80% of the netrw's current
" let g:netrw_winsize = 80


" ###### gpg ######
" http://www.cipherdyne.org/blog/2008/02/interfacing-vim-with-gnupg-encrypted-files.html
"
" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff <wouter@blub.net>
augroup encrypted
au!
" First make sure nothing is written to ~/.viminfo while editing
" an encrypted file.
autocmd BufReadPre,FileReadPre *.gpg set viminfo=
" We don't want a swap file, as it writes unencrypted data to disk
autocmd BufReadPre,FileReadPre *.gpg set noswapfile
" Switch to binary mode to read the encrypted file
autocmd BufReadPre,FileReadPre *.gpg set bin
autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg2 --decrypt 2> /dev/null
" Switch to normal mode for editing
autocmd BufReadPost,FileReadPost *.gpg set nobin
autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")
" Convert all text to encrypted text before writing
autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg2 --default-recipient-self -ae 2>/dev/null
" Undo the encryption so we are back in the normal text, directly
" after the file has been written.
autocmd BufWritePost,FileWritePost *.gpg u 

