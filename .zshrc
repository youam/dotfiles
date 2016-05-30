#
# zsh rc file for Uli "youam" Martens <uli@youam.net>
#

#
# path settings
#

if [ -e "$HOME/.alias" ]; then
	source "$HOME/.alias"
fi


#
# screen colaboration
#

# set the screen window title to the current command
preexec () {
	if [[ "$TERM" == "screen" ]]; then
		# needs: setopt extended_glob
		local CMD=${1[(wr)^(*=*|sudo|man|vi|-*)]}
		echo -ne "\ek$CMD\e\\"
	fi
}

# reset the screen window titel to "zsh"
precmd () {
	 if [[ "$TERM" == "screen" ]]; then
		 echo -ne "\ekzsh\e\\"
	 fi
}

#
# shell features
#

# use extended globbing, (^ for inverted matches etc)
setopt EXTENDED_GLOB

###############################################################################
###############################################################################
###############################################################################
###############################################################################
#
# beep on error in zle
setopt beep

# notify background job changes at once, don't wait for prompt
setopt notify

# Wait for KEYTIMEOUT ms if the input could be the prefix to some longer command
#KEYTIMEOUT=40



# The following lines were added by compinstall

zstyle ':completion:*' completer _complete
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' substitute 1
zstyle :compinstall filename '/root/.zshrc'

autoload -Uz compinit
compinit

setopt auto_pushd

unsetopt autocd nomatch

#svn-mirror
export SVMREPOS=$HOME/.vcs/svn-mirror

# precmd() {
#	local escape colno lineno
#	IFS='[;' read -s -d R escape\?$'\e[6n' lineno colno
#	(( colno > 1 )) && echo ''
# }


fpath+=(~/.zsh/functions)

export EDITOR=vim
for snippet in ~/.zsh/rc/S[0-9][0-9]*[^~] ; do source $snippet; done
