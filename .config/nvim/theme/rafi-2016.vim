
" rafi-2016 - hybrid custom
" =========================

" UI elements {{{
" ---------------------------------------------------------
set showbreak=↪
set fillchars=vert:│,fold:─
set listchars=tab:\⋮\ ,extends:⟫,precedes:⟪,nbsp:␣,trail:·
" }}}

" Tabline {{{
" ---------------------------------------------------------
" TabLineFill: Tab pages line, where there are no labels
hi TabLineFill ctermfg=234 ctermbg=236 guifg=#1C1C1C guibg=#303030 cterm=NONE gui=NONE
" TabLine: Not-active tab page label
hi TabLine     ctermfg=243 ctermbg=236 guifg=#767676 guibg=#303030 cterm=NONE gui=NONE
" }}}

" Statusline {{{
if g:colors_name ==# 'hybrid'
	highlight StatusLine   ctermfg=236 ctermbg=248 guifg=#30302c guibg=#a8a897
	highlight StatusLineNC ctermfg=236 ctermbg=242 guifg=#30302c guibg=#666656
endif
" }}}

" Highlights: General GUI {{{
" ---------------------------------------------------------
highlight! Error  term=NONE cterm=NONE
highlight! link mkdLineBreak      NONE
highlight! link pythonSpaceError  NONE
highlight! link pythonIndentError NONE
highlight! link WarningMsg  Comment
highlight! link ExtraWhitespace  SpellBad
" }}}

" Plugin: VimFiler icons {{{
" ---------------------------------------------------------
let g:vimfiler_tree_indentation = 1
let g:vimfiler_tree_leaf_icon = '┆'
let g:vimfiler_tree_opened_icon = '▼'
let g:vimfiler_tree_closed_icon = '▷'
let g:vimfiler_file_icon = ' '
let g:vimfiler_readonly_file_icon = '✖'
let g:vimfiler_marked_file_icon = '✓'
"}}}

" Plugin: NERDTree icons and highlights {{{
" ---------------------------------------------------------
let g:NERDTreeIndicatorMapCustom = {
	\ 'Modified':  'M',
	\ 'Staged':    'Ṁ',
	\ 'Untracked': '⁇',
	\ 'Renamed':   'R',
	\ 'Unmerged':  'U',
	\ 'Deleted':   'D',
	\ 'Dirty':     '⠟',
	\ 'Clean':     '✓',
	\ 'Unknown':   '?'
	\ }

let g:NERDTreeDirArrowExpandable = '▷'
let g:NERDTreeDirArrowCollapsible = '▼'

highlight! NERDTreeOpenable ctermfg=132 guifg=#B05E87
highlight! def link NERDTreeClosable NERDTreeOpenable

highlight! NERDTreeFile ctermfg=246 guifg=#999999
highlight! NERDTreeExecFile ctermfg=246 guifg=#999999

highlight! clear NERDTreeFlags
highlight! NERDTreeFlags ctermfg=234 guifg=#1d1f21
highlight! NERDTreeCWD ctermfg=240 guifg=#777777

highlight! NERDTreeGitStatusModified ctermfg=1 guifg=#D370A3
highlight! NERDTreeGitStatusStaged ctermfg=10 guifg=#A3D572
highlight! NERDTreeGitStatusUntracked ctermfg=12 guifg=#98CBFE
highlight! def link NERDTreeGitStatusRenamed Title
highlight! def link NERDTreeGitStatusUnmerged Label
highlight! def link NERDTreeGitStatusDirDirty Comment
highlight! def link NERDTreeGitStatusDirClean DiffAdd
highlight! def link NERDTreeGitStatusUnknown Comment

" NERDTress File highlighting
function! s:nerdtree_highlight(extension, fg, bg, guifg, guibg)
 exec 'highlight NERDFileType'.a:extension.' ctermbg='.a:bg.' ctermfg='.a:fg.' guibg='.a:guibg.' guifg='.a:guifg
 exec 'syn match NERDFileType'.a:extension.' #^\s\+\]*.*\.'.a:extension.'$#'
endfunction

function! s:NERDTreeHighlight()
	for l:name in keys(g:NERDTreeIndicatorMapCustom)
		let l:prefix = index(['Dirty', 'Clean'], l:name) > -1 ? 'Dir' : ''
		let l:hiname = escape('NERDTreeGitStatus'.l:prefix.l:name, '~')
		let l:icon = g:NERDTreeIndicatorMapCustom[l:name]
		execute 'syntax match '.l:hiname.' #'.l:icon.'# containedin=NERDTreeFlags'
	endfor

	syntax match NERDTreeOpenBracket /\[/
		\ contained containedin=NERDTreeFlags conceal
endfunction

augroup AddHighlighting
	autocmd!
	autocmd FileType nerdtree call s:NERDTreeHighlight()
augroup END
"}}}

" Plugin: Tagbar icons {{{
" ---------------------------------------------------------
let g:tagbar_iconchars = ['▷', '◢']
"}}}

" Plugin: Neomake icons {{{
" ---------------------------------------------------------
let g:neomake_error_sign = {'text': '✖', 'texthl': 'ErrorMsg'}
let g:neomake_warning_sign = {'text': '▷', 'texthl': 'WarningMsg'}
let g:neomake_message_sign = {'text': '▣', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}
"}}}

" Plugin: GitGutter icons {{{
" ---------------------------------------------------------
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▋'
"}}}

" Plugin: Indent-Guides icons {{{
" ---------------------------------------------------------
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 1
let g:indent_guides_auto_colors = 0
"}}}

" Plugin: vim-gitgutter {{{
" ---------------------------------------------------------
highlight GitGutterAdd ctermfg=22 guifg=#006000 ctermbg=NONE
highlight GitGutterChange ctermfg=58 guifg=#5F6000 ctermbg=NONE
highlight GitGutterDelete ctermfg=52 guifg=#600000 ctermbg=NONE
highlight GitGutterChangeDelete ctermfg=52 guifg=#600000 ctermbg=NONE
" }}}

" Plugin: denite {{{
" ---------------------------------------------------------
highlight clear WildMenu
highlight link WildMenu CursorLine
highlight link deniteSelectedLine Type
highlight link deniteMatchedChar Function
highlight link deniteMatchedRange Underlined
highlight link deniteMode Comment
" }}}

" Plugin: vimfiler.vim {{{
" ---------------------------------------------------------
highlight vimfilerNonMark     ctermfg=132 guifg=#B05E87
highlight vimfilerLeaf        ctermfg=238 guifg=#444444
highlight vimfilerClosedFile  ctermfg=246 guifg=#949494
highlight link vimfilerOpenedFile  Normal
highlight link vimfilerNormalFile  Comment
highlight link vimfilerMarkedFile  Type
" }}}

" Plugin: vim-indent-guides {{{
" ---------------------------------------------------------
highlight IndentGuidesOdd  guibg=#262626 ctermbg=235
highlight IndentGuidesEven guibg=#303030 ctermbg=236
" }}}

" Plugin: vim-operator-flashy {{{
" ---------------------------------------------------------
highlight link Flashy Todo
" }}}

" }}}
" Plugin: vim-bookmarks {{{
let g:bookmark_sign = '⚐'
highlight BookmarkSign            ctermfg=12 guifg=#4EA9D7
highlight BookmarkAnnotationSign  ctermfg=11 guifg=#EACF49
" }}}

" Plugin: vim-choosewin {{{
" ---------------------------------------------------------
let g:choosewin_label = 'SDFJKLZXCV'
let g:choosewin_overlay_enable = 1
let g:choosewin_statusline_replace = 1
let g:choosewin_overlay_clear_multibyte = 0
let g:choosewin_blink_on_land = 0

let g:choosewin_color_label = {
	\ 'cterm': [ 236, 2 ], 'gui': [ '#555555', '#000000' ] }
let g:choosewin_color_label_current = {
	\ 'cterm': [ 234, 220 ], 'gui': [ '#333333', '#000000' ] }
let g:choosewin_color_other = {
	\ 'cterm': [ 235, 235 ], 'gui': [ '#333333' ] }
let g:choosewin_color_overlay = {
	\ 'cterm': [ 2, 10 ], 'gui': [ '#88A2A4' ] }
let g:choosewin_color_overlay_current = {
	\ 'cterm': [ 72, 64 ], 'gui': [ '#7BB292' ] }
" }}}

" vim: set ts=2 sw=0 tw=80 noet :
