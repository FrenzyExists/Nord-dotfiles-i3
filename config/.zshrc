# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=4000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/frenzy/.zshrc'

# Ditch Nano, join the NeoVim Team
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim


TIME=$(date "+%H")
greeting_message="Wazzup!!!"

if [ $TIME -gt 21 ]; then
	greeting_message="Its quite late..."
elif [ $TIME -gt 18 ]; then
	greeting_message="Good evening"
elif [ $TIME -gt 15 ]; then
	greeting_message="Good afternoon"
elif [ $TIME -gt "11" ]; then
	greeting_message="Good day"
elif [ $TIME -gt "6" ]; then
	greeting_message="Good morning"
else [ $TIME -ge 0 ]
	greeting_message="Good night"
fi


autoload -Uz compinit
compinit
# End of lines added by compinstall
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme
source ~/powerlevel10k/powerlevel10k.zsh-theme
source ~/powerlevel10k/powerlevel10k.zsh-theme
source ~/powerlevel10k/powerlevel10k.zsh-theme
source ~/powerlevel10k/powerlevel10k.zsh-theme
source ~/powerlevel10k/powerlevel10k.zsh-theme

export PATH="$HOME/.cargo/bin:$PATH"

# Straight from https://sw.kovidgoyal.net/kitty/kittens/hyperlinked_grep.html
alias kitty-search='kitty +kitten hyperlinked_grep'
compdef _rg kitty-search


