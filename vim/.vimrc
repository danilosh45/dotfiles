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

" --- Apariencia ---
" Tema azul de stock (alternativa: darkblue)
colorscheme blue

" Cursor: bloque en normal/visual, barra fina en insert, subrayado en replace
" (secuencias DECSCUSR, funcionan en GNOME Terminal/VTE, xterm, etc.)
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
let &t_SR = "\e[4 q"

" Al salir, devolver el cursor por defecto a la terminal
augroup reset_cursor_shape
  autocmd!
  autocmd VimLeave * silent !printf '\e[0 q'
augroup END

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
