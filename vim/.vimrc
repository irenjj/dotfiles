set clipboard+=unnamed
set hlsearch
syntax enable
autocmd BufReadPost * normal G
highlight Error ctermfg=white ctermbg=red guifg=white guibg=red

"----- keymap -----
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')

nnoremap q :q!<CR>
