highlight MDHighlightH term=standout ctermfg=0 ctermbg=11 guifg=orangered
highlight MDHighlightHB term=standout ctermfg=0 ctermbg=11 guifg=orangered cterm=bold

syntax region MDHighlight matchgroup=HighEnd start='==' end='==' concealends
highlight link MDHighlight MDHighlightH

syntax region MDBoldHighlight matchgroup=HighEnd start='\*\*' end='\*\*' concealends containedin=MDHighlight contained
highlight link MDBoldHighlight MDHighlighHB

syntax match markdownBlockQuote "^> .*"
