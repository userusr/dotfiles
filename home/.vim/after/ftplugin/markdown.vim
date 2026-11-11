" Назначение: ширина текста Markdown и проверка английской/русской орфографии.
" Использование: автоматически при filetype=markdown; параметров вызова нет.
" Зависимости: оба словаря spell/*.utf-8.spl устанавливает scripts/install_vim.
" Результат: textwidth=80; spell включается только при наличии обоих словарей.
" Новых клавиш нет. Локальные опции отменяются при смене типа файла.

" --- Текст и орфография: использовать только уже установленные словари ---
setlocal textwidth=80 spelllang=en,ru
" Не инициировать загрузку словарей при первом открытии файла.
if !empty(globpath(&runtimepath, 'spell/en.utf-8.spl'))
      \ && !empty(globpath(&runtimepath, 'spell/ru.utf-8.spl'))
  setlocal spell
endif
call dotfiles#undo_ftplugin('setlocal textwidth< spell< spelllang<')
