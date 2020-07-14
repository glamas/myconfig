export PROMPT_COMMAND='history -a'
alias ll='ls -l'
alias ls='ls -F --color=auto --show-control-chars'
alias python='winpty python.exe'
alias python3='winpty python3.exe'

if [[ "$(uname)" =~ "_NT" ]]; then
	alias workon="workon.bat"
	alias mkvirtualenv="mkvirtualenv.bat"
	alias lsvirtualenv="lsvirtualenv.bat"
	alias rmvirtualenv="rmvirtualenv.bat"
fi

export EDITOR=nano
