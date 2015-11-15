" =============================================================================
"        << 判断操作系统是 Windows 还是 Linux 和判断是终端还是 Gvim >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
" -----------------------------------------------------------------------------
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

" -----------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif


" =============================================================================
"                          << 以下为软件默认配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < Windows Gvim 默认配置> 做了一点修改
" -----------------------------------------------------------------------------
if g:iswindows
    " =============================================================================
    "                     << windows 下解决 Quickfix 乱码问题 >>
    " =============================================================================
    " windows 默认编码为 cp936，而 Gvim(Vim) 内部编码为 utf-8，所以常常输出为乱码
    " 以下代码可以将编码为 cp936 的输出信息转换为 utf-8 编码，以解决输出乱码问题
    " 但好像只对输出信息全部为中文才有满意的效果，如果输出信息是中英混合的，那可能
    " 不成功，会造成其中一种语言乱码，输出信息全部为英文的好像不会乱码
    " 如果输出信息为乱码的可以试一下下面的代码，如果不行就还是给它注释掉
    function QfMakeConv()
        let qflist = getqflist()
        for i in qflist
           let i.text = iconv(i.text, "cp936", "utf-8")
        endfor
        call setqflist(qflist)
    endfunction
    au QuickfixCmdPost make call QfMakeConv()


    "解决consle输出乱码
    language messages zh_CN.utf-8

    let $VIMFILES = $VIM.'/vimfiles'


    if g:isGUI
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
        set lines=50 columns=170                          "指定窗口大小，lines为高度，columns为宽度
        set guifont=consolas:h10:cANSI
        set gfw=youyuan:h10.5:cGB2312

        " au GUIEnter * simalt ~x                           "窗口启动时自动最大化
        winpos 100 10                                     "指定窗口出现的位置，坐标原点在屏幕左上角
        syntax enable

        set guioptions-=m
        set guioptions-=T
        set guioptions-=r
        set guioptions-=L
        nmap <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
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
endif

" -----------------------------------------------------------------------------
"  < Linux Gvim/Vim 默认配置> 做了一点修改
" -----------------------------------------------------------------------------
if g:islinux
    set hlsearch        "高亮搜索
    set incsearch       "在输入要搜索的文字时，实时匹配
    set guifont=Monospace\ 11

    let $VIMFILES = $HOME.'/.vim'
    " Uncomment the following to have Vim jump to the last position when
    " reopening a file
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif

    if g:isGUI
        " Source a global configuration file if available
        if filereadable("/etc/vim/gvimrc.local")
            source /etc/vim/gvimrc.local
        endif
        set lines=24 columns=80                          "指定窗口大小，lines为高度，columns为宽度

        " au GUIEnter * simalt ~x                           "窗口启动时自动最大化
        winpos 100 10                                     "指定窗口出现的位置，坐标原点在屏幕左上角
        syntax enable

        set guioptions-=m
        set guioptions-=T
        set guioptions-=r
        set guioptions-=L
        nmap <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
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
    else
        " This line should not be removed as it ensures that various options are
        " properly set to work with the Vim-related packages available in Debian.
        runtime! debian.vim

        " Vim5 and later versions support syntax highlighting. Uncommenting the next
        " line enables syntax highlighting by default.
        if has("syntax")
            syntax on
        endif

        set mouse=a                    " 在任何模式下启用鼠标
        set t_Co=256                   " 在终端启用256色
        set backspace=2                " 设置退格键可用

        " Source a global configuration file if available
        if filereadable("/etc/vim/vimrc.local")
            source /etc/vim/vimrc.local
        endif
    endif

endif

" -----------------------------------------------------------------------------
"  < 编码配置 >
" -----------------------------------------------------------------------------
" 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
set encoding=utf-8                                    "设置gvim内部编码，默认不更改
set fileencoding=utf-8                                "设置当前文件编码，可以更改，如：gbk（同cp936）
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "设置支持打开的文件的编码

" 文件格式，默认 ffs=dos,unix
set fileformat=unix                                   "设置新（当前）文件的<EOL>格式，可以更改，如：dos（windows系统常用）
" set fileformats=unix,dos,mac                          "给出文件的<EOL>格式类型
set wildmode=list:longest


" -----------------------------------------------------------------------------
"  < 编写文件时的配置 >
" -----------------------------------------------------------------------------
set smartindent                                       "启用智能对齐方式
set expandtab                                         "将Tab键转换为空格
set tabstop=4                                         "设置Tab键的宽度，可以更改，如：宽度为2
set shiftwidth=4                                      "换行时自动缩进宽度，可更改（宽度同tabstop）
set smarttab                                          "指定按一次backspace就删除shiftwidth宽度
if line("$")>200
    set foldenable                                        "启用折叠
    set foldmethod=syntax                                 "indent 折叠方式
endif
" set foldmethod=marker                                "marker 折叠方式

" 常规模式下用空格键来开关光标行所在折叠（注：zR 展开所有折叠，zM 关闭所有折叠）
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zO')<CR>

" 当文件在外部被修改，自动更新该文件
set autoread

" 常规模式下输入 cS 清除行尾空格
nmap cS :%s/\s\+$//g<CR>:noh<CR>

" 常规模式下输入 cM 清除行尾 ^M 符号
nmap cM :%s/\r$//g<CR>:noh<CR>

set ignorecase                                        "搜索模式里忽略大小写
set smartcase                                         "如果搜索模式包含大写字符，不使用 'ignorecase' 选项，只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用
" set noincsearch                                       "在输入要搜索的文字时，取消实时匹配

" Ctrl + K 插入模式下光标向上移动
imap <c-k> <Up>

" Ctrl + J 插入模式下光标向下移动
imap <c-j> <Down>

" Ctrl + H 插入模式下光标向左移动
imap <c-h> <Left>

" Ctrl + L 插入模式下光标向右移动
imap <c-l> <Right>

" 启用每行超过80列的字符提示（字体变蓝并加下划线），不启用就注释掉
"au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)

" 共享剪切板
set clipboard=unnamed

" -----------------------------------------------------------------------------
"  < 界面配置 >
" -----------------------------------------------------------------------------
set number                                            "显示行号
set laststatus=2                                      "启用状态栏信息
set cmdheight=2                                       "设置命令行的高度为2，默认为1
set cursorline                                        "突出显示当前行
set wrap                                            "设置不自动换行
set scrolloff=5
set shortmess=atI                                     "去掉欢迎界面


" 设置代码配色方案
colorscheme monokai              "Gvim配色方案

" =============================================================================
"                          << 以下为用户自定义配置 >>
" =============================================================================
" -----------------------------------------------------------------------------
"  < Vundle 插件管理工具配置 >
" -----------------------------------------------------------------------------
" 用于更方便的管理vim插件，具体用法参考 :h vundle 帮助
" Vundle工具安装方法为在终端输入如下命令
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" 如果想在 windows 安装就必需先安装 "git for window"，可查阅网上资料
let g:hasVundle=1
if g:hasVundle
    set nocompatible                                      "禁用 Vi 兼容模式
    filetype off                                          "禁用文件类型侦测

    if g:islinux
        set rtp+=~/.vim/bundle/vundle/
        call vundle#rc()
    else
        set rtp+=$VIM/vimfiles/bundle/vundle/
        call vundle#rc('$VIM/vimfiles/bundle/')
    endif

    Bundle 'gmarik/vundle'

    " 以下为要安装或更新的插件，不同仓库都有（具体书写规范请参考帮助）
    "Bundle 'a.vim'
    "Bundle 'Align'
    Bundle 'jiangmiao/auto-pairs'
    "Bundle 'bufexplorer.zip'
    "Bundle 'vim-scripts/ccvext.vim'
    Bundle 'cSyntaxAfter'
    "Bundle 'ctrlpvim/ctrlp.vim'
    Bundle 'mattn/emmet-vim'
    Bundle 'Yggdroot/indentLine'
    Bundle 'vim-javacompleteex'
    Bundle 'Mark--Karkat'
    Bundle 'Shougo/neocomplcache.vim'
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'scrooloose/nerdtree'
    Bundle 'OmniCppComplete'
    Bundle 'Lokaltog/vim-powerline'
    Bundle 'repeat.vim'
    "Bundle 'msanders/snipmate.vim'
    "Bundle 'wesleyche/SrcExpl'
    Bundle 'std_c.zip'
    Bundle 'tpope/vim-surround'
    Bundle 'scrooloose/syntastic'
    Bundle 'majutsushi/tagbar'
    "Bundle 'taglist.vim'
    "Bundle 'TxtBrowser'
    "Bundle 'ZoomWin'
    Bundle 'Valloric/ListToggle'
    Bundle 'pydiction'
    "highlight
    Bundle 'vim-scripts/TagHighlight'
    Bundle 'xuhdev/SingleCompile'
    "Bundle 'vim-scripts/EasyColour'
    Bundle 'vim-scripts/hardy'
    Bundle 'pangloss/vim-javascript'
    Bundle 'drmingdrmer/xptemplate' 
    Bundle 'djoshea/vim-matlab'
    Bundle 'vim-scripts/vimim'
    Bundle 'godlygeek/tabular'
    Bundle 'plasticboy/vim-markdown'
    Bundle 'vim-scripts/PDV--phpDocumentor-for-Vim'


    "Bundle 'supertab'

    Bundle 'c-support'
    "Bundle 'html.zip'
    "Bundle 'ycm-win'

    filetype on                                           "启用文件类型侦测
    filetype plugin on                                    "针对不同的文件类型加载对应的插件
    filetype plugin indent on                             "启用缩进



    " -----------------------------------------------------------------------------
    "  < 编译、连接、运行配置 (目前只配置了C、C++、Java语言)>
    " -----------------------------------------------------------------------------


    " -----------------------------------------------------------------------------
    "  < 其它配置 >
    " -----------------------------------------------------------------------------
    set writebackup                             "保存文件前建立备份，保存成功后删除该备份
    set nobackup                                "设置无备份文件
    " set noswapfile                              "设置无临时文件
    " set vb t_vb=                                "关闭提示音


    " =============================================================================
    "                          << 以下为常用插件配置 >>
    " =============================================================================
    " -----------------------------------------------------------------------------
    "  < matlab 插件配置 >
    " -----------------------------------------------------------------------------
    autocmd BufEnter *.m    compiler mlint


    " -----------------------------------------------------------------------------
    "  < Taghighlight 插件配置 >
    " -----------------------------------------------------------------------------
    nmap <Leader>hl :UpdateTypesFile<CR>
    " -----------------------------------------------------------------------------
    "  < a.vim 插件配置 >
    " -----------------------------------------------------------------------------
    " 用于切换C/C++头文件
    " :A     ---切换头文件并独占整个窗口
    " :AV    ---切换头文件并垂直分割窗口
    " :AS    ---切换头文件并水平分割窗口

    " -----------------------------------------------------------------------------
    "  < Align 插件配置 >
    " -----------------------------------------------------------------------------
    " 一个对齐的插件，用来——排版与对齐代码，功能强大，不过用到的机会不多

    " -----------------------------------------------------------------------------
    "  < auto-pairs 插件配置 >
    " -----------------------------------------------------------------------------
    " 用于括号与引号自动补全，不过会与函数原型提示插件echofunc冲突
    " 所以我就没有加入echofunc插件

    " -----------------------------------------------------------------------------
    "  < BufExplorer 插件配置 >
    " -----------------------------------------------------------------------------
    " 快速轻松的在缓存中切换（相当于另一种多个文件间的切换方式）
    " <Leader>be 在当前窗口显示缓存列表并打开选定文件
    " <Leader>bs 水平分割窗口显示缓存列表，并在缓存列表窗口中打开选定文件
    " <Leader>bv 垂直分割窗口显示缓存列表，并在缓存列表窗口中打开选定文件

    " -----------------------------------------------------------------------------
    "  < ccvext.vim 插件配置 >
    " -----------------------------------------------------------------------------
    " 用于对指定文件自动生成tags与cscope文件并连接
    " 如果是Windows系统, 则生成的文件在源文件所在盘符根目录的.symbs目录下(如: X:\.symbs\)
    " 如果是Linux系统, 则生成的文件在~/.symbs/目录下
    " 具体用法可参考www.vim.org中此插件的说明
    " 设置matlab语言的ctags
    autocmd FileType matlab map <F8> :!Ctags --langdef=matlab --langmap=matlab.m --regex-matlab="/^function[ \t]*\\[.*\\][ \t]*=[ \t]*([a-zA-Z0-9_]+)/\1/f,function/" --regex-matlab="/^function[ \t]*[a-zA-Z0-9_]+[ \t]*=[ \t]*([a-zA-Z0-9_]+)/\1/f,function/" --regex-matlab="/^function[ \t]*([a-zA-Z0-9_]+)[^=]*$/\1/f,function/" --regex-matlab="/^.*\s*function\s*(\w+)\s*=\s*(\w+)\s*\(.*$/\2/f,function/" --regex-matlab="/^.*\s*function\s*(\w+)\s*\(.*$/\1/f,function/" --languages=matlab --extra=+q --excmd=pattern -R .<CR>:call EditTagFile()<CR>
    " 编辑Tag文件
    function EditTagFile()
        exe ':e tags'
        for lineNum in range(line('^'), line('$'))
            " 得到每一行的内容
            let lineStr = getline(lineNum)
            if matchstr(lineStr, '^!') == ""
                let fileName = matchstr(lineStr, '\v\\\zs((\w|_)*)\ze(\.m)')
                let tagName = matchstr(lineStr, '\v^\zs(\S*)\ze(\t)')
                if fileName != tagName
                    let newLineStr = fileName.'.'.lineStr
                    call setline(lineNum, newLineStr)
                endif
            else
                if matchstr(lineStr, '^!_TAG_FILE_SORTED') != ""
                    let startStr = matchstr(lineStr,'\v\zs(^)\S*\ze(\t)')
                    let endStr = matchstr(lineStr, '\v\d\t\zs(.*)\ze($)')
                    let newLineStr = startStr."\t"."0"."\t".endStr
                    call setline(lineNum, newLineStr)
                endif
            endif
        endfor
        exe ':w'
        exe ':bdelete tags'
    endfunction
    " <Leader>sc 连接已存在的tags与cscope文件

    " -----------------------------------------------------------------------------
    "  < cSyntaxAfter 插件配置 >
    " -----------------------------------------------------------------------------
    " 高亮括号与运算符等
    au! BufRead,BufNewFile,BufEnter *.{c,cpp,h,java,javascript} call CSyntaxAfter()

    " -----------------------------------------------------------------------------
    "  < ctrlp.vim 插件配置 >
    " -----------------------------------------------------------------------------
    " 一个全路径模糊文件，缓冲区，最近最多使用，... 检索插件；详细帮助见 :h ctrlp
    " 常规模式下输入：Ctrl + p 调用插件

    " -----------------------------------------------------------------------------
    "  < emmet-vim（前身为Zen coding） 插件配置 >
    " -----------------------------------------------------------------------------
    " HTML/CSS代码快速编写神器，详细帮助见 :h emmet.txt

    let g:user_emmet_install_global = 0
    autocmd FileType php,html,css EmmetInstall

    let g:user_emmet_expandabbr_key = ';n'
    let g:user_emmet_balancetaginward_key = ';d'
    let g:user_emmet_balancetagoutward_key = ';D'
    let g:user_emmet_next_key = ';p'
    let g:user_emmet_prev_key = ';P'
    let g:user_emmet_imagesize_key = ';i'
    let g:user_emmet_togglecomment_key = ';/'
    let g:user_emmet_splitjointag_key = ',j'
    let g:user_emmet_removetag_key = ';k'
    let g:user_emmet_anchorizeurl_key = ';a'
    autocmd FileType css,html vmap ; <plug>(emmet-expand-abbr)
    " -----------------------------------------------------------------------------
    "  < indentLine 插件配置 >
    " -----------------------------------------------------------------------------
    " 用于显示对齐线，与 indent_guides 在显示方式上不同，根据自己喜好选择了
    " 在终端上会有屏幕刷新的问题，这个问题能解决有更好了
    " 开启/关闭对齐线
    nmap <leader>il :IndentLinesToggle<CR>
    au! BufRead,BufNewFile,BufEnter IndentLinesToggle()

    " 设置Gvim的对齐线样式
    if g:isGUI
        let g:indentLine_char = "┊"
        let g:indentLine_first_char = "┊"
    endif

    " 设置终端对齐线颜色，如果不喜欢可以将其注释掉采用默认颜色
    let g:indentLine_color_term = 239

    " 设置 GUI 对齐线颜色，如果不喜欢可以将其注释掉采用默认颜色
    " let g:indentLine_color_gui = '#A4E57E'

    " -----------------------------------------------------------------------------
    "  < vim-javacompleteex（也就是 javacomplete 增强版）插件配置 >
    " -----------------------------------------------------------------------------
    " java 补全插件

    " -----------------------------------------------------------------------------
    "  < Mark--Karkat（也就是 Mark） 插件配置 >
    " -----------------------------------------------------------------------------
    " 给不同的单词高亮，表明不同的变量时很有用，详细帮助见 :h mark.txt

    " " -----------------------------------------------------------------------------
    " "  < MiniBufExplorer 插件配置 >
    " " -----------------------------------------------------------------------------
    " " 快速浏览和操作Buffer
    " " 主要用于同时打开多个文件并相与切换

    " " let g:miniBufExplMapWindowNavArrows = 1     "用Ctrl加方向键切换到上下左右的窗口中去
    " let g:miniBufExplMapWindowNavVim = 1        "用<C-k,j,h,l>切换到上下左右的窗口中去
    " let g:miniBufExplMapCTabSwitchBufs = 1      "功能增强（不过好像只有在Windows中才有用）
    " "                                            <C-Tab> 向前循环切换到每个buffer上,并在但前窗口打开
    " "                                            <C-S-Tab> 向后循环切换到每个buffer上,并在当前窗口打开

    " 在不使用 MiniBufExplorer 插件时也可用<C-k,j,h,l>切换到上下左右的窗口中去
    noremap <c-k> <c-w>k
    noremap <c-j> <c-w>j
    noremap <c-h> <c-w>h
    noremap <c-l> <c-w>l

    " -----------------------------------------------------------------------------
    "  < neocomplcache 插件配置 >
    " -----------------------------------------------------------------------------
    " 关键字补全、文件路径补全、tag补全等等，各种，非常好用，速度超快。
    let g:neocomplcache_enable_at_startup = 1     "vim 启动时启用插件
    set complete-=k complete+=k

    " let g:neocomplcache_disable_auto_complete = 1 "不自动弹出补全列表
    " 在弹出补全列表后用 <c-p> 或 <c-n> 进行上下选择效果比较好

    " -----------------------------------------------------------------------------
    ""  < nerdcommenter 插件配置 >
    " -----------------------------------------------------------------------------
    " 我主要用于C/C++代码注释(其它的也行)
    " 以下为插件默认快捷键，其中的说明是以C/C++为例的，其它语言类似
    " <Leader>ci 以每行一个 /* */ 注释选中行(选中区域所在行)，再输入则取消注释
    " <Leader>cm 以一个 /* */ 注释选中行(选中区域所在行)，再输入则称重复注释
    " <Leader>cc 以每行一个 /* */ 注释选中行或区域，再输入则称重复注释
    " <Leader>cu 取消选中区域(行)的注释，选中区域(行)内至少有一个 /* */
    " <Leader>ca 在/*...*/与//这两种注释方式中切换（其它语言可能不一样了）
    " <Leader>cA 行尾注释
    let NERDSpaceDelims = 1                     "在左注释符之后，右注释符之前留有空格

    " -----------------------------------------------------------------------------
    "  < nerdtree 插件配置 >
    " -----------------------------------------------------------------------------
    " 有目录村结构的文件浏览插件

    " 常规模式下输入 F2 调用插件
    nmap <F2> :NERDTreeToggle<CR>

    " -----------------------------------------------------------------------------
    "  < omnicppcomplete 插件配置 >
    " -----------------------------------------------------------------------------
    " 用于C/C++代码补全，这种补全主要针对命名空间、类、结构、共同体等进行补全，详细
    " 说明可以参考帮助或网络教程等
    " 使用前先执行如下 ctags 命令（本配置中可以直接使用 ccvext 插件来执行以下命令）
    " ctags -R --c++-kinds=+p --fields=+iaS --extra=+q
    " 我使用上面的参数生成标签后，对函数使用跳转时会出现多个选择
    " 所以我就将--c++-kinds=+p参数给去掉了，如果大侠有什么其它解决方法希望不要保留呀

    set completeopt=menu                        "关闭预览窗口

    autocmd filetype javascript set dictionary+=$VIMFILES/dict/javascript.dict
    autocmd filetype html set dictionary+=$VIMFILES/dict/javascript.dict
    autocmd filetype css set dictionary+=$VIMFILES/dict/css.dict
    autocmd filetype php set dictionary+=$VIMFILES/dict/php.dict
    autocmd filetype python set dictionary+=$VIMFILES/dict/python.dict
    autocmd filetype arduino set dictionary+=$VIMFILES/dict/arduino.dict

    " -----------------------------------------------------------------------------
    "  < powerline 插件配置 >
    " -----------------------------------------------------------------------------
    " 状态栏插件，更好的状态栏效果

    " -----------------------------------------------------------------------------
    "  < repeat 插件配置 >
    " -----------------------------------------------------------------------------
    " 主要用"."命令来重复上次插件使用的命令

    " -----------------------------------------------------------------------------
    "  < snipMate 插件配置 >
    " -----------------------------------------------------------------------------
    " 用于各种代码补全，这种补全是一种对代码中的词与代码块的缩写补全，详细用法可以参
    " 考使用说明或网络教程等。不过有时候也会与 supertab 插件在补全时产生冲突，如果大
    " 侠有什么其它解决方法希望不要保留呀

    " -----------------------------------------------------------------------------
    "  < SrcExpl 插件配置 >
    " -----------------------------------------------------------------------------
    " 增强源代码浏览，其功能就像Windows中的"Source Insight"
    nmap <F3> :SrcExplToggle<CR>                "打开/闭浏览窗口

    " -----------------------------------------------------------------------------
    "  < std_c 插件配置 >
    " -----------------------------------------------------------------------------
    " 用于增强C语法高亮

    " 启用 // 注视风格
    let c_cpp_comments = 1

    " -----------------------------------------------------------------------------
    "  < surround 插件配置 >
    " -----------------------------------------------------------------------------
    " 快速给单词/句子两边增加符号（包括html标签），缺点是不能用"."来重复命令
    " 不过 repeat 插件可以解决这个问题，详细帮助见 :h surround.txt
    xmap ) S(
    xmap } S[
    xmap } S{
    xmap ' S'
    xmap " S"

    " -----------------------------------------------------------------------------
    "  < Syntastic 插件配置 >
    " -----------------------------------------------------------------------------
    " 用于保存文件时查检语法

    " -----------------------------------------------------------------------------
    "  < Tagbar 插件配置 >
    " -----------------------------------------------------------------------------
    " 相对 TagList 能更好的支持面向对象

    " 常规模式下输入 tb 调用插件，如果有打开 TagList 窗口则先将其关闭
    nmap tb :TagbarToggle<CR>

    let g:tagbar_width=30                       "设置窗口宽度
    " let g:tagbar_left=1                         "在左侧窗口中显示

    " -----------------------------------------------------------------------------
    "  < TagList 插件配置 >
    " -----------------------------------------------------------------------------
    " 高效地浏览源码, 其功能就像vc中的workpace
    " 那里面列出了当前文件中的所有宏,全局变量, 函数名等

    " 常规模式下输入 tl 调用插件，如果有打开 Tagbar 窗口则先将其关闭
    nmap tl :TagbarClose<CR>:Tlist<CR>

    let Tlist_Show_One_File=1                   "只显示当前文件的tags
    " let Tlist_Enable_Fold_Column=0              "使taglist插件不显示左边的折叠行
    let Tlist_Exit_OnlyWindow=1                 "如果Taglist窗口是最后一个窗口则退出Vim
    let Tlist_File_Fold_Auto_Close=1            "自动折叠
    let Tlist_WinWidth=30                       "设置窗口宽度
    let Tlist_Use_Right_Window=1                "在右侧窗口中显示

    " -----------------------------------------------------------------------------
    "  < txtbrowser 插件配置 >
    " -----------------------------------------------------------------------------
    " 用于文本文件生成标签与与语法高亮（调用TagList插件生成标签，如果可以）
    au BufRead,BufNewFile *.txt setlocal ft=txt

    " -----------------------------------------------------------------------------
    "  < ZoomWin 插件配置 >
    " -----------------------------------------------------------------------------
    " 用于分割窗口的最大化与还原
    " 常规模式下按快捷键 <c-w>o 在最大化与还原间切换

    " =============================================================================
    "                          << 以下为常用工具配置 >>
    " =============================================================================

    " -----------------------------------------------------------------------------
    "  < cscope 工具配置 >
    " -----------------------------------------------------------------------------
    " 用Cscope自己的话说 - "你可以把它当做是超过频的ctags"
    if has("cscope")
        "设定可以使用 quickfix 窗口来查看 cscope 结果
        set cscopequickfix=s-,c-,d-,i-,t-,e-
        "使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳转
        set cscopetag
        "如果你想反向搜索顺序设置为1
        set csto=0
        "在当前目录中添加任何数据库
        if filereadable("cscope.out")
            cs add cscope.out
        "否则添加数据库环境中所指出的
        elseif $CSCOPE_DB != ""
            cs add $CSCOPE_DB
        endif
        set cscopeverbose
        "快捷键设置
        nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
        nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
        nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    endif

    " -----------------------------------------------------------------------------
    "  < ctags 工具配置 >
    " -----------------------------------------------------------------------------
    " 对浏览代码非常的方便,可以在函数,变量之间跳转等

    set tags=./tags;                            "向上级目录递归查找tags文件（好像只有在Windows下才有用）

    " -----------------------------------------------------------------------------
    "  < gvimfullscreen 工具配置 > 请确保已安装了工具
    " -----------------------------------------------------------------------------
    " 用于 Windows Gvim 全屏窗口，可用 F11 切换
    " 全屏后再隐藏菜单栏、工具栏、滚动条效果更好
    if (g:iswindows && g:isGUI)
        nmap <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
    endif

    " -----------------------------------------------------------------------------
    "  < vimtweak 工具配置 > 请确保以已装了工具
    " -----------------------------------------------------------------------------
    " 这里只用于窗口透明与置顶
    " 常规模式下 Ctrl + Up（上方向键） 增加不透明度，Ctrl + Down（下方向键） 减少不透明度，<Leader>t 窗口置顶与否切换
    " if (g:iswindows && g:isGUI)
        " unmap <c-v>
        " let g:Current_Alpha = 255
        " let g:Top_Most = 0
        " func! Alpha_add()
            " let g:Current_Alpha = g:Current_Alpha + 10
            " if g:Current_Alpha > 255
                " let g:Current_Alpha = 255
            " endif
            " call libcallnr("vimtweak.dll","SetAlpha",g:Current_Alpha)
        " endfunc
        " func! Alpha_sub()
            " let g:Current_Alpha = g:Current_Alpha - 10
            " if g:Current_Alpha < 155
                " let g:Current_Alpha = 155
            " endif
            " call libcallnr("vimtweak.dll","SetAlpha",g:Current_Alpha)
        " endfunc
        " func! Top_window()
            " if  g:Top_Most == 0
                " call libcallnr("vimtweak.dll","EnableTopMost",1)
                " let g:Top_Most = 1
            " else
                " call libcallnr("vimtweak.dll","EnableTopMost",0)
                " let g:Top_Most = 0
            " endif
        " endfunc

        " "快捷键设置
        " nmap <c-up> :call Alpha_add()<CR>
        " nmap <c-down> :call Alpha_sub()<CR>
        " nmap <leader>t :call Top_window()<CR>
    " endif

    " -----------------------------------------------------------------------------
    "  < pydiction > 请确保以已装了工具
    " -----------------------------------------------------------------------------

    "then make sure you set g:pydiction_location to the full path of where you installed complete-dict. Ex:
    "for example, if you used Pathogen to install Pydiction, you would set this to:

    let g:pydiction_location = $VIM.'/bundle/pydiction/complete-dict'
    " python pydiction.py <module> [module]

    " -----------------------------------------------------------------------------
    "  < html 工具配置 > 请确保以已装了工具
    " -----------------------------------------------------------------------------
    let g:no_html_map_override = 'yes'
    "let g:html_map_leader=mapleader
    "au BufRead,BufNewFile,BufEnter *.html map <F9> <lead>db

    " =============================================================================
    "                          << 以下为常用自动命令配置 >>
    " =============================================================================

    " 自动切换目录为当前编辑文件所在目录
    au BufRead,BufNewFile,BufEnter * cd %:p:h


    " -----------------------------------------------------------------------------
    "  < xptemplate 插件配置 >
    " -----------------------------------------------------------------------------
    " Prevent supertab from mapping <tab> to anything.
    let g:SuperTabMappingForward = '<Plug>xpt_void'

    " Tell XPTemplate what to fall back to, if nothing matches.
    " Original SuperTab() yields nothing if g:SuperTabMappingForward was set to
    " something it does not know.
    let g:xptemplate_fallback = '<C-r>=XPTwrapSuperTab("n")<CR>'

    fun! XPTwrapSuperTab(command) "{{{
        let v = SuperTab(a:command)
        if v == ''
            " Change \<Tab> to whatever you want, when neither XPTemplate or
            " supertab needs to do anything.
            return "\<Tab>"
        else
            return v
        end
    endfunction "}}}
    "let g:xptemplate_vars = "BRfun= "
    " -----------------------------------------------------------------------------
    "   YCM 补全
    " -----------------------------------------------------------------------------
    " 菜单配色
    "highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
    "" 选中项
    "highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900
    "" 补全功能在注释中同样有效
    "let g:ycm_complete_in_comments=1
    "" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
    "let g:ycm_confirm_extra_conf=0
    ""是去找搜索路径
    "let g:ycm_filetype_whitelist = { '*':1,'cpp':1,'python':1,}
    ""let g:ycm_filetype_whitelist = { 'cpp':1,'python':1,}
    "let g:ycm_show_diagnostics_ui = 0
    ""先试一试禁止,去掉错误分析,可以先去掉,待要编译完成再加上
    ""或者趁文件小时加上,文件大时,再减去(麻烦)
    "
    "" 开启 YCM 基于标签引擎
    "let g:ycm_collect_identifiers_from_tags_files=1
    "" 引入 C++ 标准库stltags
    ""set tags+=c:\\Vim\\vimfiles\\tags\\tags
    "let g:ycm_seed_identifiers_with_syntax = 1
    ""试一试,这个可能是自己的标识符
    ""let g:ycm_key_list_select_completion = ['<TAB>', '<Ctrl>',]
    ""let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']
    ""这两个无用
    ""let g:ycm_key_invoke_completion = '<C-/>'
    "nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
    ""强迫其重分析(刷新),上一个不知道
    "
    "" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
    "inoremap <leader>; <C-x><C-o>
    "" 补全内容不以分割子窗口形式出现，只显示补全列表
    "set completeopt-=preview
    "" 从第一个键入字符就开始罗列匹配项
    "let g:ycm_min_num_of_chars_for_completion=1
    "" 禁止缓存匹配项，每次都重新生成匹配项
    "let g:ycm_cache_omnifunc=0
    "" 语法关键字补全            
    "let g:ycm_seed_identifiers_with_syntax=1 
    "let g:ycm_global_ycm_extra_conf = "C:/Vim/vimfiles/bundle/ycm-win/ycm_extra_conf.py"
    ""let g:ycm_key_list_select_completion=[]
    ""let g:ycm_key_list_previous_completion=[]
    ""用C-n,c-p,进行自动补全
    "nnoremap <leader>d :YcmCompleter GoToDefinitionElseDeclaration<CR>
    "inoremap <leader>a <C-x><C-o>
    "这个是集成omnicpp补全,是管用的
    "要一边按一下才不能累
    "
    "
    " -----------------------------------------------------------------------------
    "  < singlecompile 插件配置 >
    " -----------------------------------------------------------------------------

    " F9 一键保存、编译、连接存并运行
    nmap <F9> :w<cr>: SCCompileRun<CR>
    imap <F9> <ESC>:w<CR>:SCCompileRun<CR>
    let g:SingleCompile_showquickfixiferror = 1
    if g:iswindows
        call SingleCompile#SetCompilerTemplate('html', 'wchrome', 'chrome','chrome', '', '')
        call SingleCompile#ChooseCompiler('html', 'wchrome')
        call SingleCompile#SetCompilerTemplate('markdown', 'wchrome', 'chrome','chrome', '', '')
        call SingleCompile#ChooseCompiler('markdown', 'wchrome')
        call SingleCompile#SetCompilerTemplate('php', 'php', 'php','php', '', '')
        call SingleCompile#ChooseCompiler('php', 'php')
    end
    " call SingleCompile#ChooseCompiler('xhtml', 'wchrome')
    " -----------------------------------------------------------------------------
    "  < markdown 插件配置 >
    " -----------------------------------------------------------------------------
    " au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=mkd
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    let g:vim_markdown_folding_disabled=1
    " -----------------------------------------------------------------------------
    "  < vimim插件配置 >
    " -----------------------------------------------------------------------------
    "http://vimim.googlecode.com/svn/vimim/vimim.html
    let g:Vimim_mode='static'

    let g:Vimim_map='c-space'
    let g:Vimim_punctuation=-1
    "用gi切换中英文 
    imap gi <C-Space> 

    " -----------------------------------------------------------------------------
    "  < PDV 插件配置 >
    " ------source ~/.vim/php-doc.vim 
    " source ~/.vim/php-doc.vim 
    inoremap <Leader>add <ESC>:call PhpDocSingle()<CR>i 
    nnoremap <Leader>add      :call PhpDocSingle()<CR> 
    vnoremap <Leader>add      :call PhpDocRange()<CR> 
    " =============================================================================
    "                          << 其它 >>
    " =============================================================================
    " 注：上面配置中的"<Leader>"在本软件中设置为"\"键（引号里的反斜杠），如<Leader>t
    " 指在常规模式下按"\"键加"t"键，这里不是同时按，而是先按"\"键后按"t"键，间隔在一
    " 秒内，而<Leader>cs是先按"\"键再按"c"又再按"s"键；如要修改"<leader>"键，可以把
    " 下面的设置取消注释，并修改双引号中的键为你想要的，如修改为逗号键。
    let g:vimim_disable_smart_space=1
endif

" autocmd BufNewFile,BufRead *.c source $vimfiles/cscript.vim
" autocmd BufNewFile,BufRead *.cpp source $vimfiles/cppscript.vim
autocmd BufNewFile,BufRead *.h source $vimfiles/hscript.vim
autocmd BufNewFile,BufRead *.c source $vimfiles/cscript.vim
autocmd BufNewFile,BufRead *.cpp source $vimfiles/cppscript.vim
autocmd FileType python source $VIMFILES/pyscript.vim
autocmd FileType arduino source $VIMFILES/inoscript.vim
autocmd FileType matlab source $VIMFILES/matlabscript.vim
autocmd FileType asm source $VIMFILES/asmscript.vim
autocmd FileType php source $VIMFILES/phpscript.vim

nmap su :set fileencoding=utf-8<cr>:%s/\t/<space><space><space><space>/g<CR>
nmap sg :set fileencoding=gbk<cr>
smap y <c-g>y
smap d <c-g>d
noremap <c-v> <c-v>
imap <c-v> <c-v>

imap kk <esc>la
imap jj <ESC> "jj为esc
"autocmd FileType c source $vimfiles/cscript.vim
"xmap ( di(<esc>p2l
xmap ) S(
xmap ] S[
xmap } S{
xmap ' S'
xmap " S"
"noremap <Tab> <c-v>I<Tab><Esc>
cmap W w

nmap <Leader>hl :UpdateTypesFile<CR>
nmap <F2> :NERDTreeToggle<CR>
nmap tb :TlistClose<CR>:TagbarToggle<CR>

nmap <Leader>ex :NERDTreeToggle<CR>:TagbarToggle<CR>:UpdateTypesFile<CR><c-l>
"":SrcExplToggle<CR> 
if g:iswindows
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
endif
