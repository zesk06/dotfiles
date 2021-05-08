# parceque sur archelite, c'est pas pareil tu vois
if [ "$(hostname)" = "ns378079.ip-176-31-250.eu" ]
then
	export PYTHON_PATH="/usr/bin/python"
	export VIRTUALENVWRAPPER_PYTHON="${PYTHON_PATH}"
        export NPM_PACKAGES="/home/fedora/.npm-packages"
        export PATH="${PATH}:${NPM_PACKAGES}/bin"
	# setxbmap fr	
fi
