color koehler
set ts=4
set number
set autoindent
set wildmenu

imap nm <C-n>
imap jk <Esc>
map vv :vsp<ENTER>

"Always display open file name
set laststatus=2

"Highlight whitespace at the end of a line
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd BufRead * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"Display tab numbers on the tab
fu! MyTabLabel(n)
	let buflist = tabpagebuflist(a:n)
	let winnr = tabpagewinnr(a:n)
	let string = fnamemodify(bufname(buflist[winnr - 1]), ':t')
	let string = (getbufvar(buflist[winnr - 1], "&mod") ? '*':'') . string
	return empty(string) ? '[unnamed]' : string
endfu

fu! MyTabLine()
	let s = ''
	for i in range(tabpagenr('$'))
	" select the highlighting
	    if i + 1 == tabpagenr()
	    let s .= '%#TabLineSel#'
	    else
	    let s .= '%#TabLine#'
	    endif

	    " set the tab page number (for mouse clicks)
	    "let s .= '%' . (i + 1) . 'T'
	    " display tabnumber (for use with <count>gt, etc)
	    let s .= ' '. (i+1) . ' '

	    " the label is made by MyTabLabel()
	    let s .= '%{MyTabLabel(' . (i + 1) . ')} '

	    if i+1 < tabpagenr('$')
	        let s .= ' |'
	    endif
	endfor

	" after the last tab fill with TabLineFill and reset tab page nr
  	let s .= '%#TabLineFill#%T'

	return s
	endfu
set tabline=%!MyTabLine()

