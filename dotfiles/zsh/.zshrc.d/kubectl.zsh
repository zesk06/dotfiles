# les truc en rapport avec kubectl
if [ $commands[kubectl] ]
then
	# kubectl c'est trop long a taper tu vois
	alias k='kubectl'
	alias kw='watch -n 1 -d kubectl'
fi
# la completion c'est la vie
function kubecomplete (){
	source <(kubectl completion zsh)
}
