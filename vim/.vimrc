set clipboard+=unnamed
set hlsearch
syntax enable
autocmd BufReadPost * normal G
highlight Error ctermfg=white ctermbg=red guifg=white guibg=red

" Define 'j' to behave like 'gj' when no count is given, otherwise keep 'j'
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Define 'k' to behave like 'gk' when no count is given, otherwise keep 'k'
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
