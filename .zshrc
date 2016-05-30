#
# zsh rc file for Uli "youam" Martens <uli@youam.net>
#

#
# path settings
#

if [ -e "$HOME/.alias" ]; then
	source "$HOME/.alias"
fi

# add private path for latex files
#   trailing colon -> append standard search path to TEXINPUTS
#   trailing double slash -> search directory recursively
if [ -e "$HOME/.tex" ]; then
	export TEXINPUTS="$HOME/.tex//:"
fi

#
# keybinding settings
#

# select VI keybindings
bindkey -v

bindkey "^R" history-incremental-search-backward

#
# prompt settings
#

PROMPT=$'%0(?..%{\033[31m%}%B%?%b:)%(!.%{\033[31m%}%B.%{\033[34m%}%B%n@)%m%b:%B%30<...<%~%b%(!.#.$) '
#        ^^^^^^^^^^^^^^^^^^^^^^^^^^
# print the return status of the last executed command if it is not null
#                                  ^^^^^^^^^^^^^^^^^^^                 ^                    ^^^^^ ^
# if we're root, print the hostname bold red, suffix the prompt with a hash
# mark
#                                  ^^^^              ^^^^^^^^^^^^^^^^^^^                    ^^^ ^^^
# if we're not root, prepend the hostname with the user name, printed in bold
# blue, suffix the prompt with a dolar sign.
#                                                                              ^^^^^^^^^^^^^^^^^^^^^
# limit the rest of the prompt to a total of 30 characters, of which the first
# chars will be replaced by '...'

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

if [ -d $HOME/.perl ]; then
	export PERL5LIB=$HOME/.perl
fi

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
