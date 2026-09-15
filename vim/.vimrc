" ~/.vimrc — vim ligero para infra/IaC, cero plugins
" Keybindings portados desde nvim/.config/nvim/lua/mappings.lua

" --- Settings básicos ---
syntax on
set number
set cursorline
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set nobackup
set nowritebackup
set noswapfile
set hlsearch
set ignorecase
set smartcase

" --- Keybindings ---

" Guardar con Ctrl+Enter (puede no llegar en terminal; funciona en gvim)
nnoremap <silent> <C-Return> :w<CR>

" Explorador de archivos con sf (netrw)
nnoremap <silent> sf :Explore<CR>

" Incrementa y decrementa con + y -
nnoremap + <C-a>
nnoremap - <C-x>

" Manejo de tabs y ventanas
nnoremap <silent> te :tabedit<CR>
nnoremap <silent> <Tab> gt
nnoremap <silent> <S-Tab> gT
nnoremap <silent> sv :vsplit<CR>
nnoremap <silent> ss :split<CR>

" Moverse entre ventanas en splits
nnoremap <silent> <Space> <C-w>w
nnoremap <silent> sh <C-w>h
nnoremap <silent> sk <C-w>k
nnoremap <silent> sj <C-w>j
nnoremap <silent> sl <C-w>l

" En netrw, crear un archivo nuevo con N
autocmd FileType netrw nmap <buffer> N :call inputsave()\|let name = input('Enter file name: ')\|call inputrestore()\|execute 'e %:h/' . name<CR>

" --- Opcional: vim-plug por si quieres 1-2 plugins (resaltado extra, etc.) ---
" Instalar: curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" call plug#begin('~/.vim/plugged')
" Plug 'pearofducks/ansible-vim'
" call plug#end()
