" Назначение: общие функции поиска, проверки плагинов и буферных клавиш ALE.
" Использование: Vim автоматически загружает файл при вызове dotfiles#...()
" из .vimrc или after/ftplugin. Аргументы описаны перед каждой функцией.
" Настройки: g:plugs заполняется vim-plug; <leader> в .vimrc равен запятой.
" Результат: поиск через rg/fzf и локальные команды без установки пакетов,
" сетевых запросов при загрузке или изменения регистров при чтении выделения.

" --- Плагины и отмена настроек типа файла ---
" name: имя плагина из g:plugs (например, 'ale'). Возвращает 1, если его
" каталог существует, иначе 0; работоспособность содержимого не проверяет.
function! dotfiles#has_plugin(name) abort
  return isdirectory(get(get(get(g:, 'plugs', {}), a:name, {}), 'dir', ''))
endfunction

" command: Ex-команда отмены настройки текущего буфера. Добавляет её к
" b:undo_ftplugin, который Vim выполняет при смене filetype; ничего не запускает.
" execute + string() сохраняют границы команды, включая аргументы :unmap.
function! dotfiles#undo_ftplugin(command) abort
  let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
        \ . (empty(get(b:, 'undo_ftplugin', '')) ? '' : ' | ')
        \ . 'execute ' . string(a:command)
endfunction

" Без аргументов. Вызывается после проверки ALE; задаёт Normal-клавиши
" только в текущем буфере и регистрирует их удаление при смене filetype.
" ALE использует языковой сервер для определения символов и поиска ссылок.
function! dotfiles#lsp_mappings() abort
  " Показать документацию/тип символа под курсором.
  nnoremap <silent> <buffer> K :ALEHover<CR>
  " Перейти к определению символа (,gd).
  nnoremap <silent> <buffer> <leader>gd :ALEGoToDefinition<CR>
  " Найти ссылки на символ (,gr).
  nnoremap <silent> <buffer> <leader>gr :ALEFindReferences<CR>
  " Найти использования символа (,gu), тот же ALEFindReferences.
  nnoremap <silent> <buffer> <leader>gu :ALEFindReferences<CR>
  " Найти ссылки на символ (,tr), совместимый вариант привычной клавиши.
  nnoremap <silent> <buffer> <leader>tr :ALEFindReferences<CR>
  call dotfiles#undo_ftplugin('silent! nunmap <buffer> K')
  for l:key in ['gd', 'gr', 'gu', 'tr']
    call dotfiles#undo_ftplugin('silent! nunmap <buffer> <leader>' . l:key)
  endfor
endfunction

" --- Поиск по проекту ---
" Без аргументов. Возвращает корень Git-репозитория текущего файла.
" Для буфера без имени начинает с cwd; без Git/репозитория возвращает cwd.
" Рабочий каталог Vim не меняется.
function! dotfiles#search_root() abort
  let l:start = empty(expand('%:p')) ? getcwd() : expand('%:p:h')
  if executable('git')
    let l:result = systemlist('git -C ' . shellescape(l:start)
          \ . ' rev-parse --show-toplevel 2>/dev/null')
    if !v:shell_error && !empty(l:result)
      return l:result[0]
    endif
  endif
  return getcwd()
endfunction

" text: буквальный текст поиска (не регулярное выражение), одна строка.
" Открывает результаты rg в fzf с предпросмотром относительно search_root().
" Пустой запрос пропускается; многострочный запрос или отсутствие зависимостей
" объясняются сообщением. Вызывается клавишей ,gf из .vimrc.
function! dotfiles#search(text) abort
  if empty(a:text)
    return
  endif
  if a:text =~# "[\r\n]"
    echo 'Поиск ,gf поддерживает только одну строку.'
    return
  endif
  if !executable('rg') || !dotfiles#has_plugin('fzf.vim')
    echo 'Для поиска нужны ripgrep и fzf.vim: bash scripts/install_vim'
    return
  endif
  let l:command = 'rg --column --line-number --no-heading --color=always'
        \ . ' --smart-case --fixed-strings -- ' . shellescape(a:text) . ' .'
  call fzf#vim#grep(l:command, 1,
        \ fzf#vim#with_preview({'dir': dotfiles#search_root()}), 0)
endfunction

" Без аргументов. Возвращает последнее посимвольное выделение в одной строке
" по меткам '< и '>, учитывая selection=exclusive и многобайтные символы.
" Не выполняет yank и не меняет регистры/буфер обмена. Для другого вида
" выделения выбрасывает исключение dotfiles:, которое обрабатывает search_visual().
function! dotfiles#visual_text() abort
  let l:start = getpos("'<")
  let l:end = getpos("'>")
  if visualmode() !=# 'v' || l:start[1] != l:end[1]
    throw 'dotfiles: выделите текст посимвольно в одной строке для поиска ,gf.'
  endif
  if exists('*getregion')
    return join(getregion(l:start, l:end,
          \ {'type': 'v', 'exclusive': &selection ==# 'exclusive'}), '')
  endif
  " Ранние Vim 9.1 без getregion(): позиции столбцов заданы в байтах;
  " включаем последний символ целиком, не прибегая к yank.
  let l:line = getline(l:start[1])
  let l:last = l:end[2] - 1
  if &selection !=# 'exclusive' || l:start[2] == l:end[2]
    let l:last += strlen(matchstr(strpart(l:line, l:last), '^.'))
  endif
  return strpart(l:line, l:start[2] - 1, l:last - l:start[2] + 1)
endfunction

" Без аргументов. Обработчик Visual-клавиши ,gf: читает выделение и запускает
" поиск. Ошибки выбора показывает пользователю, прочие ошибки не скрывает.
function! dotfiles#search_visual() abort
  try
    call dotfiles#search(dotfiles#visual_text())
  catch /^dotfiles:/
    echo v:exception
  endtry
endfunction
