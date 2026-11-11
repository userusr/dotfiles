" Назначение: переносы текста TeX и ручное форматирование через latexindent.
" Использование: автоматически при filetype=tex; параметров вызова нет.
" Зависимости: ALE + latexindent для форматирования. <leader> = запятая.
" Результат: локальная ширина 79 и буферная клавиша; b:undo_ftplugin отменяет
" настройки при смене filetype. ALEFix не сохраняет изменения на диск.

" --- Переносы: отображать длинные строки и переносить вводимый текст ---
setlocal wrap textwidth=79 formatoptions+=t
call dotfiles#undo_ftplugin('setlocal wrap< textwidth< formatoptions<')
" --- Форматирование: клавиша доступна только при наличии исполнителя ---
if dotfiles#has_plugin('ale') && executable('latexindent')
  let b:ale_fixers = ['latexindent']
  " ,pt: исправить/отформатировать текущий буфер через ALE; сохранить отдельно (,w).
  nnoremap <silent> <buffer> <leader>pt :ALEFix<CR>
  call dotfiles#undo_ftplugin('unlet! b:ale_fixers')
  call dotfiles#undo_ftplugin('silent! nunmap <buffer> <leader>pt')
endif
