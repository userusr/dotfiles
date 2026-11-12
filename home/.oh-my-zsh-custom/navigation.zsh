# Назначение:
#   fd/fzf, дополнение fzf-tab, Git-поиск и переходы zoxide в интерактивном Zsh.
# Использование:
#   Oh My Zsh загружает этот файл после plugins=(... fzf ...), то есть после
#   compinit и штатных клавиш fzf. Позиционных параметров нет.
# Окружение:
#   DOTFILES_ZSH_PLUGINS_DIR — каталог checkout плагинов;
#   по умолчанию ~/.local/share/dotfiles/zsh. PATH содержит системные утилиты
#   и ~/.local/bin/dotfiles_previewer. EDITOR используется Git-поиском.
# Результат:
#   Ctrl+R — история; Ctrl+T — вставить путь; Alt+C — перейти в каталог;
#   Tab — меню дополнения; Ctrl+G и вторая клавиша — Git; z/zi — zoxide.
#   Shell ничего не устанавливает: отсутствующие зависимости объясняются
#   в stderr, остальные возможности shell продолжают работать.

[[ -o interactive ]] || return

# --- fd: учитывать скрытые файлы и .gitignore, исключить служебные каталоги ---
if (( $+commands[fd] )); then
    _dotfiles_fd=fd
elif (( $+commands[fdfind] )); then
    _dotfiles_fd=fdfind
else
    _dotfiles_fd=''
    print -u2 '[dotfiles] fd/fdfind не найден: установите зависимости terminal; fzf использует стандартный поиск.'
fi
if [[ -n $_dotfiles_fd ]]; then
    export FZF_DEFAULT_COMMAND="$_dotfiles_fd --type f --hidden --exclude .git --exclude .venv --exclude node_modules"
    export FZF_CTRL_T_COMMAND="$_dotfiles_fd --hidden --exclude .git --exclude .venv --exclude node_modules"
    export FZF_ALT_C_COMMAND="$_dotfiles_fd --type d --hidden --exclude .git --exclude .venv --exclude node_modules"
fi
unset _dotfiles_fd

# --- fzf: предпросмотр только в файловых widgets, не во всех меню редакторов ---
export FZF_CTRL_T_OPTS="--preview 'dotfiles_previewer {}' --bind 'ctrl-h:toggle-preview'"
export FZF_ALT_C_OPTS="--preview 'dotfiles_previewer {}' --bind 'ctrl-h:toggle-preview'"
export FSG_FILE_PREVIEW=dotfiles_previewer
# Совпадает с темой delta в .gitconfig; перекрывает светлую GitHub из плагина.
export FSG_BAT_THEME='Monokai Extended'
export EDITOR="${EDITOR:-vim}"

# --- fzf-tab: штатное Zsh-дополнение плюс группы и безопасный предпросмотр ---
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' switch-group '[' ']'
zstyle ':fzf-tab:*' fzf-flags --layout=reverse --bind=ctrl-h:toggle-preview
zstyle ':fzf-tab:complete:(cd|ls|bat|batcat|cat|cp|mv|ln|vim|code|open|tree):*' \
    fzf-preview 'dotfiles_previewer "$realpath"'

# --- Плагины: установка — задача scripts/install_terminal, а не запуска shell ---
_dotfiles_plugins=${DOTFILES_ZSH_PLUGINS_DIR:-$HOME/.local/share/dotfiles/zsh}
if (( $+commands[fzf] )); then
    for _dotfiles_plugin in fzf-tab fzf-simple-git; do
        if [[ -f "$_dotfiles_plugins/$_dotfiles_plugin/$_dotfiles_plugin.plugin.zsh" ]]; then
            source "$_dotfiles_plugins/$_dotfiles_plugin/$_dotfiles_plugin.plugin.zsh"
            if [[ $_dotfiles_plugin == fzf-simple-git ]]; then
                # Плагин не передаёт delta ширину preview, поэтому в pipe она
                # выбирает 80 колонок. Сохранить его выбор pager/темы и добавить
                # ширину только при запуске preview. Одинарные кавычки важны:
                # FZF_PREVIEW_COLUMNS появится позже, в процессе предпросмотра.
                functions[_dotfiles_fsg_pager]=$functions[__fsg_pager]
                __fsg_pager() {
                    local pager=$(_dotfiles_fsg_pager)
                    if (( $+commands[delta] )) && [[ -z ${FSG_PAGER:-} ]]; then
                        print -r -- "$pager"' ${FZF_PREVIEW_COLUMNS:+--width=$FZF_PREVIEW_COLUMNS}'
                    else
                        print -r -- "$pager"
                    fi
                }
                # Одиночный Ctrl+G по умолчанию вызывает send-break после
                # KEYTIMEOUT. Оставить его только префиксом, чтобы пауза перед
                # второй клавишей не отменяла строку с beep. Ctrl+C сохраняется.
                for _dotfiles_keymap in emacs viins vicmd; do
                    bindkey -M "$_dotfiles_keymap" -r '^g'
                done
                unset _dotfiles_keymap
            fi
        else
            print -u2 "[dotfiles] $_dotfiles_plugin отсутствует: выполните terminal-шаг установщика."
        fi
    done
else
    print -u2 '[dotfiles] fzf не найден: интерактивные меню не подключены; установите системные зависимости.'
fi
unset _dotfiles_plugins _dotfiles_plugin

# --- zoxide: заменить плагин z; zi открывает интерактивный выбор через fzf ---
if (( $+commands[zoxide] )); then
    eval "$(zoxide init zsh)"
else
    print -u2 '[dotfiles] zoxide не найден: z/zi недоступны; установите системные зависимости.'
fi
