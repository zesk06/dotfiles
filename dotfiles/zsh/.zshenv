# The .zshenv is loaded automatically
#
# put your PATH and alias stuff in here
#
# Set this variable to have zsh debug at loading phase
# export ZSH_DEBUG="0"

# this mess with my fzf
export FZF_DEFAULT_COMMAND='ag --nocolor --hidden --ignore .git -g ""'

export EDITOR=nvim

alias apk='ansible-playbook -K'
alias apv='ansible-playbook --ask-vault-pass -e@vault.yml'
alias gs='git status'
alias pt='py.test'

# typo alias
# les alias pour quand je fais des typo
alias eco='echo'
# 0 . Enter
bindkey -s "^[Op" "0"
bindkey -s "^[On" "."
bindkey -s "^[OM" "^M"
# 1 2 3
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
# 4 5 6
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
# 7 8 9
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# + -  * / =
bindkey -s "^[Ok" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"
bindkey -s "^[OX" "="

if [ "$(uname -s)" = "Darwin" ]
then
	# on a mac
	export PYTHON_PATH="/usr/local"
	export VIRTUALENVWRAPPER_PYTHON="${PYTHON_PATH}/bin/python3"
	source /usr/local//bin/virtualenvwrapper.sh
fi

# load command-dependant configs
for file in $(find ${HOME}/.zshrc.d/ -type f)
do
	source ${file}
done

# change da PATH
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# (cat ~/.cache/wal/sequences &)
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
export GPG_TTY=$(tty)
