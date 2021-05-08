.PHONY: \
	clean \
	dotfiles \
	venvs \
	ohmyzsh \ 


.DEFAULT_GOAL := dotfiles

UID = $(shell id -u)
GID = $(shell id -g)

all: dotfiles

docker: 
	@docker build --build-arg USER_ID=$(UID) -t zesk06/neovim:$(UID) .
	@docker push zesk06/neovim:$(UID)

DOCKER_UIDS = 1000 1233 1003
DOCKER_TARGETS = $(addprefix docker_, $(DOCKER_UIDS))

$(DOCKER_TARGETS): docker_%:
	@docker build --build-arg USER_ID=$(subst docker_,,$@) -t zesk06/neovim:$(subst docker_,,$@) .
	@docker push zesk06/neovim:$(subst docker_,,$@)

all_docker: $(DOCKER_TARGETS)

# autogen target for stowing directories in dotfiles
STOW_DIRS = $(shell ls -1 dotfiles)

STOW_TARGETS = $(addprefix stow_, $(STOW_DIRS))

$(STOW_TARGETS): stow_%:
	@#echo "stowing $(subst stow_,,$@)"
	stow --target=${HOME} --dotfiles --dir=dotfiles $(subst stow_,,$@)

stow: $(STOW_TARGETS)

~/tmp:  # create the ~/tmp
	@mkdir -p ~/tmp

OHM_PLUGS = ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions \
            ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

OHM_THEMES = ~/.oh-my-zsh/custom/themes/powerlevel9k \
             ~/.oh-my-zsh/custom/themes/powerlevel10k

~/.oh-my-zsh:
	@if [ ! -d $@ ]; then git clone https://github.com/ohmyzsh/ohmyzsh $@; fi

~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting:
	@if [ ! -d $@ ]; then git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $@; fi

~/.oh-my-zsh/custom/plugins/zsh-autosuggestions:
	@if [ ! -d $@ ]; then git clone https://github.com/zsh-users/zsh-autosuggestions.git $@; fi

~/.oh-my-zsh/custom/themes/powerlevel10k:
	@if [ ! -d $@ ]; then git clone https://github.com/romkatv/powerlevel10k.git $@; fi

~/.oh-my-zsh/custom/themes/powerlevel9k:
	@if [ ! -d $@ ]; then git clone https://github.com/Powerlevel9k/powerlevel9k.git $@; fi

ohmyzsh: ~/.oh-my-zsh $(OHM_PLUGS) $(OHM_THEMES)

~/.virtualenvs:
	mkdir -p $@

~/.virtualenvs/neovim:
	python3 -m venv $@
	$@/bin/pip3 install --upgrade pip
	$@/bin/pip3 install --upgrade neovim pynvim

venvs: ~/.virtualenvs ~/.virtualenvs/neovim

PLUGVIM = ${HOME}/.local/share/nvim/site/autoload/plug.vim

$(PLUGVIM):
	@curl -fLo ${HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

dotfiles: stow $(PLUGVIM) venvs ~/tmp ohmyzsh  # install the dotfiles


clean:
	rm -fr \
		~/.profile \
	    ~/.ipython/profile_default/ipython_config.py \
        ~/.config/i3 \
        ~/.config/i3status \
        ~/.npmrc \
        ~/.tmux.conf \
        ~/.vim \
        ~/.vimrc \
        ~/.zshenv \
        ~/.zshrc \
        ~/.zshrc.d

