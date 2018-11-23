"      .-.     .-.     .-.     .-.     .-.     .-.     .-.
" `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'
"
" https://github.com/rafi/vim-config

if &compatible
	set nocompatible
endif

" Set main configuration directory, and where cache is stored.
let $VIMPATH = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let $VARPATH = expand(($XDG_CACHE_HOME ? $XDG_CACHE_HOME : '~/.cache').'/vim')

" Search and use environments specifically made for Neovim.
if isdirectory($VARPATH.'/venv/neovim2')
	let g:python_host_prog = $VARPATH.'/venv/neovim2/bin/python'
endif
if isdirectory($VARPATH.'/venv/neovim3')
	let g:python3_host_prog = $VARPATH.'/venv/neovim3/bin/python'
endif

function! s:source_file(path, ...) abort
	let use_global = get(a:000, 0, ! has('vim_starting'))
	let abspath = resolve(expand($VIMPATH.'/config/'.a:path))
	if ! use_global
		execute 'source' fnameescape(abspath)
		return
	endif

	let content = map(readfile(abspath),
		\ "substitute(v:val, '^\\W*\\zsset\\ze\\W', 'setglobal', '')")
	let tempfile = tempname()
	try
		call writefile(content, tempfile)
		execute printf('source %s', fnameescape(tempfile))
	finally
		if filereadable(tempfile)
			call delete(tempfile)
		endif
	endtry
endfunction

" Set augroup
augroup MyAutoCmd
	autocmd!
	autocmd CursorHold *? syntax sync minlines=300
augroup END

" Global Mappings "{{{
" Use spacebar as leader and ; as secondary-leader
" Required before loading plugins!
let g:mapleader="\<Space>"
let g:maplocalleader=';'

" Release keymappings prefixes, evict entirely for use of plug-ins.
nnoremap <Space>  <Nop>
xnoremap <Space>  <Nop>
nnoremap ,        <Nop>
xnoremap ,        <Nop>
nnoremap ;        <Nop>
xnoremap ;        <Nop>
nnoremap m        <Nop>
xnoremap m        <Nop>

" }}}
" Ensure cache directory "{{{
if ! isdirectory(expand($VARPATH))
	" Create missing dirs i.e. cache/{undo,backup}
	call mkdir(expand('$VARPATH/undo'), 'p')
	call mkdir(expand('$VARPATH/backup'))
endif

" Disable pre-bundled plugins
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_logiPat = 1
let g:loaded_matchit = 1
let g:loaded_matchparen = 1
let g:loaded_rrhelper = 1
let g:loaded_ruby_provider = 1
let g:loaded_shada_plugin = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1

if has('nvim')
	" Write history on idle, for sharing among different sessions
	autocmd MyAutoCmd CursorHold * if exists(':rshada') | rshada | wshada | endif
endif

filetype plugin indent on
syntax enable

" Loading configuration modules
call s:source_file('general.vim')
call s:source_file('filetype.vim')
call s:source_file('mappings.vim')
" }}}

" Theme
" -----

" Enable 256 color terminal
set t_Co=256

" Enable true color
if has('termguicolors')
	set termguicolors
endif

function! s:theme_reload(name)
	let theme_path = $VIMPATH.'/theme/'.a:name.'.vim'
	if filereadable(theme_path)
		execute 'source' fnameescape(theme_path)
	endif
endfunction

" THEME NAME
let g:theme_name = 'rafi-2017'
autocmd MyAutoCmd ColorScheme * call s:theme_reload(g:theme_name)

set background=dark
colorscheme hybrid

set secure

" vim: set ts=2 sw=2 tw=80 noet :
