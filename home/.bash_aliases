alias tmux='TERM=screen-256color tmux'

alias osupg='sudo apt update && sudo apt dist-upgrade -y && sudo apt autoremove -y'

ax_backup() {
    if [ "$#" -ne 1 ]; then
        echo "Illegal number of parameters"
        return
    fi

    if [ ! -d "$1" ]; then
        echo "Parameter mast be a directory"
        return
    fi

    local name=$(basename "$1")
    local arc_name="$(pwd)/${name}_$(date +%Y%m%d%H%M%S).backup.tar.gz"

    cd "$(dirname "$1")"
    tar -I pigz -cvf "${arc_name}" "${name}"/

    echo
    echo testing ...

    tar -I pigz -tf "${arc_name}" &> /dev/null

    sha1sum -b $arc_name > $arc_name.sha1
}

# gitignore.io
# https://docs.gitignore.io/install/command-line
gi() {
    curl -sL https://www.gitignore.io/api/$@
}
