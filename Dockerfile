FROM ubuntu

ARG USER_ID=1000

# Better terminal support
ENV TERM screen-256color
ENV DEBIAN_FRONTEND noninteractive

# Common packages
RUN apt update && apt install -y \
           ctags \
           curl \
           fzf \
           git \
           make \
           neovim \
           nodejs \
           python3 \
           python3-pip \
           ripgrep \
           stow \
           silversearcher-ag\
           yarn \
           zsh

RUN pip3 install \
        black \
        isort

RUN apt install -y \
           locales \
           python3-venv

# Locales
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8

# Setup non root user
RUN groupadd -g ${USER_ID} neo
RUN useradd -m -d /home/neo -s /bin/bash -g neo -u ${USER_ID} neo

# I know Kung Fu!
USER neo

# RUN mkdir -p /home/neo/.config/nvim
# RUN mkdir -p /home/neo/tmp
# RUN curl --silent -fLo /home/neo/.config/nvim/autoload/plug.vim --create-dirs \
#   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN mkdir -p /home/neo/.dotfiles
COPY --chown=neo:neo . /home/neo/.dotfiles
RUN cd /home/neo/.dotfiles && make clean all

# launch zsh once to load zsh lazy stuff while we are connected to the internet
RUN zsh --login -c "echo zsh_launched"
# Install neovim plugins
RUN nvim +PlugInstall +qall        > /dev/null
# Install Coc language servers
RUN nvim +"CocInstall coc-python"   +qall > /dev/null
RUN nvim +"CocInstall coc-tsserver" +qall > /dev/null

# Set the workdir
WORKDIR /src
