# les truc en rapport avec pyenv

if command -v pyenv 1>/dev/null 2>&1
then
	# if [[ -n ZSH_DEBUG ]]; then echo ">>> pyenv detected";fi
	if [ "$(uname -s)" = "Darwin" ]
	then
		# skip pyenv on MAC
	else
		# on linux
		export PYENV_ROOT="$HOME/.pyenv"
		export PATH="$PYENV_ROOT/bin:$PATH"
		eval "$(pyenv init -)"
		# on charge le plugin pyenv virtualenvwrapper
		pyenv virtualenvwrapper
	fi
fi
