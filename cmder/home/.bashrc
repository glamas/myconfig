export PROMPT_COMMAND='history -a'
alias ll='ls -l'
alias ls='ls -F --color=auto --show-control-chars'
alias python='winpty python.exe'
alias python3='winpty python3.exe'

# python virtualenvwrapper
if [[ ${USERPROFILE} != "" ]]; then
  export WORKON_HOME=$($(where cygpath) -p ${USERPROFILE} -u)/Envs
  source $(where virtualenvwrapper.sh)
fi

export EDITOR=nano

