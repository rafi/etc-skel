
" rafi-2017 - hybrid custom
" =========================

" UI elements
" ---
set showbreak=↪
set fillchars=vert:│,fold:─
set listchars=tab:\▏\ ,extends:⟫,precedes:⟪,nbsp:␣,trail:·

if g:colors_name ==# 'hybrid'
	" TabLineFill: Tab pages line, where there are no labels
	hi TabLineFill ctermfg=234 ctermbg=236 guifg=#1C1C1C guibg=#303030 cterm=NONE gui=NONE
	" TabLine: Not-active tab page label
	hi TabLine     ctermfg=243 ctermbg=236 guifg=#767676 guibg=#303030 cterm=NONE gui=NONE
	" TabLineSel: Active tab page label
	hi TabLineSel  ctermfg=241 ctermbg=234 guifg=#626262 guibg=#1C1C1C cterm=NONE gui=NONE

	" Statusline
	highlight StatusLine   ctermfg=236 ctermbg=248 guifg=#30302c guibg=#a8a897
	highlight StatusLineNC ctermfg=236 ctermbg=242 guifg=#30302c guibg=#666656
endif

" Highlights: General GUI
" ---
" highlight! Error  term=NONE cterm=NONE
" highlight! link WarningMsg  Comment
highlight! link pythonSpaceError  NONE
highlight! link pythonIndentError NONE
" highlight! link mkdLineBreak      NONE
highlight! link ExtraWhitespace  SpellBad
highlight! WarningMsg ctermfg=100 guifg=#CCC566

" vim: set foldmethod=marker ts=2 sw=0 tw=80 noet :
