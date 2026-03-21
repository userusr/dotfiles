# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# PYENV
# [pyenv/pyenv: Simple Python version management](https://github.com/pyenv/pyenv)
# export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# latexindent.pl
# https://github.com/cmhughes/latexindent.pl
export LATEXINDENT_BASE="$HOME/.latexindent"
export PATH=$LATEXINDENT_BASE:$PATH

# fnm
# Fast Node Manager
# https://github.com/Schniz/fnm
export PATH=$HOME/.fnm:$PATH
eval "`fnm env`"

# rust
# https://rustup.rs/
export PATH=$HOME/.cargo/bin:$PATH

# fzf
export FZF_BASE="$HOME/.fzf"
export PATH=$FZF_BASE/bin:$PATH
# source "$FZF_BASE/shell/key-bindings.zsh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# platformio
export PATH=$HOME/.platformio/penv/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# local ruby gems
export PATH=$HOME/.local/share/gem/ruby/3.0.0/bin/:$PATH

# local claude code config
[ -f ~/.claude-code.sh ] && source  ~/.claude-code.sh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="af-magic"
# ZSH_THEME="maran"
ZSH_THEME="axl"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fzf fnm git-prompt cp z)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"

function vrg() {
  if (( $# != 1 )); then
    echo "Ошибка: требуется ровно один аргумент" >&2
    return 1
  fi

  local arg=$1
  rg --vimgrep -m2 "$arg" | \
  fzf --preview 'bat --style=numbers --color=always --highlight-line {2} {1} --paging=always' \
      --delimiter ':' --nth 1,2,3 \
      --bind "enter:execute(code --goto --new-window {1}:{2} > /dev/tty)"
}

function clone_and_checkout_git_ssh() {
  local repo_url="$1"
  local branch="${2:-master}"

  local start_dir
  start_dir="$(pwd)"
  trap 'cd "$start_dir"' EXIT

  local repo_path
  local repo_name
  repo_path=$(echo "$repo_url" | sed -E 's#^[^:]+:([^\.]+)\.git$#\1#')
  repo_name=$(echo "$repo_url" | sed -E 's#.*/([^/]+)\.git#\1#')

  if [[ -z "$repo_path" ]]; then
    echo "ERROR: Не удалось извлечь путь из SSH-URL: $repo_url"
    return 1
  fi

  if [[ -z "$repo_name" ]]; then
    echo "ERROR: Не удалось извлечь имя из SSH-URL: $repo_url"
    return 1
  fi

  safe_branch=$(echo "$branch" | sed -E 's#[^A-Za-z0-9._-]#_#g')

  local full_path="${repo_path}/${repo_name}__${safe_branch}"

  if [ -d "$full_path" ]; then
    echo "Path '$full_path' exists"
    code ${full_path}
    return 0
  fi

  mkdir -p "$full_path" || {
    echo "ERROR: Не удалось создать директорию $full_path";
    return 2;
  }

  git clone "$repo_url" "$full_path" || {
    echo "ERROR: git clone завершился с ошибкой для репозитория $repo_url";
    return 3;
  }

  cd "$full_path" || {
    echo "ERROR: Не удалось перейти в директорию $full_path";
    return 4;
  }

  git checkout "$branch" || {
    echo "ERROR: Не удалось выполнить git checkout ветки $branch";
    return 5;
  }

  cd "$start_dir" || {
    echo "ERROR: Не удалось перейти в директорию $start_dir";
    return 6;
  }

  code ${full_path}
}
