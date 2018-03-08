" =============================================================================
"        << 判断操作系统是 Windows 还是 Linux 和判断是终端还是 Gvim >>
" =============================================================================
"               < 判断操作系统是否是 Windows 还是 Linux >
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif


"                           < 判断是终端还是 Gvim >
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

" =============================================================================
"                          << 软件默认配置 >>
" =============================================================================
"                       < Windows Gvim 默认配置>
if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
    set diffexpr=MyDiff()

    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

"                       < Linux Gvim/Vim 默认配置>
if g:islinux
    if g:isGUI
        if filereadable("/etc/vim/gvimrc.local")
            source /etc/vim/gvimrc.local
        endif
    else
        " Source a global configuration file if available
        if filereadable("/etc/vim/vimrc")
            source /etc/vim/vimrc
        elseif filereadable("/etc/vimrc")
            source /etc/vimrc
        endif
    endif
endif




" =============================================================================
"                           << 用户自定义配置 >>
" =============================================================================
"                               < 文件和编码配置 >
"禁用 Vi 兼容模式
set nocompatible

" 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
set encoding=utf-8                              " 设置gvim内部编码
set fileencoding=utf-8                          " 设置当前文件编码
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1       " 设置支持打开的文件的编码

" 文件格式，默认 ffs=dos,unix
set fileformat=unix                             " 设置新文件的<EOL>格式
set fileformats=unix,dos,mac                    " 给出文件的<EOL>格式类型

" 文件类型
filetype on                                     " 启用文件类型侦测
filetype plugin on                              " 针对不同的文件类型加载对应的插件

" 解决乱码
if (g:iswindows && g:isGUI)
    language messages zh_CN.utf-8               " 解决consle输出乱码
    "source $VIMRUNTIME/delmenu.vim              " 解决菜单乱码
    "source $VIMRUNTIME/menu.vim
endif


"                           < 文件编辑的配置 >
" 代码高亮
if has("syntax")
    syntax on
endif
" 缩进
filetype plugin indent on                       " 启用缩进
set smartindent                                 " 启用智能对齐方式
set expandtab                                   " 将Tab键转换为空格
set tabstop=4                                   " 设置Tab键的宽度
set shiftwidth=4                                " 换行时自动缩进4个空格
set smarttab                                    " 指定按一次backspace就删除shiftwidth宽度的空格
set backspace=2                                 " 设置退格键可用，和 :set backspace=indent,eol,start相同

" 折叠
set foldenable                                  " 启用折叠
set foldlevel=99                                " 默认不折叠
set foldmethod=indent                           " indent 折叠方式
"set foldmethod=marker                          " marker 折叠方式
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>  " 用空格键来开关折叠

" 搜索高亮
set hlsearch                                    " 高亮搜索
set incsearch                                   " 在输入要搜索的文字时，实时匹配
set ignorecase                                  " 搜索模式里忽略大小写
set smartcase                                   " 如果搜索模式包含大写字符，不使用 'ignorecase' 选项

" 文件更新和目录切换
set autoread                                    " 当文件在外部被修改，自动更新该文件
au BufRead,BufNewFile,BufEnter * cd %:p:h       " 自动切换目录为当前编辑文件所在目录

" 80列提示
"au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)

" 行尾空格处理
nmap cS :%s/\s\+$//g<CR>:noh<CR>                " 常规模式下输入 cS 清除行尾空格
nmap cM :%s/\r$//g<CR>:noh<CR>                  " 常规模式下输入 cM 清除行尾 ^M 符号

"  插入模式下光标移动
imap <c-k> <Up>
imap <c-j> <Down>
imap <c-h> <Left>
imap <c-l> <Right>


"                               < 界面配置 >
set shortmess=atI                               " 去掉欢迎界面
set number                                      " 显示行号
set laststatus=2                                " 启用状态栏信息
set cmdheight=2                                 " 设置命令行的高度为2，默认为1
set showcmd                                     " 显示命令
set cursorline                                  " 突出显示当前行

set mouse=a                                     " 在任何模式下启用鼠标
set t_Co=256                                    " 在终端启用256色

" 设置 gVim 窗口初始位置及大小
if g:isGUI
    " au GUIEnter * simalt ~x                   " 窗口启动时自动最大化
    winpos 100 10                               " 指定窗口出现的位置，坐标原点在屏幕左上角
    set lines=38 columns=120                    " 指定窗口大小，lines为高度，columns为宽度
endif

" 显示/隐藏菜单栏、工具栏、滚动条，可用 Ctrl + F11 切换
if g:isGUI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    map <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif


"                               < 其它配置 >
"set guifont=YaHei_Consolas_Hybrid:h10          " 设置字体:字号（字体名称空格用下划线代替）
"set nowrap                                     " 设置不自动换行
"set listchars=tab:>-,trail:~
"set list
set writebackup                                 " 保存文件前建立备份，保存成功后删除该备份
set nobackup                                    " 设置无备份文件
set noswapfile                                  " 设置无临时文件
set vb t_vb=                                    " 关闭提示音
" 和系统剪切板交互
if has("clipboard")
    set clipboard+=unnamed
endif



" =============================================================================
"                           << 插件配置 >>
" =============================================================================
"                           < vim-plug 插件管理工具 >
" 安装方法，将plugin.vim文件下载并保存到autoload/
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" 或者：
" git clone https://github.com/junegunn/vim-plug.git .vim/autoload
" 如果想在 windows 安装就必需先安装 "git for window"，可查阅网上资料


"                           < 插件安装目录 >
if g:islinux
    set rtp+=~/.vim/packages/
    call plug#begin('~/.vim/packages')
else
    "set rtp+=$VIM/vimfiles/
    let path='$VIM/vimfiles/packages'
    call plug#begin(path)
endif


"                           < 显示增强插件 >
" -------------------- 开始页面插件
Plug 'mhinz/vim-startify'

" -------------------- 代码配色方案
Plug 'mhinz/vim-janah'

" -------------------- 彩虹括号增强版，手动 :RainbowToggle
Plug 'luochen1990/rainbow'

let g:rainbow_active = 1

" -------------------- 缩进显示,暂时没找到好的
"Plug 'Yggdroot/indentLine'

"let g:indentLine_setColors = 0                 " 0设置竖线背景为灰色
"let g:indentLine_char = '┆'                     " ¦, ┆, │, ⎸, or ▏
"let g:indentLine_leadingSpaceEnabled = 1
"let g:indentLine_leadingSpaceChar = '.'

" -------------------- 状态栏/标签栏增强插件
Plug 'vim-airline/vim-airline'

" Tab
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
" statusline
"let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'long', 'mixed-indent-file' ]
let g:airline#extensions#whitespace#checks = [ 'indent', 'long', 'mixed-indent-file' ]
"let g:airline_powerline_fonts = 1
"let g:airline#extensions#wordcount#format = '%d wd'
let g:airline#extensions#wordcount#enabled = 0  " 是否显示单词统计，按空格，tab，换行分割，不准确
"let g:airline#extensions#wordcount#filetypes = ''
let g:airline_section_z = '%3p%%/%L %l:%3c[%4B]'

" -------------------- 字体,需要安装，要求不高就不要了
"Plug 'powerline/fonts'

" -------------------- 代码状态插件
Plug 'airblade/vim-gitgutter'

"                           < 编辑增强插件 >
" 补全插件1
Plug 'ervandew/supertab'                        " tab补全,使用vim内置方法

" 补全插件2
"Plug 'Shougo/neocomplete.vim'                  " 需要+lua
"Plug 'Shougo/deoplete.nvim'                    " 需要+python3和version>=8.0
"Plug 'Valloric/YouCompleteMe'                  " 需要额外的二进制包编译

" -------------------- 对齐插件
Plug 'junegunn/vim-easy-align'

" 参考链接 https://github.com/junegunn/vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" -------------------- 多光标编辑
Plug 'terryma/vim-multiple-cursors'

let g:multi_cursor_use_default_mapping=1        " 0禁用默认键绑定，后面单独配置
" 默认键绑定
"let g:multi_cursor_start_key='<F6>'             " 进入多光标编辑，默认为next快捷键"
"let g:multi_cursor_next_key='<C-n>'
"let g:multi_cursor_prev_key='<C-p>'
"let g:multi_cursor_skip_key='<C-x>'
"let g:multi_cursor_quit_key='<Esc>'
" 其他配置 https://github.com/terryma/vim-multiple-cursors
let g:multi_cursor_exit_from_insert_mode=1     " 默认1，若置0，退出insert模式后，不清除选中

" -------------------- 匹配符号增强插件
Plug 'tpope/vim-surround'

" 文档 https://github.com/tpope/vim-surround
" 命令格式：
"       cs + 当前符号 + 目标符号/标签
"       cst + 目标符号          " 将标签替换为目标符号
"       ds + 符号               " 清除匹配符号
"       ysiw + 0个或者1个空格 + 符号/标签       " 对单词添加匹配符号/标签，注意左符号自带一个空格，右符号不带空格，但可添加
"       yss + 0个或者1个空格 + 符号/标签        " 类似ysiw，但是对整行
"       VS + 字符串                             " 行模式，高亮部分的行前和行后添加字符串

" -------------------- 查找增强
"Plug 'easymotion/vim-easymotion'               " 和<Leader>冲突

" -------------------- 文件查找插件
if g:islinux
    Plug 'Yggdroot/LeaderF', { 'do': '.\install.sh' }
else
    Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
endif

" https://github.com/Yggdroot/LeaderF
" <leader>f                 " 查找文件
" <ESC>/i                   " 输入模式和选择模式切换
" <F1>                      " 选择模式帮助
" <C-C>/q                   " 输入模式退出查找/选择模式退出查找

" -------------------- 撤销目录树，手动 :UndotreeToggle
Plug 'mbbill/undotree'

" 显示样式，（tree，diff）：1左上，左下，2左上，底部，3右上，右下，4右上，底部
let g:undotree_WindowLayout = 3
if has("persistent_undo")
    if g:islinux
        set undodir=~/.vim/undodir/
    else
        set undodir=$VIM/vimfiles/undodir/
    endif
    set undofile
endif
nnoremap <F5> :UndotreeToggle<cr>


"                           < 功能/代码增强插件 >
" -------------------- 语法检查插件
if ( version < 800 )
    Plug 'scrooloose/syntastic'

    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
else
    Plug 'w0rp/ale'

    " 文档 https://github.com/w0rp/ale
    let g:ale_completion_enabled = 1
endif

" -------------------- 行尾空格高亮
Plug 'ntpeters/vim-better-whitespace'

let g:better_whitespace_enabled=1               " 高亮行尾空格
let g:strip_whitespace_on_save=0                " 保存时去除行尾空格，置0不去除
let g:strip_whitelines_at_eof=1                 " 去除文件末尾空格
let g:show_spaces_that_precede_tabs=1           " 高亮tab前和tab内部的空格
let g:better_whitespace_skip_empty_lines=0      " 置1忽略纯空格的行
" 默认下列文件格式对该插件屏蔽，若不注释则所有格式都开启
"let g:better_whitespace_filetypes_blacklist=['diff', 'gitcommit', 'unite', 'qf', 'help', 'markdown']
" 在行尾空格快速移动
nnoremap ]w :NextTrailingWhitespace<CR>
nnoremap [w :PrevTrailingWhitespace<CR>
" <number><Leader>s<space>                      " 清除N行行尾空格
" <Leader>s<motion>                             " 根据<motion>清除，如<Leader>sip清除当前段落行尾空格

" -------------------- 目录树
Plug 'scrooloose/nerdtree'

nmap <F2> :NERDTreeToggle<CR>                   " 常规模式下输入 F2 调用插件
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden = 1

let g:nerdtree_tabs_open_on_console_startup = 1
let g:nerdtree_tabs_focus_on_files = 1

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" -------------------- 注释
Plug 'scrooloose/nerdcommenter'

" https://github.com/scrooloose/nerdcommenter  快捷键 <Leader>ci或者<Leader>c<space>
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1


call plug#end()
"                           < 插件安装完毕后配置 >
if g:isGUI
    colorscheme janah                           " Gvim配色方案
else
    colorscheme janah                           " 终端配色方案
endif




" =============================================================================
"                     << windows 下解决 Quickfix 乱码问题 >>
" =============================================================================
" windows 默认编码为 cp936，而 Gvim(Vim) 内部编码为 utf-8，所以常常输出为乱码
" 以下代码可以将编码为 cp936 的输出信息转换为 utf-8 编码，以解决输出乱码问题
" 但好像只对输出信息全部为中文才有满意的效果，如果输出信息是中英混合的，那可能
" 不成功，会造成其中一种语言乱码，输出信息全部为英文的好像不会乱码
" 如果输出信息为乱码的可以试一下下面的代码，如果不行就还是给它注释掉

" if g:iswindows
"     function QfMakeConv()
"         let qflist = getqflist()
"         for i in qflist
"            let i.text = iconv(i.text, "cp936", "utf-8")
"         endfor
"         call setqflist(qflist)
"      endfunction
"      au QuickfixCmdPost make call QfMakeConv()
" endif




" =============================================================================
"                                   << 其它 >>
" =============================================================================
" 注：上面配置中的"<Leader>"在本软件中设置为"\"键（引号里的反斜杠），如<Leader>t
" 指在常规模式下按"\"键加"t"键，这里不是同时按，而是先按"\"键后按"t"键，间隔在一
" 秒内，而<Leader>cs是先按"\"键再按"c"又再按"s"键
