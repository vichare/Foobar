"
" vichare.vim file for vichare
" would be include by _vimrc
" Maintainer: Vichare Wang <vicharewang@gmail.com>
"

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" set nocompatible " this has already been set in _vimrc


"syntax on
set history=50		" keep 50 lines of command line history
set nu          " show row number
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set nobackup
"set autoindent		" always set autoindenting on
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
set showmatch
set expandtab
set tabstop=4
set shiftwidth=4

" switch windows
map <F12> <C-W>w

" The Vim editor will start searching when you type the first character of the search string. As you type in more characters, the search is refined.
set incsearch 

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    " Any search highlights the string matched by the search
    set hlsearch
endif

" link clipboard to unnamed
set clipboard+=unnamed

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
    augroup END
else
    set autoindent		" always set autoindenting on
endif " has("autocmd")

"*****************************************
" hmisty's personal settings (perl setting)
"*****************************************
if has("gui_running")
    func ResetMenu(...)
        " a:0 argc a:1...argv
        if (a:0==0) || (a:1 != "first")
            unmenu FunnyType(Z)
        endif
        menu FunnyType(&Z).C(&c) :set filetype=c<CR>
        menu FunnyType(&Z).C++(&cc) :set filetype=cpp<CR>
        menu FunnyType(&Z).Html(&h) :set filetype=html<CR>
        menu FunnyType(&Z).Perl(&P) :set filetype=perl<CR>
        menu FunnyType(&Z).Java(&J) :set filetype=java<CR>
        menu FunnyType(&Z).TeX(&T) :set filetype=tex<CR>
        menu FunnyType(&Z).MetaPost(&M) :set filetype=mp<CR>
    endfunc
    call ResetMenu("first")
endif

" --------------------- Set File Type ---------------------
if has('autocmd')
    " when event "set filetype" occurs (see :help filetype)
    " autocmd Filetype perl call PerlDetected()
    autocmd Filetype java call JavaDetected()
    autocmd Filetype tex call TeXDetected()
    " autocmd Filetype mp call MetaPostDetected()
    autocmd Filetype cpp call CppDetected()
    autocmd Filetype c call CppDetected()
    autocmd Filetype html call HtmlDetected()
    autocmd Filetype htm call HtmlDetected()
endif

" -------------------为不同文件类型建立不同的按键映射--------------
if has("all_builtin_terms")

        func PerlDetected()
                if has("gui_running")
                        call ResetMenu()
                        menu FunnyType(&Z).-Separator- :
                        menu FunnyType(&Z).模版(&M) :set fo-=r<CR>i#!/usr/bin/perl -w<CR><CR>use strict;<CR><CR><Esc>:set fo+=r<CR>
                        menu FunnyType(&Z).查字典(&D) :call TypeDoc(expand("<cword>"))<CR>
                        menu FunnyType(&Z).单步调试(&S) :w<CR>:!perl -wd "%"<CR>
                        menu FunnyType(&Z).语法检查(&G) :w<CR>:!perl -wc "%"<CR>
                        menu FunnyType(&Z).运行(&R) :w<CR>:!perl '%'<CR>
                else
                        " -----F4 查字典 F7 单步调试 F8 语法检查 F9 运行程序-------
                        map <F4> :call PerlDoc(expand("<cword>"))<CR>
                        map <F7> :w<CR>:!perl -wd "%"<CR>
                        map <F8> :w<CR>:!perl -wc "%"<CR>
                        map <F9> :w<CR>:!perl '%'<CR>
                endif
                autocmd BufUnload * call SetPerlExecutable()
        endfunc

        func SetPerlExecutable()
                if synIDattr(synID(1,1,1),"name")=="perlSharpBang"
                        exec ':!(if [ \! -x '.expand("<afile>").' ]; then chmod +x '.expand("<afile>").'; fi)'
                endif
        endfunc

        func PerlDoc(keyword)
                if a:keyword=~"::"
                        "module name;
                        exec ':!perldoc '.a:keyword
                elseif a:keyword=~"^perl"
                        "perl pod
                        exec ':!perldoc '.a:keyword
                else
                        "perl function
                        exec ':!perldoc -f '.a:keyword

                endif
        endfunc

        func JavaDetected()
                if has("gui_running")
                        call ResetMenu()
                        menu FunnyType(&Z).-Separator- :
                        menu FunnyType(&Z).New(&M) :set fo-=r<CR>i<CR>public class  {<CR><CR>}<Esc>2G$h:set fo+=r<CR>
                        menu FunnyType(&Z).Compile(&C) :w<CR>:!javac "%"<CR>
                        menu FunnyType(&Z).Run(&R) :w<CR>:!java -cp "%:p:h" "%:r"<CR>
                        menu FunnyType(&Z).AppletViewer(&A) :w<CR>:!appletviewer "%"<CR>
                else
                        " ----- F8 编译.java F7 Applet Viewer F9 运行.class-------
                        "map <F7> :w<CR>:!appletviewer "%"<CR>
                        "map <F8> :w<CR>:!javac "%"<CR>
                        "map <F9> :w<CR>:!java -cp "%:p:h" "%:r"<CR>
                endif
                map <F8> :w<CR>:!appletviewer "%"<CR>
                map <F9> :w<CR>:!javac "%"<CR>
                map <F10> :w<CR>:!java -cp "%:p:h" "%:r"<CR>
        endfunc

        func TeXDetected()
                if has("gui_running")
                        call ResetMenu()
                        menu FunnyType(&Z).-Separator- :
                        menu FunnyType(&Z).New(&M) :set fo-=r<CR>i\documentclass[11pt, a4paper,oneside]{article}<CR>\usepackage{CJK}<CR>\usepackage{graphicx}<CR>\usepackage{listings}<CR>\usepackage{color}<CR>\usepackage{indentfirst}<CR><CR>\setlength{\parindent}{2em}<CR><CR>\begin{document}<CR>\begin{CJK*}{GBK}{song}<CR>\title{}<CR>\author{}<CR>\date{}<CR>\maketitle<CR>\tableofcontents<CR><CR>\end{CJK*}<CR>\end{document}<Esc>7k:set fo+=r<CR>
                        menu FunnyType(&Z).用pdflatex编译(&P) :w<CR>:!pdflatex "%"<CR>
                        menu FunnyType(&Z).用latex+dvipdfm编译(&L) :w<CR>:!latex "%:p:r" ; dvipdf "%:p:r"<CR>
                        menu FunnyType(&Z).查看pdf(&V) :!xpdf "%:p:r.pdf"<CR>
                else
                        " ----- F5 查看pdf F6 用pdflatex编译 F8 用latex+dvipdfm编译-------
                        map <F5> :!xpdf "%:p:r.pdf"<CR>
                        map <F6> :w<CR>:!pdflatex "%"<CR>
                        map <F8> :w<CR>:!latex "%:p:r" ; dvipdf "%:p:r" "<CR>
                endif
				"map <F9> :!mpdf "%"<CR><CR>:!evince "%:p:r.pdf"<CR><CR>
				map <F9> :!texify --pdf --tex-option=-synctex=1 "%"<CR><CR>
				"map <F10> :!texworks "%:p:r.pdf"<CR><CR>
				map <F10> :!SumatraPDF "%:p:r.pdf"<CR><CR>

                set spell
                let g:tex_flavor='latex'
                let g:Tex_DefaultTargetFormat = 'pdf'
                set iskeyword+=:,.,_
                "]s — next misspelled word
                "[s — previous misspelled word
                "z= — view spelling suggestions for a mispelled word
                "zg — add a word to the dictionary
                "zug — undo the addition of a word to the dictionary
                call IMAP('`3', "\\sum_{<++>}^{<++>}<++>", 'tex')
                call IMAP('`1', "\\lim_{<++>}<++>", 'tex')
                call IMAP('`[', "\\[<++>\\]<++>", 'tex')
        endfunc

        func MetaPostDetected()
                if has("gui_running")
                        call ResetMenu()
                        menu FunnyType(&Z).-Separator- :
                        menu FunnyType(&Z).模版(&M) :set fo-=r<CR>ibeginfig()<CR><CR>endfig;<CR>end<Esc>1G$:set fo+=r<CR>
                        menu FunnyType(&Z).编译(&C) :w<CR>:!mpost "%"<CR>
                        menu FunnyType(&Z).查看(&V) :w<CR>:!tex mproof %:r.<cword> ; dvipdf mproof.dvi ; xpdf mproof.pdf<CR>
                else
                        " ----- F5 编译 F9 查看-------
                        map <F9> :w<CR>:!tex mproof %:r.<cword> ; dvipdf mproof.dvi ; xpdf mproof.pdf<CR>
                        map <F5> :w<CR>:!mpost "%"<CR>
                endif
        endfunc

        func CppDetected()
            if has("gui_running")
                call ResetMenu()
                menu FunnyType(&Z).-Separator- :
                menu FunnyType(&Z).模版(&M) :set fo-=r<CR>O#include <iostream><CR><CR>using namespace std;<CR><CR>int main()<Esc>A {<CR>return 0;<CR>}<Esc>1G$:set fo+=r<CR>
                menu FunnyType(&Z).编译(&C) :w<CR>:!make "%:p:r"<CR>
                menu FunnyType(&Z).运行(&V) :!"%:p:r"<CR>
            endif
            "------ put the cursor between "" or () automatically ----
            inoremap "" ""<C-C>i
            inoremap () ()<C-C>i

            " ----- put ; at the end ----
            nmap ;; A;<ESC>

            "----------- Ctrl+J to input a empty block {} --------
            nmap <C-J> A {<CR>}<C-C>O;<ESC>
            imap <C-J> <C-C>A {<CR>}<C-C>O

            " ------ Compile and Run ---------
            map <F9> :!make "%:p:r"<CR>
            map <F10> :!"%:p:r"<CR>

            " ------ F11 for template --------
            nmap <F11> O#include <iostream><CR><CR>using namespace std;<CR><CR>int main() {<CR>return 0;<CR>}<C-C>
            nmap <F11> <C-C>O#include <iostream><CR><CR>using namespace std;<CR><CR>int main() {<CR>return 0;<CR>}<C-C>
        endfunc

        func HtmlDetected()
			nmap <C-J> A {<CR>}<C-C>O;<ESC>
			imap <C-J> <C-C>A {<CR>}<C-C>O
        endfunc

endif


