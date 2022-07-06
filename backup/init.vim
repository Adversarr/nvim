call plug#begin('~/.vim/plugged')
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'	
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
  Plug 'tpope/vim-fugitive'
  Plug 'tikhomirov/vim-glsl', {'for': 'glsl'}
  Plug 'machakann/vim-swap'
  Plug 'preservim/nerdcommenter'
  Plug 'jackguo380/vim-lsp-cxx-highlight'
  Plug 'mbbill/undotree', {'on': 'UndoTreeToggle'}
  Plug 'skywind3000/asynctasks.vim'
  Plug 'skywind3000/asyncrun.vim'
  Plug 'haya14busa/incsearch.vim'
  Plug 'voldikss/vim-floaterm'
  Plug 'SirVer/ultisnips'
  Plug 'keelii/vim-snippets'
  Plug 'lervag/vimtex'

  Plug 'morhetz/gruvbox'
 
  
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'windwp/nvim-autopairs'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'kyazdani42/nvim-tree.lua'
  
  Plug 'kyazdani42/nvim-web-devicons'

  Plug 'akinsho/bufferline.nvim'
  Plug 'nvim-lualine/lualine.nvim'
call plug#end()

" Color Scheme = gruvbox
colorscheme gruvbox



" >>> You Complete Me >>>
" Let clangd fully control code completion
" let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
" let g:ycm_clangd_binary_path = exepath("clangd")
" let g:ycm_clangd_args=['-pretty', '-j=4', '--background-index', '--all-scopes-completion', '--pch-storage=memory']
" <<< <<<

set expandtab
set relativenumber
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set nocompatible
set fdm=syntax fdl=100
set nu ru ls=2
set hls is si
set cinoptions=j1,(0,ws,Ws,g0
set formatoptions-=cro
set timeout nottimeout ttimeoutlen=10
set mouse=a
set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮
set showbreak=↪
set smartcase



syntax on
filetype on
filetype plugin on
filetype indent on

"let g:mapleader = ' '
"let g:mapleader = ','
let g:mapleader = ' '

nnoremap <silent> <F1> :wa<CR>:b#<CR>
nnoremap <silent> <F2> :wa<CR>:bp<CR>
nnoremap <silent> <F3> :wa<CR>:bn<CR>
nnoremap <silent> <F4> :wa<CR>
inoremap <silent> <F1> <ESC>
inoremap <silent> <F2> <ESC>:wa<CR>:bp<CR>
inoremap <silent> <F3> <ESC>:wa<CR>:bn<CR>
inoremap <silent> <F4> <ESC>:wa<CR>
inoremap <silent> <F8> <ESC>:wa<CR>:sh<CR><CR>
nnoremap <F5> :AsyncTasks project-build project-run<CR>
nnoremap <F6> :AsyncTask project-build<CR>
nnoremap <F7> :AsyncTasks file-build file-run<CR>



" for vim-airline:
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#keymap#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
" 设置切换tab的快捷键 <\> + <i> 切换到第i个 tab
nmap <silent> <leader>1 <Plug>AirlineSelectTab1
nmap <silent> <leader>2 <Plug>AirlineSelectTab2
nmap <silent> <leader>3 <Plug>AirlineSelectTab3
nmap <silent> <leader>4 <Plug>AirlineSelectTab4
nmap <silent> <leader>5 <Plug>AirlineSelectTab5
nmap <silent> <leader>6 <Plug>AirlineSelectTab6
nmap <silent> <leader>7 <Plug>AirlineSelectTab7
nmap <silent> <leader>8 <Plug>AirlineSelectTab8
nmap <silent> <leader>9 <Plug>AirlineSelectTab9

"nmap <silent> <leader>1 :tab1<CR>
"nmap <silent> <leader>2 :tab2<CR>
"nmap <silent> <leader>3 :tab3<CR>
"nmap <silent> <leader>4 :tab4<CR>
"nmap <silent> <leader>5 :tab5<CR>
"nmap <silent> <leader>6 :tab6<CR>
"nmap <silent> <leader>7 :tab7<CR>
"nmap <silent> <leader>8 :tab8<CR>
"nmap <silent> <leader>9 :tab9<CR>
"cabbrev o tab drop
"cabbrev e tabe
"cabbrev m tabm
"cabbrev a tab ball
"autocmd BufReadPost * tab ball

" for LeaderF:

let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewCode = 1
"let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
"let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

let g:Lf_ShortcutF = "<leader>ff"
"noremap <leader>ff :<C-U><C-R>=printf("Leaderf file %s", "")<CR><CR>
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <leader>fx :<C-U><C-R>=printf("Leaderf command %s", "")<CR><CR>
noremap <leader>f: :<C-U><C-R>=printf("Leaderf cmdHistory %s", "")<CR><CR>
noremap <leader>f/ :<C-U><C-R>=printf("Leaderf searchHistory %s", "")<CR><CR>
noremap <leader>fw :<C-U><C-R>=printf("Leaderf window %s", "")<CR><CR>
noremap <leader>fj :<C-U><C-R>=printf("Leaderf jumps %s", "")<CR><CR>

noremap <leader>fi :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s", expand("<cword>"))<CR><CR>
noremap <leader>fa :<C-U><C-R>=printf("Leaderf! rg -e %s", expand("<cword>"))<CR><CR>
xnoremap <leader>fi :<C-U><C-R>=printf("Leaderf! rg --current-buffer -F -e %s", leaderf#Rg#visual())<CR><CR>
xnoremap <leader>fa :<C-U><C-R>=printf("Leaderf! rg -F -e %s", leaderf#Rg#visual())<CR><CR>
noremap <leader>fr :<C-U>Leaderf! rg --recall<CR>

" should use `Leaderf gtags --update` first
"let g:Lf_GtagsAutoGenerate = 0
"let g:Lf_Gtagslabel = 'native-pygments'
"noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
"noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
"noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
"noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
"noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

" for coc.nvim:
"let g:coc_global_extensions = ['coc-ccls', 'coc-pyright', 'coc-json', 'coc-git']

" BEGIN_COC_NVIM {{{
" References: https://github.com/neoclide/coc.nvim#example-vim-configuration

set nohidden
set nobackup
set nowritebackup
set updatetime=300
set cmdheight=1
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> pumvisible() ? coc#_select_confirm() : coc#refresh()
else
  inoremap <silent><expr> <c-@> pumvisible() ? coc#_select_confirm() : coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              "\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"inoremap <silent><expr> <space> pumvisible() ? (<SID>check_back_space() ? "\<space>" : coc#_select_confirm()) : "\<space>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> g[ <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)


" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-type-definition)
nmap <silent> gc <Plug>(coc-declaration)
nmap <silent> gC <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>R <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f <Plug>(coc-format-selected)
"nmap <leader>q <Plug>(coc-format-selected)
nnoremap <leader>q :Format<CR>

" Restart CoC
"nmap <silent> <leader>t :CocRestart<CR><CR>

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>aq  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>al <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format    :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold      :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OrgImport :call CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>la  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <leader>le  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>lc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <leader>lo  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>ls  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>lj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>lk  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <leader>lp  :<C-u>CocListResume<CR>
" Show git status
nnoremap <silent> <leader>lg  :<C-u>CocList --normal gstatus<CR>

" }}} END_COC_NVIM

" for coc-snippets:
" 
" let g:coc_snippet_next = '<tab>'

" for vim-floaterm:

let g:floaterm_wintype = 'split'
let g:floaterm_position = 'botright'
let g:floaterm_height = 12

"let g:floaterm_keymap_new    = '<F1>'
"let g:floaterm_keymap_prev   = '<F2>'
"let g:floaterm_keymap_next   = '<F3>'
let g:floaterm_keymap_toggle = '<C-t>'

" for asynctasks.vim:

let g:asyncrun_open = 6
let g:asynctasks_term_pos = 'floaterm_reuse'
let g:asynctasks_term_rows = 6
let g:asynctasks_term_cols = 50
let g:asynctasks_term_reuse = 1
let g:asynctasks_term_focus = 0
let g:asyncrun_rootmarks = ['.tasks', '.git/']

function! AsyncTaskMultiple(first, ...)
    if len(a:000) >= 1
        if a:first == 0
            cclose
        endif
        let l:tmp = ""
        for task in a:000[1:]
            let l:tmp .= "'".l:task."',"
        endfor
        let l:tmp = l:tmp[:-1]
        let g:asyncrun_exit = "if g:asyncrun_code == 0 | call AsyncTaskMultiple(0, ".l:tmp.") | else | call AsyncTaskMultiple(0) | endif"
        exec "AsyncTask ".a:000[0]
    else
        let g:asyncrun_exit = ""
    endif
endfunction
command! -nargs=+ AsyncTasks   :call AsyncTaskMultiple(1, <f-args>)

" for incsearch.vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
function! s:noregexp(pattern) abort
  return '\V' . escape(a:pattern, '\')
endfunction

function! s:incsconfig() abort
  return {'converters': [function('s:noregexp')]}
endfunction

noremap <silent><expr> z/ incsearch#go(<SID>incsconfig())

" Vim Tex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'


" Ultisnips
" let g:UltiSnipsExpandTrigger = '<tab>'
" let g:UltiSnipsJumpForwardTrigger = '<tab>'
" let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'


