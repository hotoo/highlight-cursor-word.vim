" File: highlight.vim
" Desption:
" Author: 冒顿
" Last Change: 2016-10-10

if exists('loaded_highlight_cursor_word')
    finish
endif
let loaded_highlight_cursor_word = 1

if !exists('g:highlight_cursor_word_white_list')
  let g:highlight_cursor_word_white_list = { }
endif

function! GetCursorWord()
  " 通用，没有设置语法的值可以高亮。
  if synIDtrans(synID(line('.'), col('.'), 1)) == 0 &&
    \ match(getline(line("."))[col(".") - 1], '[a-zA-Z0-9_]') == 0 &&
    \ match(expand('<cword>'), '^[a-zA-Z_][a-zA-Z0-9_]*$') >= 0
      return expand('<cword>')
  endif

  " JavaScript 特殊处理
  " 'neoclide/vim-jsx-improve' 由于给变量名都设置了语法定义，例如
  " 'jsVariableDef'，所以上面的逻辑会失效，所以针对 js 所有关键字都高亮。
  if exists('g:highlight_cursor_word_white_list.' . &ft)
    let synName = synIDattr(synID(line('.'), col('.'), 1), 'name')
    if g:highlight_cursor_word_white_list[ &ft ] == '*' ||
          \ index(split(g:highlight_cursor_word_white_list[ &ft ], ','), synName) >= 0
        return expand('<cword>')
    endif
  endif

  return ''
endfunction

" 缓存最后一个高亮词，避免不必要的更新高亮，以提升性能。
let g:lastHighlightCursorWord = GetCursorWord()

function! HighlightCursorWord()
  let cursorWord = GetCursorWord()
  if cursorWord ==# g:lastHighlightCursorWord
    return
  endif
  let g:lastHighlightCursorWord = cursorWord

  if cursorWord == ''
    match Underlined /\[^\s\S]/
  else
    exe printf('match Underlined /\<%s\>/', cursorWord)
  endif
endfunction

autocmd CursorMoved,CursorHold *.js,*.ts,*.jsx,*.tsx,*.java,*.cs,*.c,*.cpp,*.h,*.vim,*.py,*.rb silent! call HighlightCursorWord()

" autocmd CursorMoved,CursorHold * silent! if synIDtrans(synID(line('.'), col('.'), 1)) == 0 &&
      " \ match(getline(line("."))[col(".") - 1], '[a-zA-Z0-9_]') == 0 &&
      " \ match(expand('<cword>'), '^[a-zA-Z_][a-zA-Z0-9_]*$') >= 0 |
        " \ exe printf('match Underlined /\<%s\>/', expand('<cword>')) |
      " \ else |
        " \ match Underlined /\[^\s\S]/ |
      " \ endif
