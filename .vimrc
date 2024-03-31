call plug#begin()
    Plug 'morhetz/gruvbox'                              "主题
    Plug 'voldikss/vim-translator'                      "翻译插件
    Plug 'scrooloose/nerdtree'                          "文件管理
    Plug 'vim-airline/vim-airline'                      "状态栏
    Plug 'tpope/vim-fugitive'                           "git
    Plug 'rbong/vim-flog'                               "git分支查看器
    Plug 'prabirshrestha/vim-lsp'                       "lsp
    Plug 'mattn/vim-lsp-settings'                       "lsp安装服务
    Plug 'prabirshrestha/asyncomplete.vim'              "自动补全
    Plug 'prabirshrestha/asyncomplete-lsp.vim'          "自动补全lsp
call plug#end()


"=================================================options====================================================
syntax enable
filetype plugin indent on
set incsearch                   "搜索时高亮匹配字符
set hlsearch                    "搜索时高亮匹配字符驻留
set relativenumber              "显示光标当前行号以及相对行号
set smartindent                 "智能缩进
set autoindent 		            "设置缩进根据上一行判断
set cursorline                  "高亮光标所在行
set splitright                  "设置左右分割窗口时，新窗口出现在右侧
set splitbelow                  "置水平分割窗口时，新窗口出现在底部
set noswapfile                  "禁止生成临时文件
set noautochdir                 "禁止生成.us 文件
set nobackup                    "不创建备份文件
set expandtab	    	        "自动将tab转空格
set nowrap                      "不让太长的一行折行显示
set number                      "显示行号
set clipboard=unnamed           "优化粘贴板
set foldmethod=indent           "代码折叠
set completeopt=menu            "禁用弹窗下方的窗口
set background=dark  	        "主题黑色模式
set softtabstop=4               "设置使用退格键删除多个空格时的宽度
set shiftwidth=4                "设定自动缩进的宽度。
set guioptions=                 "禁用gui版本的滚动条
set tabstop=4        	        "按下tab等于4个空格
set re=2                        "新正则表达式引擎
"set termguicolors               "颜色加强

"=================================================translator====================================================
nmap <C-c> :TranslateW<CR>
vmap <C-c> :TranslateW<CR>

"=================================================nerdtree======================================================
let g:NERDTreeDirArrows = 0
let g:NERDTreeMinimalUI = 1
nnoremap <C-f> :NERDTreeToggle<CR>  


"=================================================gruvbox====================================================
let g:gruvbox_contrast_dark="hard" "黑色程度
colorscheme gruvbox                "设置主题 

"=================================================lsp====================================================
let g:lsp_use_lua = has('nvim-0.4.0') || (has('lua') && has('patch-8.2.0775'))
let g:lsp_semantic_enabled=0
let g:lsp_format_sync_timeout=1000
let g:lsp_use_native_client=1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_signs_warning = {'text': '!'}
let g:lsp_diagnostics_signs_error = {'text': '✗'}
let g:lsp_diagnostics_signs_hint = {'text': '?'}
let g:lsp_signature_help_enabled = 0
let g:lsp_completion_documentation_enabled = 0
let g:lsp_document_highlight_delay = 1
let g:lsp_hover_ui = 'float'
let g:lsp_show_message_log_level="info"

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    let g:lsp_format_sync_timeout = 100
    nnoremap ge <plug>(lsp-document-diagnostics)
    nnoremap gc <plug>(lsp-workspace-symbol-search)
    nnoremap gf <plug>(lsp-document-format)
    nnoremap gj <plug>(lsp-code-action-float)
    nnoremap gd <plug>(lsp-definition)
    nnoremap gt <plug>(lsp-declaration)
    nnoremap gn <plug>(lsp-rename)
    nnoremap gt <plug>(lsp-type-definition)
    nnoremap gi <plug>(lsp-implementation)   
    nnoremap gl <plug>(lsp-references)
    nnoremap K <plug>(lsp-hover)
    nnoremap <C-j> <plug>(lsp-next-diagnostic)
    nnoremap <C-k> <plug>(lsp-previous-diagnostic)
    "gc 搜索符号
    "ge 显示当前文档的全部诊断信息
    "gj 显示光标下可用代码行为
    "gi 显示光标下接口所有实现处
    "gl 显示光标下值使用的地方
    "gn 修改变量名
    "gd 跳转到光标定义处
    "gt 跳转到类型定义
    "gf 格式化当前文件
endfunction
augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

"=================================================asyncomplete====================================================
let g:asyncomplete_auto_popup = 0

"=================================================cmp======================================================
inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() : "\<cr>"
inoremap <expr> <C-l> asyncomplete#force_refresh() 
