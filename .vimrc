"Vimscript -------by teaching{{{
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2014 Nov 05
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif
" }}}

"Basic settings 	----{{{
set nu
set cul
"set cuc
set relativenumber
set shiftround
set shiftwidth=8
"statusline
set ruler
set laststatus=2
set statusline=[%l		"currentline
set statusline+=/		"separator
set statusline+=%L]		"totalline
set statusline+=%=		"switch to the right side
set statusline+=%.20F		"path
set statusline+=\ -\ 		"separator
set statusline+=FileType 	"label
set statusline+=%y		"filetype
"set statusline+=%04l		"at least 4 characters width
set hlsearch
set incsearch


"}}}

"Mappings 		-----{{{
let mapleader = "\<Space>"
let maplocalleader = ","
nnoremap <leader>y 0v$yo<esc>			" copy current line and move down	
nnoremap <leader>d ddO				" delete current line and i
nnoremap <leader>w viw				" choose a word
nnoremap <leader>\ :vs<CR><c-w>w		" split window
nnoremap <c-u> vU				" uppercase
nnoremap <leader>w <c-w>w			" change window 
inoremap <c-d> <esc>ddi				" change current line	
inoremap <c-u> <esc>vwUi			" upper current word
inoremap <c-l> <esc>vwui			" lower current word
nnoremap <leader>ev :vsplit $MYVIMRC<cr>	" edit vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>	" so vimrc
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel	
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
nnoremap <leader>( viw<esc>a(<esc>bi)<esc>lel
nnoremap <leader>{ viw<esc>a{<esc>bi}<esc>lel
nnoremap <leader>[ viw<esc>a[<esc>bi]<esc>lel
vnoremap <leader>' <esc>a'<esc>`<i'<esc>
vnoremap <leader>( <esc>a(<esc>`<i)<esc>
vnoremap <leader>{ <esc>a{<esc>`<i}<esc>
vnoremap <leader>[ <esc>a[<esc>`<i]<esc>
vnoremap <leader>" <esc>a"<esc>`<i"<esc>
"}}}

"Filetype special settings 	---{{{
"add comment		
autocmd FileType javascript nnoremap<buffer> <localleader>c I//<esc>
autocmd FileType python nnoremap<buffer> <localleader>c I#<esc>
autocmd FileType vim nnoremap<buffer> <localleader>c I"<esc>

"snippet
iabbrev @@ lalala121.163.com
iabbrev ssig --<cr>Steve Losh<cr>steve@stevelosh.com
autocmd FileType python iabbrev <buffer> iff if:<left>
autocmd FileType javascript iabbrev <buffer> iff if()<left>
autocmd FileType cpp iabbrev <buffer> incl #include<iostream><cr>using namespace std;<cr>int main(){}<left><cr><esc>kA<cr>return 0;<esc>kA<cr>

augroup filetype_html
    autocmd!
    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END


" }}}
 
"Vimscript settings -------{{{
augroup filetype_vim
	autocmd!
	autocmd Filetype vim setlocal foldmethod=marker
augroup END

set foldlevelstart=0 



" }}}

"Abbrev 		---{{{
abbrev waht what
abbrev tehn then 
"test
iabbrev { {}<esc>i<cr><esc>kA<cr><esc>>>i
" }}}





