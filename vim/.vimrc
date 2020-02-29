syntax   on                    " 开启语法高亮
set nofoldenable               " 默认关闭代码折叠
set backspace=indent,eol,start " 智能回删
set whichwrap+=h,l,<,>,[,]     " 光标循环
set virtualedit=block,onemore  " 允许光标出现在最后一个字符的后面
set expandtab                  " Tab 替换为空格    et
set smartindent                " 智能缩进          si
set softtabstop=2              " Tab 缩进单位      sts
set shiftwidth=2               " 自动缩进单位      sw
set encoding=utf-8             " UTF-8 编码
set t_Co=256                   " 开启 256 色（若终端支持）
set background=dark            " 背景色
set nowrap                     " 禁止折行
set ignorecase                 " 搜索忽略大小写    ic
set incsearch                  " 搜索时实时高亮    is
set hlsearch                   " 高亮所有搜索结果  hls
set cursorcolumn               " 高亮当前列        cuc
set cursorline                 " 高亮当前行        cul
set scrolloff=5                " 屏幕顶/底部保持 5 行文本
set laststatus=2               " 显示状态栏
set noshowmode                 " 不显示当前状态
set showcmd                    " 显示输入的命令
set wildmenu                   " Vim 命令行提示
set nobackup                   " 不生成临时文件
set noswapfile                 " 不生成 swap 文件
set autoread                   " 自动加载外部修改
set autowrite                  " 自动保存
set confirm                    " 弹出文件未保存确认
set number                     " 显示行号          nu
set relativenumber             " 显示相对行号      rnu
set ruler                      " 显示标尺信息
set history=1024

" vim的undofile和备份文件
" 可以让你在关闭文件后再次打开时还可以撤销上次的更改
" 统一保存到.vim/.undodir
set undofile
set undodir=~/.vim/.undodir

set timeoutlen=700             " 超时……
let mapleader = "\<space>"     " 手机还是空格容易按到


" 设置插入模式下只显示绝对行号
augroup relative_numbser
  autocmd!
  autocmd InsertEnter * :set norelativenumber
  autocmd InsertLeave * :set relativenumber
augroup end

" vim-plug插件，可自行配置
call plug#begin('~/.vim/MyVimPlug')

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'ryanoasis/vim-devicons'
Plug 'chxuan/vim-buffer'
Plug 'junegunn/vim-slash'
Plug 'roman/golden-ratio'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'
Plug 'gorodinskiy/vim-coloresque'
Plug 'chxuan/change-colorscheme'
Plug 'dracula/vim'
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/vim-easy-align'
call plug#end()

" 目录树nnoremap <C-E>     :NERDTreeToggle<CR>

" 键盘映射
" fzf
nnoremap <C-F>      :Files<CR>
" 跳到下一个buffer
nnoremap <C-P> :bp<CR>
" 开一个新tab
nnoremap <Leader>t :tabnew<CR>
" 关闭tab
nnoremap <Leader>l :tabclose<CR>
" 下一个主题
map  <Leader>n :NextColorScheme<CR>

" 启动图
let g:startify_custom_header=[
      \'+----------------------+---------------+',
      \'|░░╔══╗░░░░░░░░░░╔══╗░░|something      |',
      \'|░╚╣▐▐╠╝░░╔══╗░░╚╣▐▐╠╝░|   for         |',
      \'|░░╚╦╦╝░░╚╣▌▌╠╝░░╚╦╦╝░░|     nothing   |',
      \'|░░░╚╚░░░░╚╦╦╝░░░░╚╚░░░|人生苦短       |',
      \'|░░░░░░░░░░╝╝░░░░░░░░░░|    且行且珍惜 |',
      \'+----------------------+---------------+']

" fzf配置
let g:fzf_layout = { 'down': '~35%' }
" 提供Rg命令，调用ripgrep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
" emmm滑稽配色
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"nerdtree配置
map tt :NERDTree <CR>
"当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"显示行号
let NERDTreeShowLineNumbers=1
"是否显示隐藏文件
let NERDTreeShowHidden=1
"设置宽度
let NERDTreeWinSize=15
"在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1
"忽略几个文件比如pyc
let NERDTreeIgnore=['\.pyc','\~$','\.swp']

"airline
"美化，不多说
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
"主题
let g:airline_theme='random'
colorscheme  dracula

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"按Ctrl m 运行程序
""""""""""""""""""""""""""""""""""""""""""
"	      Quickly Run
""""""""""""""""""""""""""""""""""""""""""
map <C-m> :call CompileRunGcc()<CR>

func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec '!gcc % -o %.bin && ./%.bin'
		"exec '! ./%<'
	elseif &filetype == 'cpp'
		exec '!g++ % -o %.bin && ./%.bin'
	        "exec '! ./%<'
        elseif &filetype == 'go'
               exec '!go run  %'
               "exec '! ./%<'
	elseif &filetype == 'python'
		exec '! python %'
	elseif &filetype == 'sh'
		:! bash %
	endif
endfunc

"解决中文乱码︾↓
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1

set enc=utf8

set fencs=utf8,gbk,gb2312,gb18030
"end︽
