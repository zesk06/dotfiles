# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# Do not change your PATH here, but in the .zshenv file

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# if you want to use this, change your non-ascii font to Droid Sans Mono for Awesome
export TERM="xterm-256color"
# POWERLEVEL9K_MODE='awesome-patched'
# export ZSH_THEME="powerlevel9k/powerlevel9k"
export ZSH_THEME="powerlevel10k/powerlevel10k"
#export ZSH_THEME="agnoster"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

# https://github.com/bhilburn/powerlevel9k#customizing-prompt-segments
# https://github.com/bhilburn/powerlevel9k/wiki/Stylizing-Your-Prompt
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status virtualenv host)

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"
unsetopt correct_all

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git pass zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
export LANG=en_US.UTF-8

export EDITOR='nvim'

# Add your PATH and alias stuff in the 
# ~/.zshenv
# This file is loaded automatically

if command -v ssh-agent 1>/dev/null 2>&1
then
    eval `ssh-agent` >> /dev/null
fi
unsetopt sharehistory

# because oh-my-zsh screw my ls alias i must redefined it here.
unalias ls

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
