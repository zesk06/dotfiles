# parceque sur archelite, c'est pas pareil tu vois
if [ "$(hostname)" = "archelite" ]
then
	export PYTHON_PATH="/usr/bin/python"
	export VIRTUALENVWRAPPER_PYTHON="${PYTHON_PATH}"
	source ~/.local/bin/virtualenvwrapper.sh
	# setxbmap fr	
fi
