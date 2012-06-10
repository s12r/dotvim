
" plugin pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


" common settings
syntax on
set hlsearch
set tabstop=4
set autoindent
set showcmd
set incsearch
set ignorecase
set ruler
set number
set scrolloff=5
let maplocalleader=","
set listchars=tab:▸\ ,eol:¬

" @todo for .php, .css, .js, .html
set nowrap


" enable plugins
filetype plugin on
filetype indent on


" autocomplete funcs and identifiers for languages
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete


"
" plugin specific stuff
"

" ###### Markdown ######
"
nmap <leader>md :%!Markdown.pl --html4tags <cr>


" ###### netrw ######
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

