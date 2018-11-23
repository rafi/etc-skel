
" File Types
"-------------------------------------------------

augroup MyAutoCmd " {{{

	" Highlight current line only on focused window
	autocmd WinEnter,InsertLeave * set cursorline
	autocmd WinLeave,InsertEnter * set nocursorline

	" Automatically set read-only for files being edited elsewhere
	autocmd SwapExists * nested let v:swapchoice = 'o'

	" Check if file changed when its window is focus, more eager than 'autoread'
	autocmd WinEnter,FocusGained * checktime

	autocmd Syntax * if 5000 < line('$') | syntax sync minlines=200 | endif

	" Update filetype on save if empty
	autocmd BufWritePost * nested
		\ if &l:filetype ==# '' || exists('b:ftdetect')
		\ |   unlet! b:ftdetect
		\ |   filetype detect
		\ | endif

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	autocmd BufReadPost *
		\ if &ft !~ '^git\c' && ! &diff && line("'\"") > 0 && line("'\"") <= line("$")
		\|   execute 'normal! g`"zvzz'
		\| endif

	" Disable paste and/or update diff when leaving insert mode
	autocmd InsertLeave *
			\ if &paste | setlocal nopaste mouse=a | echo 'nopaste' | endif |
			\ if &l:diff | diffupdate | endif

	autocmd FileType help
		\ setlocal iskeyword+=: | setlocal iskeyword+=# | setlocal iskeyword+=-

	autocmd FileType crontab setlocal nobackup nowritebackup

	autocmd FileType yaml.docker-compose setlocal expandtab

	autocmd FileType gitcommit setlocal spell

	autocmd FileType gitcommit,qfreplace setlocal nofoldenable

	autocmd FileType zsh setlocal foldenable foldmethod=marker

	" Improved HTML include pattern
	autocmd FileType html
		\ setlocal includeexpr=substitute(v:fname, '^\\/', '', '')
		\ | setlocal path+=./;/

	autocmd FileType markdown
		\ set expandtab
		\ | setlocal spell autoindent formatoptions=tcroqn2 comments=n:>

	autocmd FileType apache setlocal path+=./;/

	" Open Quickfix window automatically
	autocmd QuickFixCmdPost [^l]* leftabove copen
		\ | wincmd p | redraw!
	autocmd QuickFixCmdPost l* leftabove lopen
		\ | wincmd p | redraw!

	" Fix window position of help/quickfix
	autocmd FileType help if &l:buftype ==# 'help'
		\ | wincmd L | endif
	autocmd FileType qf   if &l:buftype ==# 'quickfix'
		\ | wincmd J | endif

augroup END " }}}

" Internal Plugin Settings  {{{
" ------------------------

" PHP {{{
let g:PHP_removeCRwhenUnix = 0

" }}}
" Python {{{
let g:python_highlight_all = 1

" }}}
" Vim {{{
let g:vimsyntax_noerror = 1
let g:vim_indent_cont = &shiftwidth

" }}}
" Bash {{{
let g:is_bash = 1

" }}}
" Java {{{
let g:java_highlight_functions = 'style'
let g:java_highlight_all = 1
let g:java_highlight_debug = 1
let g:java_allow_cpp_keywords = 1
let g:java_space_errors = 1
let g:java_highlight_functions = 1

" }}}
" JavaScript {{{
let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1

" }}}
" Markdown {{{
let g:markdown_fenced_languages = [
	\  'css',
	\  'javascript',
	\  'js=javascript',
	\  'json=javascript',
	\  'python',
	\  'py=python',
	\  'sh',
	\  'sass',
	\  'xml',
	\  'vim'
	\]

" }}}
" Folding {{{
" augroup: a
" function: f
let g:vimsyn_folding = 'af'
let g:tex_fold_enabled = 1
let g:xml_syntax_folding = 1
let g:php_folding = 2
let g:php_phpdoc_folding = 1
let g:perl_fold = 1
" }}}
" }}}

" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
