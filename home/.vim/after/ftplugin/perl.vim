" Назначение: ручное форматирование Perl и запуск тестов проекта.
" Использование: автоматически при filetype=perl; параметров вызова нет.
" Зависимости: ALE + perltidy для форматирования; цель test в Makefile для тестов.
" Результат: буферные клавиши (<leader> = запятая); b:undo_ftplugin удаляет их
" при смене filetype. ALEFix меняет буфер, но не сохраняет его на диск.

" --- Форматирование: добавить команду только при наличии ALE и perltidy ---
if dotfiles#has_plugin('ale') && executable('perltidy')
  let b:ale_fixers = ['perltidy']
  " ,pt: исправить/отформатировать текущий буфер через ALE; сохранить отдельно (,w).
  nnoremap <silent> <buffer> <leader>pt :ALEFix<CR>
  call dotfiles#undo_ftplugin('unlet! b:ale_fixers')
  call dotfiles#undo_ftplugin('silent! nunmap <buffer> <leader>pt')
endif
" --- Тесты: ,mt запускает make test, ошибки доступны в quickfix ---
" Нужна цель test в Makefile и подходящий текущий рабочий каталог (:pwd).
nnoremap <silent> <buffer> <leader>mt :make test<CR>
call dotfiles#undo_ftplugin('silent! nunmap <buffer> <leader>mt')
