"      .-.     .-.     .-.     .-.     .-.     .-.     .-.
" `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'
"
" https://github.com/rafi/vim-config

if &compatible
	set nocompatible
endif

" Set main configuration directory, and where cache is stored.
let $VIMPATH = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
let $VARPATH = expand(($XDG_CACHE_HOME ? $XDG_CACHE_HOME : '~/.cache').'/vim')

function! s:source_file(path, ...) abort "{{{
	let use_global = get(a:000, 0, ! has('vim_starting'))
	let abspath = resolve(expand($VIMPATH.'/config/'.a:path))
	if !use_global
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
endfunction "}}}

" Set augroup
augroup MyAutoCmd
	autocmd!
	autocmd CursorHold *? syntax sync minlines=300
augroup END

" Initialize base requirements
if has('vim_starting')
	" Global Mappings "{{{
	" Use spacebar instead of '\' as leader.
	" Required before loading plugins!
	let g:mapleader="\<Space>"
	let g:maplocalleader=','

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
	endif "}}}

	if len($SSH_CLIENT)
		let $VIM_MINIMAL = 1
	endif

	" Disable pre-bundled plugins
	let g:loaded_getscript = 1
	let g:loaded_getscriptPlugin = 1
	let g:loaded_gzip = 1
	let g:loaded_logiPat = 1
	let g:loaded_man = 1
	let g:loaded_matchit = 1
	let g:loaded_matchparen = 1
	let g:loaded_netrw = 1
	let g:loaded_netrwPlugin = 1
	let g:loaded_netrwFileHandlers = 1
	let g:loaded_netrwSettings = 1
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
		" Write history on idle
		augroup MyAutoCmd
			autocmd CursorHold * if exists(':rshada') | rshada | wshada | endif
		augroup END

		" Search and use environments specifically made for Neovim.
		if isdirectory($VARPATH.'/venv/neovim2')
			let g:python_host_prog = $VARPATH.'/venv/neovim2/bin/python'
		endif
		if isdirectory($VARPATH.'/venv/neovim3')
			let g:python3_host_prog = $VARPATH.'/venv/neovim3/bin/python'
		endif

		let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
	endif
endif

filetype plugin indent on
syntax enable

if ! has('vim_starting')
	call dein#call_hook('source')
	call dein#call_hook('post_source')
endif

" Loading configuration modules {{{
call s:source_file('general.vim')
call s:source_file('filetype.vim')
call s:source_file('mappings.vim')
" }}}

" Theme
" -----

" Enable 256 color terminal
set t_Co=256

" Enable true color (only in Neovim, but not in urxvt)
if has('nvim') && $TERM !~# '^rxvt' && exists('+termguicolors')
	set termguicolors
	if &term =~# 'tmux-256color'
		let &t_8f = "\e[38;2;%ld;%ld;%ldm"
		let &t_8b = "\e[48;2;%ld;%ld;%ldm"
	endif
endif

function! s:theme_reload(name)
	let theme_path = $VIMPATH.'/themes/'.a:name.'.vim'
	if filereadable(theme_path)
		execute 'source' fnameescape(theme_path)
	endif
endfunction

autocmd MyAutoCmd ColorScheme * call s:theme_reload(g:theme_name)

let g:theme_name = 'rafi-2016'
set background=dark
colorscheme hybrid

set secure
" vim: set ts=2 sw=2 tw=80 noet :
