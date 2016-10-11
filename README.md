# README

Highlight words which under the cursor.

![ScreenShot](./screenshot.gif)

## Install

Vundle:

```viml
Plugin 'hotoo/highlight-cursor-word.vim'

autocmd CursorMoved,CursorHold *.php,*.jsp silent! call HighlightCursorWord()
```

If you want highlight every filetypes, try:

```viml
autocmd CursorMoved,CursorHold * silent! call HighlightCursorWord()
```

Default support:

- *.js
- *.java
- *.cs
- *.c
- *.cpp
- *.h
- *.ts
- *.jsx
- *.tsx
- *.py
- *.rb

want support more filetypes by default? Fork & Pull Request please.
