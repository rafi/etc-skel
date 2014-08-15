
" vim-tinyline - Tiny status line for Vim
" Maintainer: Rafael Bodill <justrafi@gmail.com>
" Version:    0.6
"-------------------------------------------------

" Configuration {{{1
" Maximum number of directories in filepath
if !exists('g:tinyline_max_dirs')
	let g:tinyline_max_dirs = 3
endif
" Maximum number of characters in each directory
if !exists('g:tinyline_max_dir_chars')
	let g:tinyline_max_dir_chars = 5
endif
" Less verbosity on specific filetypes (regexp)
if !exists('g:tinyline_quiet_filetypes')
	let g:tinyline_quiet_filetypes = 'qf\|help\|unite\|vimfiler\|gundo\|diff\|fugitive\|gitv'
endif
" Set syntastic statusline format
if !exists('g:tinyline_disable_syntastic_integration')
	let g:syntastic_stl_format = '%W{w%w%fw}%B{ }%E{e%e%fe}'
endif

" Color palette {{{1
let s:base03  = [ '#151513', 233 ]
let s:base02  = [ '#30302c', 236 ]
let s:base01  = [ '#4e4e43', 239 ]
let s:base00  = [ '#666656', 242 ]
let s:base0   = [ '#808070', 244 ]
let s:base1   = [ '#949484', 246 ]
let s:base2   = [ '#a8a897', 248 ]
let s:base3   = [ '#e8e8d3', 253 ]
let s:yellow  = [ '#ffb964', 215 ]
let s:orange  = [ '#fad07a', 222 ]
let s:red     = [ '#cf6a4c', 167 ]
let s:magenta = [ '#f0a0c0', 217 ]
let s:blue    = [ '#8197bf', 103 ]
let s:cyan    = [ '#8fbfdc', 110 ]
let s:green   = [ '#99ad6a', 107 ]

" Colors for different Vim modes {{{1
let s:normal  = "guifg=".s:base02[0]." guibg=".s:blue[0].   " ctermfg=".s:base02[1]." ctermbg=".s:blue[1]
let s:insert  = "guifg=".s:base02[0]." guibg=".s:green[0].  " ctermfg=".s:base02[1]." ctermbg=".s:green[1]
let s:visual  = "guifg=".s:base02[0]." guibg=".s:magenta[0]." ctermfg=".s:base02[1]." ctermbg=".s:magenta[1]
let s:replace = "guifg=".s:base02[0]." guibg=".s:red[0].    " ctermfg=".s:base02[1]." ctermbg=".s:red[1]

" Set statusline colors {{{1
exec "hi StatusLine   ctermfg=".s:base02[1]." ctermbg=".s:base2[1]. " guifg=".s:base02[0]." guibg=".s:base2[0]
exec "hi StatusLineNC ctermfg=".s:base02[1]." ctermbg=".s:base00[1]." guifg=".s:base02[0]." guibg=".s:base00[0]

" Custom tinyline colors
" Vim mode color
exec "hi User1 ".s:normal
" Percent color
exec "hi User2 guifg=".s:base2[0]. " guibg=".s:base01[0]." ctermfg=".s:base2[1]. " ctermbg=".s:base01[1]
" Line and column color
exec "hi User3 guifg=".s:base02[0]." guibg=".s:base1[0]. " ctermfg=".s:base02[1]." ctermbg=".s:base1[1]
" Buffer # symbol
exec "hi User4 guifg=".s:base00[0]. " guibg=".s:base02[0]." ctermfg=".s:base00[1]. " ctermbg=".s:base02[1]
" Filepath color
exec "hi User5 guifg=".s:base3[0]. " guibg=".s:base02[0]." ctermfg=".s:base3[1]. " ctermbg=".s:base02[1]
" Write symbol
exec "hi User6 guifg=".s:red[0].   " guibg=".s:base02[0]." ctermfg=".s:red[1].   " ctermbg=".s:base02[1]
" Paste symbol
exec "hi User7 guifg=".s:green[0]. " guibg=".s:base02[0]." ctermfg=".s:green[1]. " ctermbg=".s:base02[1]
" Syntastic and whitespace
exec "hi User8 guifg=".s:yellow[0]. " guibg=".s:base02[0]." ctermfg=".s:yellow[1]. " ctermbg=".s:base02[1]

" Functions {{{1
"
" Provides relative path with limited characters in each directory name, and
" limits number of total directories. Caches the result for current buffer.
function TlSuperName()
	" Use buffer's cached filepath
	if exists('b:tinyline_filepath') && len(b:tinyline_filepath) > 0
		return b:tinyline_filepath
	endif

	" VimFiler status string
	if &ft == 'vimfiler'
		let b:tinyline_filepath = vimfiler#get_status_string()
	" Empty if owned by certain plugins
	elseif &ft =~? g:tinyline_quiet_filetypes
		let b:tinyline_filepath = ''
	" Placeholder for empty buffer
	elseif expand('%:t') == ''
		let b:tinyline_filepath = 'N/A'
	" Regular file
	else
		" Shorten dir names
		let short = substitute(expand("%"), "[^/]\\{".g:tinyline_max_dir_chars."}\\zs[^/]\*\\ze/", "", "g")
		" Decrease dir count
		let parts = split(short, '/')
		if len(parts) > g:tinyline_max_dirs
			let parts = parts[-g:tinyline_max_dirs-1 : ]
		endif
		let b:tinyline_filepath = join(parts, '/')
	endif
	return b:tinyline_filepath
endfunction

" Return git branch name, using Fugitive plugin
function TlBranchName()
	if &ft !~? g:tinyline_quiet_filetypes && exists("*fugitive#head")
		return fugitive#head(8)
	endif
	return ''
endfunction

" Returns a read-only symbol
function TlReadonly()
	return &ft !~? g:tinyline_quiet_filetypes && &readonly ? '' : ''
endfunction

" Deprecated: Returns cursor's position percentage of file total
function TlPercent()
	return float2nr(100.0 * line('.') / line('$'))
endfunction

" Returns line and column position of cursor.
" Line no. is left-padded by 4-chars, and column no. by 3-chars on the right
function TlPosition()
	if &ft =~? g:tinyline_quiet_filetypes
		return ''
	endif
	let line_no = line('.')
	let col_no = col('.')
	return repeat(' ', 4-len(line_no)).line_no
			\ .'/'.col_no.repeat(' ', 3-len(col_no))
endfunction

" Returns mode string
function TlMode()
	return &ft =~? g:tinyline_quiet_filetypes ? '' : '  '.mode().' '
endfunction

" Returns file format
function TlFormat()
	return &ft =~? g:tinyline_quiet_filetypes ? '' : &ff
endfunction

" Returns syntastic statusline and cache result per buffer
function TlSyntastic()
	" Use buffer's value if cached
	if !exists('b:tinyline_syntastic')
		if &ft =~? g:tinyline_quiet_filetypes
			let b:tinyline_syntastic = ''
		else
			let b:tinyline_syntastic = SyntasticStatuslineFlag()
		endif
	endif
	return b:tinyline_syntastic
endfunction

" Detect trailing whitespace and cache result per buffer
function! TlWhiteSpace()
	if !exists('b:tinyline_whitespace')
		let b:tinyline_whitespace = ''
		if !&readonly && &modifiable && line('$') < 20000
			let trailing = search('\s$', 'nw')
			if trailing != 0
				let b:tinyline_whitespace .= printf('trail%s', trailing)
			endif
		endif
	endif
	return b:tinyline_whitespace
endfunction!

" Sets custom `User1` color according to {mode} argument
" Examples of {mode} values: i/r/v
function s:set_mode_color(mode)
	if a:mode == 'i'
		exec 'hi! User1 '.s:insert
	elseif a:mode == 'r'
		exec 'hi! User1 '.s:replace
	else
		exec 'hi! User1 '.s:visual
	endif
endfunction

" Concat the active statusline {{{1
" ------------------------------------------=--------------------=------------
"               Gibberish                   | What da heck?      | Example
" ------------------------------------------+--------------------+------------
set statusline=                            "| Clear status line  |
set statusline+=%1*%{TlMode()}%*           "| Mode               | i
set statusline+=\ %7*%{&paste?'=':''}%*    "| Paste symbol       | =
set statusline+=%4*%{&ro?'':'#'}%*         "| Modifiable symbol  | #
set statusline+=%6*%{TlReadonly()}         "| Readonly symbol    | §
set statusline+=%*%n                       "| Buffer number      | 3
set statusline+=%6*%{&mod?'+':''}%0*       "| Write symbol       | +
set statusline+=\ %5*%{TlSuperName()}%*    "| Relative supername | cor/app.js
set statusline+=\ %<                       "| Truncate here      |
set statusline+=%(\ %{TlBranchName()}\ %) "| Git branch name    | ‡ master
set statusline+=%4*%(%{TlWhiteSpace()}\ %) "| Space and indent   | trail:9
set statusline+=%(%{TlSyntastic()}\ %)%*   "| Syntastic err/info | e2:23
set statusline+=%=                         "| Align to right     |
set statusline+=%{TlFormat()}              "| File format        | unix
set statusline+=%(\ \ %{&fenc}\ \ %)     "| File encoding      | • utf-8 •
set statusline+=%{&ft}                     "| File type          | python
set statusline+=%*\ %2*\ %3.p%%            "| Percentage         | 88%
set statusline+=\ %3*%{TlPosition()}%*     "| Line and column    | 69/77
" ------------------------------------------'--------------------'------------
" Non-active statusline {{{1
" ------------------------------------------+--------------------+------------
let s:stl_nc = "\ %{&paste?'=':''}"        "| Paste symbol       | =
let s:stl_nc.= "%{TlReadonly()}%n"         "| Readonly & buffer  | §7
let s:stl_nc.= "%6*%{&mod?'+':''}%*"       "| Write symbol       | +
let s:stl_nc.= "\ %{TlSuperName()}"        "| Relative supername | src/main.py
let s:stl_nc.= "%="                        "| Align to right     |
let s:stl_nc.= "%{&ft}\ "                  "| File type          | python
" ------------------------------------------'--------------------'------------

" Store the active statusline for later toggling
let s:stl = &g:statusline

" Auto-commands {{{1

" Toggle mode color according to insertmode (does not trigger for visual)
autocmd InsertEnter * call s:set_mode_color(v:insertmode)
autocmd InsertLeave * exec 'hi! User1 '.s:normal

" On save, clear whitespace and syntastic cache
autocmd BufWritePost * unlet! b:tinyline_whitespace | unlet! b:tinyline_syntastic

" Toggle buffer's inactive/active statusline
autocmd WinEnter * let &l:statusline = s:stl
autocmd WinLeave * let &l:statusline = s:stl_nc

" For quickfix windows
autocmd BufReadPost * let &l:statusline = s:stl

" }}}
