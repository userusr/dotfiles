" Назначение: отступы Python, диагностика Ruff/basedpyright и команды ALE.
" Использование: автоматически после стандартного ftplugin при filetype=python.
" Параметров вызова нет. Ruff берёт правила из проекта; путь к basedpyright
" задан в .vimrc через адаптер ALE pyright. <leader> = запятая.
" Результат: настройки действуют только в буфере; b:undo_ftplugin отменяет их
" при смене filetype. Исправления ALEFix не сохраняют файл автоматически.

" --- Отступы: четыре пробела, без изменения остальных буферов ---
" Отступы локальны; Ruff читает стиль и правила из конфигурации проекта.
setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
call dotfiles#undo_ftplugin('setlocal expandtab< tabstop< softtabstop< shiftwidth<')
" --- Диагностика и исправления: активировать только с установленным ALE ---
" pyright — имя адаптера ALE; фактически запускается basedpyright из .vimrc.
if dotfiles#has_plugin('ale')
  let b:ale_linters = ['ruff', 'pyright']
  let b:ale_fixers = ['ruff', 'ruff_format']
  call dotfiles#lsp_mappings()
  " ,pt: исправить/отформатировать текущий буфер через ALE; сохранить отдельно (,w).
  nnoremap <silent> <buffer> <leader>pt :ALEFix<CR>
  call dotfiles#undo_ftplugin('unlet! b:ale_linters b:ale_fixers')
  call dotfiles#undo_ftplugin('silent! nunmap <buffer> <leader>pt')
endif
" --- Тесты: ,mt запускает make test, ошибки доступны в quickfix ---
" Нужна цель test в Makefile и подходящий текущий рабочий каталог (:pwd).
nnoremap <silent> <buffer> <leader>mt :make test<CR>
call dotfiles#undo_ftplugin('silent! nunmap <buffer> <leader>mt')
