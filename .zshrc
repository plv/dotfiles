# Oh My Zsh configuration

export ZSH="$(realpath ~/.oh-my-zsh)"
ZSH_THEME="agnoster"
plugins=(git)
source $ZSH/oh-my-zsh.sh


# Other scripts

## Machine-specific stuff that I don't want to sync
if [[ -f ~/.localzshrc ]]; then
    . ~/.localzshrc
fi

## z.sh (unrelated to zsh) to go fast
if [[ -f ~/dotfiles/z.sh ]]; then
    . ~/dotfiles/z.sh
else
    echo "z.sh or $(realpath ~/dotfiles) doesn't exist. Make sure dotfiles is" \
    "in your home dir, and that z.sh is in it."
fi


# Options

if type nvim >/dev/null 2>/dev/null; then
    export EDITOR=nvim
    alias vim=nvim
else
    export EDITOR=vim
fi

## Sharing history between zsh processes
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

## Never ever beep ever >:(
setopt NO_BEEP

## Allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD


# Aliases and functions
## General
up() {
    if [ -z "$1" ]; then
        up 1
    else
        cd $(yes ".." | head "-$1" | tr '\n' '/')
    fi
}

## Vimwiki/Notes
diary () {
    vim ~/notes/diary/$(date "+%Y-%m-%d.wiki")
}

### qn (QuickNote) -  a dispoable note made in /tmp that is copied to clipboard
### after exiting.
qn() {
    todaydir="/tmp/qn-$(date '+%Y-%m-%d')"
    if [ ! -d "$todaydir" ]; then
        mkdir "$todaydir"
    fi

    notepath="$todaydir/$(date +%s).wiki"
    "$EDITOR" "$notepath"
    case "$(uname -s)" in
        Linux*) cmd='xclip -i -selection clipboard';;
        Darwin*) cmd='pbcopy';;
        *) exit 1
    esac
    cat "$notepath" | eval "$cmd"
}
